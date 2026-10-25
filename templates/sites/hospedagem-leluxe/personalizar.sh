#!/usr/bin/env bash
#
# Cria uma cópia do template Leluxe (hospedagem) já com a cor de marca e o nome
# do cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2E5E4E' 'Pousada Recanto Verde'
#
# Cor de marca do template: #ffd40d (amarelo). O resto do site é preto/branco/
# cinza — o amarelo é o único acento: botão "Reservar", sublinhado do menu,
# aba ativa do café, faixa atrás do preço, fundo do submenu, dia marcado no
# calendário, borda de campo em foco. Não tem CSS var: é hex cru.
#   #ffd40d — 20 usos em assets/css/style.css + 1 em zebra-datepicker.css
#             + 1 no favicon.svg (o favicon é reescrito com a inicial do cliente)
#   #fffad4 — 2 usos (fundo de <ins> e de .alert.notice): tom bem claro do
#             amarelo. O script deriva a partir da COR (88% branco).
#   #fcf08d — 1 uso (borda do .alert.notice): tom médio. Derivado (55% branco).
# Nenhuma ocorrência em rgb()/rgba(), SVG inline, PNG ou JS.
#
# O texto em cima do amarelo é PRETO. Se a COR do cliente for escura, preto em
# cima dela fica ilegível — o script mede a luminância e, se precisar, escreve
# em assets/css/style-custom.css as regras que viram esse texto branco.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#ffd40d'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#2E5E4E' 'Pousada Recanto Verde'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#2E5E4E' (recebi '$COR')" >&2
  exit 1
fi
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

PYTHON_BIN="python"
"$PYTHON_BIN" --version >/dev/null 2>&1 || PYTHON_BIN="python3"
export PYTHONIOENCODING=utf-8

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

"$PYTHON_BIN" - "$DESTINO" "$COR" "$NOME" "$COR_ORIGINAL" <<'PY'
import sys, os, re, glob, html

destino, cor, nome, cor_orig = sys.argv[1], sys.argv[2].lower(), sys.argv[3], sys.argv[4].lower()

def rgb(h):
    h = h.lstrip('#'); return tuple(int(h[i:i+2], 16) for i in (0, 2, 4))

def hexa(t):
    return '#%02x%02x%02x' % tuple(max(0, min(255, round(v))) for v in t)

def misturar_branco(h, p):
    r, g, b = rgb(h); return hexa((r + (255 - r) * p, g + (255 - g) * p, b + (255 - b) * p))

def luminancia(h):
    def canal(c):
        c = c / 255
        return c / 12.92 if c <= 0.03928 else ((c + 0.055) / 1.055) ** 2.4
    r, g, b = rgb(h); return 0.2126 * canal(r) + 0.7152 * canal(g) + 0.0722 * canal(b)

tinta_clara = misturar_branco(cor, 0.88)
tinta_media = misturar_branco(cor, 0.55)

# 1. cor nos CSS (todas as grafias: maiúscula/minúscula)
total = 0
for css in glob.glob(os.path.join(destino, 'assets', 'css', '*.css')):
    s = open(css, encoding='utf-8').read(); orig = s
    for velho, novo in ((cor_orig, cor), ('#fffad4', tinta_clara), ('#fcf08d', tinta_media)):
        n = len(re.findall(re.escape(velho), s, flags=re.I)); total += n
        s = re.sub(re.escape(velho), novo, s, flags=re.I)
    if s != orig:
        open(css, 'w', encoding='utf-8', newline='\n').write(s)
print(f"→ cor de marca: {cor_orig} → {cor}  (+ tons derivados #fffad4 → {tinta_clara}, #fcf08d → {tinta_media}) — {total} troca(s) no CSS")

