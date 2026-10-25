#!/usr/bin/env bash
#
# Cria uma cópia do template Foodio já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#D9822B' 'Cantina XYZ'
#
# O template NÃO tem uma CSS var única de cor. O vermelho #F3274C está
# hardcoded em 3 arquivos diferentes (19 ocorrências ao todo, confirmado por
# grep -ri em toda a árvore antes de escrever este script):
#   - assets/css/color.css   (3 usos — é um arquivo dedicado só de cor, mas
#     repete o hex em vez de usar variável, então precisa de sed igual aos
#     outros)
#   - assets/css/style.css   (15 usos — inclui 1 ocorrência com canal alfa,
#     "#f3274ce8"; a troca de substring preserva o "e8" sozinha, sem precisar
#     de tratamento especial)
#   - assets/js/custom.js    (1 uso — cor do gradiente cônico da barra de
#     progresso de scroll, "conic-gradient(#f3274c ...)")
# Nenhum HTML nem SVG carrega a cor — confirmado, zero ocorrências.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#f3274c'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#D9822B' 'Cantina XYZ'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#D9822B' (recebi '$COR')" >&2
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

COR_SEM_HASH="${COR_ORIGINAL#\#}"
COR_NOVA_SEM_HASH="${COR#\#}"

for f in "$DESTINO/assets/css/color.css" "$DESTINO/assets/css/style.css" "$DESTINO/assets/js/custom.js"; do
  echo "→ cor de marca (${COR_ORIGINAL}) → ${COR} em ${f#$DESTINO/}"
  sed -i "s/${COR_SEM_HASH}/${COR_NOVA_SEM_HASH}/gI" "$f"
done

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam_cor=$(grep -rIoi "$COR_SEM_HASH" "$DESTINO" --include=*.html --include=*.css --include=*.js 2>/dev/null | wc -l || true)
restam_nome=$(grep -rIoi '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)
restam=$((restam_cor + restam_nome))

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           assets/img/logo.png, logo-white.png, logo-white-color.png
                     e logo-icon.png têm a palavra "Foodio" desenhada dentro
                     do PNG (ícone de tigela + texto, na cor de marca) — não
                     é texto HTML, o script não mexe em raster. Trocar pela
                     logo real do cliente.
  2. ZERO FOTO REAL  o template inteiro roda em cima de placehold.co (336
                     ocorrências: hero, cardápio, chefs, galeria, blog) — não
                     veio nenhuma foto de banco de imagem, é 100% placeholder
                     cinza com a dimensão escrita dentro. Sem foto real do
                     prato/salão/fachada, o site fica com cara de maquete.
                     Um dos placehold.co do index.html vinha com a URL
                     duplicada colada ("...588https://placehold.co/590x588")
                     — já corrigido na cópia mestra em html/.
  3. TEXTURA COM A COR ANTIGA QUEIMADA NO ARQUIVO  assets/img/patron.jpg e
                     patron-black.jpg são um padrão decorativo de ícones de
                     comida (usado como background do hero em algumas homes)
                     já tingido na cor de marca ORIGINAL (#F3274C) dentro do
                     próprio JPG — trocar a cor no CSS não muda esse arquivo.
                     Pra outra cor de marca, ou aceita o vermelho residual
                     por trás do overlay, ou re-tinge/substitui as 2 imagens
                     na mão.
  4. TELEFONE        "+1 (850) 344 0 66" é fixo no header/rodapé de toda
                     página — trocar por WhatsApp real ou marcar
                     "a confirmar".
  5. CHEFS FICTÍCIOS índex.html tem 3 cards de chef com nome inventado
                     (Thomas Walim, James Jhonson, Room Minal) e
                     chef-details.html tem um 4º (James Smith, com telefone
                     "1234-0129-123" e e-mail "username@domain.com" de
                     mentira) — sem equipe nomeada real, apagar a seção ou
                     usar cargo genérico sem nome.
  6. DEPOIMENTOS     cards de avaliação espalhados pelas homes têm nome, foto
                     e nota inventados — usar só com selo "ilustrativo".
  7. CARDÁPIO EM DÓLAR  menu-1/2/3.html têm ~135 preços no formato "\$12.60"
                     — trocar por R\$ e valor real do cliente, não é só
                     find/replace de símbolo porque o separador decimal
                     também muda (12.60 → 12,60).
  8. FORMULÁRIO SEM BACKEND NA VERCEL  contact.php e reservation.php usam
                     mail() do PHP puro — não rodam em hospedagem estática
                     (Vercel). O e-mail de destino já vem como placeholder
                     genérico ("add_user_email_here", sem vazar contato do
                     autor original), mas o formulário não envia nada sem
                     um backend PHP de verdade. Trocar a ação do <form> por
                     wa.me ou um serviço de formulário estático antes de
                     publicar.
  9. LOJA/CARRINHO/LOGIN  shop.html, shop-cart.html, cart-checkout.html,
                     product-details.html e login.html simulam e-commerce e
                     conta de usuário sem nenhum backend — nenhum botão
                     funciona de verdade. Considerar remover do menu em demo
                     de captação.
 10. 3 HOMES         index.html (padrão), index-2.html e index-3.html (fundo
                     escuro) são heros diferentes — só index.html está
                     linkada no menu. Escolher uma antes de publicar.
 11. REDES SOCIAIS   os ícones de Facebook/Instagram/Twitter/Youtube do
                     header e do rodapé apontam pra href="#" — preencher com
                     o Instagram real do cliente ou remover.
 12. VÍDEO DO YOUTUBE  o botão de "play" do hero (fancybox) abre um vídeo do
                     YouTube de estoque (mesmo id em 8 páginas) — trocar pelo
                     vídeo real do cliente ou remover o botão.
 13. TEXTO           todo o corpo está em inglês (<html lang="en">, já
                     corrigido de "zxx" — código de "sem conteúdo
                     linguístico" que veio errado no original). Trocar pra
                     "pt-BR" e reescrever com o tom de voz do
                     identidade.md do cliente, não traduzir ao pé da letra.
FIM
exit 0
