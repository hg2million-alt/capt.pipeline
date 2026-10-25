#!/usr/bin/env bash
#
# Cria uma cópia do template Renova já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Construtora XYZ'
#
# O template tem DUAS CSS custom properties de tema, não uma:
#   --tg-theme-primary: #F66300 (laranja) — é a cor de marca de verdade:
#     botão, link ativo, ícone de destaque, hover (166 usos em main.css, mais
#     1 hex solto em assets/img/banner/hero_content_shape.svg). É essa que o
#     script troca pela COR passada.
#   --tg-theme-secondary: #171717 (preto quase puro) — NÃO é cor de marca,
#     é o neutro escuro do tema: texto padrão, fundo de botão/hover escuro,
#     borda de contraste (78 usos, confirmado lendo o uso de cada ocorrência,
#     não só o nome da variável — mesmo tipo de armadilha do
#     manutencao-qlinest). Fica FIXO: trocar junto ia clarear texto e sumir
#     com o contraste dos hovers.
#
# ARMADILHA GRANDE: o nome do template, "Renova", é ao mesmo tempo (1) prefixo
# de TODA a fonte de ícone customizada do tema — .renova-right-arrow (391x),
# .renova-cart, .renova-search, .renova-phone etc., centenas de ocorrências
# — e (2) um substring de "Renovation"/"Renovate", que aparece dezenas de
# vezes como texto normal do nicho ("Building Renovation", "Home Renovation
# Services"...). Um find/replace ingênuo de "Renova" ia apagar ícone (arrow,
# cart, busca, telefone — tudo, o site inteiro perde os ícones) E virar
# "Renovation" em "[NOME DO CLIENTE]tion" por todo canto.
# O script usa um regex com contexto: só troca "Renova" quando o caractere
# seguinte NÃO é letra nem hífen (ou seja, cobre "Renova " / "Renova." /
# "Renova's" / "Renova<", mas nunca "Renova-right-arrow" nem "Renovation").
# Testado: 0 ícones quebrados, 0 ocorrência de "Renovation" afetada.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#F66300'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Construtora XYZ'" >&2
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
escapar_regex() { printf '%s' "$1" | sed -e 's/[.[\*^$/]/\\&/g'; }

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

echo "→ cor de marca (--tg-theme-primary): $COR_ORIGINAL → $COR"
sed -i "s/--tg-theme-primary: ${COR_ORIGINAL};/--tg-theme-primary: ${COR};/" "$DESTINO/assets/css/main.css"
sed -i "s/${COR_ORIGINAL}/${COR}/gI" "$DESTINO/assets/img/banner/hero_content_shape.svg"

echo "→ preenchendo o nome do cliente (só onde 'Renova' é o nome da marca, não ícone nem 'Renovation')"
NOME_ESC="$(escapar "$NOME")"
grep -rIl "Renova" "$DESTINO" --include=*.html | while read -r f; do
  sed -i -E "s/Renova([^a-zA-Z-])/${NOME_ESC}\1/g" "$f"
done

restam_cor=$(grep -rIoi "$COR_ORIGINAL" "$DESTINO" --include=*.html --include=*.css --include=*.svg 2>/dev/null | wc -l || true)
restam_nome=$(grep -rIoE "Renova([^a-zA-Z-]|$)" "$DESTINO" --include=*.html 2>/dev/null | wc -l || true)
icones_ok=$(grep -rIo "renova-right-arrow" "$DESTINO/index.html" 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor original ainda presentes: $restam_cor (esperado: 0)
Ocorrências de "Renova" como marca ainda presentes: $restam_nome (esperado: 0)
Classes de ícone "renova-right-arrow" intactas em index.html: $icones_ok (esperado: 16 — se vier 0, algo saiu errado e os ícones quebraram)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO            assets/img/logo/logo.svg e w_logo.svg (versão branca)
                     têm "RENOVA" + "CONSTRUCTION" desenhados como PATH
                     vetorial (contorno, não texto de verdade) — não aparece
                     em grep de nome e o script não alcança. Trocar pela
                     logo real do cliente.
  2. <title>/<meta>  ficam como "[NOME DO CLIENTE] - Construction Building &
                     Renovation Template" — o script só troca o nome, não
                     apaga o resto da frase (é metadado de aba do navegador,
                     baixa visibilidade, mas revisar antes de publicar).
  3. FOTOS           todo assets/img/**/*.jpg é placeholder cinza com a
                     dimensão escrita dentro (ex. "790x800") — sem foto real
                     de obra/equipe/fachada, o site fica com cara de maquete.
  4. TELEFONE        "+0989 7876 9865 9" e "+(090) 8765 86543 85" (offcanvas,
                     todas as páginas) são números de mentira — trocar por
                     WhatsApp real ou marcar "a confirmar".
  5. HISTÓRIA INVENTADA history.html repete 4x "[NOME DO CLIENTE] is founded
                     in Berlin" — fato inventado do tema original (a marca
                     nasceu em Berlim?). Apagar ou reescrever com a história
                     real do cliente, nunca deixar como está.
  6. ESTATÍSTICA     números tipo "K800" / contadores animados no hero são
                     chute do tema — sem dado real do cliente, apagar.
  7. LOJA (SHOP)      shop.html, shop-details.html e o ícone de carrinho no
                     header vêm de um módulo de e-commerce que não faz
                     sentido pra pedreiro/pintor/construtora pequena — também
                     explica a faixa "Express delivery and free returns
                     within 24 hours" no topo de toda página, sobra de tema
                     de loja. Remover a seção e o item de menu.
  8. FORMULÁRIO      contact.html manda pra assets/mail.php (PHP — não roda
                     em hospedagem estática tipo Vercel). appointment.html e
                     os outros formulários (newsletter, offcanvas) têm
                     action="#" — não fazem nada, são decorativos. Trocar
                     tudo por wa.me ou um serviço de formulário estático
                     antes de publicar.
  9. 5 HOMES         o pacote trouxe index.html + index-2..5.html, cada uma
                     um layout de home diferente (a 5ª, "index-5", é
                     rotulada "Renovation" na documentação original) —
                     escolher uma como principal e decidir o que fazer com
                     as outras (apagar do menu ou manter como página extra).
 10. TEXTO           todo o corpo está em inglês, <html lang="en"> incluso —
                     trocar pra "pt-BR" e reescrever com o tom de voz do
                     identidade.md do cliente, não traduzir ao pé da letra.
 11. BLOG/DEPOIMENTO blog.html, blog-2/3.html e os depoimentos da home têm
                     texto, nome e foto inventados — usar só com selo
                     "ilustrativo" visível, ou remover.
FIM
exit 0