# 2. contraste do texto em cima da cor
L = luminancia(cor)
if L < 0.4:
    regra = """
/* Gerado pelo personalizar.sh: a cor de marca é escura (luminância %.2f),
   então o texto que fica EM CIMA dela vira branco. */
.button-color,
button.button-color,
input[type="button"].button-color,
input[type="reset"].button-color,
input[type="submit"].button-color,
.tab-container .tabs a.tab-link-active,
.booking-form form .field .dropdown ul .selected a,
.Zebra_DatePicker .dp_body .dp_selected {
	color: #fff;
}

@media (max-width: 767px) {
	#identity .languages .current-menu-item a {
		color: #fff;
	}
}

@media (min-width: 1200px) {
	.nav-menu .menu-item-has-children li a {
		color: #fff;
	}
}

/* O sublinhado do menu e a faixa do preço são um "marca-texto" de 10px
   atrás da parte de baixo das letras: em cor escura vira um risco por cima
   do texto. Aqui ficam finos e descem para baixo da palavra. */
@media (min-width: 768px) {
	#identity .languages .current-menu-item a:after,
	#site-menu .nav-menu > ul > .current-menu-item > a:after,
	#site-menu .nav-menu > ul > .current-menu-parent > a:after {
		bottom: 0;
		height: 3px;
	}
}

.entry-accomodation .accomodation-price .price {
	background-position: 0 100%%;
	background-size: 100%% 4px;
}
""" % L
    with open(os.path.join(destino, 'assets', 'css', 'style-custom.css'), 'a', encoding='utf-8', newline='\n') as f:
        f.write(regra)
    print(f"→ cor escura (luminância {L:.2f}): texto sobre a cor virou branco (assets/css/style-custom.css)")
else:
    print(f"→ cor clara (luminância {L:.2f}): texto sobre a cor continua preto, nada a ajustar")

# 3. nome do cliente (HTML-escapado: "&" vira &amp;, aspas não quebram atributo)
nome_html = html.escape(nome, quote=True)
n_nome = 0
for f in glob.glob(os.path.join(destino, '*.html')):
    s = open(f, encoding='utf-8').read()
    n_nome += s.count('[NOME DO CLIENTE]')
    open(f, 'w', encoding='utf-8', newline='\n').write(s.replace('[NOME DO CLIENTE]', nome_html))
print(f"→ nome do cliente: {n_nome} ocorrência(s) de [NOME DO CLIENTE] trocadas")

# 4. favicon com a cor e a inicial
inicial = html.escape(next((c for c in nome if c.isalnum()), 'H').upper())
texto_fav = '#fff' if L < 0.4 else '#000'
open(os.path.join(destino, 'favicon.svg'), 'w', encoding='utf-8', newline='\n').write(
    f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64"><rect width="64" height="64" rx="12" fill="{cor}"/>'
    f'<text x="32" y="45" font-family="Georgia, serif" font-size="38" font-weight="700" text-anchor="middle" fill="{texto_fav}">{inicial}</text></svg>\n')
print(f"→ favicon.svg: inicial '{inicial}' sobre {cor}")
PY

