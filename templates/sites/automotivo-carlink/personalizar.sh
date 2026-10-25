#!/usr/bin/env bash
#
# Cria uma cópia do template já com a cor de destaque e o nome do cliente
# trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> <#COR> "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/OficinaX/site '#F36A21' 'Oficina X'
#
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

# O template tem DOIS vermelhos de marca, quase idênticos:
#   #DD0005 — o acento geral (botões, ícones, links, dots)  — 159 usos
#   #DD1F06 — a classe .style-color1, que pinta o destaque do título do hero
# Trocar só o primeiro deixa o título vermelho no meio do site novo.
CORES_ORIGINAIS=('#DD0005' '#DD1F06')

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> <#COR> \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/OficinaX/site '#F36A21' 'Oficina X'"    >&2
  exit 1
fi

if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#F36A21' (recebi '$COR')" >&2
  exit 1
fi

if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

for original in "${CORES_ORIGINAIS[@]}"; do
  echo "→ trocando $original por $COR"
  # -I pula binário (imagens, fontes); só CSS, JS e HTML são tocados.
  grep -rIl "$original" "$DESTINO" 2>/dev/null | while read -r f; do
    sed -i "s/${original}/${COR}/g" "$f"
  done
done

echo "→ preenchendo o nome do cliente nos <title>"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME//\//\\/}/g" "$f"
done

restam=0
for original in "${CORES_ORIGINAIS[@]}"; do
  n=$(grep -rIl "$original" "$DESTINO" 2>/dev/null | wc -l || true)
  restam=$((restam + n))
done

cat <<FIM

Pronto: $DESTINO
Ocorrências do vermelho original ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO       trocar images/logo.png (304x96), logo-w.png e logo-b.png
                (418x132) e logo-sticky.png (418x94). São PNG com transparência.
  2. PÁGINA     escolher a home e apagar as outras (home-1 a home-5).
                Repontar href="home-1.html" se você ficar com outra.
  3. TEXTOS     o conteúdo é demo em inglês. Reescrever em pt-BR.
  4. CONTATO    telefone (265) 005 369, e-mail e endereço aparecem no header
                e no footer de todas as páginas.
  5. FOTOS      images/ tem 417 arquivos de demonstração. Trocar os que ficarem.
  6. [DESCRIÇÃO CURTA] nos <title> continua como slot, preencher por página.

FIM
