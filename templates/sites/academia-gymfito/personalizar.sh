#!/usr/bin/env bash
#
# Cria uma cópia do template já com as cores de marca e o nome do cliente
# trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> <#COR> "<Nome do Cliente>" [<#COR-SECUNDARIA>]
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#FF6A00' 'XYZ Fit'
#
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

# O template tem TRÊS cores de marca. As duas primeiras é que aparecem:
#   #F67A45 — laranja: acento geral, CTA, títulos vazados, faixa    — 4.545 usos
#   #D5BDA2 — bege: 2ª camada dos hovers, células da grade, caixas  — 4.987 usos
#   #01010F — quase-preto do fundo (não trocado por padrão; ver README)
#
# O bege é MAIS usado que o laranja. Trocar só o laranja deixa metade do site
# com um bege de template que não tem nada a ver com a marca do cliente.
COR_PRIMARIA_ORIGINAL='#F67A45'
COR_SECUNDARIA_ORIGINAL='#D5BDA2'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"
COR2="${4:-#BFC0C2}"   # prata neutra: some sem brigar com a cor da marca

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> <#COR> \"<Nome do Cliente>\" [<#COR-SECUNDARIA>]" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#FF6A00' 'XYZ Fit'"          >&2
  exit 1
fi

for c in "$COR" "$COR2"; do
  if ! [[ "$c" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
    echo "erro: cor precisa ser hex de 6 dígitos, tipo '#FF6A00' (recebi '$c')" >&2
    exit 1
  fi
done

if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

# escapa / e & para o sed não engasgar com nome de cliente
escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

trocar() {
  local de="$1" para="$2" rotulo="$3"
  echo "→ $rotulo: $de → $para"
  # -I pula binário; aqui é tudo HTML, mas mantém o hábito seguro
  grep -rIl "$de" "$DESTINO" 2>/dev/null | while read -r f; do
    sed -i "s/${de}/${para}/gI" "$f"
  done
}

trocar "$COR_PRIMARIA_ORIGINAL"   "$COR"  "cor primária"
trocar "$COR_SECUNDARIA_ORIGINAL" "$COR2" "cor secundária"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl -e 'GYMFITO' -e '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/GYMFITO/${NOME_ESC}/g; s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIo -e "$COR_PRIMARIA_ORIGINAL" -e "$COR_SECUNDARIA_ORIGINAL" -e 'GYMFITO' "$DESTINO" 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências das cores/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. HOME       escolher entre index.html (fundo ESCURO) e index2.html (fundo
                CLARO) e apagar a outra. Atenção: as 14 páginas internas são
                todas escuras. Se ficar com a index2, elas não combinam.
  2. LOGO       o logo é REMOTO, no GitHub do autor do template:
                raw.githubusercontent.com/uiaextend/gymfito/main/home/logo.svg
                Aparece nas 16 páginas. Trocar por arquivo local do cliente.
  3. IMAGENS    97 imagens únicas (1.082 referências), TODAS remotas no mesmo
                repositório. Baixar as que ficarem ou trocar por foto do cliente.
                Enquanto forem remotas, o site depende de um repo de terceiro.
  4. TEXTOS     conteúdo em inglês. Reescrever em pt-BR. O lang já está pt-BR,
                então até traduzir o site declara um idioma que não é o do texto.
  5. CONTATO    example@email.com e (406) 555-0120 aparecem 17 vezes cada.
                O mapa do contact.html aponta para Nova York.
  6. INVENÇÃO   pricing, schedule, trainer, classes e blog só existem
                preenchidas. Sem preço, grade, nome de treinador e depoimento
                REAIS do cliente, apagar as páginas — não inventar.
  7. ACENTO     conferir line-height nos títulos: o padrão do template corta
                o til e a cedilha em português. Ver "Armadilhas" no README.
  8. TITLE      [DESCRIÇÃO CURTA] continua como slot em cada <title>.

FIM
