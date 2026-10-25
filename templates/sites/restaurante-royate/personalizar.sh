#!/usr/bin/env bash
#
# Cria uma cópia do template Royate já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#8B1E3F' 'Bistrô XYZ'
#
# O template nasceu em SCSS com 8 variáveis de cor ($primary-color,
# $secondary-color, $third-color, $fourth-color, $fifth-color, $sixth-color,
# $seventh-color, $bold-color), mas o CSS compilado (css/style.css, o que
# roda de verdade) tem os valores hex já embutidos, não var() — o script
# troca o hex direto. Batendo screenshot da index crua: só UMA das oito é
# cor de marca de verdade, #CDAA7C (o dourado do "ROYATE" no header, do
# título "EXPERIENCE THE FOOD" e da barra ativa do menu, 103 usos). As
# outras sete (#ACCADD azul, #FF3333 vermelho, #956F32 marrom, #DFA027
# âmbar, #F1B1D4 rosa, #666/#333 neutros) são classes de "skin" alternativo
# (.bg-third-color, .bg-fourth-color etc.) que o pacote original oferecia
# pra trocar de tema — nenhuma delas é usada em nenhum HTML deste pacote
# (grep confirma zero ocorrência de bg-third-color/bg-fourth-color/...),
# então não têm efeito visual nenhum aqui: ignoradas.
#
# A cor de marca também aparece fora do CSS, em mais 3 lugares que o script
# cobre à parte: vendor/hcmobilenav/demo.css (item ativo do menu mobile),
# css/style.scss (fonte, não roda no navegador, só mantido coerente) e
# data-color="#cdaa7c" dentro de index.html/index-2/5/6/7.html (cor do texto
# configurada direto na tag do Revolution Slider, não no CSS).
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#cdaa7c'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#8B1E3F' 'Bistrô XYZ'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#8B1E3F' (recebi '$COR')" >&2
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

CSS="$DESTINO/css/style.css"
echo "→ cor de marca ($COR_ORIGINAL) → $COR"
sed -i "s/${COR_ORIGINAL}/${COR}/gI" "$CSS"

VENDOR_CSS="$DESTINO/vendor/hcmobilenav/demo.css"
echo "→ mesma cor no CSS do menu mobile (vendor/hcmobilenav/demo.css)"
[ -f "$VENDOR_CSS" ] && sed -i "s/${COR_ORIGINAL}/${COR}/gI" "$VENDOR_CSS"

SCSS="$DESTINO/css/style.scss"
echo "→ mesma cor na fonte SCSS (css/style.scss — não roda no navegador, mas fica coerente como referência)"
[ -f "$SCSS" ] && sed -i "s/${COR_ORIGINAL}/${COR}/gI" "$SCSS"

echo "→ cor do texto do Revolution Slider (data-color=\"$COR_ORIGINAL\" em index/index-2/5/6/7.html)"
find "$DESTINO" -maxdepth 1 -name "*.html" -print0 | xargs -0 sed -i "s/data-color=\"${COR_ORIGINAL}\"/data-color=\"${COR}\"/gI"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

# o nome da classe .color-cdaa7c (CSS + atributo class= em toda página) é
# esperado sobreviver — é só o nome da classe, o valor que ela aplica já foi
# trocado acima; por isso a checagem ignora "cdaa7c" quando vem colado depois
# de um hífen ou de "#" (ex. "color-cdaa7c", e o typo original "color-#cdaa7c"
# que existe só em index-6.html — nunca funcionou nem no template original,
# "#" dentro de nome de classe é seletor inválido).
restam_cor=$(grep -rIPoi "(?<![-#])${COR_ORIGINAL#\#}" "$DESTINO" --include=*.html --include=*.css --include=*.scss 2>/dev/null | wc -l || true)
restam_nome=$(grep -rIoi '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)
restam=$((restam_cor + restam_nome))

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes (html/css): $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO COM NOME DESENHADO  images/logo.png (header, 77x68) e
                     images/logo-menu-sidebar.png (menu lateral mobile) têm
                     o ícone de taça E a palavra "ROYATE" desenhados juntos
                     no PNG — só aparece de verdade em tamanho grande, no
                     thumbnail pequeno passa quase despercebido. O script
                     não mexe em imagem rasterizada; trocar os 2 arquivos
                     pela logo real do cliente.
  2. FOTOS           images/*.jpg (hero, menu, galeria, chefs) são fotos de
                     banco de imagem do pacote original, não placeholder
                     cinza com dimensão escrita — mas também não são do
                     cliente. Trocar pelas fotos reais do prato/salão/chef
                     antes de publicar, ou deixar só como ilustração clara.
  3. TELEFONE        "+1 (561) 800-366-6666" (variando o formato, ~51
                     ocorrências) e "(849) 490-4283" (2 ocorrências, só em
                     contact-us.html) são fixos — trocar por WhatsApp real
                     ou marcar "a confirmar".
  4. E-MAIL          todo endereço (era Eric-82@example.com e
                     kathryn-92@example.com) já veio trocado por "[EMAIL]"
                     no pré-processamento — preencher com o contato real.
  5. SITE/DOMÍNIO    o rodapé de todas as páginas tinha "www.royate.com"
                     como texto — um find/replace direto do nome quebraria
                     isso em "www.[nome do cliente].com", um domínio que não
                     existe; já veio trocado por "[SITE]" à parte do nome.
                     Preencher com o domínio real (ou apagar a linha se o
                     cliente só usa WhatsApp/Instagram).
  6. RESERVA/CONTATO reservation_v1.html e reservation_v2.html têm
                     formulário de data/hora com action="#" (decorativo, não
                     envia nada) — contact-us.html usa
                     includes/contact-form.php, que precisa de hospedagem
                     PHP e NÃO roda na Vercel. Sem backend, trocar a ação
                     dos formulários por wa.me ou remover antes de publicar.
  7. CARDÁPIO/PREÇO  menu.html tem prato e preço de exemplo do template —
                     sem cardápio real do cliente, marcar "a confirmar".
  8. DEPOIMENTO      os depoimentos espalhados pelas homes têm nome, foto e
                     texto inventados — usar só com selo "ilustrativo".
  9. LOJA/CONTA      shop-*.html, shop-cart.html, checkout.html, sign-in.html
                     e sign-up.html simulam e-commerce e login completos sem
                     nenhum backend — nenhum botão funciona de verdade.
                     Considerar remover do menu em demo de captação.
 10. 15 HOMES        index.html é a home padrão; o pacote tem mais 14
                     variantes (index-2.html a index-15.html), cada uma com
                     um layout de hero/seção diferente — só a index.html
                     está linkada no menu. Escolher uma só antes de publicar.
 11. TEXTO           todo o corpo está em inglês. <html lang="en"> também
                     precisa virar "pt-BR". Reescrever com o tom de voz do
                     identidade.md do cliente, não traduzir ao pé da letra.
 12. FONTES          o pacote original tinha licença de Lato e Satisfy
                     dentro de documentation/ — já não fazem parte de
                     html/ (limpeza da matéria-prima); se sobrar alguma
                     referência quebrada a elas no CSS, não é conteúdo do
                     site, pode ignorar.
FIM
exit 0
