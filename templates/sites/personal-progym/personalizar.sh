#!/usr/bin/env bash
#
# Cria uma cópia do template Progym já com a cor de marca e o nome do
# cliente trocados. O original em html/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> '#COR' "<Nome do Cliente>"
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#FF6A00' 'João Personal'
#
# O template tem UMA cor de acento só, via CSS custom property:
#   --accent-color: #9CFF1E (verde neon) — 107 usos em css/style.css, quase
#   todos por var(--accent-color). Trocar o valor da variável já recolore
#   botão, link ativo, ícone de destaque e linha decorativa em todas as 11
#   páginas. Há também 3 gradientes de borda (.border-accent-color-linear e
#   .border-accent-color-2) que escrevem o hex direto em vez de var() — o
#   script troca esses 3 também, via sed sobre o hex literal.
#
# NÃO mexe em (ficam como no original, não são cor de marca):
#   - --accent-color-2 (#D9D9D9, cinza claro) — usado no ícone do menu
#     hambúrguer e em detalhes neutros, não é cor de marca.
#   - --accent-color-3 (#2B2B2B) e --accent-color-4 (#1D1D1D) — cinza-escuro
#     de fundo de card/seção, servem de contraste sobre o --primary preto,
#     funcionam com qualquer cor de marca.
#   - --primary (#000000, fundo geral) e --text-color/--text-color-2 (quase
#     branco/cinza claro, texto) — não são cor de marca, são a base escura do
#     template.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/html"

COR_ORIGINAL='#9CFF1E'

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> '#COR' \"<Nome do Cliente>\"" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#FF6A00' 'João Personal'" >&2
  exit 1
fi
if ! [[ "$COR" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
  echo "erro: cor precisa ser hex de 6 dígitos, tipo '#FF6A00' (recebi '$COR')" >&2
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

CSS="$DESTINO/css/style.css"
echo "→ cor de acento (--accent-color e os 3 gradientes de borda): $COR_ORIGINAL → $COR"
sed -i "s/${COR_ORIGINAL}/${COR}/gI" "$CSS"

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

  1. LOGO          image/logo.png (header, todas as páginas) é PNG raster
                    com "PROGYM" desenhado dentro do arquivo — não é texto,
                    o script não alcança. Trocar pela logo real do cliente.
                    Tem Logo-1..5.png soltos em image/ (faixa "clientes
                    atendidos" da home) que são sobra do pacote original,
                    não referenciados em lugar nenhum do HTML — pode ignorar
                    ou apagar.
  2. FOTOS         todo image/dummy-img-WxH.jpg é placeholder cinza com a
                    dimensão escrita dentro (ex. "600x400") — 12 imagens ao
                    todo. Sem foto real do personal/aluno/espaço de treino,
                    o site fica com cara de maquete.
  3. E-MAIL        contact.html e o rodapé de todas as páginas tinham
                    "hello@domainsite.com" — já veio trocado por "[EMAIL]"
                    (não por [NOME DO CLIENTE], porque isso quebraria o
                    domínio) — preencher com o contato real ou apagar se o
                    cliente só usa WhatsApp. O "www.domainsite.com" exibido
                    em contact.html virou "[SITE]" pelo mesmo motivo.
  4. TELEFONE      "0761-8523-398" aparece fixo no rodapé de todas as
                    páginas e em contact.html — trocar por WhatsApp real ou
                    marcar "a confirmar".
  5. EQUIPE        team.html vem com nome, cargo e foto de treinador
                    inventados — sem gente real, apagar a seção/página ou
                    trocar por cargo genérico sem nome. Para personal
                    autônomo (1 profissional só), essa página provavelmente
                    não serve — considerar remover do menu.
  6. PROGRAMAS     program.html e program_detail.html vêm com 6 "programas"
                    de treino (nome, descrição, preço) inventados — sem
                    dado real do cliente, marcar como ilustrativo ou reduzir
                    para os serviços que o cliente realmente oferece.
  7. PREÇO         price_plan.html tem 3 planos com valor chutado — sem
                    tabela real do cliente, apagar a página ou marcar como
                    "a confirmar".
  8. DEPOIMENTO    os cards de depoimento na home têm nome, foto e nota
                    inventados — só usar com selo "ilustrativo" visível.
  9. BLOG          blog.html e single_blog.html vêm com posts de texto
                    genérico em inglês, autor "[NOME DO CLIENTE]" (era
                    "Rometheme", nome do estúdio que fez o template,
                    trocado junto por ser a mesma string) — geralmente não
                    serve pra demo de captação; considerar remover do menu.
 10. FORMULÁRIO    php/form_process.php só funciona com hospedagem PHP; a
                    Vercel não roda PHP. Sem backend, o formulário de
                    contact.html não envia nada — trocar a ação do <form>
                    por um link wa.me ou um serviço de formulário estático
                    antes de publicar.
 11. TEXTO         todo o corpo já veio com <html lang="pt-BR"> ajustado
                    neste template, mas o conteúdo em si ainda está em
                    inglês — reescrever com o tom de voz do identidade.md
                    do cliente, não traduzir ao pé da letra.
 12. REDES SOCIAIS os ícones do rodapé (Facebook/Twitter/Instagram/Youtube)
                    apontam pra href="#" — preencher ou remover os que não
                    existem.
FIM
exit 0
