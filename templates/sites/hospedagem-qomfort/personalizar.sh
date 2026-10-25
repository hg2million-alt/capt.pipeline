#!/usr/bin/env bash
#
# Cria uma cópia do template Qomfort (hospedagem) já com a cor de marca e o
# nome do cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>" [home]
#
# Exemplos:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2e6b4f' 'Pousada XYZ' index2
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2e6b4f' 'Chácara XYZ' index3
#
# [home] = index | index2 | index3 (ver README):
#   index2 -> pousada / hotel pequeno (barra de reserva logo abaixo do hero)
#   index3 -> chácara / casa de temporada (form de reserva ao lado do hero,
#             barra de topo com telefone/e-mail, bloco de "pacotes")
#   index  -> layout mais "resort" (hero escuro com brilho); 3ª opção
# Com [home], a home escolhida vira index.html, as outras 2 são apagadas e o
# dropdown "Início" do menu vira um link simples. Sem [home], copia as 3.
#
# Cor de marca do template: cobre #AB6034 (conferido por screenshot — é a cor
# do botão, faixa do Instagram, preço, ícones, barra de topo do index3 e do
# brilho radial dos fundos escuros). Onde ela vive:
#   --primary-color: #AB6034   (:root de assets/css/style.css) — 109 var()
#   #AB6034 cru                — 1 uso (.ratting i, estrelas)
#   rgba(171, 96, 52, X)       — 56 usos (brilho dos fundos escuros, sombras)
#   #F7F0EB                    — 2 usos, tinta 10% da marca (fundo de ícone)
#   PNG/GIF com a cor pintada  — shapes/slider-circle-half.png (hero do index),
#                                icons/sidebar-toggler-color.png (index3),
#                                preloader.gif (casinha animada, toda página)
#   logos/logo*.png + favicon  — ícone de hotel + "QOMFORT" desenhados: MANUAL
# O fundo escuro #1D1B1A/#0C0B0B (carvão) é neutro, não é marca — fica.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#AB6034'
RGB_ORIGINAL='171, 96, 52'
TINTA_ORIGINAL='#F7F0EB'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"
HOME_ESCOLHIDA="${4:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\" [index|index2|index3]" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#2e6b4f' 'Pousada XYZ' index2" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#2e6b4f' (recebi '$COR')" >&2
  exit 1
fi
if [ -n "$HOME_ESCOLHIDA" ] && ! [[ "$HOME_ESCOLHIDA" =~ ^index[23]?$ ]]; then
  echo "erro: home precisa ser index, index2 ou index3 (recebi '$HOME_ESCOLHIDA')" >&2
  exit 1
fi
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

"$PYTHON_BIN" - "$DESTINO" "$COR" "$NOME" "$HOME_ESCOLHIDA" "$COR_ORIGINAL" "$RGB_ORIGINAL" "$TINTA_ORIGINAL" <<'PY'
import sys, os, re, glob, colorsys, html

destino, cor, nome, home, cor_orig, rgb_orig, tinta_orig = sys.argv[1:8]
os.chdir(destino)

def hex2rgb(h):
    h = h.lstrip('#'); return tuple(int(h[i:i+2], 16) for i in (0, 2, 4))

r, g, b = hex2rgb(cor)
# tinta clara = 10% da cor sobre branco (mesma relação #AB6034 -> #F7F0EB)
tinta = '#%02X%02X%02X' % tuple(round(255 * 0.9 + c * 0.1) for c in (r, g, b))

# ---- cor: CSS compilado + SASS fonte (sass não roda, mas fica coerente) ----
arquivos = ['assets/css/style.css'] + glob.glob('assets/sass/**/*.sass', recursive=True)
tot = {'hex': 0, 'rgba': 0, 'tinta': 0}
for f in arquivos:
    s = open(f, encoding='utf-8').read(); o = s
    tot['hex'] += len(re.findall(re.escape(cor_orig), s, re.I))
    s = re.sub(re.escape(cor_orig), cor.upper(), s, flags=re.I)
    tot['rgba'] += s.count(rgb_orig)
    s = s.replace(rgb_orig, f'{r}, {g}, {b}')
    tot['tinta'] += len(re.findall(re.escape(tinta_orig), s, re.I))
    s = re.sub(re.escape(tinta_orig), tinta, s, flags=re.I)
    if s != o:
        open(f, 'w', encoding='utf-8', newline='').write(s)
