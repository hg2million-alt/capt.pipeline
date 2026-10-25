#!/usr/bin/env bash
#
# Cria uma cópia do template Barberon já com a cor de marca do cliente e o
# nome preenchido. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR_PRIMARIA' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#8A5A2B' 'Barbearia XYZ'
#
# O Barberon nasce só em base ESCURA (não tem variante clara, ao contrário do
# barbearia-trimly) — não existe flag "escuro"/"claro" aqui, é sempre a
# mesma base: fundo quase preto tingido pelo tom da cor escolhida.
#
# A cor de marca vive inteira em UM arquivo pequeno: css/colors/gold.css (a
# paleta "gold" era a que vinha ligada por padrão nas 7 páginas). O script:
#  - gera css/colors/custom.css a partir da COR informada: --primary-color é
#    a cor em si; --secondary-color é uma variante ~35% mais clara (mistura
#    com branco) usada em gradientes e hovers; --bg-dark-1/2/3 são 3 tons de
#    fundo quase-preto tingidos pelo MESMO matiz da cor escolhida (não um
#    cinza neutro) — é esse tingimento sutil que faz o site inteiro parecer
#    "da cor do cliente" mesmo sendo, na prática, 90% preto. Todos calculados
#    em HSL a partir da cor informada (mesma ideia do
#    climatizacao-coolair/personalizar.sh, que deriva a secundária sozinho).
#  - troca as 7 tags <link id="colors" href="css/colors/gold.css"> para
#    apontar pro custom.css novo. Os 10 presets originais (amber, burgundy,
#    copper, emerald, gold, purple, rosegold, sapphire, silver, teal) ficam
#    intactos em css/colors/ — se a cor gerada não ficar boa, dá pra testar
#    um preset próximo à mão antes de mexer no custom.css.
#
# Título (h1-h6) já nasce em Playfair Display (serifada) e corpo em DM Sans —
# ao contrário do Trimly, aqui NÃO existe troca de fonte: o template já vem
# "vintage" o suficiente pra maioria das barbearias sem precisar de script.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR_PRIMARIA' \"<Nome do Cliente>\"" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#8A5A2B' (recebi '$COR')" >&2; exit 1
fi
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2; exit 1
fi

escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\&/g'; }

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

echo "→ gerando css/colors/custom.css a partir de $COR (primária + secundária
   derivada + 3 fundos quase-pretos tingidos no mesmo matiz)"
python - "$DESTINO/css/colors/custom.css" "$COR" <<'PY'
import sys, colorsys

path, hexcolor = sys.argv[1], sys.argv[2]
hexcolor = hexcolor.lstrip('#')
r, g, b = (int(hexcolor[i:i+2], 16) for i in (0, 2, 4))
h, l, s = colorsys.rgb_to_hls(r / 255, g / 255, b / 255)

def to_hex_rgb(h, l, s):
    r, g, b = colorsys.hls_to_rgb(h, l, s)
    r, g, b = round(r * 255), round(g * 255), round(b * 255)
    return f"#{r:02X}{g:02X}{b:02X}", f"{r}, {g}, {b}"

# secundária: mesma cor, bem mais clara (mistura ~35% com branco) — é o que
# os 10 presets originais fazem (ex: gold #C8A46A -> #E2C58F)
sec_l = min(l + (1 - l) * 0.42, 0.92)
secondary_hex, secondary_rgb = to_hex_rgb(h, sec_l, max(s, 0.35))

# 3 fundos quase-pretos, tingidos pelo mesmo matiz em saturação baixa —
# padrão observado nos 10 presets (ex: gold -> #171311/#221D1A/#302926)
bg1_hex, bg1_rgb = to_hex_rgb(h, 0.075, 0.14)
bg2_hex, _ = to_hex_rgb(h, 0.115, 0.14)
bg3_hex, _ = to_hex_rgb(h, 0.165, 0.13)

primary_hex = f"#{r:02X}{g:02X}{b:02X}"
primary_rgb = f"{r}, {g}, {b}"

css = f"""* {{
  --primary-color: {primary_hex};
  --primary-color-rgb: {primary_rgb};

  --secondary-color: {secondary_hex};
  --secondary-color-rgb: {secondary_rgb};

  --bg-dark-1: {bg1_hex};
  --bg-dark-1-rgb: {bg1_rgb};

  --bg-dark-2: {bg2_hex};
  --bg-dark-3: {bg3_hex};
}}"""
open(path, "w", encoding="utf-8").write(css)
print(f"   primária {primary_hex} · secundária {secondary_hex} · fundos {bg1_hex} / {bg2_hex} / {bg3_hex}")
PY

