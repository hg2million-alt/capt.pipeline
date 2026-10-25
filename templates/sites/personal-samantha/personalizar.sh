#!/usr/bin/env bash
#
# Cria uma cópia do template Samantha já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Maria Personal'
#
# Este template NÃO tem CSS custom property nenhuma — a cor de marca está
# escrita em hex literal, espalhada em DUAS folhas de estilo, e ainda por
# cima com TRÊS grafias ligeiramente diferentes do mesmo verde-limão:
#   #bde800 (16 usos em css/style.css + todo o css/color.css, que é a folha
#     dedicada só a essa cor: ~32 seletores de texto/hover/fundo)
#   #bee800 (5 usos em css/style.css — bordas e fundo das abas de
#     calculadora de IMC, claramente a MESMA cor com 1 dígito trocado, não
#     uma segunda cor de marca proposital)
#   #d8ff56 (2 usos em css/style.css — traço decorativo e o número gigante
#     de uma estatística, um verde mais claro/lavado, também parece a mesma
#     família de cor, não um acento à parte)
# Diferente do caso do Qlinest (lá o azul e o amarelo do CTA são D UAS cores
# de marca genuinamente distintas, documentado com propósito), aqui as três
# grafias são próximas demais pra serem intencionais — decidimos tratar as
# três como "a mesma cor de marca, escrita de um jeito inconsistente pelo
# autor" e trocar as três pela COR do cliente. Deixar só a #bde800 trocada
# faria o site final ficar com 1 cor nova + 2 verdes originais sobrando,
# parecendo bug, não decisão de design.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Maria Personal'" >&2
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

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

echo "→ cor de marca: #bde800, #bee800 e #d8ff56 → $COR (css/style.css e css/color.css)"
sed -i -E "s/#(bde800|bee800|d8ff56)/${COR}/gI" "$DESTINO/css/style.css" "$DESTINO/css/color.css"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "#bde800" -e "#bee800" -e "#d8ff56" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO          img/logo.svg e logo-w.svg (versão branca) têm o nome do
                    template desenhado como PATH vetorial (texto convertido
                    em contorno, não texto de verdade) — não aparece em
                    grep de nome e o script não alcança. Trocar pela arte
                    real do cliente nos 2 arquivos. img/logo-icon.png é só
                    o favicon.
  2. NOME DUPLO NO ORIGINAL — vale entender antes de mexer. O template vem
                    com DOIS nomes diferentes: "Samantha" era só o nome do
                    produto (aparecia no título da aba, na tela de
                    carregamento e no copyright) e "Hana Evans" era o nome
                    da personal trainer fictícia usada como narrador do
                    "Sobre" e autora dos posts de blog. Os DOIS já foram
                    trocados por [NOME DO CLIENTE] neste template — ou seja,
                    o texto corrido do "Sobre" e a assinatura dos posts vão
                    ficar em primeira pessoa com o nome do cliente, o que
                    faz sentido pra personal autônomo. Reler o about.html e
                    blog-details.html depois de rodar o script pra conferir
                    se a frase ainda faz sentido gramaticalmente.
  3. FOTO BORRADA POR DESIGN — a foto do hero (img/Photo.jpg) e outras
                    (img/blur*.png de fundo de seção) já vêm desfocadas de
                    propósito no arquivo, não é imagem quebrada nem é blur
                    por CSS. É o placeholder "de privacidade" do autor do
                    template. Trocar pela foto real do personal deixa a
                    imagem nítida — testar como fica, o design pode ter sido
                    pensado pra ficar desfocado (efeito "vidro fosco") e uma
                    foto nítida pode pedir ajuste de composição.
  4. FOTOS "COM NOME DE FOTO DE VERDADE" QUE SÃO PLACEHOLDER — arquivos como
                    Photo-about.jpg, card-1.jpg, portfolio-1.jpg têm
                    nome descritivo, mas boa parte é still de banco de
                    imagens genérico (não são todas cinza-com-dimensão) —
                    conferir imagem por imagem antes de assumir que já é
                    foto usável, várias mostram pessoa/academia que não é o
                    cliente.
  5. E-MAIL         "hana_evans@gmail.com" aparecia em 2 lugares por página
                    (topbar e rodapé) — já virou "[EMAIL]". Um dos dois links
                    originais era href="hana_evans@gmail.com" SEM o
                    prefixo "mailto:" (bug do próprio template) — ao
                    preencher o e-mail real, adicionar "mailto:" na frente
                    nesse link também, senão ele não abre o cliente de
                    e-mail.
  6. TELEFONE       "+1 (495) 231 17 82" aparece fixo em pelo menos 2
                    lugares por página, com o protocolo pouco comum
                    callto: em vez de tel: — trocar por WhatsApp real
                    (e trocar callto: por tel: ou por um link wa.me).
  7. FORMULÁRIO SEM AÇÃO NENHUMA — os <form> de contact.html, about.html
                    e apointment-1/2.html não têm action nem backend (nem
                    PHP fake): o botão de enviar não faz nada. Diferente dos
                    outros templates da biblioteca, aqui não tem nem o que
                    desligar — precisa ligar um wa.me ou serviço de
                    formulário estático do zero antes de publicar.
  8. AGENDAMENTO    apointment-1.html, apointment-2.html,
                    online-schedule.html e schedule.html simulam um
                    calendário de agendamento sem back-end real — funciona
                    só visualmente. Se o cliente não usa agenda online de
                    verdade, marcar como ilustrativo ou remover do menu.
  9. PREÇO          pricing-table.html tem planos com valor chutado — sem
                    tabela real do cliente, apagar a página ou marcar "a
                    confirmar".
 10. PORTFÓLIO/DEPOIMENTO/BLOG — portfolio.html, portfolio-details.html e
                    os posts de blog-style-1/2 e blog-details vêm com
                    "antes/depois" de aluno, depoimento e texto inventados,
                    em inglês — marcar como ilustrativo, reescrever ou
                    remover.
 11. TEXTO          todo o corpo está em inglês (só o atributo lang já virou
                    "pt-BR") — reescrever com o tom de voz do
                    identidade.md do cliente, não traduzir ao pé da letra.
 12. MAPA            o iframe do Google Maps em contact.html está fixado na
                    Ucrânia (coordenadas do template original) — trocar pela
                    localização real ou remover se o atendimento for só
                    online/a domicílio.
FIM
exit 0
