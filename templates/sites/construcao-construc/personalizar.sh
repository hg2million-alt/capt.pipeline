#!/usr/bin/env bash
#
# Cria uma cópia do template Construc já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Construtora XYZ'
#
# O template NÃO usa CSS custom property — a cor de marca é laranja chumbado
# em hex, com SETE grafias diferentes espalhadas por style.css (maiúsculas e
# minúsculas, e pequenas variações de tom que o autor do tema foi deixando
# ao longo das páginas): #FF5E14 (78x), #FF5E15 (53x), #FF5D13 (9x), #FF5F15
# (5x), #F16722 (4x, também usado em assets/js/particls.js — script não
# referenciado por nenhuma página do home1 que empacotamos, sobra inofensiva),
# #FF3C00 (4x) e #FF5E16 (1x). O script troca as sete, senão sobra laranja.
#
# O pacote comprado (ThemeForest) é uma bagunça de nomes: a pasta e o logo
# (imagem) dizem "Construc", mas as tags <title> da maioria das páginas dizem
# "indastre" ou até "indastre-Finance Consulting" (lixo de outro tema
# reaproveitado pelo autor) — ver "Falta fazer na mão" abaixo, o script NÃO
# mexe em "indastre" porque esse texto está entranhado em nomes de classe CSS
# reais (indastre_nav_manu, indastre-btn, indastre-service-single-item) e um
# find/replace ia quebrar layout.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

CORES_ORIGINAIS=(FF5E14 FF5E15 FF5D13 FF5F15 F16722 FF3C00 FF5E16)

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Construtora XYZ'" >&2
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

echo "→ cor de marca (laranja, 7 grafias hex): ${CORES_ORIGINAIS[*]} → $COR"
for hex in "${CORES_ORIGINAIS[@]}"; do
  grep -rIl "#${hex}" "$DESTINO" --include=*.css --include=*.js --include=*.html 2>/dev/null | while read -r f; do
    sed -i "s/#${hex}/${COR}/gI" "$f"
  done
done

echo "→ preenchendo e-mail placeholder"
grep -rIl '\[EMAIL\]' "$DESTINO" >/dev/null 2>&1 || true

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam_cor=0
for hex in "${CORES_ORIGINAIS[@]}"; do
  n=$(grep -rIoi "#${hex}" "$DESTINO" --include=*.html --include=*.css --include=*.js 2>/dev/null | wc -l || true)
  restam_cor=$((restam_cor + n))
done
restam_nome=$(grep -rIo '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor original ainda presentes: $restam_cor (esperado: 0)
Ocorrências de [NOME DO CLIENTE] ainda presentes: $restam_nome (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           assets/images/logo.png tem a palavra "Construc" desenhada
                     dentro do PNG (não é texto, o script não alcança) — usado
                     3x por página (header, header sticky, rodapé), mesma arte
                     nas três. Trocar pela logo real do cliente.
  2. TÍTULOS <title> a maioria das páginas tem <title> lixo, sobra de outro(s)
                     tema(s) do mesmo autor: "indastre Construction HTML5
                     Template", "indastre-Finance Consulting HTML5 Template"
                     (com erro de digitação "Consuting" em portfolio.html) —
                     só index.html tem título coerente ("Indastre - Industry
                     Factory and Construction..."). Reescrever à mão em cada
                     página; o script não mexe porque "indastre" também é
                     prefixo de classe CSS de verdade (indastre_nav_manu,
                     indastre-btn, indastre-service-single-item) — um
                     find/replace ia quebrar menu e botão.
  3. PACOTE ORIGINAL tinha 8 "homes" (variações de home page) dentro de
                     Construc-Buyerfile/construc/ — só empacotamos home1
                     (mais completo: 11 páginas). home3 nem é construção,
                     é "Consen - IT Startup" bundle errado do mesmo autor.
                     Se quiser outra variação de home, teria que migrar à mão.
  4. FOTOS           todo assets/images/**/*.jpg|png é placeholder cinza com
                     a dimensão escrita dentro (ex. "590x480") — sem foto real
                     de obra/equipe/fachada, o site fica com cara de maquete.
  5. TELEFONE        "+980 123 (4567) 890" no topo de cada página é número de
                     mentira — trocar por WhatsApp real ou marcar "a
                     confirmar".
  6. EQUIPE          team.html vem com nome, cargo e foto inventados — sem
                     gente real, apagar a seção ou trocar por cargo genérico.
  7. PREÇO           pricing.html tem planos com valor chutado — sem tabela
                     real do cliente, apagar ou marcar "a confirmar".
  8. PORTFÓLIO       portfolio.html e portfolio-details.html mostram "projeto"
                     com nome e categoria inventados — sem obra real do
                     cliente, ou apaga ou troca a legenda por algo genérico.
  9. BLOG            blog.html e blog-details.html vêm com posts de texto
                     genérico em inglês — geralmente não serve pra demo de
                     captação; considerar remover do menu.
 10. FORMULÁRIO      contact.html manda o form pra
                     action="https://formspree.io/f/myyleorq" — é a conta
                     Formspree do AUTOR do tema, não do cliente. Se publicar
                     assim, a mensagem de contato vai pra caixa de outra
                     pessoa. Trocar por um endpoint Formspree do cliente ou
                     pelo padrão wa.me antes de publicar.
 11. TEXTO           todo o corpo está em inglês, <html lang="en-US"> incluso
                     — trocar pra "pt-BR" e reescrever com o tom de voz do
                     identidade.md do cliente, não traduzir ao pé da letra.
 12. REDES SOCIAIS   conferir se os links do rodapé/topo apontam pra perfil
                     real do cliente antes de publicar.
FIM
exit 0
