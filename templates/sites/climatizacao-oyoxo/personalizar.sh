#!/usr/bin/env bash
#
# Cria uma cópia do template Oyoxo já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Climatização XYZ'
#
# Este template NÃO usa variável CSS (custom property) — as cores estão
# hardcoded em hex direto no CSS compilado (o pacote vem com o .scss fonte
# em assets/scss/, mas ele não é usado em runtime, só o .css já compilado
# em assets/css/style.css é carregado pelo HTML).
#
# O .scss fonte mostra 2 candidatas: $color-theme: #3464e0 e
# $color-secondary: #3498db. Conferido no CSS compilado e com screenshot:
#   #3464e0 (azul) é a cor de marca de verdade — 118 usos em style.css
#     (topbar, logo, hover de menu, botão de busca/filtro, "Read More",
#     ícones ativos). Domina a tela inteira.
#   #3498db aparece só 1 vez, num detalhe menor (nunca visível na tela
#     testada) — não vale a pena expor como opção; fica como está.
# Por isso o script troca só o `#3464e0`, igual ao caso do Handify (uma
# cor só, sem variável — aqui é hex literal em vez de CSS var).
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#3464e0'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Climatização XYZ'" >&2
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

COR_MINUSC="$(printf '%s' "$COR" | tr '[:upper:]' '[:lower:]')"

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

CSS="$DESTINO/assets/css/style.css"
echo "→ cor de marca ($COR_ORIGINAL, hex hardcoded): $COR_ORIGINAL → $COR_MINUSC"
sed -i "s/${COR_ORIGINAL}/${COR_MINUSC}/gI" "$CSS"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "${COR_ORIGINAL}" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           assets/images/logo/logo.png (196x58) e a versão
                     assets/images/logo/logo-white.png usada no preloader
                     trazem o ícone + a palavra "OYOXO" e o subtítulo
                     "Heating air conditioning" desenhados dentro do
                     arquivo — não é texto HTML, o script não alcança.
                     Trocar os 2 arquivos pela logo real do cliente.
  2. TUDO É PLACEHOLDER. Ao contrário do CoolAir (fotos de banco reais),
                     este template não trouxe NENHUMA foto de verdade — o
                     hero, os banners internos, as fotos de produto/blog são
                     todo retângulo cinza com a dimensão escrita dentro
                     (ex. "1920x817", "420x513", "800x398"). Sem foto real
                     do cliente em cada uma, o site fica com cara de
                     maquete — é o ponto mais visível do template inteiro.
  3. LOJA/PRODUTOS   as páginas shop.html, cart.html, checkout.html,
                     wishlist.html, my-account.html vendem itens genéricos
                     sem relação nenhuma com HVAC ("Multimedia alarm
                     device", "Vacuum cleaner") com preço em dólar chutado —
                     ou populam com equipamento real do cliente (split,
                     inverter, peça) ou tiram a loja do menu inteira.
  4. EQUIPE          a seção de equipe (home) repete "Brian Bader / Engineer"
                     na mesma foto/nome pra todo card — sem gente real,
                     apagar a seção ou trocar por cargo genérico sem nome.
  5. TELEFONE        "1-800-915-6270" (formato americano) aparece fixo no
                     topo e no meio da home — trocar por WhatsApp real ou
                     marcar "a confirmar".
  6. E-MAIL          contact@oyoxo.com virou "[EMAIL]" (o único que colidia
                     com o nome do template) — preencher com o e-mail real.
                     Os outros dois, contact@example.com e info@example.com,
                     são placeholder genérico do framework e continuam como
                     estavam — não colidem com o nome, mas também são fake;
                     preencher ou apagar junto.
  7. FORM            o "Make an Appointment" (assets/php/appointment.php) e
                     o formulário de contato (assets/php/mailer.php)
                     dependem de hospedagem PHP — a Vercel não roda. Sem
                     backend, nada é enviado; trocar a ação dos formulários
                     por um link wa.me ou um serviço de formulário estático
                     antes de publicar.
  8. RODAPÉ          o crédito "Designed by [NOME DO CLIENTE]" no rodapé
                     veio do link pro estúdio autor (thememarch.com) — o
                     link externo já foi neutralizado pra "#" pelo
                     pré-processamento (senão viraria um domínio inventado
                     tipo "https://nomedocliente.com/"); a frase em si pode
                     ser apagada do rodapé, não faz sentido dizer que o
                     cliente "desenhou" o próprio site.
  9. TEXTO           corpo em inglês, <html lang="en"> incluso — trocar pra
                     pt-BR e reescrever com o tom de voz do identidade.md.
 10. ESTRUTURA       ao contrário do CoolAir (uma página por assunto), aqui
                     About/Service/Products/Contact são seções por âncora
                     dentro de index.html (site one-page) — o Blog e a Loja
                     é que são de fato páginas à parte. Editar seção por
                     seção dentro do próprio index.html, não procurar
                     about.html/contact.html separados (eles não existem).
 11. PESO            3,4 MB em html/ — bem mais leve que o CoolAir, mas isso
                     é reflexo direto do item 2 (nenhuma foto real pesando).
FIM
exit 0
