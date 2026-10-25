#!/usr/bin/env bash
#
# Cria uma cópia do template LemanHouse já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Imóveis XYZ'
#
# O template não usa CSS custom property (SCSS já veio compilado pra hex
# literal) — a cor de marca é o hex #13293d (azul-marinho escuro), repetido
# 107 vezes em 3 arquivos: fundo do header/menu/rodapé, título "MORDERN
# FAMILY HOME" no slider, botões primários e bordas de destaque. É a cor que
# domina o header em toda página (confirmado por screenshot, não só pelo
# nome da variável SCSS $brand-primary).
#
# NÃO mexe em (ficam como no original, não são cor de marca — são semântica
# de status do imóvel, testado visualmente contra o mock de listagem):
#   - #56ccf2, azul-claro "brand-info" — ícone de telefone/local, texto de
#     preço "monthly", tag "For Rent". Usado em paralelo à cor de marca como
#     contraste, não é o mesmo elemento.
#   - #6dcd6d, verde "brand-success" — tag "For Sale" e borda de destaque.
#   - #114a82 e #4c58a4, dois azuis usados só nos botões "SEARCH" e
#     "CALCULATE" da calculadora de financiamento — decorativo, não repete
#     em mais nada.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#13293d'

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

echo "→ cor de marca ($COR_ORIGINAL): $COR_ORIGINAL → $COR"
for f in "$DESTINO/style.css" "$DESTINO/css/bootstrap.css" "$DESTINO/css/bootstrap-extended.css"; do
  sed -i "s/${COR_ORIGINAL}/${COR}/gI" "$f"
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

  1. LOGO           images/logo.png (e images/logo2.png, variante clara,
                     usada nas home2/home6) tem "LemanHouse Real Estate"
                     desenhado dentro do PNG — o script não alcança. Trocar
                     pela logo real do cliente, nos dois arquivos.
  2. FOTOS           NENHUMA foto é local. Todo card de imóvel e todo banner
                     usava https://via.placeholder.com/LARGURAxALTURA — esse
                     serviço saiu do ar; já trocamos por placehold.co (mesmo
                     formato de URL, mesma caixa cinza com a dimensão
                     escrita dentro) só pra não publicar imagem quebrada.
                     Ainda assim são ~690 chamadas a um serviço externo em
                     43 páginas: sem foto real de imóvel/fachada/equipe, o
                     site depende da internet do visitante pra mostrar até
                     placeholder. Trocar pelas fotos reais antes de publicar
                     é ainda mais importante aqui que no template comum.
  3. TELEFONE/ENDEREÇO "+1 246-345-0695" e "PO Box 16122 Collins Street West
                     Victoria 8007 Australia" aparecem fixos no header e
                     rodapé de toda página — trocar pelo contato real ou
                     marcar "a confirmar".
  4. E-MAIL          "info@LemanHouse.com" já veio trocado por "[EMAIL]" (8
                     ocorrências em 4 páginas: agencies-detail, agent-detail,
                     contact, home2) porque um find/replace pelo nome do
                     cliente quebraria o domínio. Preencher com o e-mail
                     real ou apagar se o cliente só usa WhatsApp. Um segundo
                     e-mail falso, "polygontheme@gmail.com" (credencial de
                     login de exemplo em user-profile.html), não foi
                     tocado — é a página de conta de usuário, sem uso numa
                     demo de captação; considerar remover do menu.
  5. IMÓVEL/PREÇO    Todo card de imóvel (endereço, preço, m², quartos,
                     banheiros, "For Sale"/"For Rent") é dado inventado do
                     template — sem imóvel real do cliente, marcar como
                     "ilustrativo" ou remover os cards antes de publicar.
  6. BUSCA/FILTRO     properties-grid*.html e afins filtram por "For
                     Rent"/"For Sale" via Isotope (JS no navegador, sem
                     backend) — funciona normal na Vercel. A busca por
                     cidade/endereço no header e o "Advanced" da barra de
                     busca são só campo de formulário, sem back-end nenhum
                     nem no original.
  7. FORMULÁRIO      NENHUM <form> do template está de fato ligado a nada:
                     todos usam action="#" (ou nem têm action), inclusive
                     contact.html. Os arquivos php/form-process.php e
                     php/form-process2.php existem no pacote mas não são
                     referenciados por nenhum HTML — nem com hospedagem PHP
                     eles disparariam sozinhos. Pra formulário funcionar na
                     Vercel, trocar a ação por um link wa.me ou um serviço
                     de formulário estático.
  8. PÁGINAS DE CONTA add-step-01..05 (cadastro de imóvel em 5 passos),
                     membership.html (planos), my-properties.html,
                     favourite-properties.html e user-profile.html simulam
                     login/conta de usuário — não funcionam (sem backend) e
                     raramente cabem numa demo de captação; considerar tirar
                     do menu.
  9. EQUIPE/AGÊNCIA  agent.html/agent-detail.html e agencies.html/
                     agencies-detail.html vêm com corretor e agência
                     fictícios (nome, foto, contato) — sem gente real,
                     remover a seção ou trocar por genérico sem nome.
 10. BLOG            blog*.html trazem post de texto genérico em inglês —
                     geralmente não serve pra demo; considerar remover do
                     menu.
 11. TEXTO           todo o corpo está em inglês, <html lang="en"> incluso —
                     trocar pra pt-BR e reescrever com o tom de voz do
                     identidade.md do cliente, não traduzir ao pé da letra.
 12. PESO            7,6 MB em html/ (sem scss/, que não é usado no site
                     publicado — só as fontes/imagens compiladas ficaram).
FIM
exit 0