restam=$(grep -rIoi -e "${COR_ORIGINAL}" -e '#fffad4' -e '#fcf08d' -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css --include=*.svg 2>/dev/null | wc -l || true)
pendentes=$(grep -rIoh -e '\[WHATSAPP\]' -e '\[TELEFONE\]' -e '\[EMAIL\]' -e '\[SITE\]' -e '\[ENDEREÇO\]' -e '\[INSTAGRAM\]' -e '\[FACEBOOK\]' -e '\[HISTÓRIA DA CASA[^]]*\]' -e '\[DESCRIÇÃO DO QUARTO[^]]*\]' -e '\[HORÁRIO DO CAFÉ\]' "$DESTINO" --include=*.html --include=*.js 2>/dev/null | sed 's/ —.*\]/…]/' | sort | uniq -c || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Placeholders que ainda estão no site (quantas vezes aparecem):
$pendentes

Falta fazer na mão — o script não tem como adivinhar:

  1. CONTATO        [WHATSAPP] (só dígitos, DDI+DDD: 5533999999999) aparece
                     em quase toda página E em assets/js/wa-forms.js — trocar
                     em todos os arquivos de uma vez (sed -i nos *.html e no
                     .js). [TELEFONE], [EMAIL], [SITE], [ENDEREÇO] (contato,
                     sobre, painel lateral), [INSTAGRAM]/[FACEBOOK] (só o @/
                     slug, vai depois de instagram.com/). Rede que o cliente
                     não tem: apagar o <li> do #social-profiles.
  2. MAPA           contact.html usa iframe de embed do Google Maps (sem API
                     key) com q=[ENDEREÇO] em 2 links — trocar pelo endereço
                     como aparece no Maps. Sem endereço confirmado, o mapa
                     mostra um lugar aleatório: nesse caso trocar o iframe
                     por uma foto.
  3. LOGO           o logo é TEXTO (o nome do cliente, fonte Eczar). O PNG
                     original tinha "LeLuxe" + 5 estrelas desenhados e foi
                     descartado. Com logo real: trocar em TODAS as páginas o
                     <a class="custom-logo-link text-logo"> por
                     <a href="index.html" class="custom-logo-link" rel="home"><img src="assets/img/logo.png" height="50" alt="..."></a>
                     (na index, que tem foto escura no 2º slide, dá para usar
                     2 imagens com class="custom-logo dark" e "custom-logo
                     light" — o CSS já alterna).
  4. FOTOS          TODAS as imagens de assets/img/ são placeholder cinza com
                     a legenda do que deve entrar ("FOTO PRINCIPAL — fachada",
                     "FOTO — item do café", tamanho em px). Trocar mantendo o
                     nome do arquivo. hero-2.jpg é de propósito ESCURO (o slide
                     tem class light-hero-colors: texto e logo brancos) — se a
                     foto real for clara, tirar essa classe do 2º slide.
  5. QUARTOS        accomodations.html traz 4 tipos de exemplo (Quarto
                     Standard, Suíte Casal, Suíte Família, Chalé) com
                     capacidade/itens chutados, e single-accomodation.html
                     detalha só a "Suíte Casal". Renomear para os quartos
                     REAIS, apagar os que não existem, e duplicar a página de
                     detalhe por quarto se valer a pena. Atualizar também o
                     <select name="room"> de booking.html e o submenu.
  6. PREÇO          nenhum preço inventado: todos os quartos mostram
                     "Consulte pelo WhatsApp". Com tabela real, o comentário no
                     topo de accomodations.html traz o markup com R\$.
  7. CAFÉ           dinning.html é o café da manhã: 4 abas com 12 itens de
                     EXEMPLO (pão de queijo, bolo, café coado...) marcados
                     "Incluso na diária" + [HORÁRIO DO CAFÉ]. Confirmar tudo
                     com o cliente. Se não serve café (chácara de aluguel),
                     apagar a página e o item "Café da manhã" do menu das 9
                     páginas, do 404 e do sobre.
  8. TEXTOS         about.html tem [HISTÓRIA DA CASA — ...] e
                     single-accomodation.html tem [DESCRIÇÃO DO QUARTO — ...]:
                     escrever com o tom do identidade.md. Frases de efeito do
                     topo ("Descanso de verdade, no ritmo do interior") são
                     genéricas — trocar por algo da casa.
  9. RESERVA        os 3 formulários (barra "Reservar" do rodapé, booking.html
                     e contato) NÃO mandam e-mail: abrem o WhatsApp com a
                     mensagem montada (assets/js/wa-forms.js). Nenhuma reserva
                     é confirmada pelo site — o texto já diz isso. Não prometer
                     "reserva online" na abordagem.
 10. QA VISUAL      abrir index/about/accomodations em ~390px e em 1440px.
                     Nome muito longo quebra o logo em 2-3 linhas (tem
                     max-width de 11em) — ok, mas conferir. Cor muito clara
                     (amarelo, bege) some como sublinhado do menu em cima de
                     foto clara.
FIM
exit 0
