#!/usr/bin/env bash
#
# Cria uma cópia do template Quick Sale já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Imóveis XYZ'
#
# ATENÇÃO — este NÃO é um template de imobiliária com catálogo de vários
# imóveis. É um site de UM imóvel só ("single property" no <title> de toda
# página): hero com endereço e preço fixos, galeria, tour, agendamento de
# visita. Serve pra corretor destacar UM imóvel específico (lançamento,
# imóvel de luxo, "coming soon"), não pra imobiliária mostrar portfólio.
#
# O tema vem com um arquivo de "skin" próprio (css/general.css, com
# comentário "/* do not change */" no meio do CSS original, ver cabeçalho do
# arquivo) e usa TRÊS cores fixas, não uma:
#   #fa6839 (laranja) — classe .theme_accent: botão principal, seleção de
#     texto, hover de link. É A cor de marca "padrão" do tema.
#   #98bd15 (verde-limão) — classe .theme_accent_2: a barra do menu inteira
#     (faixa cheia sob o header) e alguns hovers. Visualmente tão forte
#     quanto o laranja (barra de menu ocupa a largura toda).
#   #1f9ad6 (azul) — classe .theme_accent_1: usado em detalhe menor (ícone
#     de destaque, dropcap, sombra de hover) — bem menos visível que os
#     outros dois.
# Trocamos JUNTOS #fa6839 e #98bd15 pela COR do cliente (é o que dá
# identidade visual: botão + barra de menu na cor da marca). #1f9ad6 fica
# FIXO como terciário — mudar os três pra mesma cor apaga a hierarquia
# visual do tema sem ganhar nada em troca.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL_1='#fa6839'
COR_ORIGINAL_2='#98bd15'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#1E7A4C' 'Imóveis XYZ'" >&2
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

echo "→ cor de marca (laranja $COR_ORIGINAL_1 + verde $COR_ORIGINAL_2): → $COR"
for f in "$DESTINO/css/general.css" "$DESTINO/css/main_style.css" "$DESTINO/css/main_shortcodes.css"; do
  [ -f "$f" ] || continue
  sed -i "s/${COR_ORIGINAL_1}/${COR}/gI; s/${COR_ORIGINAL_2}/${COR}/gI" "$f"
done

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIl '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/g" "$f"
done

restam=$(grep -rIoi -e "$COR_ORIGINAL_1" -e "$COR_ORIGINAL_2" -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html --include=*.css 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. NICHO           confirmar com o cliente que ele quer destacar UM imóvel
                     (é pra isso que o template serve) e não um catálogo —
                     se for catálogo, ver imoveis-lemanhouse ou
                     imoveis-domira na biblioteca.
  2. LOGO            images/logo/46x60.png é só um quadrado cinza com a
                     dimensão escrita dentro (nem é logo de verdade) — o
                     nome do cliente já vem como texto HTML ao lado (tag
                     <b> no menu, trocada pelo script) e não precisa de
                     imagem nenhuma. Se o cliente tiver uma marca de
                     verdade (mesmo que só um ícone), trocar essa imagem.
  3. ENDEREÇO/IMÓVEL "123 [NOME DO CLIENTE] Street, Chicago, IL 60606",
                     preço "\$599,000" e a foto/vídeo do imóvel são todos
                     inventados (o endereço original era um trocadilho com o
                     nome do tema, "123 QuickSale Street") — reescrever com
                     o endereço, preço e mídia reais do imóvel, ou marcar
                     como "ilustrativo".
  4. FOTOS/VÍDEO     zero foto real: hero e galeria usam
                     images/*_WxH_*.jpg / .png, tudo placeholder cinza com a
                     dimensão escrita dentro. Tem 1 vídeo de exemplo em
                     video/ (usado em homepage-video-tour.html) — também
                     genérico, sem o imóvel do cliente.
  5. E-MAIL          "info@yoursite.com" e "markus@yoursite.com" (contato de
                     um agente fictício chamado Markus) já vieram trocados
                     por "[EMAIL]" (56 ocorrências) — preencher com o
                     contato real ou apagar se só usa WhatsApp. O site
                     "httt://example.com" ao lado do e-mail do Markus é erro
                     de digitação do próprio tema — apagar a linha.
  6. FORMULÁRIO      appointment.html (agendar visita) e os formulários de
                     contato não têm backend funcional na Vercel — trocar a
                     ação por um link wa.me ou um serviço de formulário
                     estático antes de publicar.
  7. MENU "TOOLS"    pages-tools-idx.html, -shortcodes.html, -typography.html
                     e -support.html são páginas de documentação do autor do
                     tema (exemplo de shortcode, tipografia, suporte), não
                     conteúdo de imóvel — tirar esse submenu inteiro antes
                     de publicar. O link "Documentation" que apontava pra
                     doc/index.html (pasta de 46 MB, não copiada pra cá) já
                     foi neutralizado pra "#" nas 58 páginas pra não dar 404.
  8. GALERIA/BLOG    as ~35 páginas de gallery-*.html e blog-*.html são só
                     variações de layout do tema (grid, masonry, colunas) —
                     escolher UMA de cada tipo pro menu final e tirar o
                     resto, senão o menu fica gigante e sem sentido pra
                     imóvel único.
  9. TEXTO           todo o corpo está em inglês, <html lang="en"> incluso —
                     trocar pra pt-BR e reescrever com o tom de voz do
                     identidade.md do cliente, não traduzir ao pé da letra.
 10. PESO            7,8 MB em html/ — já tirados os 46 MB de doc/ (site de
                     documentação do tema) e 5,4 MB de custom_menu/ (código
                     do seletor de cor do tema, só referenciado comentado,
                     nunca carregado).
FIM
exit 0
