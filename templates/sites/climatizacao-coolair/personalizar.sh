#!/usr/bin/env bash
#
# Cria uma cópia do template CoolAir já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Climatização XYZ'
#
# O template vem com um TROCADOR DE ESQUEMA DE COR de fábrica: 3 arquivos
# prontos em css/colors/scheme-0{1,2,3}.css, cada um com o mesmo par de
# variáveis em tons diferentes de azul/teal. Toda página carrega
# SEMPRE css/colors/scheme-01.css (confirmado nas 31 páginas) — é esse
# arquivo, e só ele, que o script edita.
#
#   --primary-color:   #234982 (azul escuro) — cor DOMINANTE: topbar, logo,
#     texto de menu, títulos, maioria dos botões e ícones (98 usos em
#     css/coloring.css). É a cor de marca de verdade.
#   --secondary-color: #678fd5 (azul claro) — NÃO é uma cor de contraste tipo
#     "botão amarelo sobre fundo azul" (caso do Qlinest). É o MESMO azul,
#     só mais claro — usado nos círculos de ícone, no botão "Schedule Now" e
#     no hover. Testado visualmente (screenshot antes de mexer): os dois
#     tons aparecem juntos na mesma tela o tempo todo. Por isso o script
#     NÃO fixa a secundária — ele deriva um tom mais claro da MESMA cor que
#     o cliente passar (mistura 40% em direção ao branco, mesma lógica dos
#     3 esquemas de fábrica), pra manter os dois tons sempre combinando,
#     seja qual for a cor do cliente.
#   --tertiary-color: #F4F7FB — quase-branco usado só como fundo de seção
#     neutra (bg-color-3) e cor do ícone da topbar. Fica FIXO: é um tom de
#     fundo, não de marca, e qualquer cor de cliente combina com um
#     quase-branco.
#   --quaternary-color não é usada em nenhum HTML (dead code) — ignorado.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_PRIMARIA_ORIGINAL='#234982'
COR_SECUNDARIA_ORIGINAL='#678fd5'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Climatização XYZ'" >&2
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

