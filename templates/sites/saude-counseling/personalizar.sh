#!/usr/bin/env bash
#
# Cria uma cópia do template Cloe Brooks (psicologia/terapia) já com a cor
# de marca e o nome do cliente trocados. O original em html/ nunca é
# alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#8FA37E' 'Consultório XYZ'
#
# O template ("Cloe Brooks", ThemeREX, WordPress convertido pra HTML) usa
# LESS compilado — a cor de marca de verdade é `#EDB39B` (pêssego/salmão),
# 367 usos em css/skins/less/skin.css (link, botão "Make an appointment",
# ícone, linha decorativa de título, carrossel) + mais 4 em css/style.css
# (plugin de agendamento "Booked" e uma classe utilitária de ícone) — esse
# script troca os dois arquivos.
#
# ARMADILHA DE ARQUIVO MORTO: existe um `css/skin.css` na RAIZ de css/ com o
# mesmo conteúdo, mas SALVO COM ESPAÇOS QUEBRADOS dentro de cada declaração
# ("font - family: ... 15 px", "1.85e m") — é lixo/artefato do pacote
# original, nenhuma página carrega esse arquivo (todas usam
# css/skins/less/skin.css, confirmado nos 26 HTML). Não precisa tocar nele;
# ele nem é copiado por este script no dia a dia, mas se algum dia decidir
# reconstruir o template do zero, ignore esse arquivo.
#
# --72b5ca (azul petróleo) é só o hover do link e o fundo do blockquote —
# não domina nenhum elemento grande na tela (confirmado por screenshot);
# fica FIXO, mesmo raciocínio do --secondary do ClinicMaster/--primary-color
# do Qlinest.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='EDB39B'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#8FA37E' 'Consultório XYZ'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#8FA37E' (recebi '$COR')" >&2
  exit 1
fi
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }

HEX="${COR#\#}"

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

echo "→ cor de marca ($COR_ORIGINAL): #$COR_ORIGINAL → $COR"
sed -i "s/${COR_ORIGINAL}/${HEX}/gI" "$DESTINO/css/skins/less/skin.css" "$DESTINO/css/style.css"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam_nome=$(grep -rIo '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html 2>/dev/null | wc -l || true)
restam_cor=$(grep -oi "$COR_ORIGINAL" "$DESTINO/css/skins/less/skin.css" "$DESTINO/css/style.css" 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências de [NOME DO CLIENTE] ainda presentes: $restam_nome (esperado: 0)
Ocorrências da cor original: $restam_cor (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           não tem arquivo de logo — o cabeçalho usa só o nome em
                     texto (já virou [NOME DO CLIENTE], sem problema), mas
                     confirme se o cliente quer logo de verdade no lugar.
  2. FOTOS           images/ e uploads/ trazem fotos de banco de imagem
                     (retrato de "terapeuta", ambiente de consultório) —
                     sem foto real do profissional, marcar como ilustrativo
                     ou trocar antes de publicar; primeira impressão de
                     terapeuta pede rosto real, mais que qualquer outro
                     nicho desta leva.
  3. E-MAIL/TELEFONE FAKE — "info@yoursite.com"/"info@yoursitename.com" e
                     "123-456-7890" / "123, New Lenox Chicago, IL 60606"
                     (endereço americano!) aparecem fixos em várias páginas —
                     trocar por contato e endereço reais do cliente.
  4. PLUGIN "BOOKED" — a página appointment.html e o CSS de agendamento
                     (plugin WordPress "Booked", ~linha 7148 de css/style.css)
                     vieram junto mas dependem de PHP/WordPress; não
                     funcionam como HTML estático na Vercel. Trocar o
                     formulário de agendamento por wa.me ou serviço de
                     formulário estático.
  5. FORMULÁRIO PHP  include/sendmail.php não roda na Vercel — mesma troca
                     acima vale pro formulário de contato genérico.
  6. LOJA/FÓRUM/GRUPOS/MEMBROS — shop.html, product-single.html,
                     forums.html, groups.html, groups-single.html,
                     members.html vêm do lado "multipurpose" do tema
                     (BuddyPress/bbPress/WooCommerce simulados em HTML
                     estático) — não fazem sentido pra um consultório
                     solo; não incluir no menu do demo, considerar apagar
                     as páginas.
  7. CONTEÚDO/BLOG DE EXEMPLO — category-*.html, gallery-*.html,
                     shortcodes.html, typography.html são vitrine de layout
                     do tema, não páginas de site; ignorar ou apagar.
  8. LINK DE DOCUMENTAÇÃO MORTO — o menu tinha 2 links "Documentation" pra
                     doc/index.html (pasta de ajuda do ThemeREX, 41 MB, não
                     copiada pra este template — é só documentação do tema
                     comprado, não faz parte do site). Os hrefs já foram
                     trocados por "#" pra não dar 404; remover o item de
                     menu de vez antes de publicar.
  9. TEXTO           corpo em inglês, <html lang="en"> incluso — trocar pra
                     pt-BR e reescrever com o tom de voz do identidade.md,
                     não traduzir ao pé da letra.
 10. AZUL DE HOVER FIXO — links/blockquote mudam pra azul petróleo
                     (#72b5ca) no hover/destaque; se a cor do cliente for
                     próxima disso o efeito de hover fica sutil demais —
                     ajustar à mão em casos assim (buscar "72b5ca" em
                     css/skins/less/skin.css).
FIM
exit 0
