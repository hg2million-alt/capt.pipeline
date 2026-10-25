#!/usr/bin/env bash
#
# Cria uma cópia do template Laun já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Limpeza XYZ'
#
# UMA cor de marca de verdade, mas espalhada em bem mais lugares do que
# a variável CSS sozinha:
#   --theme-color: #8CC63F (verde) — é a cor de marca: header, nav, botões,
#     CTA, ícones de destaque (277 usos em assets/css/style.css). É essa
#     que o script troca pela COR passada.
#   O MESMO #8CC63F também está craVADO, literal, em mais dois lugares que
#   NÃO passam pela variável --theme-color:
#     1. Ainda dentro de assets/css/style.css: dois gradientes decorativos
#        (linha ~12648 e ~17137) e uma regra de cor de texto (linha ~16412)
#        escrevem "#8CC63F" direto, sem var(). Se o script trocasse só a
#        variável, esses três pontos ficariam verdes pra sempre.
#     2. Em 22 arquivos SVG soltos dentro de assets/img/ (ícones de
#        feature/serviço/processo, o ícone "call", aspas de depoimento, a
#        ilustração da página 404, o shape do hero E o próprio miolo do
#        logo.svg/logo-white.svg) — 166 "fill=" e 8 "stroke=" com o hex
#        cravado. Um <img src="logo.svg"> não carrega CSS nenhum, então
#        var(--theme-color) não alcança essas cores de jeito nenhum.
#   Por isso o script faz UM sed abrangente (case-insensitive) por
#   "#8CC63F" em todo assets/css/*.css e assets/img/**/*.svg, em vez de só
#   mexer na declaração --theme-color. É a única forma de recolorir o site
#   inteiro de um jeito consistente.
# --theme-color2: #2946B8 (azul) é um ACENTO secundário fixo (hover de seta
#   de slider, um dos 3 cards de destaque na home-dry-cleaning, bordas e
#   textos pontuais — 31 usos). Confirmado visualmente batendo screenshot
#   da index e da home-dry-cleaning: o azul nunca domina fundo/header/CTA,
#   só pontua. Fica FIXO — não tem garantia de que a cor do cliente combine
#   como segundo tom sobre o verde/COR escolhida.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#8CC63F'

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

COR_ESC="$(escapar "$COR")"

echo "→ cor de marca ($COR_ORIGINAL) → $COR em CSS"
grep -rIlZ -i --include=*.css -- "$COR_ORIGINAL" "$DESTINO"/assets/css 2>/dev/null \
  | xargs -0 -r sed -i "s/${COR_ORIGINAL}/${COR_ESC}/Ig"

echo "→ cor de marca ($COR_ORIGINAL) → $COR nos 22 ícones SVG (fill/stroke cravados)"
grep -rIlZ -i --include=*.svg -- "$COR_ORIGINAL" "$DESTINO"/assets/img 2>/dev/null \
  | xargs -0 -r sed -i "s/${COR_ORIGINAL}/${COR_ESC}/Ig"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "$COR_ORIGINAL" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css --include=*.svg 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO            assets/img/logo.svg e logo-white.svg são um ícone
                      (swirl/gota) MAIS o nome "Laun" desenhado como PATH
                      vetorial (texto virado contorno, cor --title-color
                      #00151D, não é texto de verdade) — não aparece em
                      nenhum grep de nome e o script não alcança. O script
                      já recolore o miolo do ícone (fill #8CC63F → COR,
                      porque esse hex é literal no arquivo), mas o
                      "Laun" vetorizado continua lá. Trocar o SVG inteiro
                      pela logo real do cliente.
  2. FAVICONS         assets/img/favicons/*.png (16 arquivos, incl.
                      favicon.ico) são o ícone verde em PNG rasterizado —
                      não são SVG, o script não mexe. Gerar favicon novo a
                      partir da logo do cliente se o verde incomodar na aba.
  3. AZUL FIXO        --theme-color2 (#2946B8) não muda com o script — ver
                      cabeçalho. Se o azul destoar muito da cor escolhida,
                      ajustar à mão em assets/css/style.css (31 usos).
  4. FOTOS            assets/img/hero, /service, /gallery, /team etc. são
                      todo placeholder cinza com a dimensão escrita dentro
                      (ex. "845 x 850", "1920 x 900") — confirmado batendo
                      screenshot antes de mexer em qualquer coisa.
  5. IMAGEM CORROMPIDA assets/img/hero/hero_overlay_2.png veio com bad CRC
                      na extração do zip (arquivo truncado — confirmado
                      lendo os chunks PNG, não só pelo aviso do unzip). É
                      usada de verdade 3x em home-dry-cleaning.html (a
                      variante "Home Dry Cleaning" do hero, nas 3 slides do
                      carrossel) — NÃO na index.html padrão, que usa
                      hero_overlay_1.png (esse OK). Se for usar a variante
                      home-dry-cleaning como página inicial, repor essa
                      imagem (não foi recriada aqui).
  6. GALLERY.HTML      tem um aviso de PHP vazado do build do vendedor
                      (Undefined array key, caminho E:\web-dev\...\laun\...)
                      cravado dentro de um atributo class de um item de
                      filtro (~linha 479) — sobra de export malfeito do
                      autor do template, não é conteúdo do site. Vale
                      limpar à mão antes de mostrar essa página a cliente.
  7. E-MAIL            6 e-mails falsos (info@laun.com, help24/7@Laun.com,
                      help24/7@gmail.com, info.example@gmail.com,
                      kristinwatson@gmail.com — este último no card de um
                      "funcionário" fake em team-details.html) já vieram
                      trocados por "[EMAIL]" (não "[NOME DO CLIENTE]",
                      pra não quebrar o domínio) — preencher com o contato
                      real ou apagar se o cliente só usa WhatsApp.
  8. TELEFONE          "+163-654-3569" / variantes — número de mentira,
                      substituir pelo real.
  9. DEPOIMENTO/EQUIPE  depoimentos (nome, foto, nota) e os cards de
                      "equipe" em team.html/team-details.html têm nome,
                      cargo e foto inventados — usar só com selo
                      "ilustrativo" visível.
 10. CARRINHO/LOJA      cart.html, checkout.html, shop.html, shop-details.html
                      e wishlist.html simulam e-commerce (preço, produto)
                      que não existe pra diarista/faxina — ou não usar
                      essas páginas no site final, ou trocar por outra
                      seção.
 11. FORMULÁRIO PHP     contact.html manda pra mail.php (PHP puro) — não
                      roda na Vercel (hospedagem estática). Trocar por
                      formulário que poste pra WhatsApp/serviço externo, ou
                      tirar o "action" e deixar só o link de WhatsApp.
 12. TEXTO              corpo em inglês, <html lang="zxx"> (nem "en") —
                      trocar pra pt-BR e reescrever com o tom do
                      identidade.md do cliente.
 13. PESO               html/ tem 32 MB, quase tudo (24 MB) é a fonte de
                      ícones Font Awesome Pro completa em
                      assets/fonts/fontawesome/ (todos os pesos/estilos) —
                      pesado pra um site estático, mas nenhuma imagem
                      grande foi cortada daqui; se o peso incomodar, dá pra
                      podar os formatos/pesos de fonte não usados.
FIM
exit 0
