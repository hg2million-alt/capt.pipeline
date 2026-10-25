#!/usr/bin/env bash
#
# Cria uma cópia do template Hair Care já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#8E44AD' 'Salão XYZ'
#
# De onde vem a cor: este pack (comprado como "HairCare — Beauty Salon &
# Barber HTML5 Template") não usa uma CSS custom property (--var) como o
# Handify — a cor de marca é um HEX repetido dentro de UM arquivo de skin,
# css/colors/theme-skin-lemon.css (146 ocorrências do hex sólido + 24 em
# rgba() para transparência), mais 1 ocorrência solta em css/style-main.css
# (borda decorativa). O pack original vem com 12 arquivos de skin prontos
# (blue, brown, gray, green, orange, red, rose, sky-blue, yellow...) — só
# o lemon.css foi mantido, porque é o único carregado pelas 7 páginas desta
# cópia; os outros 11 foram apagados na curadoria (dead weight).
#
# NÃO mexe em (ficam como no original, não são a cor de marca):
#   ~14 tons derivados (lighter2/3/4, darker2/3/4 etc. — ex.: #7f9301,
#   #d7f703, #3d4701) usados em hover/gradiente decorativo dentro do mesmo
#   theme-skin-lemon.css. São tons pré-calculados pelo autor a partir do
#   lemon original (#abc502), não de uma fórmula simples — trocar só o hex
#   base já resolve o essencial (botão, ícone, título, ~170 usos); esses
#   tons remanescentes ficam com um matiz ligeiramente diferente da cor
#   nova, principalmente em estados de hover. Ajustar à mão se incomodar.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#abc502'
RGB_ORIGINAL='171, 197, 2'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#8E44AD' 'Salão XYZ'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#8E44AD' (recebi '$COR')" >&2
  exit 1
fi
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }

hex2rgb() {
  local hex="${1#\#}"
  printf '%d, %d, %d' "0x${hex:0:2}" "0x${hex:2:2}" "0x${hex:4:2}"
}

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

COR_RGB="$(hex2rgb "$COR")"
COR_LOWER="$(printf '%s' "$COR" | tr '[:upper:]' '[:lower:]')"

echo "→ cor de marca: $COR_ORIGINAL → $COR_LOWER (146 usos sólidos + 24 em rgba)"
sed -i "s/${COR_ORIGINAL}/${COR_LOWER}/g" "$DESTINO/css/colors/theme-skin-lemon.css"
sed -i "s/${RGB_ORIGINAL}/${COR_RGB}/g" "$DESTINO/css/colors/theme-skin-lemon.css"
sed -i "s/${COR_ORIGINAL}/${COR_LOWER}/g" "$DESTINO/css/style-main.css"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "$COR_ORIGINAL" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)

