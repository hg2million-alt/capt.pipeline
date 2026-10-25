#!/usr/bin/env bash
#
# Cria uma cópia do template ClinicMaster já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2E8B57' 'Clínica XYZ'
#
# TAILWIND CSS 4 — MAS NÃO É "1 CSS custom property central" NEM "classe
# utilitária solta": É UMA PALETA DE ~10 TONS ESPALHADOS PELO CSS COMPILADO.
# Leia isto antes de mexer, porque a primeira suposição (achar `:root` com
# UMA variável de cor, ao molde do Handify) está errada aqui.
#
# O pacote original vem como fonte (package/src/*.html com classes Tailwind)
# já compilada por `npx @tailwindcss/cli` em assets/css/style.css. O tema
# tenta um sistema de "skins" via `html[data-theme-color="skin-N"]`, cada um
# com seu próprio `--primary`/`--secondary` — mas SÓ os textos, ícones e
# fundos sólidos seguem essa variável (via var(--color-primary)). Todo
# gradiente decorativo (botão, cartão de serviço, tag, ícone-círculo,
# sombra de acordeão) foi buildado com o HEX CRU do skin de demonstração
# gravado direto no CSS, sem passar por variável — ou seja, TROCAR só
# `--primary` no bloco do skin ativo (que é sempre "skin-7", ver abaixo)
# muda o texto/ícone mas deixa botão, cartão e tag com a cor VELHA.
#
# Por isso este script não segue o padrão de 1 sed por variável: ele varre
# uma PALETA de ~10 tokens (hex e RGB decimal, em maiúscula/minúscula, com
# e sem vírgula) que juntos cobrem toda a família rosa/coral do skin-7, e
# troca cada um pela cor recebida ou por um tom claro derivado dela.
#
# CONFIRMADO NO NAVEGADOR (Playwright, screenshot antes/depois) — a
# primeira tentativa só trocando `--primary` do bloco skin-7 manteve o
# botão "Appointment" e o fundo do hero rosa/coral: eles vêm de
# `--btn-gradient` e de `--primary-1-gradient` … `--primary-8-gradient`,
# variáveis GLOBAIS (fora de qualquer skin) com o hex cru.
#
# TODAS as 26 páginas do src/ e elements/ têm
# `<html data-theme-color="skin-7">` fixo — os outros 8 skins do arquivo
# são sobra do tema, nunca usados, não precisam ser tocados.
#
# A "cor de marca" real tem DOIS tons no arquivo original, não um:
#   ROSA  (#F0588D / #EF578D, rgb 240,88,141 / 239,87,141) — vira a COR
#         recebida.
#   CORAL (#FF8C70 / #F79C86 / #FF9478, rgb 255,140,112) — é só o segundo
#         estágio dos degradês (botão, ícone-círculo, tag), não uma cor de
#         marca separada. O script deriva um tom claro da COR recebida
#         (mistura com branco) pra manter o efeito de degradê em vez de
#         achatar tudo numa cor sólida.
# --secondary (#002E71, azul-marinho) é cor de texto/título, não de marca —
#   fica FIXA, mesma lógica do Qlinest.
#
# NÃO mexe em: os ~30 outros `--*-gradient` do arquivo (banner, card,
# título, divisor) — são washes quase-brancos/pretos com uma pitada de rosa
# ou neutros puros, não a cor de marca; perseguir cada um tinha retorno
# visual baixo pra um risco alto de sed errado. Ver "Falta fazer na mão".
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#2E8B57' 'Clínica XYZ'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#2E8B57' (recebi '$COR')" >&2
  exit 1
fi
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }
hex_ch() { printf '%d' "$((16#$1))"; }
dec_hex() { printf '%02x' "$1"; }
clamp255() { local v="$1"; [ "$v" -gt 255 ] && v=255; [ "$v" -lt 0 ] && v=0; printf '%d' "$v"; }

HEX="${COR#\#}"
R=$(hex_ch "${HEX:0:2}"); G=$(hex_ch "${HEX:2:2}"); B=$(hex_ch "${HEX:4:2}")
COR_RGB="${R}, ${G}, ${B}"
COR_RGB_SPACE="${R} ${G} ${B}"

# ~15% mais escuro (aproximação de hover/estado ativo — não existe fórmula
# fixa a replicar do original, ver cabeçalho)
RD=$(clamp255 $(( R * 85 / 100 ))); GD=$(clamp255 $(( G * 85 / 100 ))); BD=$(clamp255 $(( B * 85 / 100 )))
COR_DARK="#$(dec_hex "$RD")$(dec_hex "$GD")$(dec_hex "$BD")"

# tom claro (mistura ~35% branco) — segundo estágio dos degradês, ver cabeçalho
RT=$(clamp255 $(( R + (255 - R) * 35 / 100 ))); GT=$(clamp255 $(( G + (255 - G) * 35 / 100 ))); BT=$(clamp255 $(( B + (255 - B) * 35 / 100 )))
COR_TINT="#$(dec_hex "$RT")$(dec_hex "$GT")$(dec_hex "$BT")"
COR_TINT_RGB="${RT}, ${GT}, ${BT}"

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

CSS="$DESTINO/assets/css/style.css"
echo "→ tom principal (rosa da marca): $COR"
echo "→ tom escuro (hover/ícone, ~15% mais escuro): $COR_DARK"
echo "→ tom claro (2º estágio de degradê, ~35% branco): $COR_TINT"

