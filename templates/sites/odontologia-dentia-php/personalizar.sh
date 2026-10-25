#!/usr/bin/env bash
#
# Cria uma cópia do template Dentia PHP já com a cor de marca e o nome do
# cliente trocados. O original em php/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> <#COR> "<Nome do Cliente>" [<#COR2>]
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1A6B4F' 'Dra. Fulana'
#
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/php"

# Toda a cor de marca do template mora em UM arquivo, como variável CSS —
# nada de hex espalhado (diferente do odontologia-decare):
#   css/colors/scheme-01.css
#     --primary-color / --primary-color-rgb     — botões, links, ícones id-color,
#                                                  barra de agendamento, FAQ, CTA
#     --secondary-color / --secondary-color-rgb — outra ponta de gradiente (pouco
#                                                  visível; o CSS original já tinha
#                                                  o RGB dessa cor incoerente com o
#                                                  hex — o script sempre recalcula)
COR_ORIGINAL='#4A7CD2'
COR2_ORIGINAL='#EAA638'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"
COR2="${4:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> <#COR> \"<Nome do Cliente>\" [<#COR2>]" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#1A6B4F' 'Dra. Fulana'" >&2
  exit 1
fi

hex_rgb()   { printf '%d, %d, %d' "$((16#${1:1:2}))" "$((16#${1:3:2}))" "$((16#${1:5:2}))"; }
escurecer() { printf '#%02X%02X%02X' $((16#${1:1:2} * $2 / 100)) $((16#${1:3:2} * $2 / 100)) $((16#${1:5:2} * $2 / 100)); }

[ -z "$COR2" ] && COR2="$(escurecer "$COR" 70)"

for c in "$COR" "$COR2"; do
  if ! [[ "$c" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
    echo "erro: cor precisa ser hex de 6 dígitos, tipo '#1A6B4F' (recebi '$c')" >&2
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

echo "→ cor de marca: $COR_ORIGINAL → $COR · acento 2: $COR2_ORIGINAL → $COR2"
SCHEME="$DESTINO/css/colors/scheme-01.css"
COR_ESC="$(escapar "$COR")"
COR2_ESC="$(escapar "$COR2")"
sed -i \
  -e "s/${COR_ORIGINAL}/${COR_ESC}/gI" \
  -e "s/${COR2_ORIGINAL}/${COR2_ESC}/gI" \
  -e "s/74, 124, 210/$(hex_rgb "$COR")/" \
  -e "s/59, 157, 31/$(hex_rgb "$COR2")/" \
  "$SCHEME"

echo "→ preenchendo nome, e-mail e ano"
NOME_ESC="$(escapar "$NOME")"
ANO="$(date +%Y)"
grep -rIl -e '\[NOME DO CLIENTE\]' -e '\[ANO\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g; s/\[ANO\]/${ANO}/g" "$f"
done

restam_cor=$(grep -rIoi -e "$COR_ORIGINAL" "$DESTINO/css" 2>/dev/null | wc -l || true)
restam_nome=$(grep -rIl -e '\[NOME DO CLIENTE\]' -e '\[EMAIL DO CLIENTE\]' "$DESTINO" 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Cor original ainda em css/: $restam_cor (esperado: 0)
Arquivos com slot [NOME DO CLIENTE] ou [EMAIL DO CLIENTE] ainda não preenchido: $restam_nome
  (o e-mail dos forms fica de propósito — preencher na mão, ver item 5 abaixo)

Cor aplicada: acento $COR · acento 2 $COR2

Falta fazer na mão — o script não tem como adivinhar:

  1. HOMES        são 10 (index + homepage-2 a 10), quase todas iguais abaixo
                  do hero — variam ordem/estilo de seção. Escolher UMA, apagar
                  as outras 9 e tirar o mega menu "Home 1..10" de includes/menu.php.
                  homepage-3.php e homepage-7.php são standalone (não usam
                  includes/header.php nem footer.php) — se sobrar uma delas,
                  editar direto nela, não em includes/.
  2. TÍTULO       includes/header.php tem UM <title> hardcoded pra TODAS as
                  páginas (não há variável de título por página) — trocar lá
                  e, se quiser título diferente por página, criar uma.
  3. LOGO         images/logo-black.webp e logo-white.webp têm o dente E o
                  nome "dentia" desenhados dentro do arquivo (não é texto,
                  não sai em sed) — ficam com a cor E o nome originais até
                  trocar pela logo real do cliente. Sem logo do cliente,
                  regerar como PNG/SVG novo com a cor já aplicada.
  4. ÍCONES       images/icons/tooth-1.png a tooth-7.png (grade de serviços)
                  são PNG line-art na cor azul original — ficam azuis depois
                  do script. Sem ícone equivalente na cor nova, ou deixa (azul
                  isolado não é tão grave quanto logo) ou reexporta.
  5. FORMS        action-contact.php e action-booking.php usam mail() do PHP,
                  que precisa de MTA configurado no host — NÃO funciona de
                  graça em runtime serverless (Vercel PHP incluso). Preencher
                  [EMAIL DO CLIENTE] só resolve o "From"; pra funcionar de
                  verdade, trocar por wa.me (padrão da biblioteca) ou configurar
                  SMTP de verdade antes de publicar.
  6. PARTNER LOGOS homepage-7.php tem uma faixa "as featured in" com 10 logos
                  placeholder ("Logoipsum") em images/logo/1.png..10.png —
                  cortar a seção se não há parceiro real pra mostrar.
  7. TEXTOS       tudo em inglês, com "Google Rating 5.0 / Based on 23k
                  Reviews" fixo no hero e depoimentos com nomes inventados
                  (Bryan G., Michael S., Robert L. em testimonials.php) —
                  traduzir e marcar como ilustrativo o que não é real.
  8. FOTOS        equipe (images/team/1-4.webp) e depoimentos (images/testimonial/)
                  são fotos de banco reais (não silhueta) — trocar pelas do
                  cliente quando houver; sem foto real, ao menos avisar que
                  são ilustrativas.
  9. DEPLOY       sem vercel.json — criar um com runtime PHP (framework null
                  não basta pra PHP). Projeto Vercel com slug do cliente
                  (skill vercel-cliente-novo). Testar mail() em produção antes
                  de confiar no formulário.

FIM
