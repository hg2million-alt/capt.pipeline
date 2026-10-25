#!/usr/bin/env bash
#
# Cria uma cópia do template Quala Coat já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#8A6A2F' 'Advocacia XYZ'
#
# Não é LESS/CSS custom property (não tem nenhum "--var" nem "@var" chegando
# no CSS compilado) — é hex cru repetido no styles.css. O fonte tem
# css/less/variables.less com os nomes originais, mas o styles.css já veio
# compilado; o script mexe direto no hex.
#
# O template tem DUAS cores em jogo, não uma (confirmado com screenshot da
# index/about-us/contact ANTES de qualquer alteração — ver preview/ raw não
# guardado, mas o padrão visual é: dourado no logo/menu ativo/ícones/botão
# secundário, marrom escuro no botão principal de CTA e nos títulos de
# seção "ABOUT US"/"CONTACT US"):
#   @primary-color: #dcb04d (dourado) — 186 usos em css/styles.css + 2 usos
#     inline em index.html/about-us.html (data-bg_color="#dcb04d" de uma
#     seção com padrão de fundo). É a cor dominante: logo, aba de menu
#     ativa, ícones, bordas, um dos dois botões de CTA. É essa que o script
#     troca pela COR passada.
#   @secondary-color: #5a2918 (marrom escuro) — 32 usos, só em css/styles.css.
#     É o botão "Book Appointment"/"Get Started Now" (o CTA de maior
#     contraste) e o texto dos títulos de seção. Fica FIXO por padrão: é
#     contraste funcional contra o dourado, não tem garantia de que a cor
#     do cliente combine como botão sobre ela mesma — mesmo caso do botão
#     amarelo fixo do template Qlinest.
# Os tons #ffffff, #111111, #646464, #cccccc etc. são neutros (texto, fundo,
# borda) e não são cor de marca — não mexer.
#
# ARMADILHA que o script NÃO resolve: styles.css é CSS compilado a partir de
# LESS com lighten()/darken() aplicados sobre @primary-color para os estados
# de hover — isso virou hex fixo no compilado:
#   #e4c378 (dourado claro, hover de borda/sublinhado)
#   #ce9b28 (dourado escuro, hover de botão/link)
#   #a37b20 (dourado mais escuro ainda, hover de link/ícone)
# O sed só troca o #dcb04d base. Depois de personalizar, o HOVER de link,
# botão e ícone continua com um resquício do dourado ORIGINAL, não da COR
# nova — pode ficar levemente desencontrado. Se incomodar, recalcular à mão
# (aprox. lighten 10-30% e darken 5-20% sobre a COR nova) e substituir esses
# três hex em css/styles.css.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#dcb04d'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#8A6A2F' 'Advocacia XYZ'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#8A6A2F' (recebi '$COR')" >&2
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

CSS="$DESTINO/css/styles.css"
echo "→ cor de marca (dourado, #dcb04d): $COR_ORIGINAL → $COR"
sed -i "s/${COR_ORIGINAL}/${COR}/g" "$CSS"

echo "→ cor de marca no atributo inline (index.html, about-us.html)"
for f in "$DESTINO/index.html" "$DESTINO/about-us.html"; do
  sed -i "s/${COR_ORIGINAL}/${COR}/g" "$f"