# casamento SEM o prefixo "#"/"%23" de propósito: o mesmo hex aparece tanto
# como "#F0588D" (CSS normal) quanto "%23EF578D" (ícone SVG embutido em
# data-URI, # vira %23) — casar só o miolo hex cobre os dois formatos sem
# duplicar regra, e o prefixo original (# ou %23) fica intocado.
HEXD="$(dec_hex "$RD")$(dec_hex "$GD")$(dec_hex "$BD")"
HEXT="$(dec_hex "$RT")$(dec_hex "$GT")$(dec_hex "$BT")"
sed -i \
  -e "s/F0588D/${HEX}/gI" \
  -e "s/EF578D/${HEX}/gI" \
  -e "s/ff3279/${HEXD}/gI" \
  -e "s/239, 87, 141/${COR_RGB}/g" \
  -e "s/240, 88, 141/${COR_RGB}/g" \
  -e "s/240 88 141/${COR_RGB_SPACE}/g" \
  -e "s/FF8C70/${HEXT}/gI" \
  -e "s/F79C86/${HEXT}/gI" \
  -e "s/FF9478/${HEXT}/gI" \
  -e "s/255, 140, 112/${COR_TINT_RGB}/g" \
  "$CSS"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam_nome=$(grep -rIo '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html 2>/dev/null | wc -l || true)
restam_cor=$(grep -oiE "F0588D|EF578D|FF8C70|F79C86|FF9478|ff3279" "$CSS" 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências de [NOME DO CLIENTE] ainda presentes: $restam_nome (esperado: 0)
Ocorrências da paleta rosa/coral original: $restam_cor (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           src/images/logo.svg (2x por página: header desktop e
                     menu mobile) tem "ClinicMaster" desenhado como PATH
                     vetorial (não é <text>, não aparece em busca por nome)
                     E o ícone de cruz usa gradiente #F0588D→#F79C86 cru
                     dentro do próprio SVG — a troca de cor deste script NÃO
                     alcança esse arquivo. Trocar o SVG inteiro pela logo
                     real do cliente. src/images/logo.gif (splash de
                     carregamento) tem o mesmo problema.
  2. WASH DE FUNDO CLARO — dezenas de outras variáveis "--*-gradient" (banner-2,
                     banner-3, content-wrapper-3 etc.) são véus quase-brancos
                     com uma pitada de rosa/creme, não tocados por este
                     script (ver cabeçalho — perseguir cada um tinha retorno
                     baixo). Se o cliente for de cor fria (azul/verde),
                     conferir se esse fundo rosado-claro atrás do hero ainda
                     combina; se destoar, ajustar à mão em assets/css/
                     style.css (buscar por "banner-2-gradient"/
                     "banner-3-gradient").
  3. FOTOS           checar cada arquivo em src/images/ e elements/images/
                     antes de assumir que é foto real — o pacote mistura
                     foto de banco de imagem licenciada com placeholder.
  4. E-MAIL/TELEFONE FAKE — e-mails de exemplo usam @example.com (domínio
                     reservado, não quebra ao virar [NOME DO CLIENTE]@
                     example.com, mas troque pelo contato real). Telefone
                     "+1 123 456 7890" aparece fixo — trocar ou marcar "a
                     confirmar".
  5. EQUIPE/DEPOIMENTO/BLOG/PREÇO — team.html, testimonial.html,
                     pricing-table.html, blog-grid.html etc. vêm com nome,
                     foto, nota, texto e valor 100% inventados — sem dado
                     real do cliente, marcar como ilustrativo ou apagar a
                     seção/página.
  6. PROMESSA DE RESULTADO CLÍNICO — a home ("Lose Weight, Gain
                     Confidence"), about-us e as páginas de serviço trazem
                     frases de resultado de emagrecimento/percentual/prazo
                     que são copy de vitrine do tema, não fato clínico do
                     cliente — reescrever como exemplo ilustrativo, nunca
                     manter como promessa real (propaganda enganosa em
                     saúde é grave, não só feio).
  7. FORMULÁRIO PHP  assets/script/contact.php, contact_smtp.php,
                     mailchimp.php (+ vendor PHPMailer) não rodam na
                     Vercel. Trocar a ação do formulário por wa.me ou
                     serviço de formulário estático antes de publicar.
  8. TEXTO           corpo 100% em inglês, <html lang="en"> incluso —
                     trocar pra pt-BR e reescrever com o tom de voz do
                     identidade.md, não traduzir ao pé da letra.
  9. ENTRADA NÃO É html/index.html — é html/src/index.html. O pacote
                     original não tem página na raiz; assets/, elements/ e
                     src/ são pastas irmãs, e caminhos tipo
                     background-image:url(../../src/images/...) já vêm
                     GRAVADOS no CSS compilado relativos a assets/css/ — não
                     mover nem renomear essas pastas, ou as imagens de fundo
                     baked no CSS quebram (não tem como re-buildar sem rodar
                     o Tailwind CLI de novo). Ao publicar, apontar o
                     domínio/rewrite pra src/index.html.
 10. PÁGINAS "elements/" são a folha de estilo/shortcodes do tema (grid,
                     botões, cards soltos) — não são páginas de site, só
                     referência visual; não faz sentido linkar no menu de
                     um demo de captação.
FIM
exit 0
