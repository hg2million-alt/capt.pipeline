#!/usr/bin/env bash
#
# Cria uma cópia do template Qlinest já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Limpeza XYZ'
#
# O template tem DUAS cores em jogo, não uma:
#   --dark-blue: #1F77D6 — é a cor de marca de verdade: fundo do header, do
#     hero inteiro, da faixa de CTA final e do rodapé (37 usos). É essa que
#     o script troca pela COR passada.
#   --accent-color: #FFD643 (amarelo) — só o botão principal ("Book Your
#     First Cleaning" etc., 8 usos). Fica FIXO por padrão: é o único ponto de
#     contraste forte contra o azul, e não tem garantia de que a cor da marca
#     do cliente combine como botão sobre ela mesma.
# --primary-color (quase preto, #0E1109) é texto padrão + fundo de seção
# escura neutra — funciona com qualquer COR, não precisa mexer.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#1F77D6'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Limpeza XYZ'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#1E7A4C' (recebi '$COR')" >&2
  exit 1
fi
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

CSS="$DESTINO/assets/css/style.css"
echo "→ cor de marca (--dark-blue): $COR_ORIGINAL → $COR"
sed -i "s/--dark-blue: ${COR_ORIGINAL};/--dark-blue: ${COR};/" "$CSS"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "$COR_ORIGINAL" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           assets/img/logo.svg tem a palavra "Qlinest" desenhada
                     como PATH vetorial (texto convertido em contorno, não
                     texto de verdade) — não aparece em nenhum grep de nome
                     e o script não alcança. Trocar pelo SVG/PNG da logo real
                     do cliente.
  2. BADGES CLAROS   --light-blue (#B2EAFE) e --lightest-blue (#EAF3FC) são
                     tons fixos de azul claro, usados nos selos "A Cleaner
                     Home..." e no fundo da tag "ABOUT US" — não acompanham a
                     COR escolhida. Se o cliente não for azul, esses dois
                     selos ficam com um azul ligeiramente desencontrado do
                     resto; ajustar à mão se o contraste incomodar.
  3. FOTOS           assets/img/*.jpg (about, hero, card-services, benefit,
                     how-to-work) são todo placeholder cinza com a dimensão
                     escrita dentro (ex. "822x758"), apesar do nome de
                     arquivo parecer foto de verdade — conferir cada uma
                     antes de assumir que já é imagem real.
  4. E-MAIL          contact-us.html tinha "hello@qlinest.co" — já veio
                     trocado por "[EMAIL]" (2 lugares: href mailto e texto
                     visível) porque um find/replace direto pelo nome do
                     cliente quebraria o domínio. Preencher com o e-mail real
                     ou apagar se o cliente só usa WhatsApp.
  5. LOGO IPSUM      a faixa de "clientes atendidos" no hero (index.html) usa
                     4 logos placeholder "Logoipsum/IPSUM" — apagar a seção
                     inteira em vez de inventar cliente.
  6. DEPOIMENTO      os 3 depoimentos da home (about-us também repete) têm
                     nome, foto (avatar-N.png) e texto inventados — usar só
                     com selo "ilustrativo" visível.
  7. NÚMERO "100K+"  "More than 100K+ satisfied customer" no hero é estatística
                     de mentira — sem dado real do cliente, apagar a frase.
  8. TEXTO           corpo em inglês, <html lang="en"> incluso — trocar pra
                     pt-BR e reescrever com o tom de voz do identidade.md.
  9. PESO            html/ ficou com só 2,6 MB (o pacote original tinha uma
                     pasta de imagens em alta resolução separada, não copiada
                     — as usadas no HTML já são as leves).
FIM
exit 0
