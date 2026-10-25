"""Empacota um site (HTML + CSS + JS + imagens + fontes + vídeos) em UM arquivo .html.

Uso:
  python3 empacotar.py <pagina.html> "<Nome do Comércio>" [pasta_saida]

Saída: <pasta_saida>/<Nome do Comércio>.html  (padrão: entregas/)

O arquivo final não depende de mais nada: tudo que é local vira <style>, <script>
ou data: URI. Abre direto no navegador do celular (inclusive mandado como
documento no WhatsApp). O que é remoto (Google Fonts, CDN, mapa do Google)
continua como link e só carrega com internet — isso é esperado.

Imagens grandes são reduzidas (máx. 1600 px, JPEG/WebP ~80) pra o arquivo não
passar de ~15 MB. Links para OUTRAS páginas .html locais não funcionam num
arquivo único: o script troca por "#" e lista quais eram — por isso o demo deve
ser uma página só (one-page).
"""
import base64
import io
import mimetypes
import re
import sys
from pathlib import Path
from urllib.parse import unquote, urlsplit

MAX_PX = 1600
LIMITE_MB = 15
avisos = []
cache = {}

mimetypes.add_type("font/woff2", ".woff2")
mimetypes.add_type("font/woff", ".woff")
mimetypes.add_type("font/ttf", ".ttf")
mimetypes.add_type("application/vnd.ms-fontobject", ".eot")
mimetypes.add_type("image/svg+xml", ".svg")
mimetypes.add_type("image/webp", ".webp")
mimetypes.add_type("video/mp4", ".mp4")


def eh_local(url):
    u = url.strip()
    return bool(u) and not re.match(r"^(https?:|//|data:|mailto:|tel:|#|javascript:|about:|blob:)", u, re.I)


def resolver(url, base):
    caminho = unquote(urlsplit(url.strip()).path)
    if not caminho:
        return None
    p = (base / caminho).resolve() if not caminho.startswith("/") else (RAIZ / caminho.lstrip("/")).resolve()
    return p if p.is_file() else None


def reduzir_imagem(p, dados):
    if p.suffix.lower() not in (".jpg", ".jpeg", ".png", ".webp") or len(dados) < 150_000:
        return dados, None
    try:
        from PIL import Image
    except ImportError:
        return dados, None
    img = Image.open(io.BytesIO(dados))
    img.thumbnail((MAX_PX, MAX_PX))
    out = io.BytesIO()
    if img.mode in ("RGBA", "LA", "P"):
        img.save(out, "WEBP", quality=80)
        mime = "image/webp"
    else:
        img.convert("RGB").save(out, "JPEG", quality=80, optimize=True, progressive=True)
        mime = "image/jpeg"
    novo = out.getvalue()
    return (novo, mime) if len(novo) < len(dados) else (dados, None)


def data_uri(url, base):
    p = resolver(url, base)
    if p is None:
        # formatos antigos de fonte (.eot/.ttf/.svg) faltando é normal em template:
        # o navegador usa o .woff2/.woff que existe
        if not re.search(r"\.(eot|ttf|otf|svg|woff2?)([?#].*)?$", url, re.I) or "font" not in url.lower() and "fa-" not in url:
            avisos.append(f"arquivo não encontrado: {url}")
        return url
    if p in cache:
        return cache[p]
    if p.suffix.lower() in (".html", ".htm", ".php"):
        return url
    dados = p.read_bytes()
    dados, mime = reduzir_imagem(p, dados)
    mime = mime or mimetypes.guess_type(p.name)[0] or "application/octet-stream"
    if p.suffix.lower() == ".css":
        css = embutir_css(dados.decode("utf-8", "replace"), p.parent)
        dados = css.encode()
    uri = f"data:{mime};base64,{base64.b64encode(dados).decode()}"
    cache[p] = uri
    return uri


def embutir_css(css, base):
    def imp(m):
        url = m.group(2) if m.group(2) is not None else m.group(4)
        if not eh_local(url):
            return m.group(0)
        p = resolver(url, base)
        if p is None:
            avisos.append(f"css importado não encontrado: {url}")
            return ""
        return embutir_css(p.read_text("utf-8", "replace"), p.parent)

    # @import url('a.css');  @import url(a.css);  @import 'a.css';  (URL pode ter ";" dentro)
    css = re.sub(r"""@import\s+(?:url\(\s*(['"]?)(.*?)\1\s*\)|(['"])(.*?)\3)[^;]*;""", imp, css)

    def url(m):
        u = m.group(2)
        return f"url({data_uri(u, base)})" if eh_local(u) else m.group(0)

    return re.sub(r"""url\(\s*(['"]?)([^'")]+)\1\s*\)""", url, css)


