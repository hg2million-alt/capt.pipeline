#!/usr/bin/env bash
#
# Cria uma cópia do template já com a cor de marca e o nome do cliente
# trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> <#COR> "<Nome do Cliente>" [<#COR-HOVER>]
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#FF7A16' 'Pizzaria XYZ'
#
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

# O template tem UMA cor de marca de verdade, mais o laranja do hover:
#   #FFCE1C — amarelo: botão, pílula de preço, destaque, hover, linha  — 208 usos
#   #FF6F1C — laranja: só no hover do botão principal                  — 5 usos
#   #111111 — fundo do body (não trocado; ver README)
#
# O "50% OFF" do hero e o hexágono de horário do rodapé são PNG com o degradê
# pintado dentro (img/bg/offer.png, img/bg/time-bg.png). O sed não chega neles.
COR_ORIGINAL='#FFCE1C'
COR_HOVER_ORIGINAL='#FF6F1C'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"
COR_HOVER="${4:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> <#COR> \"<Nome do Cliente>\" [<#COR-HOVER>]" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#FF7A16' 'Pizzaria XYZ'"  >&2
  exit 1
fi

# sem hover explícito, escurece a cor principal em ~15% para o hover não sumir
if [ -z "$COR_HOVER" ]; then
  r=$((16#${COR:1:2} * 85 / 100)); g=$((16#${COR:3:2} * 85 / 100)); b=$((16#${COR:5:2} * 85 / 100))
  COR_HOVER="$(printf '#%02X%02X%02X' "$r" "$g" "$b")"
fi

for c in "$COR" "$COR_HOVER"; do
  if ! [[ "$c" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
    echo "erro: cor precisa ser hex de 6 dígitos, tipo '#FF7A16' (recebi '$c')" >&2
    exit 1
  fi
done

if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

# escapa / e & para o sed não engasgar com nome de cliente
escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

trocar() {
  local de="$1" para="$2" rotulo="$3"
  echo "→ $rotulo: $de → $para"
  # -I pula binário: as texturas em img/ não têm hex de cor dentro
  grep -rIil "$de" "$DESTINO" 2>/dev/null | while read -r f; do
    sed -i "s/${de}/${para}/gI" "$f"
  done
}

# hover primeiro: se a cor nova do cliente for igual ao laranja do hover, a
# ordem inversa trocaria o hover recém-aplicado
trocar "$COR_HOVER_ORIGINAL" "$COR_HOVER" "cor do hover"
trocar "$COR_ORIGINAL"       "$COR"       "cor de marca"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "$COR_ORIGINAL" -e "$COR_HOVER_ORIGINAL" -e '\[NOME DO CLIENTE\]' "$DESTINO" 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. FOTOS      o template NÃO TEM foto nenhuma: comida, cardápio, chef,
                galeria e blog são PNG cinza de 1,6 KB. É a primeira coisa a
                fazer, não a última — sem foto o site é uma grade cinza.
  2. LOGO       img/logo/logo.png e logo.svg ("the Signature"), nas 13 páginas.
  3. PNG COM COR o "50% OFF" do hero (img/bg/offer.png) e o hexágono de horário
                (img/bg/time-bg.png) continuam no laranja do template. Refazer
                em CSS, trocar a imagem, ou tirar.
  4. TEXTOS     conteúdo em inglês. Reescrever em pt-BR. O lang já é pt-BR.
  5. CONTATO    info@example.com e 12 3456897 aparecem 13 vezes cada, no menu
                lateral de todas as páginas. O mapa do contact.html é genérico.
  6. INVENÇÃO   reserva de mesa, cardápio com preço, avaliações, chefs, blog,
                loja, newsletter e o contador de anos só existem preenchidos.
                Sem dado REAL do cliente, apagar a seção — não inventar.
  7. FORMULÁRIO reserva e contato postam para mail.php. PHP não roda na Vercel.
                Trocar por link de WhatsApp ou apagar.
  8. PESO       img/bg/*-bg.png somam 12 MB. Converter para JPEG antes de
                publicar.
  9. TITLE      [DESCRIÇÃO CURTA] continua como slot em cada <title>.

FIM