cat <<FIM2

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)
FIM2
cat <<'FIM'

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO           images/logo-wide.png (header das páginas internas) e
                     images/logo-wide-white.png (header da home + rodapé de
                     todas as páginas) têm "HAIR CARE" e o ícone de folha
                     desenhados dentro do PNG, na cor lemon ORIGINAL — nome
                     e cor do ícone, os dois travados no raster. O script
                     não alcança nem um nem outro. Trocar os 2 arquivos pela
                     logo real do cliente. logo-wide@2x.png e
                     logo-wide-white@2x.png existem na pasta mas não são
                     referenciados em nenhum HTML — sobra do pacote, pode
                     apagar.
  2. FOTOS          todo https://placehold.co/LARGURAxALTURA (hero, galeria,
                     equipe, funfact, clientes) é placeholder cinza com a
                     dimensão escrita dentro — o pack original usava
                     http://placehold.it, que está fora do ar (403); já foi
                     trocado por placehold.co (ativo) só pra não ficar com
                     imagem quebrada, mas continua sendo placeholder de
                     verdade, não foto nenhuma. Sem fotos reais do salão,
                     cabelo, ambiente e equipe, o site fica com cara de
                     maquete.
  3. GOOGLE MAPS    contact.html carrega o mapa com a API KEY DO AUTOR
                     ORIGINAL do template (script src="maps.google.com/maps/
                     api/js?key=AIzaSy..."). Isso não é um placeholder
                     inofensivo: é uma key de terceiro, prende a cota de
                     alguém que não é o cliente e pode simplesmente parar de
                     funcionar (restrição de domínio) a qualquer momento.
                     TROCAR pela key do cliente (ou de uma conta sua) antes
                     de publicar — nunca deixar essa key no ar.
  4. NEWSLETTER     o formulário "Subscribe" do rodapé (presente nas 7
                     páginas) apontava pro Mailchimp AO VIVO do autor
                     original do tema (thememascot.us9.list-manage.com) —
                     já neutralizado nesta cópia (url vazia, comentado no
                     JS). Sem um ESP próprio do cliente, ou remover o
                     formulário do rodapé, ou plugar um serviço de verdade
                     antes de publicar.
  5. TWITTER FEED   5 das 7 páginas tinham um widget de feed do Twitter
                     puxando a conta @Envato (o marketplace de onde o tema
                     foi comprado) direto pro rodapé do cliente — já trocado
                     pelo placeholder [INSTAGRAM_OU_TWITTER_DO_CLIENTE] no
                     atributo data-username; sem conta real pra puxar,
                     remover o widget em vez de deixar apontando pra
                     ninguém.
  6. FORMULÁRIOS    includes/reservation.php (home), includes/appointment.php
                     (booking.html) e includes/sendmail.php (contact.html)
                     só funcionam com hospedagem PHP — a Vercel não roda
                     PHP. Sem backend, nenhum dos 3 formulários envia nada;
                     trocar a ação de cada <form> por wa.me ou um serviço de
                     formulário estático antes de publicar.
  7. EQUIPE         team.html vem com 4 cards idênticos: mesmo nome
                     ("Hasan Jacobson") e mesmo cargo ("Businessman" — nem é
                     vocabulário de salão, sobrou de um reskin genérico do
                     pacote) repetido nos 4. A seção "trainer" da home
                     (carrossel "Our hair Expert") repete "Steve Smith /
                     Master, English" 5 vezes. Sem equipe real, trocar por
                     cargo genérico sem nome, nunca inventar um nome novo.
  8. PREÇO          a seção Pricing da home tem 4 pacotes com preço chutado
                     (ex. "Woman's Haircut $80") e descrição em Lorem ipsum.
                     Sem tabela real do cliente, apagar a seção ou marcar
                     como "a confirmar".
  9. NÚMEROS        a faixa de estatísticas da home (funfact) tem "754 Happy
                     People", "984 People Likes", "106 Award Won", "469 Cup
                     Of Coffee" — todos inventados pelo tema. Nunca preencher
                     no chute; apagar a seção sem dado real.
 10. CLIENTES       a faixa de 8 logos "clientes atendidos" na home é
                     placeholder cinza sem marca nenhuma — apagar a seção,
                     nunca inventar cliente.
 11. TEXTO          todo o corpo está em inglês, <html lang="en"> incluso —
                     trocar pra pt-BR e reescrever com o tom de voz do
                     identidade.md, não traduzir ao pé da letra. Alguns
                     trechos são sobra de reskins ANTERIORES do mesmo pacote
                     genérico pra outros nichos (já corrigidos nesta cópia:
                     "CharityFund Office" no popup do mapa virou
                     [NOME DO CLIENTE], "Welcome to the salonZone" e "Join
                     our gymzone club" foram reescritos, o endereço fake
                     citava "Envato Labs" — agora só "endereço fictício") —
                     mas o <meta name="keywords"> de todas as páginas ainda
                     lista "building,business,construction,cleaning,
                     transport,workshop" (sobra do mesmo pacote genérico,
                     hoje irrelevante pra SEO — pode reescrever ou remover).
 12. ENDEREÇO/TEL   "203, Behind Alis Steet, Melbourne, Australia" (rodapé,
                     7 páginas), "121 King Street, Melbourne Victoria 3000
                     Australia" (contact.html + pino do mapa), telefones
                     "123-456-789" e "+262 695 2601", e "www.yourdomain.com"
                     — tudo fictício, [EMAIL] já foi isolado à parte (ver
                     abaixo) mas endereço/telefone/domínio precisam de dado
                     real ou aviso "a confirmar".
 13. E-MAIL         "contact@yourdomain.com" e "you@yourdomain.com" já
                     viraram "[EMAIL]" nesta cópia (pattern Qlinest: como o
                     domínio "yourdomain.com" não deriva do nome do tema,
                     um replace pelo nome do cliente não ia quebrar isso,
                     mas marcar deixa óbvio que é fake) — preencher com o
                     e-mail real do cliente ou apagar se ele só usa
                     WhatsApp.
 14. GALERIA/GGE    esta cópia já foi enxugada: o pack original tinha o
                     mesmo álbum de fotos repetido em 9 variações de grid
                     (2 a 10 colunas, tudo na mesma página — sobra de
                     documentação do framework) e a página de equipe tinha
                     3 estilos duplicados do mesmo shortcode ("Style
                     One/Two/Three", com "Alex Jacobson - Attorney" e textos
                     de escritório de advocacia). Só ficou 1 grid de galeria
                     (4 colunas) e 1 estilo de equipe — não precisa mexer,
                     é só pra você saber que o restante foi cortado de
                     propósito, não esquecido.
FIM
exit 0