def embutir_html(html, base):
    # <link rel="stylesheet" href="local.css">
    def link(m):
        tag = m.group(0)
        if not re.search(r"""rel\s*=\s*['"]?stylesheet""", tag, re.I):
            href = re.search(r"""href\s*=\s*(['"])(.*?)\1""", tag, re.I)
            if href and eh_local(href.group(2)) and re.search(r"""rel\s*=\s*['"]?(shortcut )?icon""", tag, re.I):
                return tag.replace(href.group(2), data_uri(href.group(2), base))
            return tag
        href = re.search(r"""href\s*=\s*(['"])(.*?)\1""", tag, re.I)
        if not href or not eh_local(href.group(2)):
            return tag
        p = resolver(href.group(2), base)
        if p is None:
            avisos.append(f"css não encontrado: {href.group(2)}")
            return ""
        return "<style>\n" + embutir_css(p.read_text("utf-8", "replace"), p.parent) + "\n</style>"

    html = re.sub(r"<link\b[^>]*>", link, html, flags=re.I)

    # <style> inline com url()
    html = re.sub(r"(<style\b[^>]*>)(.*?)(</style>)",
                  lambda m: m.group(1) + embutir_css(m.group(2), base) + m.group(3),
                  html, flags=re.I | re.S)

    # <script src="local.js"></script>
    def script(m):
        src = m.group(2)
        if not eh_local(src):
            return m.group(0)
        p = resolver(src, base)
        if p is None:
            avisos.append(f"js não encontrado: {src}")
            return ""
        js = p.read_text("utf-8", "replace").replace("</script", "<\\/script")
        attrs = re.sub(r"""\s*src\s*=\s*(['"]).*?\1""", "", m.group(0).split(">", 1)[0][7:])
        return f"<script{attrs}>\n{js}\n</script>"

    html = re.sub(r"""<script\b[^>]*\bsrc\s*=\s*(['"])(.*?)\1[^>]*>\s*</script>""", script, html, flags=re.I | re.S)

    # atributos com arquivo: src, poster, data-src, data-bg, data-background, data-image...
    def attr(m):
        nome, aspas, valor = m.group(1), m.group(2), m.group(3)
        if not eh_local(valor) or valor.lower().endswith((".html", ".htm", ".php")):
            return m.group(0)
        return f"{nome}={aspas}{data_uri(valor, base)}{aspas}"

    html = re.sub(r"""\b(src|poster|data-src|data-bg|data-background|data-bg-src|data-image|data-thumb|data-setbg|data-img)\s*=\s*(['"])(.*?)\2""",
                  attr, html, flags=re.I)

    # srcset
    def srcset(m):
        partes = []
        for item in m.group(3).split(","):
            item = item.strip()
            if not item:
                continue
            u, *desc = item.split()
            partes.append(" ".join([data_uri(u, base) if eh_local(u) else u, *desc]))
        return f"{m.group(1)}={m.group(2)}{', '.join(partes)}{m.group(2)}"

    html = re.sub(r"""\b(srcset|data-srcset)\s*=\s*(['"])(.*?)\2""", srcset, html, flags=re.I)

    # style="background-image:url(...)"
    html = re.sub(r"""\bstyle\s*=\s*(['"])(.*?)\1""",
                  lambda m: f"style={m.group(1)}{embutir_css(m.group(2), base)}{m.group(1)}", html, flags=re.I | re.S)

    # links para outras páginas locais -> "#"
    def href(m):
        valor = m.group(3)
        caminho = urlsplit(valor).path
        if eh_local(valor) and caminho.lower().endswith((".html", ".htm", ".php")):
            ancora = urlsplit(valor).fragment
            avisos.append(f"link para outra página virou âncora: {valor}")
            return f"{m.group(1)}={m.group(2)}#{ancora}{m.group(2)}"
        return m.group(0)

    html = re.sub(r"""\b(href|action)\s*=\s*(['"])(.*?)\2""", href, html, flags=re.I)
    return html


def nome_de_arquivo(nome):
    nome = re.sub(r'[\\/:*?"<>|\n\r\t]+', " ", nome).strip().strip(".")
    return re.sub(r"\s+", " ", nome) or "site"


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print(__doc__)
        sys.exit(1)
    pagina = Path(sys.argv[1]).resolve()
    nome = sys.argv[2]
    saida_dir = Path(sys.argv[3] if len(sys.argv) > 3 else "entregas")
    RAIZ = pagina.parent
    html = pagina.read_text("utf-8", "replace")
    final = embutir_html(html, pagina.parent)
    saida_dir.mkdir(parents=True, exist_ok=True)
    destino = saida_dir / f"{nome_de_arquivo(nome)}.html"
    destino.write_text(final, "utf-8")
    mb = destino.stat().st_size / 1_048_576
    vistos = set()
    for a in avisos:
        if a not in vistos:
            print("AVISO:", a)
            vistos.add(a)
    print(f"{destino}  {mb:.1f} MB")
    if mb > LIMITE_MB:
        print(f"AVISO: passou de {LIMITE_MB} MB — tirar vídeo/fotos sobrando antes de entregar.")
