#!/usr/bin/env bash
#
# Cria uma cópia do template Decare já com as cores, o nome e o ano do cliente
# trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> <#COR> "<Nome do Cliente>" [<#COR2>] [<#ESCURO>] [<#CLARO>]
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#263A32' 'Dra. Fulana' '#526259' '#1B1E1C' '#F5F2EC'
#
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

# Cores do template, tudo hex/rgb literal em css/style.css, css/default.css,
# css/responsive.css e em style="" inline nos HTML:
#   #3660d9 / rgb(54,96,217)  — acento: botões, links, ícones, kicker, gradiente (238x + 27x + rgba 4x)
#   rgb(9,152,230) / #4e6087  — acento 2: outra ponta do gradiente dos botões e da barra de
#                                agendamento (27x); fundo do breadcrumb das internas (inline)
#   #3763eb                   — hover de botão (6x)
#   #00173c #0e264f / rgb(14,38,79) #010f2e #030c26 #002e5b #08162f #00081b
#   #101c38 #162542 #12265a #2a436c #00163b #010c26
#                             — escuros: títulos, FAQ, CTA, rodapé, copyright, botão
#                                da barra de agendamento, menu offcanvas do celular
#   #eaedff #bacdff #d7dff7 #e4e9ff #cacfef — claros: bordas de card, tint, hover de link
#   #444d69 #8990b0 #b2c0d8   — cinzas azulados de texto, placeholder e link do rodapé
# Sobra uma cauda de 1x cada (cor de rede social, #1a237e, #8145da...) que não
# aparece em página nenhuma da home — não vale o sed.
COR_ORIGINAL='#3660d9'
COR2_ORIGINAL='#4e6087'
HOVER_ORIGINAL='#3763eb'
ESCUROS_ORIGINAIS='#00173c #0e264f #010f2e #030c26 #002e5b #08162f #00081b #101c38 #162542 #12265a #2a436c #00163b #010c26'
CLAROS_ORIGINAIS='#eaedff #bacdff #d7dff7 #e4e9ff #cacfef'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"
COR2="${4:-}"
ESCURO="${5:-}"
CLARO="${6:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> <#COR> \"<Nome do Cliente>\" [<#COR2>] [<#ESCURO>] [<#CLARO>]" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#263A32' 'Dra. Fulana' '#526259' '#1B1E1C' '#F5F2EC'" >&2
  exit 1
fi

