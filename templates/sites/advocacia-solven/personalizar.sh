#!/usr/bin/env bash
#
# Cria uma cópia do template Solven já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#8B5E2E' 'Almeida Advogados'
#
# O template NÃO tem variável CSS (sem `:root`, sem custom property nenhuma —
# é um template de 2020, cor é tudo hex solto espalhado em assets/css/style.css).
# A cor de marca de verdade é:
#   #c08329 (dourado) — 76 usos em assets/css/style.css: fundo da barra de
#   navegação, botão padrão, hover de menu, linha decorativa do topbar, texto
#   de destaque do hero/headline, camada de feature, barra ativa de serviço.
#   Confirmado por screenshot RAW do index/contact antes de qualquer edição:
#   é a cor que domina header, CTA e todo destaque visual do site. É essa que
#   o script troca pela COR passada.
#
# NÃO mexe em (ficam como no original, não são cor de marca):
#   - #fc6e36 (laranja) — botão "voltar ao topo", borda de foco de formulário,
#     spinner do preloader. É um acento de UI genérico do template, não
#     aparece em nenhuma peça de identidade (header, logo, CTA principal).
#   - #086ad8 / #3454D1 (azuis) — CSS de variantes de header (".header-style-2",
#     ".header-style-3", ".mini-cart", ".social-links") que NÃO são usadas nas
#     páginas reais (o HTML só usa "header-style-1", sem topbar de carrinho
#     nem social-links nesse formato) — regra morta, não aparece na tela.
#   - #c68e3c / #cd984a — variações próximas do dourado usadas só em linhas
#     decorativas finas (10px/1px) de seção — deixadas de propósito levemente
#     diferentes da cor de botão no design original; mexer nelas deixa listras
#     residuais da cor antiga espalhadas pela página. Se incomodar visualmente
#     depois de trocar a cor principal, ajustar à mão.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#c08329'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#8B5E2E' 'Almeida Advogados'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#8B5E2E' (recebi '$COR')" >&2
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
echo "→ cor de marca ($COR_ORIGINAL, hardcoded — sem variável CSS): $COR_ORIGINAL → $COR"
sed -i "s/${COR_ORIGINAL}/${COR}/g" "$CSS"

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

  1. LOGO           assets/images/logo.png é um PNG TRANSPARENTE com o ícone
                     de balança + a palavra "SOLVEN" desenhados em branco
                     dentro da imagem (não é texto real — Read/preview mostra
                     como área branca vazia porque o fundo é transparente,
                     conferir compondo sobre fundo escuro antes de julgar).
                     O script não alcança PNG — trocar o arquivo inteiro pela
                     logo real do cliente, único lugar de uso (header, todas
                     as páginas).
  2. TELEFONE/FAX    "+00 568 746 987" aparece fixo em TODAS as 16 páginas (2
                     vezes cada: topbar + rodapé) e "Fax: 568 746 987" some
                     em attrony-single.html — trocar por WhatsApp real ou
                     marcar "a confirmar", nunca deixar número de mentira.
  3. E-MAIL          attrony-single.html tinha "youremail@gmail.com" no card
                     do advogado — já veio neutralizado pra "[EMAIL]" (não dá
                     pra confundir com domínio do cliente, porque não batia
                     com "solven" mesmo antes do replace). mail-contact.php
                     também tem um e-mail de dev do autor do template
                     (themexshapermarketing@gmail.com) — ver item 7, esse
                     arquivo nem roda na Vercel, só importa se for
                     reaproveitar o backend.
  4. EQUIPE          attrony.html e attrony-single.html trazem 3 advogados
                     inventados (Deirdre Starnes, Nicolette Corral, Roselyn
                     Felton) com foto e bio genérica — sem gente real, apagar
                     os cards ou reduzir pra quem existe de fato.
  5. DEPOIMENTOS     testimonials.html reusa "Nicolette Corral" (mesmo nome
                     fictício da equipe) 4 vezes como cliente satisfeito, com
                     avatar e texto genérico — só publicar com selo
                     "ilustrativo" visível, nunca como depoimento real.
  6. CASE STUDIES — ATENÇÃO OAB: case-studies.html, case-study-single.html e
                     o bloco "quote" do index.html trazem estatística de
                     resultado de processo — "86% Case Complete", "72%
                     Charges Dropped", "24% Counter Suits Filed", "37% Case
                     Dismiss" — e o título "Recent Successfully Completed
                     Cases" com "25 Recent Successfully Completed Cases" no
                     case-study-single. Isso é PROMESSA DE RESULTADO e
                     estatística de sucesso de causa, proibido pelo
                     Provimento 205/2021 do CFOB (veda promessa de resultado,
                     captação de clientela indevida e mercantilização da
                     advocacia). REMOVER ou REESCREVER essas seções/páginas
                     inteiras antes de publicar para qualquer cliente real —
                     não é armadilha cosmética, é risco ético/disciplinar.
  7. FORM            mail-contact.php é o processador do formulário de
                     contato/orçamento — só funciona com hospedagem PHP; a
                     Vercel não roda. Sem backend, o formulário não envia
                     nada; trocar a ação do <form> por um link wa.me ou um
                     serviço de formulário estático antes de publicar.
  8. FOTOS           assets/images/ (about, hero-bg, case/*, project-single/*,
                     blog/*) — conferir cada uma antes de assumir que é foto
                     real; várias têm nome descritivo mas podem ser banco de
                     imagem genérico, não foto do escritório do cliente.
  9. TEXTO           corpo inteiro em inglês, <html lang="en"> incluso em
                     todas as páginas — trocar pra "pt-BR" e reescrever com o
                     tom de voz do identidade.md do cliente, não traduzir ao
                     pé da letra.
 10. PÁGINAS EXTRA   o template tem 16 páginas (3 variações de blog,
                     404, case studies duplo, service-single) — descartar as
                     que não fazem sentido pro demo em vez de publicar tudo.
FIM
exit 0
