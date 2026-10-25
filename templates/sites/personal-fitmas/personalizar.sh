#!/usr/bin/env bash
#
# Cria uma cópia do template Fitmas já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'João Personal'
#
# O template tem UMA cor de marca só, mas ela não vive só na variável CSS:
#   --theme-color: #F41E1E (vermelho) — em assets/css/style.css, usada por
#   var(--theme-color) nas 256 ocorrências dentro do CSS. MAS o mesmo hex
#   #F41E1E também está escrito direto (sem variável) em:
#     - 15 ícones SVG de assets/img/icon/ (about, feature, service, wcu) —
#       o traço/preenchimento do ícone é essa cor
#     - assets/img/logo.svg e logo-white.svg — só a parte do "swoosh"/círculo
#       do símbolo, não o texto "Fitmas" (esse é #1C1C1C, cor de título, não
#       de marca — fica como está, ver Armadilha de logo)
#     - assets/js/main.js, linha 465 — cor de preenchimento de uma barra de
#       progresso circular (circleProgress)
#   O script troca TODOS esses pontos com um sed sobre o hex literal, não só
#   a variável — é a única forma de manter ícone e gráfico combinando com o
#   botão depois da troca de cor.
#
# assets/css/theme.css (duplicata não usada de style.css) e assets/sass/
# (fonte SCSS não compilada em tempo de execução) já foram removidos deste
# template — nenhuma página carrega os dois, eram só peso morto.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#F41E1E'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'João Personal'" >&2
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

echo "→ cor de marca ($COR_ORIGINAL → $COR) no CSS, nos 15 ícones SVG, na logo e no gráfico circular do JS"
grep -rIlZ -e "$COR_ORIGINAL" "$DESTINO" --include=*.css --include=*.svg --include=*.js 2>/dev/null \
  | xargs -0 -r sed -i "s/${COR_ORIGINAL}/${COR}/gI"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "$COR_ORIGINAL" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css --include=*.svg --include=*.js 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO          assets/img/logo.svg, logo-white.svg e logo2.svg têm a
                    palavra "Fitmas" desenhada como PATH vetorial (texto
                    convertido em contorno, não texto de verdade) — não
                    aparece em grep de nome e o script não alcança. O
                    círculo/swoosh do símbolo já muda de cor junto com a
                    marca (é o mesmo hex), só o texto "Fitmas" propriamente
                    fica preto e precisa ser trocado pela arte real do
                    cliente nos 3 arquivos.
  2. FOTOS         este template NÃO usa placeholder cinza — as imagens em
                    assets/img/ (hero, team, blog, gallery, project) são
                    fotos de banco de imagens de verdade, só que de pessoas
                    e academias que não são o cliente. Trocar todas pelas
                    fotos reais do personal/aluno/espaço, não só completar
                    a lacuna: aqui a foto errada é mais enganosa que um
                    cinza com "600x400" escrito dentro.
  3. E-MAIL        "health@Fitmas.com", "info@Fitmas.com", "info@gmail.com",
                    "support@gmail.com" e "info@tronix.com" apareciam
                    espalhados pelo template — todos já vieram trocados por
                    "[EMAIL]" (não por [NOME DO CLIENTE], isso quebraria o
                    domínio nos dois que usavam "Fitmas.com"). Preencher com
                    o contato real ou apagar se o cliente só usa WhatsApp.
  4. TELEFONE      pelo menos 3 números de mentira aparecem em links tel:
                    (ex. +259 (0) 256 215 no header, +189 2538-2145 no
                    rodapé) — trocar por WhatsApp real ou marcar "a
                    confirmar".
  5. CONTEÚDO É DE ACADEMIA, NÃO DE PERSONAL AUTÔNOMO — a maior armadilha
                    deste template. "Fitmas" fala de matrícula, mensalidade,
                    quadro de horário de aula (shop.html, pricing.html,
                    equipe com vários treinadores em team.html/team-2.html)
                    — é conteúdo de estúdio/academia física, não de um
                    profissional sozinho. Para personal autônomo de verdade,
                    considerar usar só como referência visual (ver o template
                    personal-progym, que já nasce com copy de personal) ou
                    cortar bastante seção/página na mão.
  6. LOJA          shop.html e shop-details.html vendem produto (suplemento,
                    equipamento) com preço inventado — na prática só serve
                    se o cliente realmente revender produto; senão, apagar.
  7. EQUIPE        team.html e team-2.html têm nome, cargo e foto de vários
                    treinadores inventados — sem gente real, apagar a seção
                    ou reduzir a 1 perfil (o do próprio personal).
  8. PREÇO         pricing.html tem planos de mensalidade com valor chutado
                    — sem tabela real do cliente, apagar a página ou marcar
                    "a confirmar".
  9. DEPOIMENTO    os 3 depoimentos da home repetem o MESMO texto ("I have
                    been a member of Fitmas for over a year now...") só
                    trocando nome/foto — inventado e nem variado; usar só
                    com selo "ilustrativo" visível, ou reescrever.
 10. BLOG          blog.html, blog-2.html e blog-details.html vêm com posts
                    de texto genérico em inglês — geralmente não serve pra
                    demo de captação; considerar remover do menu.
 11. FORMULÁRIO    mail.php é o processador do formulário de contato — só
                    funciona com hospedagem PHP; a Vercel não roda PHP. Sem
                    backend, o formulário não envia nada — trocar a ação do
                    <form> em contact.html por um link wa.me ou um serviço
                    de formulário estático antes de publicar.
 12. TEXTO         todo o corpo está em inglês (só o atributo lang já virou
                    "pt-BR") — reescrever com o tom de voz do
                    identidade.md do cliente, não traduzir ao pé da letra.
 13. REDES SOCIAIS os links do rodapé/header (Facebook/Twitter/Pinterest/
                    Instagram/Discord/Linkedin/Youtube/Google) apontam pra
                    "www.<rede>.com" genérico, sem perfil real — preencher
                    ou remover os que não existem.
 14. TRÊS HOMES    index.html, home-2.html e home-3.html são 3 variações de
                    home completas, acessíveis por um submenu "Home" (Home
                    01/02/03) em todas as páginas — decidir qual vira a
                    home de verdade antes de publicar e apagar as outras
                    duas + simplificar esse submenu pra um único item.
FIM
exit 0
