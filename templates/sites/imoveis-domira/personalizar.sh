#!/usr/bin/env bash
#
# Cria uma cópia do template Domira já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Imóveis XYZ'
#
# O template tem UMA CSS custom property de marca: --Primary: #FE5631
# (laranja), 41 usos em css/styles.css (var(--Primary), sempre pela
# variável, nunca hex solto) — trocar o valor já recolore tudo que usa a
# marca: link ativo do menu (sublinhado), tag de status "For Rent"/"For
# Sale" nos cards, ícone em hover, borda de destaque.
#
# Confirmado por screenshot: o visual "editorial" do tema (fundo bege claro
# --Bg-light, texto quase-preto --Text-primary, e os BOTÕES SÓLIDOS PRETOS
# "View Properties" / "Search Property" / "Filters") continua preto mesmo
# depois de trocar a cor — não é bug, é a paleta do tema: preto pros CTAs
# principais, --Primary só pro acento secundário. Se quiser os botões
# também na cor do cliente, trocar --Black à mão (ver README).
#
# NÃO mexe em (fixo, decorativo, não é cor de marca):
#   - O degradê diagonal bege→azul-claro do hero, da listagem e do detalhe
#     de imóvel (#DCEDF5 → #F9F1E5) é hardcoded, não usa variável — é fundo
#     de seção, não acento de marca.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#FE5631'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Imóveis XYZ'" >&2
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

CSS="$DESTINO/css/styles.css"
echo "→ cor de marca (--Primary): $COR_ORIGINAL → $COR"
sed -i "s/--Primary: ${COR_ORIGINAL};/--Primary: ${COR};/" "$CSS"

# Duas páginas (blog-single.html, property-details.html) têm ícone SVG
# inline com fill="#FE5631" direto no HTML, fora da variável CSS.
grep -rIl "fill=\"${COR_ORIGINAL}\"" "$DESTINO" --include=*.html | while read -r f; do
  sed -i "s/fill=\"${COR_ORIGINAL}\"/fill=\"${COR}\"/gI" "$f"
done

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "$COR_ORIGINAL" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           images/logo/logo.svg tem a palavra "Domira" desenhada
                     como PATH vetorial (contorno, texto convertido em
                     forma) — não aparece em grep de nome e o script não
                     alcança. Tem 2 usos por página (header fixo + header
                     normal) e mais 1 no rodapé. Trocar pelo SVG/PNG da
                     logo real do cliente nos 3 lugares.
  2. FOTOS           NENHUMA foto é real: images/properties/, /agents/,
                     /house/, /banner/, /section/, /avatar/ e /blog/ são
                     todo bloco de cor sólida (azul-claro, bege, cinza) sem
                     nem a dimensão escrita dentro — o oposto do padrão
                     "cinza com WxH" dos outros templates da biblioteca.
                     Sem foto real de imóvel/corretor, o site fica com cara
                     de wireframe, não de maquete.
  3. E-MAIL          "themesflat@gmail.com" (contato do AUTOR do tema,
                     repetido em quase toda página) e "mccoy@domira.com"
                     (e-mail de um corretor fictício em property-details.html)
                     já vieram trocados por "[EMAIL]" (75 ocorrências) —
                     preencher com o contato real ou apagar se só usa
                     WhatsApp. Sem essa troca, qualquer formulário que
                     alguém ligasse a um serviço de e-mail cairia na caixa
                     do autor do tema, não do cliente.
  4. IMÓVEL/CORRETOR endereço, preço, m², quartos, banheiros e o corretor
                     "mccoy" com foto/contato em property-details.html são
                     todos inventados — sem dado real do cliente, marcar
                     como "ilustrativo" ou remover os cards antes de
                     publicar.
  5. BOTÕES PRETOS   "View Properties", "Search Property", "Filters" e
                     outros CTAs sólidos ficam pretos mesmo depois de trocar
                     a COR (ver cabeçalho do script) — é a paleta original
                     do tema, não um bug. Se o cliente quiser os botões
                     também coloridos, trocar --Black à mão em
                     css/styles.css (85+ usos, não é uma troca de 1 linha).
  6. BUSCA/FILTRO    listing-*.html filtram e ordenam por JS no navegador
                     (sem backend) — funciona normal na Vercel. Nenhum
                     <form> do template está ligado a nada (todos usam
                     action="#", inclusive contact-us.html) — pra funcionar
                     na Vercel, trocar a ação por um link wa.me ou um
                     serviço de formulário estático.
  7. TEXTO           todo o corpo está em inglês, <html lang="en"> incluso —
                     trocar pra pt-BR e reescrever com o tom de voz do
                     identidade.md do cliente, não traduzir ao pé da letra.
  8. BLOG            blog-defaults.html e blog-single.html trazem post de
                     texto genérico em inglês — geralmente não serve pra
                     demo de captação; considerar remover do menu.
FIM
exit 0
