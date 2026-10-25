#!/usr/bin/env bash
#
# Cria uma cópia do template Fresheat já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#C0392B' 'Marmitaria XYZ'
#
# O template tem DUAS cores em jogo, não uma:
#   --theme: #EB0029 (vermelho) — é a cor de marca de verdade: barra de topo
#     do header, botão "ORDER NOW" principal do hero, breadcrumb das páginas
#     internas, "FOOD MENU"/preço em destaque (209 usos em assets/css/main.css).
#     É essa que o script troca pela COR passada — junto com os SVGs que já
#     vêm nesse vermelho (ver abaixo).
#   --theme2: #FC791A (laranja) — segunda cor real do design, não é só botão:
#     aparece no texto "WELCOME [...]" acima do título, no traço sob a logo e
#     em um dos 3 cards de promoção da home inteiro pintado de laranja
#     (ver about.html). Fica FIXA por padrão: os dois tons (vermelho quente +
#     laranja) foram desenhados para contrastar um com o outro nos cards
#     alternados — trocar só o vermelho pela cor do cliente já muda header,
#     hero e CTA principal, que é o que mais aparece; se o cliente também
#     tiver um laranja pendant, ajustar --theme2 à mão em assets/css/main.css.
#
# O ícone da logo (prato/redoma) é um SVG de verdade, sem nome desenhado
# dentro (diferente da Handify) — está no mesmo vermelho #EB0029, então o
# script recolore ele junto com mais 5 ícones que nascem nessa cor:
#   assets/img/logo/logo.svg, assets/img/logo/logo3.svg,
#   assets/img/icon/star5.svg, assets/img/icon/tag.svg, assets/img/icon/user.svg,
#   assets/img/shape/bannerShape3_4.svg
# Tem ainda um SVG de aspas de citação desenhado achado só em blog-details.html
# (stroke="#EB0029" inline no HTML, não é arquivo separado) — o script varre
# todo html/*.html pela cor original por causa disso.
# ATENÇÃO: mesmo com o ícone recolorido, "[NOME DO CLIENTE]" na tela ao lado
# da logo é texto normal (trocado abaixo) — mas o logo.svg pode ter outras
# variantes com o nome antigo desenhado como caminho vetorial; ver "Falta
# fazer na mão" no fim deste script.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#EB0029'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#C0392B' 'Marmitaria XYZ'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#C0392B' (recebi '$COR')" >&2
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

CSS="$DESTINO/assets/css/main.css"
echo "→ cor de marca (--theme): $COR_ORIGINAL → $COR"
sed -i "s/--theme: ${COR_ORIGINAL};/--theme: ${COR};/" "$CSS"

echo "→ recolorindo os 6 SVGs que já nasceram na cor de marca"
for svg in \
  assets/img/logo/logo.svg \
  assets/img/logo/logo3.svg \
  assets/img/icon/star5.svg \
  assets/img/icon/tag.svg \
  assets/img/icon/user.svg \
  assets/img/shape/bannerShape3_4.svg
do
  f="$DESTINO/$svg"
  [ -f "$f" ] && sed -i "s/${COR_ORIGINAL}/${COR}/gI" "$f"
done

echo "→ recolorindo SVG inline solto em blog-details.html (ícone de aspas)"
find "$DESTINO" -maxdepth 1 -name "*.html" -print0 | xargs -0 sed -i "s/${COR_ORIGINAL}/${COR}/gI"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "$COR_ORIGINAL" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes (html/css): $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO COM NOME DESENHADO  assets/img/logo/logo.svg (e a variante
                     logo3.svg, usada na home 3) têm o ícone (prato) E a
                     palavra "FRESHEAT RESPONDENT" no mesmo arquivo — mas o
                     nome está desenhado como caminho vetorial (texto
                     convertido em path), igual a Qlinest: não é texto de
                     verdade, não aparece em busca por nome, e o script só
                     alcança a COR do ícone, não a geometria do nome. Trocar
                     o arquivo inteiro pela logo real do cliente (2 lugares
                     por página: topo e header fixo/sticky).
  2. COR SECUNDÁRIA  --theme2 (laranja #FC791A) fica fixa por padrão — ver
                     cabeçalho do script. Se incomodar contra a cor nova,
                     trocar à mão em assets/css/main.css.
  3. FOTOS           assets/img/*.jpg em boa parte já são foto de prato de
                     verdade (não placeholder cinza como Handify/Qlinest) —
                     mas são fotos de banco de imagem do template, não do
                     cliente. Trocar pelas fotos reais do prato/fachada
                     antes de publicar, ou deixar só como ilustração.
  4. TELEFONE        "+11002345909" e "+013-003-003-9993" aparecem fixos em
                     várias páginas (38 ocorrências cada) — trocar por
                     WhatsApp real ou marcar "a confirmar".
  5. E-MAIL          todo endereço de e-mail (que era info@fresheat.com,
                     info@exmple.com, info@enofik.com etc. — inclusive um
                     que usava o próprio nome do template no domínio) já
                     veio trocado por "[EMAIL]" no pré-processamento, pra
                     não quebrar domínio no find/replace do nome. Preencher
                     com o contato real ou apagar se só usa WhatsApp.
  6. CARDÁPIO/PREÇO  "Chinese Pasta", "Spicy Fried Chicken", preços
                     "\$25", "\$28", "\$55" etc. em menu.html/menu2.html e
                     nos cards da home são pratos e valores inventados —
                     sem cardápio real do cliente, marcar como "a confirmar"
                     ou trocar pelos pratos de verdade.
  7. DEPOIMENTO      testimonials.html e os depoimentos da home têm nome,
                     foto e texto inventados — usar só com selo
                     "ilustrativo" visível.
  8. LOJA/CARRINHO   shop.html, cart.html, checkout.html, wishlist.html,
                     account.html simulam e-commerce completo (produto,
                     carrinho, login) sem backend nenhum por trás — nenhum
                     botão funciona de verdade. Considerar remover do menu
                     em demo de captação (raramente um cardápio precisa de
                     loja com carrinho).
  9. HOMES MÚLTIPLAS index.html é a home padrão; o pacote também tem
                     index-2.html, index-3.html (+ variantes "-dark"),
                     index-one-page.html, index-two-page.html e
                     index-three-page.html — todas funcionam, mas só a
                     index.html está linkada no menu principal. Escolher uma
                     só antes de publicar (não faz sentido manter 9 homes
                     num site de captação).
 10. TEXTO           todo o corpo está em inglês. <html lang="en"> também
                     precisa virar "pt-BR". Reescrever com o tom de voz do
                     identidade.md do cliente, não traduzir ao pé da letra.
FIM
exit 0
