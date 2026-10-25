#!/usr/bin/env bash
#
# Cria uma cópia do template Foodu já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>" [home]
#
# Exemplos:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#C0392B' 'Restaurante XYZ'
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#C0392B' 'Restaurante XYZ' index-dark
#
# O template tem DUAS cores de marca, só via CSS custom property, em
# assets/css/style.css (bloco :root, ~linha 84):
#   --color-primary:   #EB0029  (vermelho) — botão, preço, hover, gradiente
#   --color-secondary: #f76e2a  (laranja)  — detalhe/gradiente, menos usado
# Confirmado: ZERO ocorrência solta dos hex fora do :root em todo o CSS/JS/
# HTML — 100% via var(--color-primary)/var(--color-secondary). Não precisa
# de node/regex, só sed nas duas linhas do :root.
#
# "home" é o nome do arquivo (sem .html) que deve virar o index.html do
# destino — o pacote comprado traz 12 homes (index, index-2..6 = claras;
# index-dark, index-dark-2..6 = escuras). Sem esse argumento, o script
# mantém o layout claro padrão (index.html) e só copia o resto junto.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_PRIMARIA_ORIGINAL='#EB0029'
COR_SECUNDARIA_ORIGINAL='#f76e2a'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"
HOME_ESCOLHIDA="${4:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\" [home]" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#C0392B' 'Restaurante XYZ'" >&2
  echo "     $0 /c/Dev/Captacao-CC/clientes/xyz/site '#C0392B' 'Restaurante XYZ' index-dark" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#C0392B' (recebi '$COR')" >&2
  exit 1
fi
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi
if [ -n "$HOME_ESCOLHIDA" ] && [ ! -f "$ORIGEM/${HOME_ESCOLHIDA}.html" ]; then
  echo "erro: '$ORIGEM/${HOME_ESCOLHIDA}.html' não existe. Homes disponíveis:" >&2
  ls "$ORIGEM" | grep -E '^index' | sed 's/\.html$//' | sed 's/^/  - /' >&2
  exit 1
fi

escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

CSS="$DESTINO/assets/css/style.css"
echo "→ cor primária (--color-primary): $COR_PRIMARIA_ORIGINAL → $COR"
sed -i "s/--color-primary: ${COR_PRIMARIA_ORIGINAL};/--color-primary: ${COR};/" "$CSS"
echo "→ cor secundária (--color-secondary): mantida em $COR_SECUNDARIA_ORIGINAL"
echo "  (derive uma segunda cor à mão se a marca do cliente tiver duas — o"
echo "   script não inventa a secundária sozinho, ver README)"

echo "→ preenchendo o nome do cliente (título, meta description, rodapé)"
NOME_ESC="$(escapar "$NOME")"
grep -rIl 'Foodu' "$DESTINO" --include=*.html | while read -r f; do
  sed -i "s/Foodu/${NOME_ESC}/g" "$f"
done

if [ -n "$HOME_ESCOLHIDA" ] && [ "$HOME_ESCOLHIDA" != "index" ]; then
  echo "→ usando '${HOME_ESCOLHIDA}.html' como home (index.html)"
  cp "$DESTINO/${HOME_ESCOLHIDA}.html" "$DESTINO/index.html"
fi

restam=$(grep -rIoi -e "$COR_PRIMARIA_ORIGINAL" "$DESTINO" --include=*.css 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor primária original ainda no CSS: $restam (esperado: 0 —
  são todas dentro do :root, se não for 0 confira se editou o arquivo certo)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO          assets/img/logo.png, logo-light.png, logo-light-2.png,
                    logo-icon.png e logo-3.png são a palavra "FOODU" DESENHADA
                    DENTRO do PNG (chapéu de chef + talheres em círculo
                    vermelho) — não é texto, não sai em find/replace. Trocar
                    pela logo real do cliente com o mesmo nome de arquivo.
  2. FORMULÁRIO     contact.html é o ÚNICO form com backend real: posta pra
                    assets/mail/contact.php, que mandava e-mail pro Gmail
                    PESSOAL do autor original (já trocado por um TODO
                    genérico neste template, mas o PHP não roda na Vercel de
                    qualquer forma). Sem hospedagem PHP, esse form não
                    envia nada. Trocar a ação por um link wa.me ou apagar o
                    form antes de publicar — nunca deixar um POST morto no ar.
  3. RESERVA        Todo <form class="reservation-form"> (tem em 8 páginas,
                    inclusive index e index-dark) usa action="#" — não é
                    quebrado, é decorativo: nunca teve backend nenhum, nem
                    no tema original. Sem JS novo ele não faz nada ao
                    enviar. Ligar num wa.me com os campos preenchidos (igual
                    ao padrão já usado no barbearia-trimly/) antes de
                    publicar, ou trocar o botão por um link direto de
                    WhatsApp.
  4. TELEFONE/EMAIL "+4733378901" e "food@restan.com" são fake genéricos do
                    autor (não é dado pessoal de ninguém, mas também não é
                    real) — aparecem em contact.html e no rodapé de várias
                    páginas. Trocar pelo contato real do cliente ou marcar
                    "a confirmar".
  5. FOTOS          assets/img/ tem 205 arquivos, e TODOS são placeholder
                    cinza com a dimensão escrita dentro (ex. "1500X1875",
                    "600X600") — nenhuma foto real de comida, prato, chef ou
                    fachada em lugar nenhum do pacote. Trocar pelo mesmo nome
                    de arquivo mantém o layout; sem foto real, seção de
                    cardápio/galeria/chef fica com cara de maquete.
  6. 12 HOMES       index.html + index-2..6.html (claras) e index-dark.html +
                    index-dark-2..6.html (escuras) são variações de layout
                    da MESMA marca, não modos claro/escuro alternáveis por
                    JS — escolher uma só antes de publicar (o parâmetro
                    [home] deste script já faz isso). O preview/ desta pasta
                    só cobre um subconjunto — ver README.
  7. PÁGINAS EXTRA  cart.html, checkout.html, shop.html, shop-single.html,
                    shop-single-thumb-only.html são loja de produto (e-
                    commerce genérico do pacote), normalmente fora do
                    escopo de um demo de captação de restaurante — considerar
                    remover do menu se o cliente não vende produto físico.
  8. TEXTO          Todo o corpo está em inglês. Reescrever com o tom de voz
                    do identidade.md do cliente, não traduzir ao pé da letra.
                    <html lang> já vem "pt-BR" neste template (trocado do
                    "en" original).
  9. RTL            O pacote original vinha com suporte a árabe/hebraico
                    (ligado só se alguém adicionar a classe "rtl" no
                    <body> — nunca vem ligado por padrão). O bloco inteiro de
                    CSS RTL (~1100 linhas, força de "# RTL Styles" até o fim
                    de assets/css/style.css) já foi REMOVIDO desta cópia —
                    não reativar.
 10. REDES SOCIAIS  Confirmar se os ícones do rodapé/header apontam pra
                    href="#" (a maioria) antes de publicar — preencher ou
                    remover os que não existem.
FIM
exit 0
