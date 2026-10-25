#!/usr/bin/env bash
#
# Cria uma cópia do template Hairbarber já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR_ACCENT' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#B48E40' 'Barbearia XYZ'
#
# Só existe UM parâmetro de cor porque o template inteiro depende de uma
# única CSS custom property (--primary-color, em assets/sass/style.css,
# ~156 usos) — não tem fundo alternado nem modo escuro/claro como o Trimly,
# então não há "FUNDO1/FUNDO2" pra passar. O template nasce claro (fundo
# branco/creme) e não foi construído aqui um inversor pra escuro; se um
# cliente pedir base escura, é trabalho manual ou usar o barbearia-trimly/
# no lugar (esse sim já tem modo escuro pronto).
#
# O script também sempre:
#  - preenche o nome do cliente em [NOME DO CLIENTE] (title de cada página,
#    headline "Welcome to Our [NOME DO CLIENTE]" nas 3 homes, rodapé);
#  - não mexe em fonte — o template já nasce com título em "Arima Madurai"
#    (cursiva/script, efeito vintage-barbershop) e corpo em "Arimo" (sans);
#    ao contrário do Trimly (Teko condensada, pede troca quase sempre), essa
#    combinação já costuma servir pra barbearia sem ajuste. Se o cliente
#    quiser título sem serifa/script, trocar a var --heading-font na mão.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR_ACCENT' \"<Nome do Cliente>\"" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#B48E40' (recebi '$COR')" >&2; exit 1
fi
if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2; exit 1
fi

escapar() { printf '%s' "$1" | sed -e 's/[\/&]/\&/g'; }

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

CSS="$DESTINO/assets/sass/style.css"

echo "→ cor de destaque (--primary-color): #B48E40 → $COR"
sed -i "s/--primary-color: #B48E40;/--primary-color: ${COR};/" "$CSS"

echo "→ preenchendo o nome do cliente"
NOME_ESC="$(escapar "$NOME")"
grep -rIli '\[NOME DO CLIENTE\]' "$DESTINO" | while read -r f; do
  sed -i "s/\[NOME DO CLIENTE\]/${NOME_ESC}/gI" "$f"
done

restam=$(grep -rIoi -e '\[NOME DO CLIENTE\]' "$DESTINO" --include=*.html 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências de [NOME DO CLIENTE] ainda presentes: $restam (esperado: 0)

Falta fazer na mão — o script não tem como adivinhar:

  1. LOGO         assets/img/logo.png (header, fundo transparente) e
                  logo-2.png (variante da home 2, mesmo desenho). É um ícone
                  genérico de tesoura+pente dourado — se o cliente tiver logo
                  própria, ela troca as duas; se não tiver, o ícone genérico
                  já é seguro de usar (não tem nome nenhum desenhado dentro).
  2. FOTOS        TODAS as imagens de about/, avatar/, bg/, features/,
                  products/, team-*.jpg, testimonial.jpg, working*.jpg,
                  banner.png são placeholder cinza com a dimensão escrita
                  dentro (ex.: "1920x950", "600x600") — apesar de as pastas
                  terem nome de foto de verdade (about, gallery, team...),
                  NENHUMA é imagem real, ao contrário do que os nomes de
                  pasta sugerem. Sem fotos reais do cliente, o site fica com
                  cara de maquete cinza. Ver a nota ENQUADRAMENTO no README.
  3. VÍDEO        o botão de play do hero/seção "Working Hours" (index.html,
                  index-2.html, index-3.html) abre um vídeo do YouTube de
                  terceiro (não é do cliente, não é do autor do template
                  pessoalmente, mas também não é ninguém relacionado ao
                  negócio) — trocar pelo vídeo real do cliente ou remover o
                  botão antes de publicar.
  4. EQUIPE       team.html tem 8 cards com nome inventado (Marcus Silva,
                  Rafael Costa, Camila Souza, Bruno Almeida, Lucas Pereira,
                  Diego Martins — 6 barbeiros — mais Pedro Henrique e Carla
                  Mendes, que na verdade são os 2 depoimentos da mesma
                  página, não equipe). Sem nome real, trocar por cargo
                  genérico ("Barbeiro") sem nome — nunca inventar outro nome.
  5. DEPOIMENTO   os depoimentos de index.html, index-2.html, index-3.html e
                  team.html (Pedro Henrique, Carla Mendes, Camila Souza,
                  Bruno Almeida) são texto e nota fictícios — o texto em si
                  ("Proin vel ipsum...") nem chega a ser copy de verdade, é
                  lorem ipsum. Marcar como ilustrativo, nunca como real.
  6. PREÇO        product-page.html, product-details.html, cart.html e
                  checkout.html têm preço chutado por produto (era pra
                  vender item de grooming — pomada, óleo de barba etc.). Sem
                  tabela real do cliente, apagar a seção de loja inteira (ver
                  nota LOJA no README) em vez de estimar valor de mercado.
  7. CONTATO      rodapé, cabeçalho e contact.html ficam com [WHATSAPP],
                  [EMAIL], [ENDERECO] e [HORARIO] como placeholder (inclusive
                  dentro de link https://wa.me/ e mailto:). Enquanto o
                  WhatsApp real não chega, trocar por algo que não quebre em
                  vez de deixar um wa.me/[WHATSAPP] cru na tela.
     MAPA         o iframe do Google Maps em contact.html aponta pra um
                  embed genérico de Nova York — trocar pelo embed real do
                  endereço do cliente (Google Maps → Compartilhar → Incorporar
                  um mapa) antes de publicar.
  8. TEXTO        corpo em inglês (menos nav/rodapé/formulário/contato, já em
                  pt-BR) — bastante dele é lorem ipsum em latim mesmo (não é
                  nem inglês fraco, é texto de preenchimento puro). Reescrever
                  com o tom de voz do identidade.md do cliente, não é tradução
                  literal.
  9. LOJA         cart.html, checkout.html, product-page.html e
                  product-details.html simulam uma lojinha de produto
                  (carrinho, quantidade, "finalizar compra") mas NENHUM botão
                  processa pagamento de verdade — é só front-end. Só faz
                  sentido publicar essas 4 páginas se o cliente realmente
                  vende produto de balcão (pomada, shampoo, óleo de barba) E
                  o time entender que o "checkout" não cobra ninguém. Caso
                  contrário, cortar as 4 páginas e os links "Shop" do menu —
                  ver "Bloco de template sem uso não entra no demo" na
                  memória do workspace.
 10. QA VISUAL    abrir em navegador de verdade antes de publicar — grep não
                  pega imagem cinza de placeholder nem contraste ruim; ver
                  README pra a lista completa do que já foi limpo x o que
                  ainda depende de material do cliente.
FIM
exit 0
