#!/usr/bin/env bash
#
# Cria uma cópia do template Dentisto já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>" ['#COR2']
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#0F5E52' 'Dra. Fulana'
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#0F5E52' 'Dra. Fulana' '#E8632E'
#
# O template inteiro é orientado por 11 variáveis CSS num único bloco :root
# em assets/css/special-classes.css — bem mais limpo que a maioria dos
# templates da biblioteca (que têm hex cru espalhado por dezenas de
# arquivos). Só duas famílias de cor de verdade:
#
#   --global--color-seagreen / --global--color-seagreenish  #1bc9b6 / #1bc8b5
#     "verde-água" — cor de marca principal: botão de agendamento, ícones,
#     sublinhado, cartões de destaque. As duas variáveis são praticamente
#     idênticas (1 dígito hex de diferença) — o autor do template duplicou a
#     mesma cor em dois nomes por engano; o script trata as duas como uma só.
#   --global--color-lightsea   #2d7076  — verde-água mais escuro/dessaturado,
#     usado só na barra fina do topo (endereço/e-mail/redes sociais)
#   --global--color-seablue / --global--color-darksea  #0d5c63 / #0e5053
#     verde-água bem escuro — texto e borda do botão "Contact Us", copyright
#     do rodapé, fundo do menu mobile. De novo, duas variáveis quase idênticas
#     pro mesmo papel.
#   --global--color-orange     #ff6648  — cor de destaque (kicker acima dos
#     títulos, hover de link/botão, sublinhado). Único uso de uma SEGUNDA cor
#     de verdade — é a que dá contraste com o verde-água.
#   --global--color-blackyellow #10110e — quase-preto usado em título/corpo
#     de texto. Fica FIXO: é tinta de texto, não cor de marca (mesmo raciocínio
#     do --tertiary-color do Coolair).
#   --global--color-grey/lightgrey/white/offwhite/dullwhite/dullgrey — neutros
#     de texto e fundo. Fica tudo fixo.
#
# Além do :root, sobram 6 hex crus (não usam var()) que são cópias ou quase-
# cópias dessas mesmas cores, espalhados em assets/css/custom-style.css —
# resquício do autor ter colado o valor em vez de referenciar a variável.
# O script troca os 6 também, mapeados pro papel mais próximo.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

SEAGREEN_ORIGINAL='#1bc9b6'
SEAGREENISH_ORIGINAL='#1bc8b5'
LIGHTSEA_ORIGINAL='#2d7076'
SEABLUE_ORIGINAL='#0d5c63'
DARKSEA_ORIGINAL='#0e5053'
ORANGE_ORIGINAL='#ff6648'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"
COR2="${4:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\" ['#COR2']" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#0F5E52' 'Dra. Fulana' '#E8632E'" >&2
  exit 1
fi

# '#COR2' é opcional: se não vier, mantém o laranja original do template — é a
# cor de destaque desenhada pra contrastar com o verde-água de fábrica, e
# continua contrastando com a maioria dos tons que um cliente passar. Passe
# '#COR2' explícito se a marca do cliente já tiver uma segunda cor própria
# (retorna melhor que tentar calcular uma complementar automática às cegas).
if [ -z "$COR2" ]; then
  COR2="$ORANGE_ORIGINAL"
fi

