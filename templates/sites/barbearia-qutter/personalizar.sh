#!/usr/bin/env bash
#
# Cria uma cópia do template Qutter já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2e7d32' 'Barbearia XYZ'
#
# Este template foi comprado com SASS fonte (assets/sass/), mas o HTML só
# carrega o .css já compilado em assets/css/style.css — o .sass não roda em
# runtime, fica só documentando a intenção original ($primary-color: #d6a354).
# A cor de marca é hex hardcoded no CSS compilado (mesmo caso do Oyoxo):
#   #d6a354 (dourado) — 79 usos no style.css (botão, preço, ícone ativo,
#     borda de destaque, hover de menu). É A cor de marca.
#   #d69838 — 1 uso só, background do hover do botão (uma versão ~5% mais
#     escura do dourado acima, gerada pela função darken() do SASS original).
#     O script deriva essa sombra automaticamente a partir da COR escolhida
#     (mesma técnica do CoolAir pra cor secundária), não fica hardcoded.
#   #ff7800 / #ffaa17 — cor fixa do ícone de estrela (avaliação/rating),
#     NÃO é a cor de marca — o script não mexe nisso.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#d6a354'
COR_HOVER_ORIGINAL='#d69838'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#2e7d32' 'Barbearia XYZ'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#2e7d32' (recebi '$COR')" >&2
  exit 1
fi
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

PYTHON_BIN="python"
"$PYTHON_BIN" --version >/dev/null 2>&1 || PYTHON_BIN="python3"
export PYTHONIOENCODING=utf-8

escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

CSS="$DESTINO/assets/css/style.css"

echo "→ cor de marca ($COR_ORIGINAL, hex hardcoded): $COR_ORIGINAL → $COR"
sed -i "s/${COR_ORIGINAL}/${COR}/gI" "$CSS"

"$PYTHON_BIN" - "$CSS" "$COR" "$COR_HOVER_ORIGINAL" <<'PY'
import sys, colorsys

css_path, cor, hover_original = sys.argv[1], sys.argv[2], sys.argv[3]

def hex_to_rgb(h):
    h = h.lstrip('#')
    return tuple(int(h[i:i+2], 16) for i in (0, 2, 4))

def rgb_to_hex(rgb):
    return '#%02x%02x%02x' % rgb

r, g, b = hex_to_rgb(cor)
h, l, s = colorsys.rgb_to_hls(r / 255, g / 255, b / 255)
# mesma proporção de escurecimento entre #d6a354 -> #d69838 no original (~7% de lightness)
l = max(0.0, l - 0.07)
r2, g2, b2 = colorsys.hls_to_rgb(h, l, s)
hover_novo = rgb_to_hex((round(r2 * 255), round(g2 * 255), round(b2 * 255)))

s_css = open(css_path, encoding='utf-8').read()
n = s_css.lower().count(hover_original.lower())
s_css = s_css.replace(hover_original, hover_novo).replace(hover_original.upper(), hover_novo)
open(css_path, 'w', encoding='utf-8').write(s_css)
print(f"→ sombra de hover derivada: {hover_original} → {hover_novo} ({n} uso(s))")

# rgba(214, 163, 84, X) -> rgba(novoR, novoG, novoB, X), as 3 variações de opacidade
s_css = open(css_path, encoding='utf-8').read()
old_rgb = "214, 163, 84"
new_rgb = f"{r}, {g}, {b}"
n2 = s_css.count(old_rgb)
s_css = s_css.replace(old_rgb, new_rgb)
open(css_path, 'w', encoding='utf-8').write(s_css)
print(f"→ rgba() da cor de marca: rgba({old_rgb}, X) → rgba({new_rgb}, X) ({n2} uso(s))")
PY

echo "→ trocando os fundos que só existiam como placeholder cinza com a dimensão escrita
   dentro (ex: '1920X500') por um gradiente na cor de marca — banner interno de página,
   os 3 heroes de home, e mais 9 fundos de seção menores. Nenhum deles é foto de verdade."
"$PYTHON_BIN" - "$DESTINO" "$COR" <<'PY'
import sys, glob, os

destino, cor = sys.argv[1], sys.argv[2]
GRAD = f"linear-gradient(135deg, {cor} 0%, #1f1f1f 100%)"

# (arquivo, url original) -> todos viram o mesmo gradiente de marca
alvos = [
    "assets/images/banner/banner.jpg",
    "assets/images/hero/hero-bg.jpg",
    "assets/images/hero/hero-two.jpg",
    "assets/images/hero/hero-two-left.jpg",
    "assets/images/hero/hero-three.jpg",
    "assets/images/services/service-bg.jpg",
    "assets/images/background/pricing-plan-bg.jpg",
    "assets/images/background/pricing-plan-three.jpg",
    "assets/images/background/offer-page-price.jpg",
    "assets/images/background/working-hour-bg.jpg",
    "assets/images/background/video-bg-two.jpg",
    "assets/images/background/blog-bg.jpg",
    "assets/images/about/what-we-do.jpg",
    "assets/images/contact/left.jpg",
    "assets/images/contact/right.jpg",
]

total = 0
for path in glob.glob(os.path.join(destino, "*.html")):
    s = open(path, encoding="utf-8").read()
    orig = s
    for rel in alvos:
        s = s.replace(f"url({rel})", GRAD)
    if s != orig:
        n = sum(orig.count(f"url({rel})") for rel in alvos)
        total += n
        open(path, "w", encoding="utf-8").write(s)
