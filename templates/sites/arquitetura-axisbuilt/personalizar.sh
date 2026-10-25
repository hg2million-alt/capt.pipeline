#!/usr/bin/env bash
#
# Cria uma cópia do template Axisbuilt já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Studio XYZ Arquitetura'
#
# O template tem UMA cor de marca de verdade, via CSS custom property:
#   --accent-color: #caa05c (dourado) — 145 usos em assets/css/style.css,
#   todos por var(--accent-color). É o dourado do botão "GET IN TOUCH", da
#   faixa de destaque com os serviços rolando (marquee), do texto de apoio
#   acima dos títulos e dos ícones — confirmado batendo screenshot da home,
#   about e contact antes de mexer em qualquer coisa (o dourado domina botão,
#   faixa e detalhe, o preto é só texto/fundo neutro, ver abaixo).
#
# NÃO mexe em --primary-color: #0d0d0d (quase preto). É texto padrão do
# corpo, cor dos títulos grandes e fundo das seções escuras (footer, hover de
# botão, faixa de progresso) — funciona igual com qualquer COR de acento,
# não é a cor da marca. Ajustar à mão só se o cliente pedir uma base clara
# em vez de preta nessas seções (não é troca de 1 variável, é trabalho de
# CSS).
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#caa05c'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Studio XYZ Arquitetura'" >&2
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
echo "→ cor de marca (--accent-color): $COR_ORIGINAL → $COR"
sed -i "s/--accent-color: ${COR_ORIGINAL};/--accent-color: ${COR};/" "$CSS"
# Um gradiente decorativo (card de contato do sidebar) usa o hex direto em
# maiúsculas em vez de var(--accent-color) — só essa ocorrência escapa da
# variável, trocar junto.
COR_MAIUSCULA="$(printf '%s' "$COR_ORIGINAL" | tr 'a-f' 'A-F')"
sed -i "s/${COR_MAIUSCULA}/${COR}/" "$CSS"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "$COR_ORIGINAL" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)
emails=$(grep -rIo '\[EMAIL\]' "$DESTINO" --include=*.html 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)
Marcadores [EMAIL] ainda por preencher: $emails (esperado: >0 — ver item 4
abaixo, não é sobra, é de propósito)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           assets/img/logo.svg (header) e logo2.svg (rodapé) têm a
                     palavra "AxisBuilt" desenhada como PATH vetorial (texto
                     convertido em contorno, não texto de verdade) — não
                     aparece em nenhum grep de nome e o script não alcança.
                     Tem também footer-logo.webp / footer-logo2.webp (ícone
                     decorativo) e logo-text.webp / logo-text2.webp (o
                     selo giratório "ARCHITECTURE & INTERIOR DESIGN" atrás do
                     ícone) — trocar os 6 arquivos pela identidade real.
  2. FOTOS           todo assets/img/*.webp de conteúdo (about-img, hero-img,
                     hero-bg, portfolio-img, post-img, banner-img, avatar,
                     contact-img, cta-bg, faq-img — mais de 150 arquivos) é
                     placeholder cinza com a dimensão escrita dentro (ex.
                     "789x846"). Sem fotos reais de projeto/obra/equipe, o
                     site fica com cara de maquete — o nicho de arquitetura
                     vive de portfólio visual, então isso pesa mais aqui do
                     que em outros templates.
  3. FORMULÁRIO      contact-us.html manda o formulário de contato pra
                     "https://api.web3forms.com/submit" com uma
                     access_key (cd98b256-...) que é a CONTA DO AUTOR DO
                     TEMPLATE — se publicar assim, a mensagem do cliente cai
                     na caixa de entrada de outra pessoa, não do cliente.
                     Antes de publicar: ou gera uma access_key nova e grátis
                     em web3forms.com pro e-mail real do cliente, ou troca a
                     ação do form por um link wa.me. As outras páginas (home,
                     blog, newsletter) têm formulário com action="#", que não
                     envia nada.
  4. E-MAIL           os e-mails de mentira (info@axisbuilt.com,
                     admin@axisbuilt.com, info@gmail.com, email@exmple.com,
                     support@example.com, espalhados por about-us, contact-us,
                     home-v2/v3/v6, services, team, team-details) já vieram
                     trocados por "[EMAIL]" em vez de "[NOME DO CLIENTE]"
                     porque um find/replace pelo nome ia quebrar o domínio
                     axisbuilt.com. Preencher com o e-mail real do cliente ou
                     apagar se ele só usa WhatsApp.
  5. TELEFONE        cada página tem um número de telefone/Skype diferente e
                     inventado (tel:001100110011, tel:+01234567890,
                     tel:+0844560789, tel:+25669872564, tel:+123456789,
                     tel:+12318005678990) — não é um valor único pra trocar
                     com sed, é preciso ir página por página e ou trocar pelo
                     WhatsApp real ou remover o bloco de telefone.
  6. MAPA            o iframe do Google Maps em contact-us.html está fixo em
                     Nova York (coordenadas do template original) — trocar
                     pelo endereço real do cliente ou remover a seção.
  7. EQUIPE           team.html e team-details.html vêm com nome (Savannah
                     Nguyen, Leslie Alexander, Cameron Williamson, repetidos)
                     e foto inventados — sem gente real, apagar a seção ou
                     trocar por cargo genérico sem nome.
  8. PREÇO           pricing.html tem 3 planos (\$69/\$79/\$99) chutados — sem
                     tabela real do cliente, apagar a página ou marcar como
                     "a confirmar" (projeto de arquitetura raramente tem
                     preço fixo em vitrine, considerar remover do menu).
  9. BLOG            blog.html, blog-details.html e os posts citados em
                     outras páginas são texto genérico em inglês — geralmente
                     não serve pra demo de captação; considerar remover do
                     menu.
 10. PÁGINAS DE SOBRA este pacote tem 6 versões de home (index.html = home
                     principal, home-v2 a home-v6) — escolher UMA e apagar
                     ou deslincar as outras do menu antes de entregar, senão
                     o site parece indeciso.
 11. TEXTO           todo o corpo está em inglês, <html lang="en"> incluso —
                     trocar pra "pt-BR" e reescrever com o tom de voz do
                     identidade.md do cliente, não traduzir ao pé da letra.
 12. LINKS VAZIOS    o template tem vários href="#" (menu "License" no
                     rodapé, formulário de busca, newsletter, etc.) que não
                     levam a lugar nenhum — conferir cada um antes de
                     publicar.
FIM
exit 0
