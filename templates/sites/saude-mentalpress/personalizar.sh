#!/usr/bin/env bash
#
# Cria uma cópia do template MentalPress já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#4A7C6E' 'Consultório XYZ'
#
# Tema WordPress "MentalPress" (Surjith S M) exportado pra HTML puro —
# Bootstrap 3 clássico, SEM variável CSS nenhuma (nem LESS/Sass exposto,
# nem custom property): a cor de marca é o hex `#957aca` (lilás) repetido
# 38 vezes em assets/css/style.css, sempre em classes Bootstrap semânticas
# de verdade (`.btn-primary`, `.text-primary`, `.bg-primary`,
# `.panel-primary`, `.nav-pills > li.active`, `.header .menu .featured-link`)
# — é o botão "Make an Appointment", o link ativo do menu, os elementos
# "featured". Confirmado por screenshot: é a cor que mais aparece na tela.
#
# NÃO mexe em:
#   - `#1fa7da` (azul do link de texto, 17 usos) — é cor de link padrão,
#     não domina nenhum elemento grande (confirmado por screenshot); fica
#     fixa, mesmo raciocínio do --secondary/--primary-color quase-neutro
#     dos outros templates desta leva.
#   - `.btn-danger` (vermelho padrão do Bootstrap, usado no botão de
#     telefone do cabeçalho) — é uma classe SEMÂNTICA do Bootstrap reusada
#     em vários lugares fora de contexto (inclusive mensagem de erro de
#     formulário/WooCommerce); trocar a cor de "danger" pra cor de marca
#     mudaria também avisos de erro noutro lugar do site. Se quiser o botão
#     de telefone na cor do cliente, trocar a classe manualmente pra
#     `btn-primary` no HTML (não é um sed seguro de automatizar).
#   - assets/css/themes/{blue,green,orange,red,light-blue}.css — variantes
#     de skin do tema original, comentadas por padrão no <head>, nunca
#     carregadas; só `themes/purple.css` (que tem o mesmo `957aca`) é tocada
#     por este script, por segurança, caso alguém venha a ativá-la.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='957aca'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#4A7C6E' 'Consultório XYZ'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#4A7C6E' (recebi '$COR')" >&2
  exit 1
fi
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }
HEX="${COR#\#}"

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

echo "→ cor de marca (#$COR_ORIGINAL) → $COR"
sed -i "s/${COR_ORIGINAL}/${HEX}/gI" \
  "$DESTINO/assets/css/style.css" \
  "$DESTINO/assets/css/themes/purple.css"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam_nome=$(grep -rIo '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html 2>/dev/null | wc -l || true)
restam_cor=$(grep -oi "$COR_ORIGINAL" "$DESTINO/assets/css/style.css" "$DESTINO/assets/css/themes/purple.css" 2>/dev/null | wc -l || true)
restam_email=$(grep -rIo '\[EMAIL\]' "$DESTINO" --include=*.html 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências de [NOME DO CLIENTE] ainda presentes: $restam_nome (esperado: 0)
Ocorrências da cor original: $restam_cor (esperado: 0)
Placeholders [EMAIL] a preencher à mão: $restam_email (esperado: 4 — appointment.html e contact.html, 2 cada)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           assets/images/logo.png (cabeçalho) e logo_bw.png
                     (rodapé) são UMA imagem só com o nome "MentalPress" E o
                     subtítulo "Jennifer Willinger, Ph.D" desenhados juntos
                     dentro do PNG (260×90) — pior que um logo comum: nem o
                     nome nem o cargo/assinatura são texto, os dois estão
                     "cozidos" na mesma imagem. Trocar os 2 arquivos pela
                     logo real do cliente (sem esquecer a versão logo_2x.png
                     em alta resolução, referenciada via srcset).
  2. E-MAIL          [EMAIL] (2 arquivos — appointment.html e contact.html,
                     href + texto visível em cada um) — o domínio original
                     era "info@mentalpress.com"; como isso quebraria virando
                     "info@[NOME DO CLIENTE].com" (nome com espaço/acento
                     não é domínio válido), foi isolado em [EMAIL] à parte —
                     preencher com o e-mail real do cliente.
  3. TELEFONE/ENDEREÇO FAKE — "1-888-123-4567", "227 Marion Street,
                     Columbia, SC 29201" (endereço americano) aparecem fixos
                     em várias páginas — trocar pelo contato real.
  4. BOTÃO DE TELEFONE NÃO SEGUE A COR — o botão vermelho "1-888-123-4567"
                     do cabeçalho usa a classe "btn-danger" do Bootstrap
                     (semântica, reusada em erro de formulário), não
                     "btn-primary" — não muda de cor com este script de
                     propósito (ver cabeçalho). Trocar a classe manualmente
                     se quiser esse botão na cor do cliente.
  5. FORMULÁRIO PHP  php/contact.php e php/appointment.php não rodam na
                     Vercel. Trocar a ação dos formulários por wa.me ou
                     serviço de formulário estático antes de publicar.
  6. ÍCONES DE PAGAMENTO NO RODAPÉ — "PAYMENT METHODS" com Visa/Mastercard/
                     Amex/PayPal no footer é sobra de tema com loja
                     (WooCommerce) — não faz sentido pra consultório de
                     terapia, remover a linha.
  7. LOJA/EXTRAS      shop.html, shop-single.html e extras.html são vitrine
                     genérica do tema (loja e shortcodes) — não fazem
                     sentido pra este nicho; não incluir no menu do demo.
  8. FOTOS           assets/images/ tem fotos de banco de imagem (retrato
                     de "psicóloga", ambientes) já tratadas com um filtro de
                     mosaico ("crystallize") aplicado nas imagens — sem foto
                     real do profissional, trocar ou marcar como
                     ilustrativo.
  9. TEXTO           corpo em inglês, <html lang="en"> incluso, endereço
                     americano — trocar pra pt-BR e reescrever com o tom de
                     voz do identidade.md, não traduzir ao pé da letra.
 10. LINKS DE REDE SOCIAL do cabeçalho/rodapé apontavam pro Facebook/Twitter
                     do AUTOR do tema (web3canvas) — já foram trocados por
                     "#" neste template; preencher com as redes reais do
                     cliente ou remover os ícones que não existem.
FIM
exit 0
