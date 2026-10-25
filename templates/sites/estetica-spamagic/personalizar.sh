#!/usr/bin/env bash
#
# Cria uma cópia do template Spa Magic já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#4A90A4' 'Spa XYZ'
#
# De onde vem a cor: como no Hair Care, a cor de marca não é uma CSS custom
# property — é um hex repetido dentro de UM arquivo de tema completo,
# css/pink-theme.css (31 usos sólidos do acento rosa `#efa697` + 9 usos do
# tom escuro de hover `#b7948e` + 1 em rgba()). O pack original vem com 4
# temas prontos (pink, gold, rose, silk — cada um é o MESMO arquivo de
# ~5770 linhas, só com os hex trocados); só o pink.css foi mantido nesta
# cópia porque é o único carregado pelas 10 páginas (os outros 3 estavam
# comentados no `<head>` de toda página do pacote original — dead weight,
# apagados na curadoria).
#
# NÃO mexe em (ficam como no original, não são a cor de marca):
#   bg-color-01/02/04/05 (tons de fundo bege/creme muito claros, ex.
#   #fefdfc, #f7f4f0, #d8c2be, #f0e6e0) — são a paleta de fundo "quente" do
#   tema, usados só 1-4 vezes cada, e continuam combinando com qualquer
#   acento novo. Também não mexe num rgba(255, 248, 245...) usado 13x pra
#   overlay claro — é um tom de washing bem sutil, não o hex sólido da
#   marca.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#efa697'
COR_HOVER_ORIGINAL='#b7948e'
RGB_ORIGINAL='239, 166, 151'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#4A90A4' 'Spa XYZ'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#4A90A4' (recebi '$COR')" >&2
  exit 1
fi
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }

hex2rgb() {
  local hex="${1#\#}"
  printf '%d, %d, %d' "0x${hex:0:2}" "0x${hex:2:2}" "0x${hex:4:2}"
}

# tom mais escuro pro estado de hover, derivado escurecendo cada canal em
# ~22% (a mesma proporção aproximada entre o rosa original #efa697 e seu
# hover #b7948e) — não é idêntico ao que o autor calibrou à mão pro rosa,
# mas mantém a relação "hover mais escuro que o botão" em qualquer cor nova.
hex2rgb_darker() {
  local hex="${1#\#}"
  local r=$((0x${hex:0:2} * 78 / 100))
  local g=$((0x${hex:2:2} * 78 / 100))
  local b=$((0x${hex:4:2} * 78 / 100))
  printf '#%02x%02x%02x' "$r" "$g" "$b"
}

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

COR_RGB="$(hex2rgb "$COR")"
COR_LOWER="$(printf '%s' "$COR" | tr '[:upper:]' '[:lower:]')"
COR_HOVER="$(hex2rgb_darker "$COR")"

CSS="$DESTINO/css/pink-theme.css"
echo "→ cor de marca: $COR_ORIGINAL → $COR_LOWER (31 usos sólidos + 1 em rgba)"
sed -i "s/${COR_ORIGINAL}/${COR_LOWER}/g" "$CSS"
sed -i "s/${RGB_ORIGINAL}/${COR_RGB}/g" "$CSS"
echo "→ tom de hover: $COR_HOVER_ORIGINAL → $COR_HOVER (9 usos, calculado 22% mais escuro)"
sed -i "s/${COR_HOVER_ORIGINAL}/${COR_HOVER}/g" "$CSS"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "$COR_ORIGINAL" -e "$COR_HOVER_ORIGINAL" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)

