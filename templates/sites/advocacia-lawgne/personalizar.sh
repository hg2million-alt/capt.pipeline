#!/usr/bin/env bash
#
# Cria uma cópia do template Lawgne já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#0F5C3F' 'Advocacia XYZ'
#
# O template não usa CSS custom property (não tem `:root`, é hex cru
# repetido) — tem DUAS cores em jogo, não uma:
#   #162542 (navy escuro) — cor de texto de todos os heading (h1..h6), fundo
#     das faixas escuras (.blue-bg, banner interno "About Us" etc.) e borda
#     do botão outline (.filled-btn). 83 usos em assets/css/style.css + mais
#     95 em forma rgba(22, 37, 66, ...). É o tom estrutural do template
#     (equivalente ao "quase preto" que vira fundo de seção neutra nos outros
#     templates da biblioteca) — NÃO é isso que o script troca.
#   #b68c5a (dourado/bronze) — é a cor de marca de verdade: confirmado por
#     screenshot da index.html raw (botão "FREE QUOTE" do header, link
#     "Get a Quote" da barra superior, botão "APPOINTMENT NOW" do hero,
#     sublinhado dos "Who We Are"/subtítulos de seção, hover de menu e de
#     link, ícone de contato, back-to-top). 70 usos diretos em hex + mais
#     3 em rgba(182, 140, 90, ...). É essa que o script troca pela COR
#     passada.
#
# NÃO mexe em #162542 (navy) — trocar junto quebraria a hierarquia visual
# (título e fundo escuro ficariam da cor do botão, sem contraste entre os
# dois). Se o cliente tiver uma segunda cor de marca escura, trocar #162542
# à mão depois, olhando o preview.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#b68c5a'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#0F5C3F' 'Advocacia XYZ'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#0F5C3F' (recebi '$COR')" >&2
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
echo "→ cor de marca (dourado, hex cru): $COR_ORIGINAL → $COR"
COR_LOWER=$(printf '%s' "$COR" | tr 'A-F' 'a-f')
sed -i "s/${COR_ORIGINAL}/${COR_LOWER}/g; s/$(printf '%s' "$COR_ORIGINAL" | tr 'a-f' 'A-F')/$(printf '%s' "$COR" | tr 'a-f' 'A-F')/g" "$CSS"

R=$((16#${COR_LOWER:1:2})); G=$((16#${COR_LOWER:3:2})); B=$((16#${COR_LOWER:5:2}))
echo "→ mesma cor em rgba(182, 140, 90, ...): rgba($R, $G, $B, ...)"
sed -i "s/rgba(182, 140, 90,/rgba(${R}, ${G}, ${B},/g; s/rgba(182, 141, 90,/rgba(${R}, ${G}, ${B},/g" "$CSS"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

echo "→ preenchendo e-mail (deixado como [EMAIL] no pré-processamento; sem e-mail real, o placeholder fica visível)"

restam_cor=$(grep -rIoi -e "$COR_ORIGINAL" "$CSS" 2>/dev/null | wc -l || true)
restam_nome=$(grep -rIol '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor original ainda em style.css: $restam_cor (esperado: 0)
Arquivos .html que ainda têm [NOME DO CLIENTE]: $restam_nome (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           assets/images/logo/logo-1.png (header, painel mobile) e
                     logo-2.png (rodapé) são placeholder cinza "192X45" com a
                     dimensão escrita dentro, sem nome nenhum desenhado —
                     mais fácil que a maioria dos templates da biblioteca,
                     mas ainda precisa entrar a logo real do cliente nos 3
                     lugares por página. assets/images/about/about-logo.png
                     (selo redondo "173X158" na seção "About") também.
  2. FOTOS           todo assets/images/*.jpg com nome "descritivo" (about-1,
                     hero, attorney-1, case-1, testimonial-1 etc.) é
                     placeholder cinza com a dimensão escrita dentro — 158
                     arquivos ao todo, nenhum é foto real. Não confiar no
                     nome do arquivo.
  3. TELEFONE/E-MAIL "+012 (345) 56 899" e "+012 (345) 56 998" aparecem fixos
                     em várias páginas — trocar por WhatsApp real ou marcar
                     "a confirmar". O(s) e-mail(s) (hello@barky.com,
                     info@barky.com, support@gmail.com no original) já
                     viraram "[EMAIL]" no pré-processamento — preencher com o
                     e-mail real ou apagar se o escritório só usa WhatsApp.
  4. ENDEREÇO        "59 Main Street, USA" e "New York" (contact.html, index)
                     são endereço de mentira, junto com o mapa do Google
                     embutido apontando pra "new york" — trocar pelo
                     endereço real do escritório ou remover a seção de mapa.
  5. ADVOGADOS/EQUIPE attorney.html e attorney-details.html vêm com nome,
                     cargo e foto inventados (Steven E. Hames,
                     Brian M. Crouch, Lawrence S. Perez etc.) — sem gente
                     real, apagar a seção/página ou trocar por nome genérico
                     sem sobrenome de mentira.
  6. CASOS/"CASE"    case-1.html, case-2.html, case-details.html descrevem
                     casos com texto lorem ipsum genérico — sem caso real
                     documentado, não inventar detalhe de processo.
  7. ATENÇÃO OAB     about-us.html, attorney.html e attorney-details.html têm
                     3 barras de progresso estilo "skill bar" — "Dedicated
                     Lawyer 67%", "Dedicated Lawyer 87%", "Experiance Cases
                     76%", "Professional Team 69%" — um widget genérico de
                     "habilidade" reaproveitado de template não-jurídico, mas
                     a frase "Experiance Cases 76%" lê como estatística de
                     sucesso em processo. Isso ESBARRA no Provimento 205/2021
                     da OAB (proibição de promessa de resultado, captação de
                     clientela indevida e mercantilização da advocacia) —
                     REMOVER ou reescrever essas barras antes de publicar pra
                     qualquer cliente real, não é "dado a confirmar", é
                     proibido. O mesmo vale pra qualquer estatística de "%
                     de casos ganhos" que apareça nas páginas de "case" ou
                     depoimento — nenhuma foi encontrada nesta revisão além
                     dessas 4 barras, mas conferir de novo se o conteúdo for
                     alterado.
  8. DEPOIMENTO      testimonial na index/about (Louis H. Sanders) é texto
                     genérico sem menção a resultado de processo — ok manter
                     como estrutura, mas só com selo "ilustrativo" visível e
                     nunca como depoimento real.
  9. FORMULÁRIO      contact.html e o formulário de newsletter do rodapé são
                     <form> sem action nem backend — não tem PHP no pacote
                     (bom, não precisa se preocupar com PHP na Vercel), mas
                     também não envia nada sozinho. Trocar a ação por um link
                     wa.me ou um serviço de formulário estático antes de
                     publicar.
 10. CRÉDITO ESTÚDIO o rodapé de todas as páginas diz "Design By Webtend"
                     (estúdio autor do template) — não é o nome do cliente,
                     remover antes de publicar.
 11. TEXTO           corpo inteiro em inglês, <html lang="en"> incluso —
                     trocar pra "pt-BR" e reescrever com o tom de voz do
                     identidade.md do cliente, não traduzir ao pé da letra.
 12. REDES SOCIAIS   links de redes sociais no header/rodapé apontam pra
                     href="#" ou vazio — preencher ou remover os que não
                     existem.
FIM
exit 0
