#!/usr/bin/env bash
#
# Copia UM dos 5 demos do pack Hotel Master (escolha obrigatória) já com a cor
# de marca e o nome do cliente trocados. Os originais em html/<demo>/ nunca são
# alterados — cada cliente sai de uma cópia.
#
#   ./personalizar.sh <demo> <pasta-destino> <#COR> "<Nome do Cliente>" [#COR2]
#
# <demo> é um de: masterhotel masterhotel-dark hostel modern apartment
# [#COR2] só vale pro demo apartment (o azul-marinho secundário). Sem ela, o
# marinho fica como está — ele funciona como neutro escuro.
#
# Exemplo:
#   ./personalizar.sh apartment /c/Dev/Captacao-CC/clientes/xyz/site '#2E7D32' 'Chácara Recanto Verde'
#
# Por que não é um sed de uma cor só: o tema (WordPress exportado pra HTML)
# gerou a paleta com 6 a 25 TONS da cor de marca espalhados no
# css/style-custom.css (hover, borda, tint claro, sombra escura do botão, barra
# de reserva, calendário...). O script tem, por demo, a lista exata desses tons
# (levantada contando os hex do CSS e conferindo no screenshot) e recalcula
# cada um em HSL a partir da cor nova: mesma relação de claro/escuro e de
# saturação que o tom tinha com a cor original. Precisa de node (já é
# requisito do Vercel CLI).
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DEMO="${1:-}"
DESTINO="${2:-}"
COR="${3:-}"
NOME="${4:-}"
COR2="${5:-}"

DEMOS_VALIDOS="masterhotel masterhotel-dark hostel modern apartment"

if [ -z "$DEMO" ] || [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <demo> <pasta-destino> <#COR> \"<Nome do Cliente>\" [#COR2 — só apartment]" >&2
  echo "demo: $DEMOS_VALIDOS" >&2
  exit 1
fi
if ! [[ " $DEMOS_VALIDOS " == *" $DEMO "* ]]; then
  echo "erro: demo '$DEMO' inválido. Use um de: $DEMOS_VALIDOS" >&2
  exit 1
fi
for c in "$COR" ${COR2:+"$COR2"}; do
  if ! [[ "$c" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
    echo "erro: cor precisa ser hex de 6 dígitos, tipo '#2E7D32' (recebi '$c')" >&2
    exit 1
  fi
done
if [ -n "$COR2" ] && [ "$DEMO" != "apartment" ]; then
  echo "aviso: #COR2 só é usada no demo apartment — ignorando." >&2
  COR2=""
fi
command -v node >/dev/null || { echo "erro: precisa de node no PATH" >&2; exit 1; }

ORIGEM="$AQUI/html/$DEMO"
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

# ------------------------------------------------------------ tons por demo
# BASE = cor de marca original (a que aparece no screenshot)
# TONS = todos os tons derivados dela que o tema espalhou no CSS/HTML.
# Ficam DE FORA de propósito (são padrão do tema, iguais nos 5 demos, não marca):
#   #51392B (fundo do resumo por unidade), #E36D39 (link de "skin escura"),
#   #F5BE3B (selo de nota de post), #1F242C (overlay escuro do apartment),
#   #D65938 #963A20 #D57F5C #B28855 #C23030 e os azuis #72AFD5 #81BAD3...
case "$DEMO" in
  masterhotel)
    BASE='#b89f80'
    TONS='#7b6549 #7d6444 #7e6648 #826e54 #8b6b43 #967f63 #977b58 #a38363 #aa8667 #ad9479 #af9167 #b49a7b #b4a38f #b89f80 #bea78b #cab193 #cbb9a3 #cbbca9 #d0c1af #eae0d4'
    ;;
  masterhotel-dark)
    BASE='#b89f80'
    TONS='#322b23 #5f5243 #725229 #726145 #7b6549 #7c6a53 #7e6648 #826e54 #937e63 #967c61 #967f63 #99826b #a38363 #aa8667 #ad9479 #ad977b #af9167 #b4a38f #b89f80 #bea78b #c6b29a #cab193 #cbb9a3 #eae0d4'
    ;;
  hostel)
    BASE='#1abc9c'
    TONS='#006847 #007a66 #097c62 #0e8e75 #0e9e72 #149174 #15a881 #16af9b #1abc9c #1c8e77 #53bca7 #64c1ac #91f2cb #baefe2'
    ;;
  modern)
    BASE='#ff8432'
    TONS='#7a2413 #9b3306 #d3410c #e2671f #ea732e #ed6d17 #f27f3c #f4a77a #f4c9a8 #f77e42 #f7dab9 #ff812d #ff8432 #ff8f44 #ff9854 #ffa366 #ffaa72 #ffad77 #ffaf7a #ffcaa6 #ffd5bc #ffdac6 #ffe2cf'
    ;;
  apartment)
    BASE='#fbad24'
    TONS='#d6921d #eda221 #f1ab42 #faac24 #fbad24'
    BASE2='#32435b'
    TONS2='#32435b #47628e #47658e #ced5e0'
    ;;