for c in "$COR" "$COR2"; do
  if ! [[ "$c" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
    echo "erro: cor precisa ser hex de 6 dígitos, tipo '#0F5E52' (recebi '$c')" >&2
    exit 1
  fi
done

if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }

hex_para_rgb() {
  local hex="${1#\#}"
  printf "%d, %d, %d" "$((16#${hex:0:2}))" "$((16#${hex:2:2}))" "$((16#${hex:4:2}))"
}

# mistura 'ratio' em direção ao preto (escurece) — mesma lógica do Coolair,
# só que escurecendo em vez de clareando
escurecer() {
  local hex="${1#\#}"
  local ratio="$2"
  local r=$((16#${hex:0:2}))
  local g=$((16#${hex:2:2}))
  local b=$((16#${hex:4:2}))
  local nr ng nb
  nr=$(awk -v v="$r" -v ratio="$ratio" 'BEGIN{printf "%d", v*(1-ratio)}')
  ng=$(awk -v v="$g" -v ratio="$ratio" 'BEGIN{printf "%d", v*(1-ratio)}')
  nb=$(awk -v v="$b" -v ratio="$ratio" 'BEGIN{printf "%d", v*(1-ratio)}')
  printf "#%02X%02X%02X" "$nr" "$ng" "$nb"
}

# a cor principal do cliente vira seagreen/seagreenish (as duas variáveis
# quase-duplicadas). lightsea sai um pouco mais escura (barra fina do topo,
# precisa contrastar com texto branco). seablue/darksea saem bem mais escuras
# (texto/borda de botão, copyright do rodapé, fundo do menu mobile).
LIGHTSEA="$(escurecer "$COR" 0.25)"
SEABLUE="$(escurecer "$COR" 0.55)"

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

CSS_ROOT="$DESTINO/assets/css/special-classes.css"
CSS_STRAY="$DESTINO/assets/css/custom-style.css"

trocar() {
  local de="$1" para="$2" rotulo="$3"
  local arquivo="$4"
  echo "→ $rotulo: $de → $para"
  sed -i "s/${de}/${para}/gI" "$arquivo"
}

echo "→ cores de marca (bloco :root em special-classes.css)"
trocar "$SEAGREEN_ORIGINAL"    "$COR"      "seagreen (marca)"        "$CSS_ROOT"
trocar "$SEAGREENISH_ORIGINAL" "$COR"      "seagreenish (marca, dup)" "$CSS_ROOT"
trocar "$LIGHTSEA_ORIGINAL"    "$LIGHTSEA" "lightsea (barra do topo)" "$CSS_ROOT"
trocar "$SEABLUE_ORIGINAL"     "$SEABLUE"  "seablue (escuro)"         "$CSS_ROOT"
trocar "$DARKSEA_ORIGINAL"     "$SEABLUE"  "darksea (escuro, dup)"    "$CSS_ROOT"
trocar "$ORANGE_ORIGINAL"      "$COR2"     "orange (destaque)"        "$CSS_ROOT"

echo "→ hex crus soltos em custom-style.css (não usam var(), achados na hora de empacotar)"
trocar '#0d5d63' "$SEABLUE" "borda do benefits-section (quase-seablue, 1 dígito de diferença)" "$CSS_STRAY"
trocar "$SEABLUE_ORIGINAL" "$SEABLUE" "box-shadow do benefits-section (seablue exato)" "$CSS_STRAY"
trocar '#31ccbc' "$COR" "borda de hover (verde-água solto, mais perto do seagreen)" "$CSS_STRAY"
trocar '#fe6d51' "$COR2" "fundo do doctor-timing-con (quase-orange, 1 dígito de diferença)" "$CSS_STRAY"
trocar "$SEAGREENISH_ORIGINAL" "$COR" "sublinhado da assinatura (seagreenish exato)" "$CSS_STRAY"
trocar '#3d7d82' "$LIGHTSEA" "linha decorativa do prev-title (verde-água solto, mais perto do lightsea)" "$CSS_STRAY"
# o comentário "[Color codes]" no topo do arquivo documenta a paleta original
# em hex cru — não é CSS vivo, mas atualiza junto pra não ficar desatualizado
trocar "$SEAGREEN_ORIGINAL" "$COR" "comentário de referência: seagreen" "$CSS_STRAY"
trocar "$LIGHTSEA_ORIGINAL" "$LIGHTSEA" "comentário de referência: lightsea" "$CSS_STRAY"
trocar "$DARKSEA_ORIGINAL" "$SEABLUE" "comentário de referência: darksea" "$CSS_STRAY"
trocar "$ORANGE_ORIGINAL" "$COR2" "comentário de referência: orange" "$CSS_STRAY"

echo "→ preenchendo nome e ano do cliente"
NOME_ESC="$(escapar "$NOME")"
ANO="$(date +%Y)"
grep -rIl -e '\[NOME DO CLIENTE\]' -e '\[ANO\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g; s/\[ANO\]/${ANO}/g" "$f"
done

# se COR2 não foi passado, ele É o laranja original por design (ver acima) —
# nesse caso não faz sentido contar #ff6648 como "sobrou", já que é o valor
# certo de propósito
if [ "$COR2" = "$ORANGE_ORIGINAL" ]; then
  restam=$(grep -rIoi -e "$SEAGREEN_ORIGINAL" -e '\[NOME DO CLIENTE\]' "$DESTINO/assets/css" "$DESTINO"/*.html 2>/dev/null | wc -l || true)
else
  restam=$(grep -rIoi -e "$SEAGREEN_ORIGINAL" -e "$ORANGE_ORIGINAL" -e '\[NOME DO CLIENTE\]' "$DESTINO/assets/css" "$DESTINO"/*.html 2>/dev/null | wc -l || true)
fi

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Cores aplicadas: marca $COR (seagreen/seagreenish) · barra do topo $LIGHTSEA
(lightsea) · escuro $SEABLUE (seablue/darksea) · destaque $COR2 (orange)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO       assets/images/dentisto-logo.png (header) e footer-logo.png
                (rodapé) têm a palavra "Dentisto" desenhada dentro do PNG —
                trocar pelos dois arquivos com a logo real do cliente.
  2. CONTATO    endereço, e-mail e telefone/fax viraram slot — [ENDEREÇO DO
                CLIENTE], [EMAIL DO CLIENTE], [TELEFONE DO CLIENTE] — na barra
                do topo (17 páginas), no rodapé, em contact.html (que tem um
                segundo bloco de contato próprio: e-mail, endereço e DOIS
                telefones) e em team-detail.html (e-mail/telefone da dentista
                de exemplo). O script não preenche isso: grep -rn '\[EMAIL DO
                CLIENTE\]|\[ENDEREÇO DO CLIENTE\]|\[TELEFONE DO CLIENTE\]' e
                troca à mão, ou apaga a linha se o cliente não tiver.
  3. MAPA       contact.html tinha um iframe do Google Maps apontando (via
                parâmetro pb=) pro endereço real do escritório da Envato em
                Melbourne — não era genérico, era a sede do marketplace onde o
                template foi comprado. Já trocado por um embed neutro
                (?q=Brasil) sem chave de API; trocar o "q=Brasil" pelo
                endereço real do cliente antes de publicar.
  4. VÍDEO      a seção "Watch Our Video" da home abre um YouTube embutido
                (id oNPTWlU4u4g) — é um vídeo de terceiro, não do cliente.
                Trocar pelo vídeo real ou apagar a seção (ela é só um botão de
                play sobre uma imagem, dá pra tirar sem quebrar layout).
  5. EQUIPE     nomes de dentista fictícios espalhados: "Dr. Sofia Jhon" no
                hero da home, e um time de até 6 ("Dr. Richard Muldoon",
                "Dr. Maria Andaloro", "Dr. Michael Brian", "Dr. Tomas
                Albrektsson", "Dr. Edward Angle", "Dr. Amalia Assur", "Dr.
                Ronald M. Ellis") em about.html/dentists.html/team-detail.html
                — cliente solo: apagar a seção de equipe; clínica com mais de
                um dentista: trocar pelos nomes reais.
  6. FORM       os formulários (contato, agendamento) não têm action="" —
                hoje só recarregam a própria página, não mandam nada a
                lugar nenhum. Trocar por wa.me ou um serviço de formulário
                estático antes de publicar.
  7. TEXTO      tudo em inglês com lorem ipsum, incluindo estatística "30+
                Years of Experience" (exp-contact-section da home) — reescrever
                com o tom de voz e os números reais do identidade.md; se não
                tiver o número, tirar a estatística, não inventar.
  8. FOTOS      as fotos de paciente/dentista/consultório em assets/images/
                são banco de imagens genérico (não são silhueta cinza — tem
                gente e ambiente de verdade, só que não é o cliente). Trocar
                pelas fotos reais onde existirem.
  9. PÁGINAS    9 das 17 páginas (four-column, infinite-scroll, load-more,
                one-column, single-post, six-colum-full-wide,
                three-colum-sidbar, three-column, two-column) são variações
                de LAYOUT DE LISTAGEM DE BLOG — sobra de um template de blog/
                hospedagem que a Dentisto reaproveitou (os <title> originais
                diziam "... | Dentisto - WHMCS & Hosting HTML Template",
                removido no empacotamento). Escolher no máximo uma pro blog
                do cliente e tirar o resto do menu "Blog".
 10. DEPLOY     sem vercel.json — criar com framework null. Projeto Vercel
                com slug do cliente (skill vercel-cliente-novo).
FIM
