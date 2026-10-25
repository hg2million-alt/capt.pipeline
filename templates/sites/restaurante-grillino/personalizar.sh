#!/usr/bin/env bash
#
# Cria uma cópia do template Grillino já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#8B1E3F' 'Restaurante XYZ'
#
# COR DE MARCA — uma única cor via CSS custom property (--secondary-color,
# 106 usos em assets/css/style.css), MAS ela não é a fonte única de verdade:
# assets/css/theme-color1.css (o único dos 6 esquemas prontos que qualquer
# página do pacote carrega — theme-color2..6.css existem mas nenhuma página
# linka pra eles, são esquemas alternativos mortos) reescreve as MESMAS
# classes (.bg-theme, .text-theme, .vs-btn.style1 etc.) com o hex cru por
# cima, então trocar só a variável não basta. O script troca em 3 níveis:
#
#   1. #fa8507 (cor principal) e #c06504 (variante escura, só o hover de
#      link) — hex cru — em assets/css/style.css, assets/css/theme-color1.css
#      e em TODOS os .scss fonte sob assets/sass/ (não rodam no navegador,
#      não há build/npm neste pacote — são mantidos só como referência caso
#      alguém recompile; sem isso ficariam com a cor antiga mesmo com o CSS
#      já certo)
#   2. rgba(250, 133, 7, ...) — a mesma cor principal decomposta em RGB
#      decimal, usada em 5 sombras/gradientes (2 em style.css, 3 em
#      theme-color1.css) — o script recalcula R,G,B a partir da cor nova
#   3. a cor "escura" (#c06504) é DERIVADA automaticamente (75% de cada canal
#      RGB da cor principal) — só é passado 1 argumento de cor, não 2
#
# NÃO É TOCADO (não é a cor de marca, é resíduo de layout morto):
#   #B80011 (vermelho, style.css) — usado só em header-v6, header-v7 e
#   footer-v2, layouts que NENHUMA página deste pacote usa (todas usam
#   footer-layout1 e o header padrão) — confirmado por grep antes de decidir
#   não mexer. Fica inerte. Se algum dia trocar de header/footer pra uma
#   dessas variantes, procurar #B80011 à mão.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='fa8507'
COR_ORIGINAL_HOVER='c06504'
RGB_ORIGINAL='250, 133, 7'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#8B1E3F' 'Restaurante XYZ'" >&2
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

