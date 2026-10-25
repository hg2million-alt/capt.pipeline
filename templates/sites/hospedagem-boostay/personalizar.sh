#!/usr/bin/env bash
#
# Cria uma cópia do template Boostay (hospedagem) já com a cor de marca e o
# nome do cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>" [home] ['#COR_ESCURA']
#
# Exemplos:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2E7D32' 'Pousada XYZ'
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2E7D32' 'Pousada XYZ' index-3
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2E7D32' 'Chácara XYZ' index-2 '#1B2A1F'
#
# [home] = qual das 4 homes vira o index.html do destino (index, index-2,
#   index-3, index-5 — ver README). As outras homes são APAGADAS do destino
#   (o menu não linka pra elas; ficariam órfãs no ar). Padrão: index.
#
# Cores do template (ver README, seção "Onde fica a cor de marca"):
#   #AF8C3E (dourado) — A cor de marca: botão, CTA, ícone, preço, destaque.
#     Vive em 4 lugares, o script troca TODOS:
#       - CSS: --rr-theme-primary no :root (238 usos via var) + 25 hex crus
#         no main.css (fora do :root — sem trocar, sobra dourado)
#       - HTML: 57 fill="#AF8C3E" em SVG inline (ícones de room-details,
#         event, index-2, about-us, index)
#       - PNG: 6 ícones dourados desenhados (assets/imgs/about/1.png, 2.png,
#         s.png; feature/1.png, 2.png, 3.png) — recoloridos via Pillow
#       - SVG do logo/favicon: o ícone de prédio é um PNG dourado embutido em
#         base64 dentro do SVG — recolorido via Pillow
#   #0E1730 (azul-marinho) — cor ESCURA: header em pílula, rodapé, títulos,
#     seções escuras. Só troca se passar o 5º argumento. Inclui 29 hex no
#     CSS (--rr-heading-primary1 + crus), 92 no HTML (SVG inline), 6 em SVG
#     de assets/imgs, rgba(14, 23, 48, X), o fundo do menu mobile (#0E0A24) e
#     os 2 fundos marinho que são IMAGEM (room/bg.jpg, service/bg.png,
#     usados na index-5).
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"
HOME_ESCOLHIDA="${4:-index}"
COR_ESCURA="${5:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\" [home] ['#COR_ESCURA']" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#2E7D32' 'Pousada XYZ'" >&2
  echo "     $0 /c/Dev/Captacao-CC/clientes/xyz/site '#2E7D32' 'Chácara XYZ' index-2 '#1B2A1F'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#2E7D32' (recebi '$COR')" >&2
  exit 1
fi
if [ -n "$COR_ESCURA" ] && ! [[ "$COR_ESCURA" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor escura precisa ser hex de 6 dígitos, tipo '#1B2A1F' (recebi '$COR_ESCURA')" >&2
  exit 1
fi
case "$HOME_ESCOLHIDA" in
  index|index-2|index-3|index-5) ;;
  *) echo "erro: home '$HOME_ESCOLHIDA' não existe. Use: index, index-2, index-3 ou index-5" >&2; exit 1 ;;
esac
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

PYTHON_BIN="python"
"$PYTHON_BIN" --version >/dev/null 2>&1 || PYTHON_BIN="python3"
export PYTHONIOENCODING=utf-8

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

if [ "$HOME_ESCOLHIDA" != "index" ]; then
  echo "→ usando '${HOME_ESCOLHIDA}.html' como home (index.html)"
  cp "$DESTINO/${HOME_ESCOLHIDA}.html" "$DESTINO/index.html"
fi
for h in index-2 index-3 index-5; do
  rm -f "$DESTINO/${h}.html"
done
echo "→ homes alternativas removidas do destino (ficariam órfãs — o menu só linka index.html)"

"$PYTHON_BIN" - "$DESTINO" "$COR" "$NOME" "$COR_ESCURA" <<'PY'
import sys, os, re, glob, base64, io

destino, cor, nome, cor_escura = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
OURO = '#AF8C3E'
MARINHO = '#0E1730'

def rgb(h):
    h = h.lstrip('#')
    return tuple(int(h[i:i + 2], 16) for i in (0, 2, 4))

try:
    from PIL import Image
    TEM_PIL = True
except Exception:
    TEM_PIL = False
    print('!! Pillow não instalado (pip install pillow): ícones PNG e o ícone do logo continuam DOURADOS')

def ler(p):
    return open(p, encoding='utf-8').read()

def gravar(p, s):
    open(p, 'w', encoding='utf-8', newline='').write(s)