cat <<FIM2

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)
FIM2
cat <<'FIM'

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           images/logo-01.png tem "SPA MAGIC / BEAUTY & WELLNESS"
                     desenhado como texto raster, mais o ícone de flor de
                     lótus na cor rosa ORIGINAL — nome e cor do ícone, os
                     dois travados no PNG, o script não alcança nem um nem
                     outro. images/logo-white.png é a versão branca (pra
                     header transparente sobre o hero) — parece em branco
                     num visualizador com fundo branco, mas é só a mesma
                     logo em branco sobre fundo transparente (ver nota
                     "PNG transparente engana no preview" — sempre olhar
                     composto sobre um fundo escuro antes de decidir). Trocar
                     os 2 arquivos pela logo real do cliente.
  2. FOTOS          todo `images/*.jpg` de hero, galeria, equipe, serviço e
                     depoimento é placeholder cinza-escuro com a dimensão
                     escrita dentro (ex. "1920 x 1080") — são arquivos JPG
                     de verdade (não um serviço externo como no Hair Care),
                     mas continuam sendo maquete, não foto nenhuma. Sem
                     fotos reais do espaço, tratamento e equipe, o site fica
                     com cara de maquete.
  3. NEWSLETTER     o formulário de newsletter (presente em about, index,
                     pricing e services) apontava pro Mailchimp AO VIVO do
                     autor original (`dsathemes.us3.list-manage.com`, em
                     `js/custom.js`) — já neutralizado nesta cópia (url
                     vazia). Sem ESP próprio do cliente, ou plugar um
                     serviço de verdade, ou remover o formulário antes de
                     publicar.
  4. FORMULÁRIOS    `php/contactForm.php`, `php/bookingForm.php`,
                     `php/heroForm.php` e `php/commentForm.php` só rodam
                     com hospedagem PHP — a Vercel não roda PHP. Os
                     formulários de contato, agendamento e o mini-form do
                     hero não enviam nada sem isso. Trocar a submissão (ver
                     `js/contact-form.js`, `js/booking-form.js`,
                     `js/hero-form.js`) por `wa.me` ou um serviço de
                     formulário estático antes de publicar.
  5. E-MAIL/SKYPE   `yourdomain@mail.com`/`hello@yourdomain.com` já viraram
                     `[EMAIL]` nesta cópia; o "Skype: support.spamagic"
                     citado nas páginas de contato/agendamento/equipe já
                     virou `[SKYPE]`. Preencher com o contato real do
                     cliente ou apagar a linha se ele não usa.
  6. TELEFONE       `tel:123456789` / "+12 9 8765 4321" aparece fixo no
                     topo de todas as páginas (item de telefone no menu) e
                     em pelo menos 2 lugares por página de contato/
                     agendamento — trocar pelo WhatsApp real ou marcar "a
                     confirmar", nunca deixar o número de mentira no ar.
  7. INSTAGRAM FEED a faixa de 6 fotos "insta-img" no rodapé (a maioria das
                     páginas) linka pra `href="#"` — é vitrine fake de feed
                     do Instagram. Sem conta real pra puxar, trocar os
                     `href="#"` pelo Instagram do cliente ou apagar a seção.
  8. EQUIPE/DEPOIMENTO/PREÇO conferir cada página antes de publicar: nomes
                     de equipe, depoimentos de cliente e valores da tabela
                     de preço vêm todos do pacote (fictícios). Sem dado real
                     do cliente, trocar por cargo genérico sem nome ou
                     marcar "a confirmar" — nunca inventar um nome ou preço
                     novo.
  9. BLOG REMOVIDO  a seção "Our Blog" que existia na home (3 posts
                     fictícios com autor e data inventados, linkando pra
                     `single-post.html`) foi removida nesta curadoria — o
                     pack original tem página de blog (`blog-classic.html`,
                     `blog-masonry.html`, `blog-sidebar.html`,
                     `single-post.html`) que não faz parte deste template
                     enxuto. Se o cliente quiser blog de verdade, é
                     conteúdo novo, não vem pronto aqui.
 10. TEXTO          todo o corpo está em inglês, `<html lang="en">`
                     incluso — trocar pra `pt-BR` e reescrever com o tom de
                     voz do `identidade.md`, não traduzir ao pé da letra. O
                     `<meta name="keywords">` ainda cita "Jthemes" (autor
                     original) — irrelevante pra SEO hoje, não foi tocado.
FIM
exit 0