COR_HEX="${COR#\#}"
R=$((16#${COR_HEX:0:2}))
G=$((16#${COR_HEX:2:2}))
B=$((16#${COR_HEX:4:2}))
DR=$(( R * 75 / 100 ))
DG=$(( G * 75 / 100 ))
DB=$(( B * 75 / 100 ))
COR_HOVER_HEX=$(printf '%02x%02x%02x' "$DR" "$DG" "$DB")
RGB_NOVO="$R, $G, $B"

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

echo "→ cor principal (#$COR_ORIGINAL) → #$COR_HEX"
echo "→ cor escura derivada, 75% dos canais (#$COR_ORIGINAL_HOVER) → #$COR_HOVER_HEX"
echo "→ rgba($RGB_ORIGINAL) → rgba($RGB_NOVO)"

for CSS in "$DESTINO/assets/css/style.css" "$DESTINO/assets/css/theme-color1.css"; do
  [ -f "$CSS" ] || continue
  sed -i "s/${COR_ORIGINAL}/${COR_HEX}/gI" "$CSS"
  sed -i "s/${COR_ORIGINAL_HOVER}/${COR_HOVER_HEX}/gI" "$CSS"
  sed -i "s/rgba(${RGB_ORIGINAL}/rgba(${RGB_NOVO}/g" "$CSS"
done

if [ -d "$DESTINO/assets/sass" ]; then
  find "$DESTINO/assets/sass" -name '*.scss' -print0 | while IFS= read -r -d '' SCSS; do
    sed -i "s/${COR_ORIGINAL}/${COR_HEX}/gI" "$SCSS"
    sed -i "s/${COR_ORIGINAL_HOVER}/${COR_HOVER_HEX}/gI" "$SCSS"
    sed -i "s/rgba(${RGB_ORIGINAL}/rgba(${RGB_NOVO}/g" "$SCSS"
  done
fi

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam_cor=$(grep -rIi -e "${COR_ORIGINAL}" -e "${COR_ORIGINAL_HOVER}" -e "rgba(${RGB_ORIGINAL}" "$DESTINO" --include=*.html --include=*.css --include=*.scss 2>/dev/null | wc -l || true)
restam_nome=$(grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)
restam=$((restam_cor + restam_nome))

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes (html/css/scss): $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. ESCOLHER A HOME     o pacote tem 9 homes numeradas (index.html a
                    index-9.html) + 4 variantes "one page" (index-2 a
                    index-5-onepage.html) — 13 ao todo, só index.html linkada
                    no menu por padrão. Escolher uma e apagar o resto (ou ao
                    menos tirar do menu) antes de publicar.
  2. FOTOS          apesar de nomes de arquivo tipo
                    "delicious-burger-with-many-ingredients...png" sugerirem
                    foto de banco de imagem real, TODA foto do pacote
                    (hero, cardápio, galeria, chef, depoimento — ~300+
                    arquivos) é placeholder cinza com a dimensão escrita
                    dentro (ex. "1920X900", "354X450"), igual ao padrão do
                    manutencao-handify/ — confirmado abrindo os arquivos, não
                    só pelo nome. Só ícone/forma decorativa (pasta icons/,
                    shape/, bg/) é arte real. Sem foto real do
                    prato/fachada/salão/equipe, o site fica com cara de
                    maquete.
  3. LOGO COM NOME VETORIZADO (grave)  assets/img/logo.svg e logo-white.svg
                    NÃO são só o símbolo da chama — o nome "Grillino" em
                    script cursivo está desenhado dentro do MESMO <path>
                    (id="Path_12") do ícone, como geometria vetorial pura,
                    sem nenhuma tag <text>. Abrindo o arquivo como texto
                    parece só coordenadas de curva — não aparece "Grillino"
                    em lugar nenhum pra buscar, e o find/replace de nome
                    (que troca 211 ocorrências em todo o html/) NÃO alcança
                    isso porque não é string, é forma. Só aparece renderizando
                    a página de verdade (confirmado por screenshot: o nome
                    "Grillino" sai estampado do lado do ícone em TODA
                    página). Trocar os 2 arquivos inteiros pela logo real do
                    cliente antes de publicar — não dá pra "limpar" o SVG.
  4. TELEFONE       "+869 526 212" é fixo em praticamente toda página (~90
                    ocorrências em tel: e texto) — trocar por WhatsApp real
                    ou marcar "a confirmar".
  5. E-MAIL         "info@example.com" (mail.php e formulários) é só
                    placeholder genérico, não é e-mail de pessoa real —
                    ainda assim precisa virar o contato de verdade.
  6. FORMULÁRIO     contact.html manda pra mail.php (PHP puro, recipient
                    "info@example.com") — a Vercel NÃO roda PHP. Sem
                    hospedagem PHP à parte, o formulário não envia nada.
                    Trocar a ação por wa.me ou um serviço de formulário
                    estático antes de publicar. reservation.html/
                    reservation-2.html têm action="#" (decorativo).
  7. CHEFS FICTÍCIOS  chef.html/chef-2.html/chef-details.html têm 6 nomes
                    inventados (Mark Polo, Vivi Marian, Zerzzy Lamot, Peter
                    Parker, Suzana Roise, Mohn Deo) com foto de banco — sem
                    equipe real, apagar a seção ou trocar por cargo sem nome.
  8. CARDÁPIO/PREÇO  menu.html, menu-2/3/4.html e menu-details.html têm
                    prato, categoria e preço de exemplo — sem cardápio real
                    do cliente, marcar "a confirmar".
  9. LOJA/CONTA/BLOG  cart.html, checkout.html, shop*.html, login.html,
                    sign-up.html simulam e-commerce e login sem nenhum
                    backend; blog*.html tem post de texto genérico em
                    inglês — considerar remover do menu em demo de captação.
 10. REDES SOCIAIS  todo ícone de rede social (facebook/twitter/instagram/
                    linkedin/youtube) tem href="#" — preencher ou remover os
                    que não existirem.
 11. TEXTO          todo o corpo está em inglês, <html lang="en"> incluso —
                    trocar pra "pt-BR" e reescrever com o tom de voz do
                    identidade.md do cliente, não traduzir ao pé da letra.
 12. FAVICON        apple-touch-icon.png e assets/img/favicons/* são o
                    símbolo genérico do template — trocar pelo ícone real.
FIM
exit 0