print(f"→ {total} fundo(s) trocado(s) por gradiente em html/*.html")
PY

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "${COR_ORIGINAL}" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           assets/images/logos/logo.png (header, usado em quase toda
                     página) E assets/images/hero/logo.png (variante usada só
                     em index3.html) trazem o ícone (tesoura+bigode) + a
                     palavra "QUTTER" + o subtítulo "Hair Salon" desenhados
                     dentro do PNG — não é texto, o script não alcança.
                     Trocar os 2 arquivos pela logo real do cliente.
  2. FAVICON        assets/images/favicon.png é só o ícone (tesoura+bigode)
                     sem texto — genérico, pode ficar ou trocar pela marca
                     real do cliente.
  3. TUDO É PLACEHOLDER. Igual o Oyoxo, este template não trouxe NENHUMA foto
                     real — hero, banners internos, galeria (gellary/),
                     equipe (team/), depoimento (testimonials/) são todos
                     retângulo cinza com a dimensão escrita dentro. O script
                     já trocou os 15 fundos de CSS por gradiente na cor de
                     marca (ver acima) — mas toda foto que é <img> solta
                     (galeria, equipe, retrato de depoimento, antes/depois em
                     portfolio) continua placeholder até entrar foto real do
                     cliente. Sem isso o site fica com cara de maquete.
  4. TESTEMUNHOS    "premium sponsors" (about.html/index.html) e os selos de
                     logo de empresa dentro de cada card de depoimento
                     (about.html/index2.html/index3.html) já foram REMOVIDOS
                     na cópia-base — o pacote original citava marca de
                     terceiro sem relação nenhuma com barbearia (uma delas
                     era "natural mineral water"), não fazia sentido pro
                     nicho e não tinha como virar informação real do
                     cliente. O texto do depoimento em si, nome
                     ("Donald A. Guthrie" etc.) e nota continuam fictícios —
                     usar só com aviso "ilustrativo" visível, nunca como
                     depoimento real. Nome de equipe (team/memberN.jpg) não
                     vem com nome atrelado nesta cópia (só alt="Member"), o
                     que ajuda: trocar a FOTO já resolve, sem precisar
                     inventar nome.
  5. BADGE EST.1996  assets/images/about/logo.png é um selo "Barber Shop —
                     Haircuts & Shaves — EST. 1996" desenhado dentro do PNG
                     (about.html e index2.html, logo acima do texto "sobre").
                     1996 é fictício — não usar a menos que seja o ano real
                     de fundação do cliente. Sem confirmação, esconder o
                     elemento (a classe do wrapper é ".about-content-two
                     .logo") ou trocar a imagem por um selo real do cliente.
  6. PREÇO          pricing.html (3 planos: Regular/Standard/Premium) e a
                     seção "smart offer" de offers.html trazem valor em
                     dólar chutado. Sem tabela real do cliente, apagar a
                     seção — não estimar "valor de mercado".
  7. CONTATO        WhatsApp/telefone e e-mail ficam como [WHATSAPP] e
                     [EMAIL] em todo o header/rodapé/contact.html — inclusive
                     dentro dos formulários (ver item 8). [WHATSAPP] precisa
                     ser só dígitos com DDI+DDD (ex: 5533999999999). Endereço
                     e mapa (contact.html) continuam com o endereço fictício
                     original do template — trocar pelo endereço real ou
                     marcar "a confirmar".
  8. FORMULÁRIOS    o "send message" (contact.html) e os dois "appointment"
                     (services.html, service-details.html) já foram trocados
                     pra abrir WhatsApp via assets/js/wa-forms.js, com a
                     mensagem montada a partir dos campos preenchidos — o
                     form-process.php original (PHP mail(), não roda em
                     hospedagem estática) foi removido. Só falta preencher
                     [WHATSAPP] no próprio wa-forms.js (2 ocorrências) antes
                     de publicar. O formulário "newsletter subscribe" do
                     rodapé (todas as páginas) continua sem back-end nenhum
                     — é decorativo; apagar do rodapé ou plugar um serviço de
                     e-mail marketing se o cliente quiser usar de verdade.
  9. VÍDEO           o botão de play do hero (about.html, index.html, index2.html,
                     service-details.html) abre um vídeo do YouTube que é
                     conteúdo de demonstração do template
                     (youtube.com/watch?v=9Y7ma241N8k), não do cliente —
                     trocar pelo vídeo real do salão ou remover o botão de
                     play antes de publicar.
 10. TEXTO           corpo em inglês (lang já ajustado pra pt-BR, mas o
                     conteúdo textual — parágrafos "Lorem ipsum" style,
                     títulos de seção etc. — segue em inglês). Reescrever com
                     o tom de voz do identidade.md do cliente, não é tradução
                     literal.
 11. TITLE           cada <title> ainda tem "[NOME DO CLIENTE] | Página" —
                     conferir se o texto depois da barra ainda faz sentido.
 12. QA VISUAL        abrir num navegador de verdade antes de publicar — o
                     gradiente cobre o retângulo cinza inteiro, mas o
                     contraste do texto por cima pode precisar ajuste
                     dependendo da COR escolhida (cor clara = texto branco
                     pode ficar fraco). Testar em ~390px de largura também.
FIM
exit 0
