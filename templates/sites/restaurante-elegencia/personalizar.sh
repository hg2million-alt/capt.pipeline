#!/usr/bin/env bash
#
# Cria uma cópia do template já com a cor de marca e o nome do cliente
# trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> <#COR> "<Nome do Cliente>" [claro <#COR_TITULO>]
#
# Exemplos:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#C9A85B' 'Bistrô XYZ'
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#C9A85B' 'Buffet XYZ' claro '#65002F'
#
# Sem "claro", o site continua escuro (fundo #040D10) e só o dourado #FFD28D
# vira a COR. Com "claro", tools/claro.js inverte o CSS para base branca:
# COR vira linha/filete/borda e COR_TITULO vira título e botão cheio.
#
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#FFD28D'          # dourado: título, borda, botão, linha — 105 usos no CSS

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"
MODO="${4:-}"
COR_TITULO="${5:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> <#COR> \"<Nome do Cliente>\" [claro <#COR_TITULO>]" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#C9A85B' (recebi '$COR')" >&2; exit 1
fi
if [ "$MODO" = "claro" ] && ! [[ "$COR_TITULO" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: modo claro pede a cor de título, tipo '#65002F' (recebi '$COR_TITULO')" >&2; exit 1
fi
if [ -n "$MODO" ] && [ "$MODO" != "claro" ]; then
  echo "erro: quarto argumento só pode ser 'claro' (recebi '$MODO')" >&2; exit 1
fi
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2; exit 1
fi

escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\&/g'; }

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

if [ "$MODO" = "claro" ]; then
  echo "→ invertendo o CSS para base clara (tools/claro.js)"
  node "$AQUI/tools/claro.js" "$DESTINO/assets/css/style.css" "$COR" "$COR_TITULO"
  # o mega menu do hambúrguer tem o fundo pintado por JS, não por CSS
  sed -i "s/background: \"#040D10\",/background: \"${COR_TITULO}\",/" "$DESTINO/assets/js/main.js"
fi

# o dourado também está em stroke/fill de SVG inline nas páginas (58x) e no
# sass/ de origem; rgba(255, 210, 141, x) é o mesmo dourado com transparência
echo "→ cor de marca: $COR_ORIGINAL → $COR"
r=$((16#${COR:1:2})); g=$((16#${COR:3:2})); b=$((16#${COR:5:2}))
grep -rIil "$COR_ORIGINAL" "$DESTINO" | while read -r f; do
  sed -i "s/${COR_ORIGINAL}/${COR}/gI; s/rgba(255, 210, 141,/rgba(${r}, ${g}, ${b},/g" "$f"
done

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

echo "→ letras do preloader"
# o preloader soletra o nome letra a letra; regenera o bloco entre os marcadores
# tira acento antes (Ô → O), senão a letra some
LETRAS="$( (printf '%s' "$NOME" | iconv -f UTF-8 -t ASCII//TRANSLIT 2>/dev/null || printf '%s' "$NOME") | tr '[:lower:]' '[:upper:]' | tr -cd 'A-Z0-9')"
BLOCO=""
while IFS= read -r -n1 l; do
  [ -z "$l" ] && continue
  BLOCO+="                    <span data-text-preloader=\"$l\" class=\"letters-loading\">$l</span>\n"
done < <(printf '%s' "$LETRAS")
for f in "$DESTINO"/*.html; do
  python - "$f" "$BLOCO" <<'PY'
import sys,re
f,bloco=sys.argv[1],sys.argv[2].replace('\n','\n')
s=open(f,encoding='utf-8').read()
s=re.sub(r'<!-- preloader-letras -->[\s\S]*?<!-- /preloader-letras -->','<!-- preloader-letras -->\n'+bloco+'                    <!-- /preloader-letras -->',s)
open(f,'w',encoding='utf-8').write(s)
PY
done

restam=$(grep -rIoi -e "$COR_ORIGINAL" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. FOTOS      o template NÃO TEM foto nenhuma: hero, pratos, galeria, chef
                e blog são PNG escuros com a dimensão escrita. É a primeira
                coisa a fazer — sem foto o site é uma grade de retângulos.
  2. LOGO       assets/img/logo.png (127x46) no header e assets/img/Elegencia.png
                no rodapé, em todas as páginas. O favicon é assets/img/favicon.svg.
  3. PÁGINA     três homes: index (slider de texto sobre foto), home2 (marquee +
                slider de cards), home3 (menu lateral fixo). Escolher uma, apagar
                as outras e limpar o dropdown "Home 1/2/3" do header.
  4. TEXTOS     conteúdo em inglês. Reescrever em pt-BR. O lang já é pt-BR.
  5. CONTATO    info@example.com (40x) e 1-800-915-6271 (56x) no rodapé e na
                página de contato; endereço de Montreal; mapa genérico.
  6. INVENÇÃO   cardápio com preço, reserva de mesa, chef, depoimento, blog e
                portfólio só existem preenchidos. Sem dado REAL do cliente,
                apagar a seção — não inventar.
  7. FORMULÁRIO reserva e contato não postam para lugar nenhum (sem action).
                Trocar por link de WhatsApp ou apagar.
  8. TITLE      [DESCRIÇÃO CURTA] continua como slot em cada <title>.
  9. FONTES     Baskervville + Prompt via Google Fonts, na 1ª linha do style.css.
                Trocar é uma linha — mas conferir line-height em título com acento.
FIM
[ "$MODO" = "claro" ] && cat <<FIM
 10. CLARO      o claro.js inverte por regra, não por olho. Rodar o preview e
                conferir hero (texto branco sobre foto precisa de overlay), header
                (deixa de ser transparente: o hero precisa de padding-top 150px),
                rodapé (fica na cor de seção; se a marca pedir, escurecer à mão),
                o mega menu do hambúrguer (fundo já trocado para COR_TITULO no
                main.js — logo e ícone precisam de versão clara) e qualquer bloco
                que continuou preto.
FIM
exit 0
