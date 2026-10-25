#!/usr/bin/env bash
#
# Cria uma cópia do template Trimly já com cor, fonte e nome do cliente
# trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR_ACCENT' "<Nome do Cliente>" [escuro '#FUNDO1' '#FUNDO2']
#
# Exemplos:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#be8644' 'Barbearia XYZ'
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#35A7D8' 'A Firma' escuro '#102B3B' '#191C1B'
#
# Sem "escuro", o site continua na base clara de origem (fundo branco/creme)
# e só o dourado #be8644 (~24 usos, todo via CSS var) vira a COR — serve pra
# marca clara/moderna que não briga com o template original.
#
# Com "escuro", o :root inteiro é invertido: FUNDO1 vira o fundo principal
# (era branco), FUNDO2 vira o fundo alternado das seções (era creme), e o
# texto/ícone escuro do template vira off-white fixo — pronto pra marca tipo
# "barbearia clássica escura" (navy, preto, carvão).
#
# Em qualquer um dos dois modos, o script também:
#  - troca a fonte de título de Teko (condensada, sem serifa — o original do
#    Trimly) para Fraunces (serifada display). O Trimly nasce com tipografia de
#    título genérica; qualquer marca de barbearia "vintage/serifada" (a
#    maioria) vai precisar dessa troca, então não fica atrás de flag.
#  - troca os 8 fundos de seção/banner que só existiam como PNG/JPG de
#    placeholder com a dimensão escrita dentro (ex: "1920 × 702") por um
#    gradiente nas próprias --secondary--/--accent--color — nenhum deles é
#    foto de verdade em nenhum dos dois modos.
#  - esconde a silhueta+setas do hero (desenhadas pro Teko mais estreito;
#    com Fraunces colidem com o texto) e o watermark "TRIMLY STYLE" que vem
#    desenhado DENTRO do PNG assets/images/vector.png (não é texto, não pega
#    em find/replace de nome).
#  - dá crop circular no slot de foto do "A Firma Club" (era silhueta
#    transparente; se o cliente puser uma foto retangular real, ela cabe no
#    anel decorativo já existente em vez de ficar quadrada por cima).
#
# Com "escuro" especificamente, também:
#  - seta background-color no <body> — o original nunca tinha (fazia sentido
#    só com --secondary--color branco).
#  - troca a cor do texto do menu e das 3 barrinhas do hambúrguer mobile pra
#    --black--color em vez de --secondary--color. O original usa
#    --secondary--color pras duas coisas (fundo de seção clara E texto de
#    menu sempre branco sobre o hero) porque em modo claro as duas leituras
#    davam branco mesmo. Em escuro elas se separam — sem essa troca, o menu
#    fica com texto escuro sobre header escuro (achado só depois de publicar,
#    no olho, não em grep).
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"
MODO="${4:-}"
FUNDO1="${5:-}"
FUNDO2="${6:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR_ACCENT' \"<Nome do Cliente>\" [escuro '#FUNDO1' '#FUNDO2']" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#35A7D8' (recebi '$COR')" >&2; exit 1
fi
if [ "$MODO" = "escuro" ]; then
  if ! [[ "$FUNDO1" =~ ^#[0-9A-Fa-f]{6}$ ]] || ! [[ "$FUNDO2" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
    echo "erro: modo escuro pede FUNDO1 e FUNDO2 em hex, tipo '#102B3B' '#191C1B' (recebi '$FUNDO1' '$FUNDO2')" >&2; exit 1
  fi
elif [ -n "$MODO" ]; then
  echo "erro: quarto argumento só pode ser 'escuro' (recebi '$MODO')" >&2; exit 1
fi
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2; exit 1
fi

escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\&/g'; }

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

CSS="$DESTINO/assets/css/style.css"

echo "→ cor de destaque (--primary--color): #be8644 → $COR"
sed -i "s/--primary--color: #be8644;/--primary--color: ${COR};/" "$CSS"

if [ "$MODO" = "escuro" ]; then
  echo "→ invertendo para base escura: fundo $FUNDO1 / $FUNDO2"
  sed -i \
    -e "s/--secondary--color: #ffffff;/--secondary--color: ${FUNDO1};/" \
    -e "s/--accent--color: #f8f3ec;/--accent--color: ${FUNDO2};/" \
    -e "s/--black--color: #000000;/--black--color: #F5F5F1;/" \
    -e "s/--smoke--color: #2a2a2a;/--smoke--color: ${FUNDO2};/" \
    -e "s/--text--color: #6a6a6a;/--text--color: #B9B5AC;/" \
    -e "s/--text--color2: #6b6b6b;/--text--color2: #B9B5AC;/" \
    -e "s/--text--color3: #666666;/--text--color3: #B9B5AC;/" \
    -e "s/--border--color: #e6e6e6;/--border--color: rgba(245,245,241,.14);/" \
    -e "s/--light--grey--color: #cfcfcf;/--light--grey--color: rgba(245,245,241,.25);/" \
    -e "s/--light--grey--color2: #f5f5f5;/--light--grey--color2: ${FUNDO2};/" \
    "$CSS"
  # os 2 hex soltos do CSS (não passam por variável) seguem o mesmo destino do --black--color
  sed -i \
    -e "s/color: #fff;/color: #F5F5F1;/" \
    -e "s/color: #1f2328;/color: #F5F5F1;/" \
    "$CSS"
  # --secondary--color faz dupla função no original: fundo das seções claras E cor
  # do texto/ícone do MENU especificamente (sempre branco, pra contrastar com o
  # hero — que nasce foto ou gradiente escuro mesmo no template claro). Em modo
  # claro as duas leituras dão branco, então uma variável só bastava — em modo
  # escuro elas se separam: FUNDO1 vira o fundo, mas o menu PRECISA continuar
  # claro (fica sobre o hero, que segue escuro). Sem isso o texto do menu e as 3
  # barrinhas do hambúrguer mobile ficam invisíveis (cor escura sobre header
  # escuro) — só apareceu no olho do usuário depois de publicado, grep não pega
  # texto "presente só ilegível". Corrigido só nesses 2 pontos (não em todo uso de
  # --secondary--color como cor de texto no CSS — tem ~50, e alguns são texto
  # sobre botão na cor de destaque, onde a leitura clara/escura já está certa;
  # trocar todos sem checar caso a caso arrisca inverter contraste que já
  # funcionava certo pro lado errado).
  python - "$CSS" <<'PY'
import sys
f = sys.argv[1]
s = open(f, encoding="utf-8").read()
pairs = [
    (".header-con .navbar-light .navbar-nav .nav-link {\n    font-size: 16px;\n    color: var(--secondary--color);",
     ".header-con .navbar-light .navbar-nav .nav-link {\n    font-size: 16px;\n    color: var(--black--color);"),
    (".header-con .navbar-light .navbar-nav .nav-link.active {\n    color: var(--secondary--color);",
     ".header-con .navbar-light .navbar-nav .nav-link.active {\n    color: var(--black--color);"),
    # mesmo problema do menu, só que na seção "A Firma Club" (parágrafo + lista de
    # benefícios): também usa --secondary--color como "texto claro fixo" em vez de
    # --black--color, e a seção é escura nos dois modos (não seguia a inversão de
    # --secondary--color de qualquer forma) — achado no olho, não em grep.
    (".trimly-club-content-con p {\n    color: var(--secondary--color);",
     ".trimly-club-content-con p {\n    color: var(--black--color);"),
    (".trimly-club-content-con ul li {\n    color: var(--secondary--color);",
     ".trimly-club-content-con ul li {\n    color: var(--black--color);"),
]
for old, new in pairs:
    assert s.count(old) == 1, f"padrão não bateu como esperado ({s.count(old)}x): {old[:60]!r}"
    s = s.replace(old, new)
open(f, "w", encoding="utf-8").write(s)
PY
  sed -i "s/background: var(--accent--color);/background: var(--black--color);/" "$DESTINO/assets/css/responsive.css"
  # --smoke--color tem a MESMA dupla função de --secondary--color (fundo do rodapé
  # E cor de texto de metade dúzia de elementos — títulos grandes .text-size-80/40,
  # itens da lista de confiança do agendamento, link do WhatsApp, ícone do carrossel).
  # Original: #2a2a2a (cinza escuro, correto como texto sobre fundo branco). Depois
  # de virar FUNDO2 pro rodapé, esses ~7 usos como texto ficam com a MESMA cor do
  # fundo ao redor — só os de FUNDO (bg-smoke, seção "Book Appointment", nav do
  # carrossel) devem virar FUNDO2; os de TEXTO viram --black--color. Ao contrário
  # de --secondary--color (que tem uso legítimo escuro em botão claro), aqui os 7
  # usos como texto são todos o mesmo bug — troca em bloco, sem checar caso a caso.
  python - "$CSS" <<'PY'
import sys
f = sys.argv[1]
lines = open(f, encoding="utf-8").read().split("\n")
n = 0
for i, line in enumerate(lines):
    if line.strip() == "color: var(--smoke--color);":
        lines[i] = line.replace("color: var(--smoke--color);", "color: var(--black--color);")
        n += 1
assert n >= 6, f"esperava ~7 usos de --smoke--color como texto, achei {n} — conferir se o template mudou"
open(f, "w", encoding="utf-8").write("\n".join(lines))
PY
  # o <body> original nunca teve background-color (fazia sentido com --secondary--color
  # branco). Só COM --secondary--color escuro isso vira bug: qualquer seção sem cor de
  # fundo própria (equipe, depoimentos, teaser de contato — nenhuma delas seta
  # background-color) fica branca por baixo de texto que virou quase-branco. Sem essa
  # linha, a A Firma foi ao ar com 3 seções de texto ilegível (achado só no QA visual,
  # não em grep) — não pular esse passo achando que é redundante com --secondary--color.
  python - "$CSS" "$FUNDO1" <<'PY'
import sys
f, fundo1 = sys.argv[1], sys.argv[2]
s = open(f, encoding="utf-8").read()
old = 'body {\n    font-family: "Inter", sans-serif;\n}'
new = f'body {{\n    font-family: "Inter", sans-serif;\n    background-color: {fundo1};\n}}'
assert s.count(old) == 1, f"body rule not found as expected ({s.count(old)} matches)"
s = s.replace(old, new)
open(f, "w", encoding="utf-8").write(s)
PY
fi

echo "→ trocando os 8 fundos de banner/seção que só existiam como PNG/JPG de
   placeholder com a dimensão escrita dentro (ex: '1920 × 702') — nenhum deles
   é foto de verdade, em light ou escuro. Vira gradiente com as próprias
   variáveis de cor, então acompanha qualquer COR/FUNDO escolhido."
python - "$CSS" <<'PY'
import sys
f = sys.argv[1]
s = open(f, encoding="utf-8").read()
GRAD_MAIN = "background: linear-gradient(160deg, var(--secondary--color) 0%, var(--accent--color) 100%);"
GRAD_ALT = "background: linear-gradient(150deg, var(--accent--color) 0%, var(--secondary--color) 100%);"
pairs = [
    ("background-image: url(../images/banner-bg-img.png);\n    background-repeat: no-repeat;\n    background-size: cover;\n    height: 1087px;\n    background-position: bottom;\n    overflow: hidden;",
     f"{GRAD_MAIN}\n    height: 1087px;\n    overflow: hidden;"),
    ("background-image: url(../images/about-banner-bg-img.png);", GRAD_MAIN),
    ("background-image: url(../images/contact-banner-bg-img.png);", GRAD_MAIN),
    ("background-image: url(../images/gallery-banner-bg-img.png);", GRAD_MAIN),
    ("background-image: url(../images/services-banner-bg-img.png);", GRAD_MAIN),
    ("background-image: url(../images/men-services-bg-img.png);", GRAD_MAIN),
    ("background-image: url(../images/booking-banner-bg-img.png);", GRAD_MAIN),
    ("background-image: url(../images/trimly-club-bg-img.png);", GRAD_ALT),
    ("background-image: url(../images/book-appointment-bg-img.jpg);", GRAD_ALT),
]
for old, new in pairs:
    n = s.count(old)
    if n != 1:
        print(f"AVISO: '{old[:50]}...' apareceu {n}x (esperado 1)")
    s = s.replace(old, new)
open(f, "w", encoding="utf-8").write(s)
PY

echo "→ escondendo o silhueta/setas decorativas do hero (desenhadas pra um headline
   Teko mais estreito — com Fraunces largo, colidem com o texto) e o watermark
   'TRIMLY STYLE' que vem desenhado DENTRO do PNG assets/images/vector.png
   (não é texto, não pega em find/replace de nome)"
python - "$CSS" <<'PY'
import sys
f = sys.argv[1]
s = open(f, encoding="utf-8").read()
s = s.replace(
    ".half-elipse {\n    right: 0;\n    left: 0;\n    margin: 0 auto;\n    bottom: 0;\n}",
    ".half-elipse, .main-img1, .banner-left-arrow, .banner-right-arrow {\n    display: none;\n}\n\n.half-elipse {\n    right: 0;\n    left: 0;\n    margin: 0 auto;\n    bottom: 0;\n}"
)
s = s.replace(
    ".about-vector {\n    position: absolute;\n    right: 0;\n    bottom: 0;\n}",
    ".about-vector {\n    display: none;\n}"
)
# about-icon.png é um círculo cinza chapado sem ícone nenhum desenhado dentro —
# outro placeholder do pacote nunca finalizado. Fica flutuando por cima da foto
# real (about-img-con) se não esconder.
s = s.replace(
    ".about-icon {\n    top: 134px;\n    left: -75px;\n}",
    ".about-icon {\n    display: none;\n}"
)
# o slot circular do "A Firma Club" (trimly-club-img.png) era silhueta transparente
# — se o cliente colocar uma foto retangular real, recorta em círculo pra caber no
# anel decorativo já existente. max-width:100% + aspect-ratio (em vez de height fixo)
# porque o responsive.css original só encolhe a FIGURE em telas pequenas (300px),
# nunca a img — com height fixo em 480px ela vaza da moldura no mobile.
s = s.replace(
    ".trimly-club-img-con figure img {\n    position: relative;\n    z-index: 1;\n}",
    ".trimly-club-img-con figure img {\n    position: relative;\n    z-index: 1;\n    width: 480px;\n    max-width: 100%;\n    aspect-ratio: 1 / 1;\n    height: auto;\n    object-fit: cover;\n    border-radius: 50%;\n    display: block;\n    margin: 0 auto;\n}"
)
open(f, "w", encoding="utf-8").write(s)
PY

echo "→ trocando título de Teko (condensada) para Fraunces (serifada display)"
sed -i "s#@import url('https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900\&family=Teko:wght@300..700\&display=swap');#@import url('https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900\&family=Fraunces:ital,wght@0,600;0,900;1,600;1,900\&display=swap');#" "$CSS"
python - "$CSS" <<'PY'
import re, sys
f = sys.argv[1]
s = open(f, encoding="utf-8").read()
# .teko-font (números/badges: preço, contador, avaliação, telefone) vira Inter em
# vez de serifa primeiro — são dado/rótulo, não headline. Precisa rodar ANTES do
# replace geral de baixo, senão as duas regras (idênticas em texto) ficam iguais.
s = re.sub(r'\.teko-font \{\s*font-family: "Teko", sans-serif;\s*\}',
            '.teko-font {\n    font-family: "Inter", sans-serif;\n    font-weight: 700;\n}', s)
# resto das ocorrências de Teko (h1-h6 e afins) vira a serifada display
s = s.replace('font-family: "Teko", sans-serif;', 'font-family: "Fraunces", serif;\n    font-weight: 700;')
# o headline gigante (.text-size-190 e afins) ganha o peso/itálico mais expressivo
s = s.replace(
    ".text-size-190 {\n    font-size: 190px;",
    ".text-size-190 {\n    font-style: italic;\n    font-weight: 900;\n    font-size: 190px;",
)
open(f, "w", encoding="utf-8").write(s)
PY

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

  1. LOGO         assets/images/logo.png e logo2x.png (header), footer-logo.png
                  (rodapé), favicon/ inteiro. O Trimly não tem selo de marca
                  d'água pronto — se o cliente só mandou um monograma, ele vai
                  se repetir em todos os três lugares. Se o monograma tiver
                  fundo sólido próprio, ele pode "brigar" com o fundo do
                  header (que é transparente sobre a seção de banner) — testar
                  visualmente, às vezes precisa de padding/raio na moldura.
  2. FOTOS        about-img1/2, gallery-image1..N, service-img*, team-img*,
                  testimonial client-img*, e a foto circular do "A Firma Club"
                  (trimly-club-img.png, já com crop circular pronto na seção,
                  só falta a foto em si) — tudo placeholder cinza com a
                  dimensão escrita dentro. Sem foto real do cliente, o site
                  fica com cara de maquete. O silhueta do hero (banner-img1) e
                  as setas decorativas já saem escondidas por padrão (ver
                  cabeçalho) — não precisa mexer nelas.
     HERO         .home-outer-wrapper (a seção inteira do topo da home) só tem
                  o gradiente escuro por padrão. Se o cliente mandar foto real
                  da fachada/salão em formato paisagem, dar background-image
                  no ::before (não no elemento em si — mantém o texto/nav por
                  cima em z-index própria e permite animar zoom sem mexer no
                  layout): gradiente escuro semi-transparente empilhado sobre
                  a url() da foto, background-size cover, e uma @keyframes de
                  scale(1) a scale(1.1) tipo 20-25s ease-in-out infinite
                  alternate no ::before pra dar um Ken Burns sutil. Testado na
                  A Firma (fachada com letreiro neon e vidro) — texto branco
                  ficou legível com o gradiente em ~70-90% de opacidade nas
                  pontas. Comprimir a foto antes (ex.: ffmpeg -i entrada.jpg
                  -vf scale=1920:-1 -q:v 4 saida.jpg) — foto de celular vem na
                  casa de 3-8 MB. A altura do hero no mobile (assets/css/
                  responsive.css, @media max-width:575px, .home-outer-wrapper)
                  já vem recalibrada pra 500px pra caber o título em Fraunces
                  sem sobrar faixa vazia — se o texto do cliente for bem mais
                  longo ou curto que "Seu estilo fala antes de você.", medir
                  de novo (ver nota no própio CSS) e ajustar.
  3. EQUIPE       team.html tem nome, cargo e Instagram inventados por barbeiro
                  (John, David, Alex...). Sem nome real, ou apaga a pessoa ou
                  troca por cargo genérico ("Barbeiro") sem nome — nunca inventa
                  nome de funcionário.
  4. PREÇO        a seção "Transparent Pricing" (index.html) e a página
                  pricing.html original (já removida da cópia) têm preço
                  chutado por serviço. Sem tabela real do cliente, apaga a
                  seção — não estima "valor de mercado".
  5. DEPOIMENTO   testimonials.html e o carrossel de depoimentos na home são
                  texto e nota inventados. Só usar com o aviso "ilustrativo"
                  visível, nunca como depoimento real.
  6. CONTATO      rodapé e contact.html ficam com [WHATSAPP], [EMAIL],
                  [ENDERECO], [LINK_MAPA], [HORARIO] e [INSTAGRAM] como
                  placeholder — inclusive dentro do botão "Falar no WhatsApp"
                  e do formulário de agendamento. Enquanto o WhatsApp real não
                  chega, trocar esses links por algo que não quebre (ex: âncora
                  pra seção de contato com um selo "a confirmar" visível) em
                  vez de deixar um wa.me/ sem número ou o colchete cru
                  aparecendo na tela.
  7. TEXTO        corpo em inglês (menos nav/rodapé/formulário, já em pt-BR).
                  Reescrever com o tom de voz do identidade.md do cliente —
                  não é tradução literal.
  8. TITLE        cada <title> ainda tem "[DESCRIÇÃO CURTA] | ${NOME}" — a
                  parte antes da barra veio do Trimly original, conferir se
                  ainda faz sentido por página.
  9. 404           404.html ficou fora da limpeza de nav/rodapé/fundo (é
                  página de erro, sem chrome de site) — não precisa mexer.
 10. QA VISUAL    abrir o site num navegador de verdade antes de publicar —
                  grep não pega watermark desenhado dentro de PNG, texto claro
                  sobre seção sem fundo próprio, nem headline mais largo
                  colidindo com elemento decorativo. Cada um desses já
                  aconteceu nesta biblioteca antes da correção acima.
FIM
exit 0