textos = glob.glob(os.path.join(destino, '*.html')) + glob.glob(os.path.join(destino, 'assets', 'css', '*.css')) \
    + glob.glob(os.path.join(destino, 'assets', 'imgs', '**', '*.svg'), recursive=True)

# ---- cor de marca (dourado) em CSS/HTML/SVG
n = 0
for p in textos:
    s = ler(p)
    s2, k = re.subn(re.escape(OURO), cor, s, flags=re.I)
    if k:
        gravar(p, s2); n += k
print(f'→ cor de marca {OURO} → {cor}: {n} ocorrência(s) em CSS/HTML/SVG (+238 usos via var(--rr-theme-primary))')

# ---- cor escura (opcional)
if cor_escura:
    r, g, b = rgb(cor_escura)
    n = 0
    for p in textos:
        s = ler(p)
        s2, k1 = re.subn(re.escape(MARINHO), cor_escura, s, flags=re.I)
        s2, k2 = re.subn(r'#0E0A24', cor_escura, s2, flags=re.I)
        s2, k3 = re.subn(r'rgba\(14,\s*23,\s*48,', f'rgba({r}, {g}, {b},', s2)
        if k1 + k2 + k3:
            gravar(p, s2); n += k1 + k2 + k3
    print(f'→ cor escura {MARINHO} → {cor_escura}: {n} ocorrência(s) (+29 usos via var(--rr-heading-primary1))')

# ---- recolorir PNG dourado (ícones) e o PNG embutido no logo/favicon
def recolorir(im, alvo, origem=rgb(OURO), tol=70):
    im = im.convert('RGBA')
    px = im.load()
    tr, tg, tb = alvo
    orr, og, ob = origem
    for y in range(im.size[1]):
        for x in range(im.size[0]):
            pr, pg, pb, pa = px[x, y]
            if pa and abs(pr - orr) + abs(pg - og) + abs(pb - ob) < tol:
                px[x, y] = (tr, tg, tb, pa)
    return im

if TEM_PIL:
    alvo = rgb(cor)
    icones = ['about/1.png', 'about/2.png', 'about/s.png', 'feature/1.png', 'feature/2.png', 'feature/3.png']
    for rel in icones:
        p = os.path.join(destino, 'assets', 'imgs', *rel.split('/'))
        if os.path.exists(p):
            recolorir(Image.open(p), alvo).save(p)
    print(f'→ {len(icones)} ícone(s) PNG dourado(s) recolorido(s)')
    for rel in ('logo/logo.svg', 'logo/logo-3.svg', 'logo/favicon.svg'):
        p = os.path.join(destino, 'assets', 'imgs', *rel.split('/'))
        s = ler(p)
        def troca(m):
            raw = base64.b64decode(m.group(2))
            im = recolorir(Image.open(io.BytesIO(raw)), alvo)
            buf = io.BytesIO(); im.save(buf, 'PNG')
            return m.group(1) + base64.b64encode(buf.getvalue()).decode()
        s = re.sub(r'(href="data:image/png;base64,)([A-Za-z0-9+/=]+)', troca, s)
        gravar(p, s)
    print('→ ícone embutido no logo.svg / logo-3.svg / favicon.svg recolorido')
    if cor_escura:
        de = (17, 25, 38)  # tom das 2 imagens-fundo marinho
        dr, dg, db = rgb(cor_escura)
        for rel in ('room/bg.jpg', 'service/bg.png'):
            p = os.path.join(destino, 'assets', 'imgs', *rel.split('/'))
            if not os.path.exists(p):
                continue
            im = Image.open(p).convert('RGB')
            lut = []
            for canal, (o, t) in enumerate(zip(de, (dr, dg, db))):
                lut += [max(0, min(255, v - o + t)) for v in range(256)]
            im.point(lut).save(p)
        print('→ fundos marinho em imagem (room/bg.jpg, service/bg.png) deslocados pra cor escura')

    # banner das páginas internas (breadcrumb.png era placeholder cinza "1920X590")
    base = rgb(cor_escura) if cor_escura else rgb(MARINHO)
    acc = rgb(cor)
    w, h = 1920, 590
    grad = Image.new('RGB', (w, h))
    gp = grad.load()
    for x in range(w):
        t = x / (w - 1)
        c = tuple(int(base[i] * (1 - 0.35 * t) + acc[i] * 0.35 * t) for i in range(3))
        for y in range(h):
            gp[x, y] = c
    grad.save(os.path.join(destino, 'assets', 'imgs', 'breadcrumb', 'breadcrumb.png'))
    print('→ banner das páginas internas (breadcrumb.png, era placeholder cinza) virou gradiente da marca')