print(f"→ cor de marca {cor_orig} → {cor.upper()} ({tot['hex']} hex, incl. --primary-color que alimenta 109 var())")
print(f"→ rgba({rgb_orig}, X) → rgba({r}, {g}, {b}, X) ({tot['rgba']} usos)")
print(f"→ tinta clara {tinta_orig} → {tinta} ({tot['tinta']} usos)")

# ---- PNG/GIF com a cor pintada: recolore mantendo luz/alfa ----
try:
    from PIL import Image, ImageSequence
    ho, lo, so = colorsys.rgb_to_hls(*(c / 255 for c in hex2rgb(cor_orig)))
    hn, ln, sn = colorsys.rgb_to_hls(r / 255, g / 255, b / 255)

    def px(p):
        pr, pg, pb = p[:3]
        h, l, s = colorsys.rgb_to_hls(pr / 255, pg / 255, pb / 255)
        dh = min(abs(h - ho), 1 - abs(h - ho))
        if s < 0.15 or dh > 0.08:
            return p
        l2 = max(0, min(1, l + (ln - lo)))
        s2 = max(0, min(1, sn * (s / so) if so else sn))
        nr, ng, nb = colorsys.hls_to_rgb(hn, l2, s2)
        return (round(nr * 255), round(ng * 255), round(nb * 255)) + tuple(p[3:])

    def recolor(im):
        im = im.convert('RGBA'); d = im.load()
        for y in range(im.height):
            for x in range(im.width):
                d[x, y] = px(d[x, y])
        return im

    for f in ['assets/images/shapes/slider-circle-half.png', 'assets/images/icons/sidebar-toggler-color.png']:
        recolor(Image.open(f)).save(f)
    gif = 'assets/images/preloader.gif'
    src = Image.open(gif)
    frames, durs = [], []
    for fr in ImageSequence.Iterator(src):
        durs.append(fr.info.get('duration', 50))
        frames.append(recolor(fr.copy()).convert('RGB'))
    frames[0].save(gif, save_all=True, append_images=frames[1:], duration=durs, loop=0, disposal=2)
    print("→ recoloridos: slider-circle-half.png, sidebar-toggler-color.png, preloader.gif")
except ImportError:
    print("!! Pillow não instalado — slider-circle-half.png, sidebar-toggler-color.png e")
    print("   preloader.gif continuam cobre. pip install pillow e rode de novo, ou troque na mão.")

# ---- home escolhida ----
if home:
    if home != 'index':
        os.replace(f'{home}.html', 'index.html')
    for h in ('index2.html', 'index3.html'):
        if os.path.exists(h):
            os.remove(h)
    dd = re.compile(r'<li class="dropdown"><a href="#">Início</a>\s*<ul>.*?</ul>\s*</li>', re.S)
    for f in glob.glob('*.html'):
        s = open(f, encoding='utf-8').read()
        s = dd.sub('<li><a href="index.html">Início</a></li>', s)
        open(f, 'w', encoding='utf-8', newline='').write(s)
    print(f"→ home: {home}.html virou index.html; as outras homes foram apagadas e o menu 'Início' virou link simples")

# ---- nome ----
n = 0
for f in glob.glob('*.html'):
    s = open(f, encoding='utf-8').read()
    n += s.count('[NOME DO CLIENTE]')
    s = s.replace('[NOME DO CLIENTE]', html.escape(nome, quote=False))
    open(f, 'w', encoding='utf-8', newline='').write(s)
print(f"→ nome do cliente: {n} ocorrência(s) de [NOME DO CLIENTE] preenchidas")
PY