esac

echo "→ copiando demo '$DEMO' para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

echo "→ recalculando os tons da marca e preenchendo o nome"
HM_DESTINO="$DESTINO" HM_BASE="$BASE" HM_TONS="$TONS" HM_COR="$COR" \
HM_BASE2="${BASE2:-}" HM_TONS2="${TONS2:-}" HM_COR2="$COR2" HM_NOME="$NOME" \
node - <<'NODE'
const fs = require('fs'), path = require('path');
const E = process.env;

function hsl(hex) {
  const r = parseInt(hex.slice(1, 3), 16) / 255, g = parseInt(hex.slice(3, 5), 16) / 255, b = parseInt(hex.slice(5, 7), 16) / 255;
  const mx = Math.max(r, g, b), mn = Math.min(r, g, b); let h = 0, s = 0; const l = (mx + mn) / 2;
  if (mx !== mn) { const d = mx - mn; s = l > .5 ? d / (2 - mx - mn) : d / (mx + mn);
    h = mx === r ? (g - b) / d + (g < b ? 6 : 0) : mx === g ? (b - r) / d + 2 : (r - g) / d + 4; h *= 60; }
  return [h, s, l];
}
function hex(h, s, l) {
  h = ((h % 360) + 360) % 360; s = Math.min(1, Math.max(0, s)); l = Math.min(1, Math.max(0, l));
  const f = n => { const k = (n + h / 30) % 12, a = s * Math.min(l, 1 - l);
    return Math.round(255 * (l - a * Math.max(-1, Math.min(k - 3, 9 - k, 1)))).toString(16).padStart(2, '0'); };
  return '#' + f(0) + f(8) + f(4);
}
// tom antigo -> tom novo, mantendo a relação (matiz, saturação e claro/escuro) com a base
function derivar(tom, base, nova) {
  if (tom.toLowerCase() === base.toLowerCase()) return nova.toLowerCase();
  const [ht, st, lt] = hsl(tom), [hb, sb, lb] = hsl(base), [hn, sn, ln] = hsl(nova);
  let dh = ht - hb; if (dh > 180) dh -= 360; if (dh < -180) dh += 360;
  const s = sb > 0 ? st * sn / sb : sn;
  const l = lt <= lb ? lt * ln / lb : ln + (lt - lb) * (1 - ln) / (1 - lb);
  return hex(hn + (sn < 0.08 ? 0 : dh), s, l);
}
const mapa = {};
function montar(tons, base, nova) { if (!nova || !tons) return; for (const t of tons.split(/\s+/).filter(Boolean)) mapa[t.toLowerCase()] = derivar(t, base, nova); }
montar(E.HM_TONS, E.HM_BASE, E.HM_COR);
montar(E.HM_TONS2, E.HM_BASE2, E.HM_COR2);

