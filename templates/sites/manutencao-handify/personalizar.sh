#!/usr/bin/env bash
#
# Cria uma cópia do template Handify já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Manutenções XYZ'
#
# O template tem UMA cor de acento só, via CSS custom property:
#   --accent-color: #F05A30  (laranja) — 92 usos em css/style.css, todos por
#   var(--accent-color). Trocar só o valor da variável já recolore botão,
#   ícone, hover, tag e linha decorativa em todas as 15 páginas.
#
# NÃO mexe em (ficam como no original, não são cor de marca):
#   - #FFD43B, amarelo das estrelas de avaliação (rating), ~50 usos inline
#     nos cards de depoimento/review — trocar junto deixaria a nota de 5
#     estrelas com a cor do botão, confunde o padrão visual de review.
#   - Um punhado de hex soltos em gradiente/borda decorativos (#004551,
#     #8692af, #a55950 etc.) — são detalhe de fundo, não a cor de marca.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#F05A30'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Manutenções XYZ'" >&2
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

CSS="$DESTINO/css/style.css"
echo "→ cor de acento (--accent-color): $COR_ORIGINAL → $COR"
sed -i "s/--accent-color: ${COR_ORIGINAL};/--accent-color: ${COR};/" "$CSS"

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

  1. LOGO          image/logo.png (header) e image/logo.png no rodapé (mesma
                    arte, 2 lugares por página) — trocar pela logo real. Tem
                    variantes Logo-1..5.png e Logo-grey-1..5.png soltas na
                    pasta image/ que não são usadas em lugar nenhum do HTML
                    (sobra do pacote original) — pode ignorar ou apagar.
  2. FOTOS         todo image/dummy-img-WxH.jpg é placeholder cinza com a
                    dimensão escrita dentro (ex. "600x400") — 46 imagens ao
                    todo. Sem foto real do serviço/equipe/fachada, o site
                    fica com cara de maquete.
  3. TELEFONE      "+1 (212) 555-1212" aparece fixo em pelo menos 4 lugares
                    (header, seção de contato, footer) — trocar por WhatsApp
                    real ou marcar "a confirmar", nunca deixar o número de
                    mentira no ar.
  4. EQUIPE        team.html e team_detail.html vêm com nome, cargo e foto
                    inventados — sem gente real, apagar a seção ou trocar por
                    cargo genérico sem nome.
  5. DEPOIMENTO    testimonial.html e os cards de review na home têm texto e
                    nota inventados — só usar com selo "ilustrativo" visível.
  6. PREÇO         pricing_plan.html tem 3 planos com valor chutado — sem
                    tabela real do cliente, apagar a página ou marcar como
                    "a confirmar".
  7. BLOG          blog.html e single_blog.html vêm com 6 posts de texto
                    genérico em inglês — geralmente não serve pra demo de
                    captação; considerar remover do menu.
  8. FORM          php/form_process.php é o processador do formulário de
                    contato — só funciona com hospedagem PHP (a Vercel não
                    roda PHP). Sem backend, o formulário não envia nada;
                    trocar a ação do <form> por um link wa.me ou um serviço
                    de formulário estático antes de publicar.
  9. TEXTO         todo o corpo está em inglês. <html lang="en"> também
                    precisa virar "pt-BR". Reescrever com o tom de voz do
                    identidade.md do cliente, não traduzir ao pé da letra.
 10. REDES SOCIAIS os links do rodapé (Instagram/Tiktok/Youtube) apontam pra
                    href="" vazio — preencher ou remover os que não existem.
FIM
exit 0