restam=$(grep -rIoi -e "${COR_ORIGINAL}" -e "${RGB_ORIGINAL}" -e "${TINTA_ORIGINAL}" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           assets/images/logos/logo.png (header claro-sobre-escuro,
                     index + rodapé), logo-black.png (header branco: páginas
                     internas e index3) e logo-white.png (index2) trazem o
                     ícone de hotel + a palavra "QOMFORT" DESENHADOS no PNG.
                     Trocar os 3 pela logo real, mesmo nome de arquivo.
                     favicon.png (ícone de hotel cobre) idem.
  2. FOTOS          TODAS as imagens são placeholder cinza com a medida escrita
                     dentro ("1920X520", "410X270"...) — hero, quartos,
                     galeria, blog, Instagram, equipe, depoimento. Nenhuma foto
                     real no pacote. Sem foto do cliente o demo fica com cara
                     de maquete. Trocar mantendo nome/proporção.
  3. CONTATO        [TELEFONE], [EMAIL], [SITE], [ENDEREÇO] e [INSTAGRAM] ficam
                     em header (toda página), topo do index3, faixa do Instagram (toda
                     página), contact.html e mapas. [WHATSAPP] fica em
                     assets/js/wa-forms.js (1x) e no botão "Reservar" do header
                     de toda página (href wa.me). Só dígitos com DDI+DDD
                     (ex: 5533999999999). Ex. de replace em lote:
                       grep -rl '\[TELEFONE\]' $DESTINO | xargs sed -i 's/\[TELEFONE\]/(33) 99999-9999/g'
                     (tel: dos links também usa [TELEFONE] — deixar só dígitos lá).
  4. MAPA           contact.html e room-details.html usam
                     google.com/maps?q=[ENDEREÇO]&output=embed (sem API key).
                     Trocar [ENDEREÇO] pelo endereço real (com + no lugar de
                     espaço funciona) ou apagar o bloco.
  5. PREÇOS         Diárias em DÓLAR chutadas (\$59, \$84, \$173 "per night"...)
                     em homes e páginas de quarto, e o bloco "Corporate Pricing
                     Package" do index3 e do services.html (\$19.56 "per month" — não faz sentido
                     pra hotel). Sem preço real: tirar o preço do card ou
                     marcar "sob consulta". No index3 esse bloco pode virar
                     "Diária / Fim de semana / Evento" SE o cliente passar os
                     valores.
  6. NÚMEROS FAKE    contadores animados ("Projects complete", "Luxury
                     Rooms", "Beaches" — número no atributo data-stop do
                     <span class="count-text">), "25+ Years Of Experience", barras
                     de "Quality 86%", estrelas 5/5, depoimentos com nome
                     inventado (Diane C. Valentine, Michael A. Braun...),
                     assinatura "Robert L. Robinson / CEO & Founder" (about/
                     signature.png é PNG). Tirar ou marcar "ilustrativo".
  7. VÍDEO          Botões de play (index, index2, index3) abrem um vídeo do
                     YouTube de demonstração do pacote (watch?v=9Y7ma241N8k),
                     não do cliente. Trocar pelo vídeo real ou remover o botão.
  8. CALENDÁRIO     room-details.html tem um calendário (FullCalendar) em
                     pt-BR no mês atual, mas SEM disponibilidade real — é só
                     um calendário. Não vender como "disponibilidade online";
                     se incomodar, apagar a div #calendar.
  9. TEXTO          Menu, rodapé, formulários, títulos de página e botões já
                     estão em pt-BR. O corpo (títulos de seção tipo "Explore
                     Luxury Hotel & Suites", parágrafos lorem ipsum, lista de
                     comodidades do quarto, "Rules & Regulations", FAQ, blog)
                     segue em inglês — reescrever com o tom do identidade.md.
                     A lista "Comodidades" do rodapé (Café da manhã, Wi-Fi,
                     Estacionamento, Piscina, Área de lazer) é EXEMPLO —
                     confirmar com o cliente o que ele tem de verdade.
 10. NEWSLETTER     o "Novidades / Assinar" do rodapé (toda página) é
                     decorativo (action="#"). Apagar o bloco ou plugar algo real.
                     Busca e comentário do blog-details também são decorativos.
 11. REDES          ícones sociais (header lateral, rodapé, topo do index3)
                     apontam pra "#", e o rodapé traz Behance/LinkedIn.
                     Deixar só as redes que o cliente tem.
 12. QA VISUAL      abrir num navegador de verdade e testar em ~390px. Se a
                     COR nova for clara, o texto branco dos botões pode perder
                     contraste.
FIM
exit 0