echo "→ apontando as 7 páginas para css/colors/custom.css"
grep -rl 'href="css/colors/gold.css"' "$DESTINO"/*.html | while read -r f; do
  sed -i 's#href="css/colors/gold\.css"#href="css/colors/custom.css"#' "$f"
done

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIli '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/gI" "$f"
done

restam=$(grep -rIoi -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências de [NOME DO CLIENTE] ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO         images/logo-white.webp (header + rodapé) e images/icon.webp
                  (favicon) são placeholder genérico "B" — trocar pelo logo
                  real do cliente. images/logo-icon.webp é um brasão/crest
                  decorativo (usado como selo pequeno no "About" E como
                  marca-d'água bem apagada — op-1 = 10% de opacidade — atrás
                  de 3 seções): o pacote original tinha essa marca-d'água
                  QUEBRADA (referenciava um arquivo images/misc/logo-wm-1.webp
                  que não existe no zip comprado — bug de origem, corrigido
                  aqui redirecionando pro logo-icon.webp existente). Se o
                  cliente não tiver um monograma próprio pra essa marca-d'água,
                  ela pode ficar assim (é só decoração, quase invisível) ou
                  ser escondida (display:none nas classes .abs.w-30.end-0.
                  bottom-0.op-1) — nunca deixar o crest genérico passar por
                  "o logo do cliente" na peça principal.
  2. FOTOS        ⚠️ AO CONTRÁRIO da maioria dos templates da biblioteca, TODAS
                  as fotos aqui são fotos de banco REAIS (preto e branco, alta
                  qualidade) — não são placeholder cinza com dimensão escrita
                  dentro. Isso significa que elas PARECEM prontas pra publicar,
                  mas são modelos de banco de imagem, não o barbeiro nem o
                  salão do cliente de verdade. Nunca publicar como se fosse a
                  equipe/loja real sem deixar claro que é ilustrativo, e
                  trocar por fotos reais sempre que o cliente mandar (regra do
                  AGENTS.md vale igual pra foto que "parece" real).
                  Ficam em: images/slider/ (hero, 4 fotos), images/services/
                  (6), images/team/ (3, com hover), images/gallery/ (5),
                  images/testimonial/ (8, rosto pequeno), images/background/
                  (10, banner das páginas internas), images/misc/ (about).
  3. EQUIPE       team.html tem 3 barbeiros com só o PRIMEIRO nome inventado
                  (Sam, Leo, Max) + cargo (Master Barber, Fade Specialist,
                  Beard Grooming Expert) + ícones de Facebook/X/Instagram que
                  apontam pra "#". Sem nome real, trocar por cargo genérico
                  sem nome — nunca inventar outro nome. Os ícones sociais "#"
                  precisam virar o Instagram real do cliente ou sumir.
  4. FUNDADOR     A home (index.html) tem uma citação de abertura assinada
                  "[NOME DO FUNDADOR]" + "Founder & Master Barber" (era
                  "Samuel Barberon" no original — um nome de pessoa, não o
                  nome da barbearia, por isso o script não preenche
                  automaticamente com o nome do cliente). Preencher com o
                  nome do dono/barbeiro principal se o cliente quiser esse
                  bloco, ou apagar a seção inteira (#section-intro em
                  index.html) se não houver essa figura.
  5. DEPOIMENTO   reviews.html e o carrossel de 4 depoimentos na home são
                  texto, nota (5.0 fixo) e foto de cliente FICTÍCIOS — as
                  frases já citam "[NOME DO CLIENTE]" (o script troca o nome
                  do template pelo nome do cliente dentro da própria citação,
                  o que funciona bem porque a frase original citava
                  "Barberon" pelo nome) — mas o conteúdo em si é inventado.
                  Marcar como ilustrativo, nunca como depoimento real.
  6. PREÇO        services.html tem preço chutado nas 6 categorias (\$30, \$20,
                  \$35, \$25, \$45, \$25) — achado só na captura de tela, não
                  aparece em grep de "price"/"\$" (o valor vem sozinho num
                  <p> sem a palavra "price" por perto). Sem tabela real do
                  cliente, apagar os preços — não estimar "valor de mercado".
                  about.html também tem "Since 1998" fixo no topo da página —
                  ano de fundação inventado, mesma lógica: apagar ou trocar
                  pelo ano real, nunca deixar o do template.
  7. CONTATO      [WHATSAPP] e [ENDERECO] ficam como placeholder no rodapé de
                  toda página e na seção de contato de about.html/booking.html
                  /gallery.html/index.html/reviews.html/services.html/
                  team.html — inclusive dentro do link "tel:". Preencher os
                  dois antes de publicar. O HORÁRIO de funcionamento
                  (booking.html, index.html — Segunda a Domingo com horas
                  fixas) também é ilustrativo, sem token — conferir ou marcar
                  "a confirmar".
  8. AGENDAMENTO  O formulário de agendamento (index.html e booking.html)
                  tentava, no pacote original, enviar por POST pra
                  "booking-barber.php" — um arquivo que NUNCA existiu no zip
                  comprado (referência morta desde a origem, não é coisa que
                  o processo de limpeza quebrou). Reescrito em
                  js/validation-barber.js pra montar a mensagem e abrir o
                  WhatsApp direto (wa.me), mesmo padrão do barbearia-trimly.
                  Só falta preencher WHATSAPP_NUMERO no topo desse arquivo
                  (sem formatação, ex: 5533999999999) — é o mesmo número do
                  item 7, mas em outro arquivo, os dois precisam bater.
  9. TEXTO        Corpo em inglês (nav/rodapé/formulário já não têm mais nada
                  do autor original, mas frases de serviço/sobre/depoimento
                  seguem em inglês). Reescrever com o tom de voz do
                  identidade.md do cliente — não é tradução literal.
 10. TITLE        Cada <title> segue o padrão "Página | [Nome preenchido]" —
                  conferir se o texto antes da barra ainda faz sentido.
 11. QA VISUAL    Abrir num navegador de verdade antes de publicar. O bug da
                  marca-d'água quebrada (item 1) só apareceu rodando
                  \`python\` num grep de todos os src= contra o disco — não
                  aparece navegando às pressas, porque em 10% de opacidade
                  uma imagem quebrada e uma imagem ausente ficam parecidas.
                  Cada página tem GSAP (ScrollTrigger/SplitText) + Swiper —
                  testar o scroll e o carrossel de depoimentos em ~390px.
FIM
exit 0
