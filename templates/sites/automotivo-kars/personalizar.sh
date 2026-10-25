#!/usr/bin/env bash
#
# Cria uma cópia do template já com a cor de destaque e o nome do cliente
# trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> <#COR> "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/OficinaX/site '#1E6F5C' 'Oficina X'
#
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

# O template tem UMA cor de marca só, em variável CSS (--theme-color no
# :root de assets/css/style.css) — mas ela também está chumbada em hex cru
# dentro de ~35 ícones SVG e das duas logos, porque SVG não lê variável CSS
# externa. Por isso a troca é por substituição de texto (grep+sed) em vez de
# editar só o :root — do jeito que já é feito no automotivo-carlink.
COR_ORIGINAL='#F02801'

# Nome fictício da concessionária de demonstração, usado em TODA a copy
# (hero, "Sobre", depoimentos, rodapé) — não só no <title>. Ver README,
# seção "Armadilhas".
NOME_ORIGINAL='Kars'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> <#COR> \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/OficinaX/site '#1E6F5C' 'Oficina X'"    >&2
  exit 1
fi

if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#1E6F5C' (recebi '$COR')" >&2
  exit 1
fi

if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

echo "→ trocando $COR_ORIGINAL por $COR (CSS, SASS e ~35 ícones/logos SVG)"
grep -rIl "$COR_ORIGINAL" "$DESTINO" 2>/dev/null | while read -r f; do
  sed -i "s/${COR_ORIGINAL}/${COR}/g" "$f"
done

# home-2.html (variante moto) tem <body class="bike-dealership">, que
# redefine --theme-color: #FE8900 (laranja) por cima da cor geral, só
# para essa página. A linha é única no arquivo (diferente de
# --theme-color2, que também usa FE8900) — sem esse passo, quem escolher
# a home de moto ficaria com acento laranja preso mesmo depois de trocar
# a cor.
if grep -rIlq -- '--theme-color: #FE8900;' "$DESTINO" 2>/dev/null; then
  echo "→ trocando o acento laranja exclusivo da home de moto (.bike-dealership) por $COR"
  grep -rIl -- '--theme-color: #FE8900;' "$DESTINO" | while read -r f; do
    sed -i "s/--theme-color: #FE8900;/--theme-color: ${COR};/g" "$f"
  done
fi

NOME_ESCAPADO="${NOME//\//\\/}"

echo "→ preenchendo o nome do cliente nos <title>, <meta>, alt de logo e rodapé"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESCAPADO}/g" "$f"
done

echo "→ trocando o nome da concessionária de demonstração ($NOME_ORIGINAL) pelo nome do cliente no corpo do site"
grep -rIl "\b${NOME_ORIGINAL}\b" "$DESTINO" 2>/dev/null | while read -r f; do
  sed -i "s/\b${NOME_ORIGINAL}\b/${NOME_ESCAPADO}/g" "$f"
done

restam_cor=$(grep -rIl "$COR_ORIGINAL" "$DESTINO" 2>/dev/null | wc -l || true)
restam_nome=$(grep -rIl "\b${NOME_ORIGINAL}\b" "$DESTINO" 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Arquivos com a cor original ainda presente: $restam_cor (esperado: 0)
Arquivos com "$NOME_ORIGINAL" ainda presente: $restam_nome (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO       assets/img/logo.svg e logo-white.svg têm a palavra "KARS"
                DESENHADA em path vetorial (não é texto, não é find/replace).
                A cor já foi trocada automaticamente, mas o nome, não — para
                usar o nome real do cliente, o logo precisa ser refeito do
                zero ou substituído pelo logo real da marca.
  2. PÁGINA     escolher a home (index.html = home 1, home-2 a home-6) e
                apagar as outras. Ver README para o que cada uma é — elas
                NÃO são intercambiáveis, cada uma serve um sub-nicho
                diferente (marketplace, oficina, moto, carro único, etc.).
                Repontar os links de logo/menu para a home escolhida se ela
                não for index.html.
  3. TEXTOS     o conteúdo é demo em inglês. Reescrever em pt-BR. O nome
                "Kars" já foi trocado, mas frases inteiras (depoimentos,
                "Sobre", números de anos de experiência) continuam
                fictícias e em inglês.
  4. CONTATO    telefone, endereço e e-mail aparecem no header e no footer
                de quase todas as páginas — e não é só um e-mail: o header
                usa info@kars.com, contact.html mostra karshelp@gmail.com
                num card separado, e mail.php manda pra yourmail@gmail.com
                (item 5). Trocar os três, não só um.
  5. FORMULÁRIO mail.php manda para um e-mail placeholder
                (yourmail@gmail.com) — trocar antes de publicar, ou o
                formulário não entrega para ninguém. mail.php também exige
                servidor com PHP + função mail() configurada; Vercel não
                serve PHP — ou troca o action por um serviço de formulário
                (Formspree/web3forms) ou tira o formulário do ar.
                sell-a-car.html tem um SEGUNDO formulário com
                action="/submit-form", que não existe em lugar nenhum —
                mesma decisão.
  6. FOTOS      diferente do automotivo-carlink: aqui ~265 dos ~300
                arquivos em assets/img/ (carro no hero, catálogo, equipe,
                depoimentos, blog) são placeholder cinza com a medida
                escrita dentro ("946 x 452" etc.), não fotos reais de
                banco de imagem. Só os fundos texturizados/decorativos são
                arte de verdade. Trocar TUDO que for foto de veículo,
                fachada ou equipe pelas fotos reais do cliente.
  7. HOME-6     "GS24" / "Nautique Super Air" não é carro — é um produto de
                barco/lancha que sobrou do módulo de loja genérico do tema
                (mesmo módulo de cart.html/shop.html/wishlist.html). Se for
                usar essa home, os dados do produto têm que virar veículo;
                mais fácil é simplesmente não escolher essa home.
  8. [DESCRIÇÃO CURTA] em <title> e <meta> continua como slot, preencher
                por página.

FIM
