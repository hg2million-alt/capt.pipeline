#!/usr/bin/env bash
#
# Cria uma cópia do template já com a cor de marca e o nome do cliente
# trocados. O original em app/ nunca é alterado.
#
# ATENÇÃO — este template é REACT (Vite + TS), não HTML estático como os
# outros da biblioteca. Depois de rodar este script você ainda precisa
# instalar dependências e rodar/buildar o projeto — ver "Falta fazer" no
# final e o README.md.
#
#   ./personalizar.sh <pasta-destino> <#COR> "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/OficinaX/site '#0EA5E9' 'Oficina X'
#
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/app"

# A cor de marca original é #EB3300 (laranja-avermelhado). Ela aparece de
# dois jeitos no CSS já compilado (src/assets/css/style.css e custom.css —
# é isso que o app importa em tempo de execução, não os .scss em
# src/assets/sass/, que ficam no repo só como referência e não são
# processados no build):
#   1. Hex sólido "#EB3300"              — 199 usos (botões, ícones, bordas)
#   2. rgba(235, 51, 0, <alpha>)         — 4 variações de opacidade, usadas
#      em overlays e sombras
# Trocar só o hex deixa esses overlays com o laranja original por baixo da
# cor nova.
COR_ORIGINAL_HEX='EB3300'
COR_ORIGINAL_RGB='235, 51, 0'

NOME_ORIGINAL='Automec'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> <#COR> \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/OficinaX/site '#0EA5E9' 'Oficina X'"     >&2
  exit 1
fi

if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#0EA5E9' (recebi '$COR')" >&2
  exit 1
fi

if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

COR_HEX_MAIUSCULO="${COR#\#}"
COR_HEX_MAIUSCULO="$(echo "$COR_HEX_MAIUSCULO" | tr '[:lower:]' '[:upper:]')"

R=$((16#${COR_HEX_MAIUSCULO:0:2}))
G=$((16#${COR_HEX_MAIUSCULO:2:2}))
B=$((16#${COR_HEX_MAIUSCULO:4:2}))
COR_RGB="${R}, ${G}, ${B}"

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"
# node_modules e dist nunca vêm no template guardado — garantindo que uma
# cópia antiga não vaze aqui também.
rm -rf "$DESTINO/node_modules" "$DESTINO/dist" "$DESTINO/tsconfig.app.tsbuildinfo"

echo "→ trocando #$COR_ORIGINAL_HEX por #$COR_HEX_MAIUSCULO (hex sólido)"
grep -rIl "$COR_ORIGINAL_HEX" "$DESTINO" 2>/dev/null | while read -r f; do
  sed -i "s/#${COR_ORIGINAL_HEX}/#${COR_HEX_MAIUSCULO}/g; s/#${COR_ORIGINAL_HEX,,}/#${COR_HEX_MAIUSCULO}/g" "$f"
done

echo "→ trocando rgba($COR_ORIGINAL_RGB, ...) por rgba($COR_RGB, ...)"
grep -rIl "rgba($COR_ORIGINAL_RGB" "$DESTINO" 2>/dev/null | while read -r f; do
  sed -i "s/rgba(${COR_ORIGINAL_RGB}/rgba(${COR_RGB}/g" "$f"
done

echo "→ trocando o nome '$NOME_ORIGINAL' pelo nome do cliente"
NOME_ESCAPADO="${NOME//\//\\/}"
grep -rIl "$NOME_ORIGINAL" "$DESTINO" 2>/dev/null | while read -r f; do
  sed -i "s/${NOME_ORIGINAL}/${NOME_ESCAPADO}/g" "$f"
done

restam_cor=$(grep -rIl "$COR_ORIGINAL_HEX" "$DESTINO" 2>/dev/null | wc -l || true)
restam_rgba=$(grep -rIl "rgba($COR_ORIGINAL_RGB" "$DESTINO" 2>/dev/null | wc -l || true)
restam_nome=$(grep -rIl "$NOME_ORIGINAL" "$DESTINO" 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor original ainda presentes — hex: $restam_cor, rgba: $restam_rgba (esperado: 0)
Ocorrências de "$NOME_ORIGINAL" ainda presentes: $restam_nome (esperado: 0)

Isto é um projeto REACT (Vite + TypeScript), não HTML estático. Antes de ver
qualquer coisa no navegador:

  cd "$DESTINO"
  npm install
  npm run dev        # http://localhost:5173 — pra conferir
  npm run build       # gera dist/ — é o que sobe pro Vercel

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO         public/images/logo/logo.png, logo-white.png e favicon.png
                  têm "Automec" desenhado dentro da imagem (não é texto CSS,
                  não sai em find/replace). Precisa substituir os PNGs pelo
                  logo real do cliente.
  2. HOME         escolher Home1 (home-1, marketplace/hero split) ou Home2
                  (hero mais simples) em src/Routers.tsx e apagar a rota que
                  não for usada.
  3. PLACEHOLDER  o hero de ambas as homes usa uma imagem cinza com a
                  dimensão escrita dentro ("534x722") — trocar por foto real
                  da oficina/cliente antes de publicar.
  4. TEXTOS       conteúdo é demo em inglês (Lorem Ipsum incluso). Reescrever
                  em pt-BR.
  5. CONTATO      endereço "Dhaka", telefone "+88 0123456789" e e-mail
                  "info@exampleyourmail.com" aparecem no header, footer e
                  página de contato — trocar em src/components/contact/ e
                  src/jsonData/.
  6. REDES        rodapé linka pra facebook.com/twitter.com genéricos (não
                  são contas do autor, mas também não são do cliente) —
                  trocar em src/components/slider/SocialShare.tsx.
  7. <TITLE>      só existe UM <title> pra todo o site (definido via Helmet
                  em src/App.tsx) — diferente dos templates HTML, aqui não
                  há título por página.
  8. IMAGEM QUEBRADA  o fundo do card de depoimento estilo 2 aponta pra um
                  caminho relativo errado em src/assets/css/style.css
                  (linha ~4973: "../../images/section-bg/testimonial-two-bg.png").
                  Trocar para "/images/section-bg/testimonial-two-bg.png".

FIM
