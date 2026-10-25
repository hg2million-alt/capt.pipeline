#!/usr/bin/env bash
#
# Cria uma cópia do template já com a cor de marca e o nome do cliente
# trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> <#COR> "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh clientes/cine-xyz/site '#7A2FA3' 'Cine XYZ'
#
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

# O template tem UMA cor de acento só, o amarelo do Movflx original:
#   #e4d804 — botão, aba ativa, quality tag, ícone, hover, linha — 49 usos
# O fundo já nasce escuro (vários tons de #04081a a #20212b, sem variável),
# então uma marca de base escura (como um azul-marinho) encaixa
# sem precisar inverter nada — só troca o acento.
COR_ORIGINAL='#e4d804'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> <#COR> \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 clientes/cine-xyz/site '#7A2FA3' 'Cine XYZ'" >&2
  exit 1
fi

if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#7A2FA3' (recebi '$COR')" >&2
  exit 1
fi

if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

# escapa / e & para o sed não engasgar com nome de cliente
escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

echo "→ cor de acento: $COR_ORIGINAL → $COR"
grep -rIil "$COR_ORIGINAL" "$DESTINO" 2>/dev/null | while read -r f; do
  sed -i "s/${COR_ORIGINAL}/${COR}/gI" "$f"
done

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "$COR_ORIGINAL" -e '\[NOME DO CLIENTE\]' "$DESTINO" 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. NICHO         o template é de STREAMING (assinatura, "Sign In", "Watch
                    Now", download offline, planos em pricing.html). Um
                    cinema físico vende ingresso de sessão, não assinatura.
                    Reescrever CTA de "assistir" para "comprar ingresso" /
                    "ver sessões", e decidir o que sobra de pricing.html
                    (pode virar combo de bomboniere) e tv-show.html (pode
                    virar "em breve" ou sair).
  2. POSTERS        os 10 pôsteres em img/poster/ são de filmes genéricos de
                    banco de imagem (Women's Day, The Perfect Match etc.),
                    sem nome de filme real. Ou usam cartaz real do filme em
                    cartaz (material oficial de divulgação, não fica marcado
                    como ilustrativo), ou ficam com selo "pôster ilustrativo"
                    se for preencher vaga.
  3. LOGO           img/logo/logo.png, usado no header (2x: desktop + mobile)
                    e no footer — 3 lugares por página.
  4. VÍDEO DO HERO  o banner (banner_bg01.jpg) e o slider de index-2.html são
                    imagem estática; se o cliente mandou vídeo, trocar
                    data-background por <video> de fundo é trabalho manual,
                    o script não faz.
  5. TEXTOS         conteúdo em inglês (sinopse, categorias, newsletter). O
                    lang já é pt-BR.
  6. CONTATO        contact.html tem endereço, telefone e e-mail de mentira
                    num mapa genérico (Google Maps embed do autor).
  7. INVENÇÃO       sessão, preço de ingresso, combo, classificação indicativa
                    e nota do filme só existem preenchidas com dado de
                    demonstração. Sem dado real do cliente, marcar como
                    "a confirmar" — não completar no chute.
  8. PESO           img/ tem 4,7 MB, quase tudo pôster e banner de banco de
                    imagem — ok para demo, trocar por foto real depois.
  9. TITLE          [DESCRIÇÃO CURTA] continua como slot em cada <title>.

FIM
