#!/usr/bin/env bash
#
# Cria uma copia do template ja com a cor de marca e o nome do evento
# trocados. O original em html/ nunca e alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "Nome do Evento" ['#COR-SECUNDARIA']
#
# Exemplo:
#   ./personalizar.sh /c/Dev/ExpoMotorX/site '#0072FF' 'Expo Motor X'
#   ./personalizar.sh /c/Dev/ExpoMotorX/site '#0072FF' 'Expo Motor X' '#02D982'
#
# A cor de marca vive em DUAS folhas de estilo pequenas, nao no CSS grande:
#   css/colors/blue.css       (usada por index-expo-4.html)
#   css/colors/blue-teal.css  (usada pelas outras 9 paginas)
# Cada uma define --primary-color e --secondary-color (mais as versoes -rgb).
# O restante do CSS (style.css, coloring.css) so consome var(--primary-color)
# e var(--secondary-color) -- nao ha hex cru espalhado no CSS grande.
# O script reescreve as DUAS folhas com a mesma cor, pra as 10 paginas terem
# a marca consistente (no original, blue.css e blue-teal.css ja divergiam
# entre si -- por isso duas folhas em vez de uma).
#
# Se a cor secundaria nao for passada, ela fica igual a primaria (esquema
# solido, sem gradiente perceptivel) -- igual ao comportamento original do
# blue.css. Passe a 4a cor se quiser o gradiente que o template usa em
# titulos e botoes (classe .text-gradient, faixas de progresso etc.).
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"
COR_SECUNDARIA="${4:-$COR}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"Nome do Evento\" ['#COR-SECUNDARIA']" >&2
  echo "ex:  $0 /c/Dev/ExpoMotorX/site '#0072FF' 'Expo Motor X'"                >&2
  exit 1
fi

for c in "$COR" "$COR_SECUNDARIA"; do
  if ! [[ "$c" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
    echo "erro: cor precisa ser hex de 6 digitos, tipo '#0072FF' (recebi '$c')" >&2
    exit 1
  fi
done

if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' ja existe e nao esta vazia. Escolha outra pasta." >&2
  exit 1
fi

hex_to_rgb() {
  local hex="${1#\#}"
  printf '%d, %d, %d' "0x${hex:0:2}" "0x${hex:2:2}" "0x${hex:4:2}"
}

RGB_PRIMARIA="$(hex_to_rgb "$COR")"
RGB_SECUNDARIA="$(hex_to_rgb "$COR_SECUNDARIA")"

echo "-> copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

for arquivo in css/colors/blue.css css/colors/blue-teal.css; do
  echo "-> escrevendo $arquivo"
  cat > "$DESTINO/$arquivo" <<CSS
:root {
  --primary-color: $COR;
  --primary-color-rgb: $RGB_PRIMARIA;
  --secondary-color: $COR_SECUNDARIA;
  --secondary-color-rgb: $RGB_SECUNDARIA;
}
CSS
done

echo "-> preenchendo o nome do evento"
grep -rIl '\[NOME DO EVENTO\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO EVENTO\]/${NOME//\//\\/}/g" "$f"
done

# "Autovent" ainda aparece como texto visivel (H1 do hero em 3 paginas e o
# paragrafo "sobre o evento" em 4 paginas) -- troca de palavra inteira, com
# fronteira, pro nome nao virar substring de outra coisa por engano.
echo "-> trocando 'Autovent' pelo nome do evento no conteudo"
grep -rIl '\bAutovent\b' "$DESTINO" --include="*.html" | while read -r f; do
  sed -i "s/\bAutovent\b/${NOME//\//\\/}/g" "$f"
done

restam_cor=0
for c in "$COR" "$COR_SECUNDARIA"; do
  :
done
restam_nome=$(grep -rIl '\[NOME DO EVENTO\]' "$DESTINO" 2>/dev/null | wc -l || true)
restam_autovent=$(grep -rIl '\bAutovent\b' "$DESTINO" --include="*.html" 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Slots [NOME DO EVENTO] restantes: $restam_nome (esperado: 0)
Mencoes a 'Autovent' restantes: $restam_autovent (esperado: 0)

Falta fazer na mao -- o script nao tem como adivinhar:

  1. LOGO        trocar images/logo.png (188x27) e images/logo-mobile.png
                 (39x27). Sao PNG pequenos, conferir legibilidade no tamanho.
  2. HOME        escolher uma entre as 5 (index.html, index-expo-2/3/4.html,
                 index-car-1.html) e apagar/desligar as outras no menu
                 "Home" (dropdown com os 5 links, repetido nas 10 paginas).
  3. TEXTOS      conteudo e demo em ingles (inclusive paragrafo de Lorem
                 Ipsum em index-expo-3.html). Reescrever em pt-BR.
  4. CONTATO     endereco "100 Mainstreet Center, NY", telefone
                 "+1 333 9296" e e-mail "contact@suppport.com" (sic) --
                 aparecem no rodape de todas as paginas e em contact.html.
  5. FOTOS       images/ tem fotos de banco (carros, publico, patrocinadores
                 fake em images/sponsors/). Trocar pelas midias reais do
                 cliente/evento.
  6. REDES       os icones sociais do menu lateral e do rodape apontam para
                 "#" (o autor original ja tinha tirado os proprios links) --
                 preencher com as redes reais do evento.
  7. FORMULARIO  o contato usa PHP de verdade (handler.php via AJAX em
                 form.js), nao um form estatico. Antes de publicar:
                   - em html/handler.php: trocar 'your-email-here' pelo
                     e-mail que recebe as mensagens
                   - configurar a chave do reCAPTCHA em
                     html/src/ReCaptchaValidator.php (initSecretKey em
                     handler.php esta com 'copy-your-secret-key-here')
                   - hospedar em servidor com PHP. Numa Vercel padrao
                     (estatico) o formulario NAO funciona -- ou troca por
                     Formspree/web3forms, ou usa Vercel com runtime PHP, ou
                     aponta o action do form pra um endpoint que funcione.
  8. INGRESSOS   tickets.html tem 3 planos com preco fixo em dolar --
                 confirmar valores reais ou marcar como "a confirmar".
  9. [DESCRICAO CURTA] continua como slot nos <title>, preencher por pagina.

FIM