const nome = E.HM_NOME;
const nomeHtml = nome.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
const nomeJs = nome.replace(/\\/g, '\\\\').replace(/'/g, "\\'");

const re = new RegExp('#(' + Object.keys(mapa).map(k => k.slice(1)).join('|') + ')(?![0-9a-f])', 'gi');
let arquivos = 0, trocas = 0;
(function walk(d) {
  for (const f of fs.readdirSync(d)) {
    const p = path.join(d, f);
    if (fs.statSync(p).isDirectory()) { walk(p); continue; }
    if (!/\.(css|html|js)$/i.test(f)) continue;
    const s = fs.readFileSync(p, 'latin1'); // latin1 = byte a byte, não corrompe utf-8 ao regravar
    let n = s;
    if (Object.keys(mapa).length) n = n.replace(re, m => { trocas++; return mapa[m.toLowerCase()]; });
    if (n.includes('[NOME DO CLIENTE]')) {
      const alvo = /\.js$/i.test(f) ? nomeJs : /\.html$/i.test(f) ? nomeHtml : nome;
      n = n.split('[NOME DO CLIENTE]').join(Buffer.from(alvo, 'utf8').toString('latin1'));
    }
    if (n !== s) { fs.writeFileSync(p, n, 'latin1'); arquivos++; }
  }
})(E.HM_DESTINO);
console.log(`  ${trocas} ocorrências de cor trocadas em ${arquivos} arquivos`);
for (const [a, b] of Object.entries(mapa)) if (a === E.HM_BASE || a === E.HM_BASE2) console.log(`  base ${a} → ${b}`);
NODE

restam_nome=$(grep -rIl -- '\[NOME DO CLIENTE\]' "$DESTINO" 2>/dev/null | wc -l || true)
restam_cor=0
for t in $TONS ${COR2:+${TONS2:-}}; do
  n=$(grep -rIil -- "$t" "$DESTINO" 2>/dev/null | wc -l || true)
  restam_cor=$((restam_cor + n))
done

cat <<FIM

Pronto: $DESTINO (demo: $DEMO)
Arquivos com "[NOME DO CLIENTE]" ainda sem preencher: $restam_nome (esperado: 0)
Arquivos com algum tom antigo da marca: $restam_cor (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. WHATSAPP   js/whatsapp.js: trocar [WHATSAPP] pelo número só com dígitos
                (DDI+DDD, ex. 5533999999999). Todo formulário de reserva e de
                contato e todo link .js-whatsapp saem por ali.
  2. PLACEHOLDERS  grep -rl '\[' *.html — [TELEFONE] [EMAIL] [ENDEREÇO]
                [INSTAGRAM] [FACEBOOK] [HORÁRIO] [HORÁRIO DE ATENDIMENTO]
                [FRASE DE DESTAQUE] [DIFERENCIAL 1/2] [NOME DA ACOMODAÇÃO]
                [PREÇO] [UNIDADE 1/2/3]. O mapa (contato e acomodação) é um
                iframe com q=[ENDERE%C3%87O] na URL — trocar pelo endereço
                real (url-encoded) ou apagar o bloco .hm-mapa.
  3. TEXTOS     o corpo continua em inglês/lorem (quartos "Superior Room",
                "Standard Room", comodidades, descrição, depoimentos com nome
                inventado, "News From Us" com posts falsos). Menu, rodapé,
                formulários e calendário já estão em português.
  4. PREÇOS     tudo em dólar e inventado ("\$80.00 / Night", "Extra people
                \$50", "Security Deposit"). Trocar por R\$ real do cliente ou
                apagar a linha — nunca publicar preço que o cliente não deu.
  5. FOTOS      toda <img> e todo fundo é placeholder cinza com a medida
                escrita (upload/*.jpg). Trocar mantendo o nome do arquivo, ou
                apagar a seção sem foto real.
  6. SEÇÕES     apagar o que o cliente não tem: novidades.html (blog falso),
                estatísticas "2800 guests / 99.9%" (hostel/estrutura),
                depoimentos, "Nossas unidades" (modern — é pra rede com
                várias unidades), sidebar de blog da lista de acomodações do
                apartment.
  7. LOGO       o logo é texto (a.hm-logo-texto, estilo em css/cliente.css).
                Se o cliente tiver logo, trocar por <img> ali.
  8. DEPLOY     sem vercel.json — criar com framework null. Projeto Vercel
                com slug do cliente (skill vercel-cliente-novo).

FIM