done

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "$COR_ORIGINAL" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO            images/logo.png (usado em TODAS as 27 páginas, header)
                      tem "QUALA COAT" + "YOUR TRUSTED LAW PARTNER" desenhado
                      dentro do PNG (raster, não é texto) — trocar pela logo
                      real do escritório. images/logo_1.png..logo_8.png são
                      OUTRA coisa: uma faixa de "Our Clients" (index.html,
                      seção "client-logo") com 8 logos de mentira tipo
                      Logoipsum — apagar a seção inteira, nunca inventar
                      cliente do escritório.
  2. FOTOS            praticamente TODO o conteúdo fotográfico (hero slides
                      home_1_slider_1..3, fotos de equipe team_5..8,
                      serviços service_1..6/service_single, galeria
                      gallery_1..8, avatares user_1..4/support_user,
                      testimony_feat_img, 404_img, coming-soon) é um
                      retângulo cinza-escuro liso com marca d'água "DEMO" —
                      o pacote veio sem as fotos de banco de imagens do
                      preview original, não é só dimensão escrita tipo
                      "600x400". Sem foto real da banca/advogados, o site
                      fica com cara de rascunho, não de maquete. Ícones
                      (highlight_*.png, pricing_*.png) e o pattern_1.png
                      decorativo estão OK, não precisam de troca.
  3. TELEFONE/E-MAIL  telefones fixos são todos falsos e no padrão de
                      Bangladesh (+880-1911-623-458, +8801-717-682-743,
                      +8800-191-161-3458, +093-120-525-9162) — aparecem no
                      topo, no header e em contact.html. O endereço também é
                      inconsistente e falso ("Saifa Summit, Bangladesh" no
                      header vs "3100 C/A Mouchak, Sylhet, UK" em
                      contact.html). Os e-mails do rodapé
                      (support-us@swimes.com, helpmenow@swimes.com — sobra
                      de OUTRO template chamado "Swimes", repetida nas 27
                      páginas) e o query@yourdomain.com de contact.html são
                      igualmente de mentira. NENHUM desses domínios contém
                      "quala"/"coat", então o replace do nome não quebrou
                      domínio nenhum — mas também não os tocou; trocar à mão
                      por contato real ou "a confirmar".
  4. EQUIPE           team.html e single-team.html vêm com nome, cargo e
                      foto de advogado inventados (fotos já cobertas no item
                      2) — sem gente real, apagar a seção/página ou trocar
                      por cargo genérico sem nome.
  5. DEPOIMENTO        os depoimentos de index.html/about-us.html/
                      element-feedback.html têm nome, empresa e texto
                      inventados — e o texto nem fala de advocacia: "I
                      appreciate the ride to work too and delivered to my
                      work the same day it broke down" é sobra de um
                      template de oficina/automotivo, não foi reescrito para
                      escritório de advocacia. Reescrever do zero ou apagar;
                      se usar, só com selo "ilustrativo" visível.
  6. OAB — ATENÇÃO    index.html e about-us.html têm um contador
                      "99.99% Successful Case" (seção "COUNTER SECTION 02").
                      Isso é estatística de resultado de processo/promessa
                      de êxito. Publicidade de advocacia no Brasil segue o
                      Provimento 205/2021 do Conselho Federal da OAB, que
                      proíbe promessa de resultado, captação de clientela
                      indevida e mercantilização da advocacia. Esse número
                      TEM que ser removido ou reescrito (ex.: trocar por
                      "anos de atuação" ou "áreas de atuação") antes de
                      publicar para qualquer cliente real — nunca preencher
                      com um número de verdade também, mesmo que o
                      escritório tenha estatística própria de sucesso.
  7. FORMULÁRIO PHP   contact_email.php processa o form de contact.html via
                      AJAX (js/custom-scripts.js, url: "contact_email.php")
                      — só funciona com hospedagem PHP, a Vercel não roda.
                      free_quote_email.php está no pacote mas ÓRFÃO: nenhum
                      HTML nem JS chama esse arquivo — pode até ser
                      apagado. Sem backend, trocar a ação do
                      #contact-form por um link wa.me ou serviço de
                      formulário estático antes de publicar.
  8. AGENDAMENTO      appointment.html tem um formulário (.appoinment-form:
                      nome, e-mail, telefone, mensagem) mas SEM data/hora,
                      SEM action e SEM handler nenhum no custom-scripts.js —
                      diferente do contact.html, aqui o botão "enviar" não
                      faz absolutamente nada, nem tenta um POST. Não é
                      "agendamento" de verdade, é um form decorativo a mais.
                      Precisa de wa.me (ou serviço externo) igual ao
                      contact.html, e o nome "Book Appointment" no menu é
                      só rótulo — não confundir com sistema de agenda real.
  9. PÁGINAS DE TEMA  as 11 páginas element-appointment/counter/cta/
                      feedback/highlights/info-box/logos/pricing-table/
                      service/subscribe/team são vitrine de componente do
                      tema, sem conteúdo próprio do escritório — todas têm
                      título "Element X" e não vão pro menu real. Uma delas
                      (element-info-box.html) ainda tem o <title> vazado de
                      OUTRO template do mesmo pacote/autor ("Mobila Fixer -
                      Mobile Phone Service Center"), prova de que o
                      boilerplate é compartilhado entre nichos — não usar
                      nenhuma dessas 11 numa entrega de verdade, nem
                      coming-soon.html/404.html (utilitárias, sem menção ao
                      escritório).
 10. TEXTO            todo o corpo está em inglês, <html lang="en"> incluso
                      — trocar pra "pt-BR" e reescrever com o tom de voz do
                      identidade.md, não traduzir ao pé da letra.
 11. HOVER DOURADO    ver o cabeçalho deste script: os hex derivados
                      (#e4c378/#ce9b28/#a37b20) de hover não seguem a COR
                      nova automaticamente.
FIM
exit 0
