#!/usr/bin/env bash
#
# Copia UM dos 6 demos do pack Luminex (escolha obrigatória) já com a cor de
# marca e o nome do cliente trocados. Os originais em html/<demo>/ nunca são
# alterados — cada cliente sai de uma cópia.
#
#   ./personalizar.sh <demo> <pasta-destino> <#COR> "<Nome do Cliente>"
#
# <demo> é um de: bitelo codexa fortexa luminex storedge visora
#
# Exemplo:
#   ./personalizar.sh fortexa /c/Dev/Captacao-CC/clientes/xyz/site '#00C2A8' 'XYZ Security'
#
# Cada demo tem sua própria paleta (ver README.md) — o script sabe, pra cada
# um, quais variáveis CSS carregam a cor de marca de verdade (algumas usam a
# variável --accent-color pro nome errado — ver Fortexa) e deriva hover/tint/
# escuro a partir da COR informada, do mesmo jeito que o script do Decare.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DEMO="${1:-}"
DESTINO="${2:-}"
COR="${3:-}"
NOME="${4:-}"

DEMOS_VALIDOS="bitelo codexa fortexa luminex storedge visora"

if [ -z "$DEMO" ] || [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <demo> <pasta-destino> <#COR> \"<Nome do Cliente>\"" >&2
  echo "demo: $DEMOS_VALIDOS" >&2
  exit 1
fi

if ! [[ " $DEMOS_VALIDOS " == *" $DEMO "* ]]; then
  echo "erro: demo '$DEMO' inválido. Use um de: $DEMOS_VALIDOS" >&2
  exit 1
fi

if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#00C2A8' (recebi '$COR')" >&2
  exit 1
fi

ORIGEM="$AQUI/html/$DEMO"
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

hex_rgb()   { printf '%d, %d, %d' "$((16#${1:1:2}))" "$((16#${1:3:2}))" "$((16#${1:5:2}))"; }
escurecer() { printf '#%02X%02X%02X' $((16#${1:1:2} * $2 / 100)) $((16#${1:3:2} * $2 / 100)) $((16#${1:5:2} * $2 / 100)); }
# clarear MISTURA%: 0 = cor pura, 100 = branco puro
clarear()   { local m=$2; printf '#%02X%02X%02X' \
                $(( (16#${1:1:2} * (100-m) + 255*m) / 100 )) \
                $(( (16#${1:3:2} * (100-m) + 255*m) / 100 )) \
                $(( (16#${1:5:2} * (100-m) + 255*m) / 100 )); }
escapar()   { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }

HOVER="$(escurecer "$COR" 80)"
SECOND="$(clarear "$COR" 55)"
TINT="$(clarear "$COR" 65)"
LIGHTTINT="$(clarear "$COR" 90)"
ESCURO="$(escurecer "$COR" 55)"

echo "→ copiando demo '$DEMO' para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

trocar() {
  local de="$1" para="$2" rotulo="$3"
  [ -z "$de" ] && return 0
  # nem toda cor/variante aparece em todo demo — grep sem match (exit 1) não
  # pode derrubar o script com "set -e -o pipefail"
  { grep -rIil -- "$de" "$DESTINO" 2>/dev/null | while read -r f; do
      sed -i "s/${de}/${para}/gI" "$f"
    done
  } || true
  echo "→ $rotulo: $de → $para"
}

# Ícone de +/-, seta e afins entram como <svg> dentro de background-image:
# url('data:image/svg+xml,...fill="%23HEXHEX"...'), com o '#' escapado como
# %23 — o hex sozinho (sem #) também precisa ser trocado nessa forma, senão
# esses ícones ficam com a cor antiga.
trocar_hex() {
  local de="$1" para="$2" rotulo="$3"
  trocar "$de" "$para" "$rotulo"
  trocar "%23${de:1}" "%23${para:1}" "$rotulo (ícone svg inline)"
}

# ---------------------------------------------------------------- por demo
# Cada bloco documenta, no README.md deste template, qual variável do
# css/style.css é a cor de marca de verdade — nem sempre é --accent-color.
case "$DEMO" in

  bitelo)
    # --accent-color (azul) + --accent-hover. Único tom, direto.
    trocar_hex '#2868ed' "$COR"   "acento"
    trocar_hex '#2a71d3' "$HOVER" "hover"
    trocar "$(hex_rgb '#2868ed')" "$(hex_rgb "$COR")"   "rgb do acento"
    trocar "$(hex_rgb '#2a71d3')" "$(hex_rgb "$HOVER")" "rgb do hover"
    ;;

  codexa)
    # --accent-color (azul) + tons -5/-6 (tints usados em gradiente e fundo)
    # e dois tons extras só de gradiente (#98C1FF) sem variável própria.
    trocar_hex '#267dff' "$COR"       "acento"
    trocar_hex '#8ebbff' "$TINT"      "tint (accent-color-5)"
    trocar_hex '#e8f1ff' "$LIGHTTINT" "tint claro (accent-color-6, fundo)"
    trocar_hex '#98c1ff' "$TINT"      "tint do gradiente do hero"
    trocar "$(hex_rgb '#267dff')" "$(hex_rgb "$COR")" "rgb do acento"
    ;;

  fortexa)
    # ⚠️ --accent-color aqui é #e6e6e6 (cinza claro de texto/ícone em fundo
    # escuro) — NÃO é a cor de marca. O verde neon é --accent-hover +
    # --text-color-2, usado nos gradientes do hero/CTA. Deixar --accent-color
    # como está (cinza neutro); trocar só a família verde.
    trocar_hex '#1aff7c' "$COR"    "acento real (accent-hover, verde neon)"
    trocar_hex '#71ffae' "$SECOND" "verde claro (text-color-2)"
    trocar "$(hex_rgb '#1aff7c')" "$(hex_rgb "$COR")"    "rgb do acento"
    trocar "$(hex_rgb '#71ffae')" "$(hex_rgb "$SECOND")" "rgb do verde claro"
    trocar '0, 230, 138' "$(hex_rgb "$ESCURO")" "resíduo de verde só no gradiente (sem variável)"
    ;;

  luminex)
    # Dois tons de marca: --accent-color (roxo) e --accent-color-2 (rosa),
    # mais dois roxos e dois lilases só de gradiente sem variável própria.
    # Com uma cor só de entrada, os dois tons viram tons do mesmo matiz.
    trocar_hex '#9e56e6' "$COR"       "acento (roxo)"
    trocar_hex '#ff77e9' "$SECOND"    "acento 2 (rosa)"
    trocar_hex '#9747ff' "$COR"       "roxo do gradiente do hero"
    trocar_hex '#a855f7' "$COR"       "roxo do gradiente radial"
    trocar_hex '#dbb7ff' "$TINT"      "lilás claro do gradiente radial"
    trocar_hex '#e8d2ff' "$LIGHTTINT" "lilás bem claro do gradiente do hero"
    trocar "$(hex_rgb '#9e56e6')" "$(hex_rgb "$COR")" "rgb do acento"
    trocar '151, 71, 255' "$(hex_rgb "$COR")"       "rgb do gradiente (accent-color-6)"
    trocar '232, 210, 255' "$(hex_rgb "$LIGHTTINT")" "rgb claro do gradiente (accent-color-6)"
    ;;

  storedge)
    # --accent-color (azul) + --accent-color-5 (variante próxima, mesmo tom)
    # + --accent-color-8 (tint claro). --accent-color-6/-7 são verde
    # semântico (status/uptime) — não são cor de marca, ficam como estão.
    trocar_hex '#2563eb' "$COR"       "acento"
    trocar_hex '#2083ff' "$COR"       "variante do acento (accent-color-5)"
    trocar_hex '#e4eef9' "$LIGHTTINT" "tint claro (accent-color-8)"
    trocar "$(hex_rgb '#2563eb')" "$(hex_rgb "$COR")"    "rgb do acento"
    trocar "$(hex_rgb '#2083ff')" "$(hex_rgb "$COR")"    "rgb da variante"
    trocar '21, 56, 133' "$(hex_rgb "$ESCURO")" "azul escuro do gradiente-2 (sem variável)"
    ;;

  visora)
    # --accent-color (laranja). Único tom, direto — igual ao Bitelo.
    trocar_hex '#ff6800' "$COR" "acento"
    trocar "$(hex_rgb '#ff6800')" "$(hex_rgb "$COR")" "rgb do acento"
    ;;
esac

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl -- '\[NOME DO CLIENTE\]' "$DESTINO" 2>/dev/null | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIl -- '\[NOME DO CLIENTE\]' "$DESTINO" 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO (demo: $DEMO)
Arquivos com "[NOME DO CLIENTE]" ainda sem preencher: $restam (esperado: 0)

Cores aplicadas: acento $COR · hover $HOVER · segunda cor $SECOND · escuro $ESCURO

Falta fazer na mão — o script não tem como adivinhar:

  1. TEXTOS     tudo em inglês, com copy de SaaS/startup (features, planos de
                software, "book a demo"). Traduzir e reescrever seção por
                seção pro negócio real do cliente — não é serviço de TI toda
                empresa que usa esse pack.
  2. PÁGINAS    pricing/pricing_plan, blog, team, gallery e case-study/study_case
                só existem com dado inventado (plano, preço, post, equipe,
                estudo de caso). Apagar o que o cliente não tem e tirar do
                menu — inclusive as seções correspondentes na home.
  3. LOGO       image/logo/ (verificar nome exato dentro da pasta do demo) e
                favicon — o pack não traz identidade nenhuma, é genérico.
  4. FONTES     as fontes vêm auto-hospedadas em font/ (bem pesado — 20-30MB
                por demo). Nos outros sites deste workspace a fonte entra via
                Google Fonts CDN no <head>; considerar trocar em vez de
                carregar os arquivos locais.
  5. FOTOS      todo <img> é placeholder cinza (dummy-img-*.jpg) — sem foto
                real de cliente nenhuma. Seção sem material do cliente = ou
                fica ilustrativa e marcada, ou é apagada.
  6. FORMS      formulário de contato não tem back-end configurado nesse
                pack — trocar por wa.me ou apagar.
  7. DEPLOY     sem vercel.json — criar com framework null. Projeto Vercel
                com slug do cliente (skill vercel-cliente-novo).

FIM