hex_rgb()   { printf '%d, %d, %d' "$((16#${1:1:2}))" "$((16#${1:3:2}))" "$((16#${1:5:2}))"; }
escurecer() { printf '#%02X%02X%02X' $((16#${1:1:2} * $2 / 100)) $((16#${1:3:2} * $2 / 100)) $((16#${1:5:2} * $2 / 100)); }
clarear()   { printf '#%02X%02X%02X' $(( (16#${1:1:2} + 255*5) / 6 )) $(( (16#${1:3:2} + 255*5) / 6 )) $(( (16#${1:5:2} + 255*5) / 6 )); }

HOVER="$(escurecer "$COR" 88)"
[ -z "$COR2" ]   && COR2="$(escurecer "$COR" 70)"
[ -z "$ESCURO" ] && ESCURO="$(escurecer "$COR" 55)"
[ -z "$CLARO" ]  && CLARO="$(clarear "$COR")"

for c in "$COR" "$COR2" "$ESCURO" "$CLARO"; do
  if ! [[ "$c" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
    echo "erro: cor precisa ser hex de 6 dígitos, tipo '#263A32' (recebi '$c')" >&2
    exit 1
  fi
done

if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

trocar() {
  local de="$1" para="$2" rotulo="$3"
  echo "→ $rotulo: $de → $para"
  grep -rIil -- "$de" "$DESTINO/css" "$DESTINO"/*.html 2>/dev/null | while read -r f; do
    sed -i "s/${de}/${para}/gI" "$f"
  done
}

# hover antes do acento: se a cor do cliente coincidir com o azul do hover,
# a ordem inversa trocaria o hover recém-aplicado
trocar "$HOVER_ORIGINAL" "$HOVER" "hover do botão"
trocar "$COR_ORIGINAL"   "$COR"   "cor de acento"
trocar '#1f53db'         "$COR"   "cor de acento (borda de botão)"
trocar "$COR2_ORIGINAL"  "$COR2"  "acento 2 (breadcrumb)"
for e in $ESCUROS_ORIGINAIS; do trocar "$e" "$ESCURO" "escuro"; done
for c in $CLAROS_ORIGINAIS; do trocar "$c" "$CLARO" "claro"; done
# rgb() em decimal: o template escreve com e sem espaço
trocar '54, \?96, \?217' "$(hex_rgb "$COR")"    "rgb do acento"
trocar '9, \?152, \?230' "$(hex_rgb "$COR2")"   "rgb do acento 2 (gradiente)"
trocar '14, \?38, \?79'  "$(hex_rgb "$ESCURO")" "rgb do escuro (botão da barra)"
# cinzas azulados viram cinzas neutros — só fazem sentido com marca azul
trocar '#444d69' '#4f4f4f' "cinza de texto"
trocar '#8990b0' '#9a9a9a' "cinza de placeholder"
trocar '#b2c0d8' '#c9c9c9' "cinza do rodapé"

echo "→ preenchendo nome e ano"
NOME_ESC="$(escapar "$NOME")"
ANO="$(date +%Y)"
grep -rIl -e '\[NOME DO CLIENTE\]' -e '\[ANO\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g; s/\[ANO\]/${ANO}/g" "$f"
done

restam=$(grep -rIoi -e "$COR_ORIGINAL" -e '#00173c' -e '9,152,230' -e '54,96,217' -e '\[NOME DO CLIENTE\]' "$DESTINO/css" "$DESTINO"/*.html 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Cores aplicadas:  acento $COR · acento 2 $COR2 · hover $HOVER · escuro $ESCURO · claro $CLARO

Falta fazer na mão — o script não tem como adivinhar:

  1. HOME       são três (index, index-2, index-3), iguais abaixo do hero.
                Ficar com UMA, renomear para index.html, apagar as outras
                duas e o submenu "Home Page 01/02/03" do menu. Se não for a
                home 3, apagar img/slider/slider-vedio.mp4 (10 MB).
  2. PÁGINAS    pricing, shop, shop-details, blog, blog-details, team,
                team-single e projects só existem com dado inventado
                (plano, preço, produto, post, equipe). Apagar o que o
                cliente não tem e tirar do menu — inclusive as seções
                correspondentes na home (planos, equipe, depoimentos).
  3. LOGO       img/logo/logo.png (header) e f_logo.png (rodapé, versão
                clara), ambos 376x78, mais img/favicon.ico.
  4. FONTES     Poppins/Roboto via Google Fonts no <head>. Serifada para
                título entra por cima: trocar o link e sobrescrever
                h1-h6 no fim do css/style.css.
  5. TEXTOS     tudo em inglês com lorem ipsum. Traduzir seção por seção.
                Contato fake: info@example.com, +91-7052-101-786,
                1800-121-3637, "1247/Plot No. 39 ... Kanpur" — grep e troca.
  6. FORMS      contact.html posta em mail.php e a newsletter da home em
                news-mail.php — os .php foram apagados (mandavam o form
                para o e-mail do autor do template). Trocar por wa.me ou
                apagar o form.
  7. FOTOS      todo <img> é silhueta cinza. Hero, sobre, equipe, galeria,
                depoimento. Seção sem foto do cliente = apagar a seção.
  8. DEPLOY     sem vercel.json — criar com framework null. Projeto Vercel
                com slug do cliente (skill vercel-cliente-novo).

FIM