# deriva um tom mais claro (mistura 'ratio' em direção ao branco) da cor
# passada, pra virar a --secondary-color combinando com a primária escolhida
clarear() {
  local hex="${1#\#}"
  local ratio="$2"
  local r=$((16#${hex:0:2}))
  local g=$((16#${hex:2:2}))
  local b=$((16#${hex:4:2}))
  local nr ng nb
  nr=$(awk -v r="$r" -v ratio="$ratio" 'BEGIN{printf "%d", r+(255-r)*ratio}')
  ng=$(awk -v g="$g" -v ratio="$ratio" 'BEGIN{printf "%d", g+(255-g)*ratio}')
  nb=$(awk -v b="$b" -v ratio="$ratio" 'BEGIN{printf "%d", b+(255-b)*ratio}')
  printf "#%02X%02X%02X" "$nr" "$ng" "$nb"
}

hex_para_rgb() {
  local hex="${1#\#}"
  printf "%d, %d, %d" "$((16#${hex:0:2}))" "$((16#${hex:2:2}))" "$((16#${hex:4:2}))"
}

COR_SECUNDARIA="$(clarear "$COR" 0.40)"
COR_RGB="$(hex_para_rgb "$COR")"
COR_SECUNDARIA_RGB="$(hex_para_rgb "$COR_SECUNDARIA")"

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

CSS="$DESTINO/css/colors/scheme-01.css"
echo "→ cor de marca (--primary-color): $COR_PRIMARIA_ORIGINAL → $COR"
sed -i "s/--primary-color: ${COR_PRIMARIA_ORIGINAL};/--primary-color: ${COR};/" "$CSS"
echo "→ cor de marca clara (--secondary-color): $COR_SECUNDARIA_ORIGINAL → $COR_SECUNDARIA (derivada, 40% mais clara que $COR)"
sed -i "s/--secondary-color: ${COR_SECUNDARIA_ORIGINAL};/--secondary-color: ${COR_SECUNDARIA};/" "$CSS"
# as variantes -rgb (usadas em rgba() pra gradiente/overlay/sombra em
# coloring.css) precisam acompanhar, senão o overlay fica na cor antiga
sed -i "s/--primary-color-rgb: 35, 73, 130;/--primary-color-rgb: ${COR_RGB};/" "$CSS"
sed -i "s/--secondary-color-rgb: 103, 143, 213;/--secondary-color-rgb: ${COR_SECUNDARIA_RGB};/" "$CSS"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "${COR_PRIMARIA_ORIGINAL}" -e "${COR_SECUNDARIA_ORIGINAL}" -e "35, 73, 130" -e "103, 143, 213" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome/e-mail originais ainda presentes: $restam (esperado: 0,
mas [EMAIL] fica de propósito até alguém preencher o contato real — ver item 5)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           images/logo.webp (topo, versão branca) e
                     images/logo-black.webp (versão escura, aparece ao rolar
                     a página) têm o ícone de onda + a palavra "CoolAir"
                     desenhados dentro do arquivo (raster pequeno, ~150x30px)
                     — não é texto HTML, o script não alcança. Trocar os 2
                     arquivos pela logo real do cliente (2 versões: clara e
                     escura, mesmo formato).
  2. FOTOS          as ~180 imagens em images/ (condensadoras de telhado,
                     técnico, controle remoto, prédio comercial) são fotos de
                     banco de imagens genéricas, sem qualquer ligação com o
                     cliente — servem como fundo de seção, mas não são o
                     trabalho/local real dele. Trocar pelas fotos do cliente
                     onde existirem; onde não existir, deixar claro que é
                     ilustrativo.
  3. TELEFONE       "+929 333 9296" aparece fixo em várias páginas (topbar,
                     contato, seção de preço) — trocar por WhatsApp real ou
                     marcar "a confirmar".
  4. EQUIPE         about.html tem 4 cards de equipe, todos com o MESMO nome
                     inventado repetido ("Jeffery Mussman", cargo "Founder &
                     CEO") — sem gente real, apagar a seção ou trocar por
                     cargo genérico sem nome.
  5. DEPOIMENTO     os depoimentos da home (Michael S., Robert L., Jake M.)
                     têm texto e nota inventados — só usar com selo
                     "ilustrativo" visível.
  6. PREÇO          price-list.html tem uma tabela real de preços por tipo de
                     ar-condicionado (ex. "Window Type" \$30, "Window Type
                     Inverter" \$40) em dólar e chutados — sem tabela real do
                     cliente, traduzir a moeda/apagar ou marcar "a confirmar".
  7. E-MAIL         contact@coolair.com virou "[EMAIL]" (32 ocorrências, en-
                     tre href mailto e texto visível) porque um find/replace
                     direto pelo nome do cliente quebraria o domínio.
                     Preencher com o e-mail real ou apagar se só usa WhatsApp.
  8. FORM           contact.php e booking.php processam os formulários de
                     contato e agendamento — só funcionam com hospedagem PHP
                     (a Vercel não roda PHP). Sem backend, nada é enviado;
                     trocar a ação do <form> por um link wa.me ou serviço de
                     formulário estático antes de publicar.
  9. TEXTO          todo o corpo está em inglês, <html lang="en"> incluso —
                     trocar pra pt-BR e reescrever com o tom de voz do
                     identidade.md, não traduzir ao pé da letra.
 10. PÁGINAS DEMO   o template vem com 14 variações de home (homepage-2.html
                     a homepage-14.html) + onepage-1.html, todas concorrendo
                     como "a" home — escolher UMA (index.html é a mais
                     completa) e remover as outras do menu antes de publicar,
                     senão o site fica com navegação confusa.
 11. REDES SOCIAIS  os ícones do topo (Facebook/X/Youtube/Pinterest/Insta)
                     apontam pra href="#" vazio — preencher ou remover os
                     que o cliente não tem.
 12. PESO           56 MB em html/, quase tudo em images/ — considerar
                     comprimir ou remover as fotos das páginas/variantes que
                     não forem usadas antes do deploy.
FIM
exit 0
