#!/usr/bin/env bash
#
# Cria uma cópia da one-page de pizzaria já com a cor de marca, o nome e o
# WhatsApp do cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> <#COR> "<Nome do Cliente>" <WHATSAPP> [<#COR-APOIO>] [<#COR-HOVER>]
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#FF7A16' 'Pizzaria XYZ' '5533999990000'
#
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

# Três cores, todas em hex literal:
#   #FFCE1C — acento: botão, placa do logo, faixa, selos, pílula PEDIR  (css/style.css + assets/css/pizzaria.css)
#   #FFE27A — apoio: kicker, selos "a confirmar", topo dos degradês      (assets/css/pizzaria.css)
#   #FF6F1C — hover dos botões                                           (css/style.css + assets/css/pizzaria.css)
COR_ORIGINAL='#FFCE1C'
APOIO_ORIGINAL='#FFE27A'
HOVER_ORIGINAL='#FF6F1C'
# os rgba() da pizzaria.css carregam a cor de acento e a de apoio em decimal
RGBA_ACENTO_ORIGINAL='255,206,28'
RGBA_APOIO_ORIGINAL='255,226,122'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"
WA="${4:-}"
APOIO="${5:-}"
HOVER="${6:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ] || [ -z "$WA" ]; then
  echo "uso: $0 <pasta-destino> <#COR> \"<Nome do Cliente>\" <WHATSAPP-só-dígitos-com-55> [<#COR-APOIO>] [<#COR-HOVER>]" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#FF7A16' 'Pizzaria XYZ' '5533999990000'"                     >&2
  exit 1
fi

if ! [[ "$WA" =~ ^55[0-9]{10,11}$ ]]; then
  echo "erro: WhatsApp precisa ser só dígitos, com 55 na frente, tipo 5533999990000 (recebi '$WA')" >&2
  exit 1
fi

hex_rgb() { printf '%d,%d,%d' "$((16#${1:1:2}))" "$((16#${1:3:2}))" "$((16#${1:5:2}))"; }
escurecer() { printf '#%02X%02X%02X' $((16#${1:1:2} * 85 / 100)) $((16#${1:3:2} * 85 / 100)) $((16#${1:5:2} * 85 / 100)); }
clarear()   { printf '#%02X%02X%02X' $(( (16#${1:1:2} + 255*2) / 3 )) $(( (16#${1:3:2} + 255*2) / 3 )) $(( (16#${1:5:2} + 255*2) / 3 )); }

[ -z "$HOVER" ] && HOVER="$(escurecer "$COR")"
[ -z "$APOIO" ] && APOIO="$(clarear "$COR")"

for c in "$COR" "$APOIO" "$HOVER"; do
  if ! [[ "$c" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
    echo "erro: cor precisa ser hex de 6 dígitos, tipo '#FF7A16' (recebi '$c')" >&2
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
  grep -rIil -- "$de" "$DESTINO" 2>/dev/null | while read -r f; do
    sed -i "s/${de}/${para}/gI" "$f"
  done
}

# hover primeiro: se a cor do cliente for igual ao laranja do hover, a ordem
# inversa trocaria o hover recém-aplicado
trocar "$HOVER_ORIGINAL" "$HOVER" "cor do hover"
trocar "$APOIO_ORIGINAL" "$APOIO" "cor de apoio"
trocar "$COR_ORIGINAL"   "$COR"   "cor de marca"
trocar "$RGBA_ACENTO_ORIGINAL" "$(hex_rgb "$COR")"   "rgba do acento"
trocar "$RGBA_APOIO_ORIGINAL"  "$(hex_rgb "$APOIO")" "rgba do apoio"

echo "→ preenchendo nome e WhatsApp"
NOME_ESC="$(escapar "$NOME")"
grep -rIl -e '\[NOME DO CLIENTE\]' -e '\[WA_NUMERO\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g; s/\[WA_NUMERO\]/${WA}/g" "$f"
done

# (os SVG de placeholder são texto: o trocar() acima já os cobre)

restam=$(grep -rIoi -e "$COR_ORIGINAL" -e "$HOVER_ORIGINAL" -e '\[NOME DO CLIENTE\]' -e '\[WA_NUMERO\]' "$DESTINO" 2>/dev/null | wc -l || true)
slots=$(grep -o '\[[A-ZÇÃÕ][^]]*\]' "$DESTINO/index.html" | sort | uniq -c | sort -rn || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome/zap originais ainda presentes: $restam (esperado: 0)

Slots que continuam em aberto no index.html (preencher ou apagar a seção):
$slots

Falta fazer na mão — o script não tem como adivinhar:

  1. FOTOS      todo assets/img/*.svg é placeholder com o rótulo do que vai
                ali (hero 720x720 vista de cima, fachada, salão, kids, área
                externa, delivery, 4 itens do cardápio, 3 posters). Trocar
                pelo material do cliente com o MESMO nome, ou ajustar o src.
                Seção sem foto do cliente = apagar a seção, não deixar cinza.
  2. LOGO       assets/img/logo-preto.svg (placa do header) e logo-branco.svg
                (rodapé), mais simbolo-*.svg e favicon.svg. Se o cliente não
                tiver um símbolo, apagar os <img> do símbolo — não inventar.
  3. VÍDEOS     assets/video/reel-1.mp4, reel-2.mp4, reel-3.mp4 não existem.
                Reels reais do Instagram do cliente, mudos, 480x854, CRF ~31.
                Sem reel, apagar a seção #instagram inteira.
  4. TEXTOS     [FRASE DA MARCA], [MARCA], [ANO], [N] anos, [CIDADE/UF],
                [TELEFONE 2], [de onde foi lido]. O que não for real, apaga.
                "Esfiha" aparece no kicker, na faixa, nos bullets e no
                cardápio — se a pizzaria não vende esfiha, tirar de todos.
  5. CARDÁPIO   os 8 itens são EXEMPLOS e a seção já nasce com o selo
                "CARDÁPIO ILUSTRATIVO". Com cardápio real: trocar itens,
                tirar o selo e o aviso, decidir se preço entra na pílula.
  6. APP        o card "PELO APP" supõe app próprio. Sem app, apagar o card e
                deixar dois (delivery + salão) — o grid aguenta.
  7. TITLE      [DESCRIÇÃO CURTA] continua como slot no <title>.
  8. DEPLOY     vercel.json já está aqui (framework null, cleanUrls). Projeto
                Vercel com slug do cliente — skill vercel-cliente-novo.

FIM