# ---- nome do cliente (+ largura do SVG do logo, que é texto)
largura = int(50 + len(nome) * 17 + 6)
n = 0
for p in textos:
    s = ler(p)
    if '[NOME DO CLIENTE]' not in s:
        continue
    k = s.count('[NOME DO CLIENTE]')
    s = s.replace('[NOME DO CLIENTE]', nome.replace('&', '&amp;').replace('<', '&lt;'))
    if p.endswith('.svg') and os.path.basename(p).startswith('logo'):
        s = re.sub(r'viewBox="0 0 \d+ 52" width="\d+"', f'viewBox="0 0 {largura} 52" width="{largura}"', s, count=1)
    gravar(p, s); n += k
print(f'→ nome "{nome}": {n} ocorrência(s) (título, rodapé, textos, logo SVG com {largura}px de largura)')
PY

restam=$(grep -rIoi -e '#AF8C3E' -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css --include=*.svg 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor dourada / [NOME DO CLIENTE] ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           o logo é um SVG com o ícone de prédio (recolorido) + o nome
                     do cliente em TEXTO (Georgia). É provisório — com logo real
                     do cliente, trocar assets/imgs/logo/logo.svg (header claro:
                     index), logo-3.svg (header/rodapé/menu escuros) e
                     favicon.svg. Nome muito longo (>22 letras) fica pequeno
                     no header: o CSS limita a 280px (210px no celular).
  2. FOTOS          TODAS as fotos são placeholder cinza com a medida escrita
                     ("944X840", "1920X590", "410X320"...) — hero, quartos,
                     galeria, sobre, eventos, depoimentos. Nenhuma foto real
                     no pacote. Trocar mantendo o nome do arquivo. O banner
                     das páginas internas já virou gradiente da marca.
  3. WHATSAPP       [WHATSAPP] aparece nos links wa.me de todas as páginas E em
                     assets/js/wa-forms.js (var WHATSAPP). Só dígitos com
                     DDI+DDD, ex: 5533999999999. Trocar nos dois lugares:
                       grep -rl '\[WHATSAPP\]' "$DESTINO" | xargs sed -i 's/\[WHATSAPP\]/5533999999999/g'
  4. CONTATO        [TELEFONE], [EMAIL], [ENDEREÇO], [CIDADE], [INSTAGRAM],
                     [FACEBOOK] — rodapé de todas as páginas, contact.html
                     (inclusive o mapa: iframe com q=[ENDEREÇO], sem API key)
                     e hero da index-5. Sem dado real, marcar "a confirmar" ou
                     remover — nunca publicar o colchete.
  5. TEXTO          menu, rodapé, formulários, barra de reserva e títulos das
                     páginas internas já estão em pt-BR. O CORPO das seções
                     segue em inglês/lorem ("Making travel dreams come true
                     us", "Where Comfort Meets Convenience"...). Reescrever
                     com o tom do identidade.md — não traduzir ao pé da letra.
  6. PREÇOS         cards de quarto/evento trazem preço em DÓLAR chutado
                     ("\$120/day", "\$80 / day"). room-details já diz "Valor
                     sob consulta". Sem tabela real, apagar o preço do card.
  7. NÚMEROS/SELOS  contadores e estrelas fictícios: "14+ Years of
                     experience", "800+ Luxury Apartment", "100+ Award
                     Winning", "50+ Rooms", "4.9 Customer Ratings", estrelas
                     ★★★★★ nos cards, "Unique Place & luxury hotel". Pousada
                     pequena não tem 800 apartamentos — trocar pelo número
                     real ou remover a seção.
  8. DEPOIMENTOS    nomes e textos fictícios (Kane Williamson, Ronald
                     Richards, Abu Talha...) — só com chip "ilustrativo" ou
                     remover. Idem assinatura "Abu Talha / Manager" na index-5.
  9. VÍDEO          botão de play (index-2, index-3) abre vídeo de
                     demonstração do YouTube do pacote — trocar pelo vídeo
                     real ou remover o botão.
 10. SEÇÕES FORA    serviços como "Airport Pickup", "Spa Center", "Juice bar",
     DO NICHO       "Day Spa", "Beach", "Restaurant" nos filtros da galeria
                     (index) e cards de serviço — manter só o que o cliente
                     tem de verdade (piscina, café da manhã, estacionamento,
                     Wi-Fi, área de churrasco...).
 11. CONTRASTE      botões usam texto branco sobre a COR. Se a cor do
                     cliente for clara (amarelo, bege, verde-limão), o texto
                     some — conferir num navegador e escurecer a cor se
                     precisar. Testar em ~390px de largura.
FIM
exit 0
