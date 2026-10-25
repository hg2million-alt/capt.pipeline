#!/usr/bin/env bash
#
# Cria uma cópia do template Dentia (Next.js) já com a cor de marca e o nome
# do cliente trocados. O original em src/ nunca é alterado.
#
#   ./personalizar.sh <pasta-destino> <#COR> "<Nome do Cliente>" [<#COR2>]
#
# Exemplo:
#   ./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1F6F54' 'Dra. Fulana'
#
# Diferente dos templates HTML da biblioteca: aqui a cor de marca mora inteira
# em UM arquivo, public/css/colors/scheme-01.css (4 variáveis CSS — cor e rgb
# de acento e acento 2), consumidas por rgba()/gradientes em 41 pontos de
# public/css/style.css. Não há Tailwind de verdade apesar do globals.css citar
# @tailwind (ver README) — não precisa mexer lá.
#
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEM="$AQUI/src"

DESTINO="${1:-}"
COR="${2:-}"
NOME="${3:-}"
COR2="${4:-}"

if [ -z "$DESTINO" ] || [ -z "$COR" ] || [ -z "$NOME" ]; then
  echo "uso: $0 <pasta-destino> <#COR> \"<Nome do Cliente>\" [<#COR2>]" >&2
  echo "ex:  $0 /c/Dev/Captacao-CC/clientes/xyz/site '#1F6F54' 'Dra. Fulana'" >&2
  exit 1
fi

hex_rgb()  { printf '%d, %d, %d' "$((16#${1:1:2}))" "$((16#${1:3:2}))" "$((16#${1:5:2}))"; }
clarear()  { printf '#%02X%02X%02X' $(( (16#${1:1:2} + 255*2) / 3 )) $(( (16#${1:3:2} + 255*2) / 3 )) $(( (16#${1:5:2} + 255*2) / 3 )); }

# Acento 2 sem valor: deriva um tom mais claro do acento (a dupla vira um
# gradiente de uma cor só, discreto). Passe explícito se quiser duas cores
# de marca de verdade (ex: azul + dourado, como no template original).
[ -z "$COR2" ] && COR2="$(clarear "$COR")"

for c in "$COR" "$COR2"; do
  if ! [[ "$c" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
    echo "erro: cor precisa ser hex de 6 dígitos, tipo '#1F6F54' (recebi '$c')" >&2
    exit 1
  fi
done

if [ -e "$DESTINO" ] && [ -n "$(ls -A "$DESTINO" 2>/dev/null)" ]; then
  echo "erro: '$DESTINO' já existe e não está vazia. Escolha outra pasta." >&2
  exit 1
fi

echo "→ copiando template para $DESTINO"
mkdir -p "$DESTINO"
cp -r "$ORIGEM/." "$DESTINO/"

echo "→ cor de marca: acento $COR · acento 2 $COR2"
cat > "$DESTINO/public/css/colors/scheme-01.css" <<CSS
* {
  --primary-color: $COR;
  --primary-color-rgb: $(hex_rgb "$COR");
  --secondary-color: $COR2;
  --secondary-color-rgb: $(hex_rgb "$COR2");
}
CSS

echo "→ trocando nome da marca (Dentia → $NOME)"
grep -rIl "Dentia" \
  "$DESTINO/app" "$DESTINO/components" \
  "$DESTINO/public/css/style.css" "$DESTINO/public/js/on3step.js" 2>/dev/null \
| while read -r f; do
  sed -i "s/Dentia/${NOME//\//\\/}/g" "$f"
done

restam=$(grep -rIo -e '#4A7CD2' -e '#EAA638' -e 'Dentia' \
  "$DESTINO/app" "$DESTINO/components" \
  "$DESTINO/public/css/style.css" "$DESTINO/public/js/on3step.js" 2>/dev/null | wc -l || true)

cat <<FIM

Pronto: $DESTINO
Ocorrências da cor/nome originais ainda presentes: $restam (esperado: 0). Isso
NÃO cobre "dentia" minúsculo dentro de contact@dentiacare.com/dentiaclinic.com
— esse é o item 5 da lista abaixo, de propósito fora do escopo do script.

Falta fazer na mão — o script não tem como adivinhar:

  1. INSTALAR    entrar em $DESTINO e rodar \`npm install\`. Sem isso não builda
                nem roda o dev server. Depois \`npm run dev\` (porta 3000) para
                conferir, ou \`npm run build\` (gera export estático em out/,
                por causa do output:'export' no next.config.ts).
  2. HOME         são sete (page.tsx, homepage-2 a homepage-7), quase iguais.
                Escolher UMA, apagar as rotas das outras em app/ e tirar o
                submenu "Homepage 1..7" de components/Header.tsx.
  3. PÁGINAS      blog, blog/single e o "pricing" embutido na home inventam
                dado (post, preço). testimonials e dentists têm depoimento e
                credencial fictícios (ex.: "Doctor of Dental Surgery (DDS),
                New York University", prêmio "Top Dentist in Manhattan") —
                apagar ou marcar como ilustrativo, nunca publicar como real.
  4. LOGO         public/images/logo-white.webp e logo-black.webp (header e
                rodapé) e public/favicon.ico. public/images/logo/1..10.png
                são logos de "parceiro" genéricos — apagar se não houver os
                do cliente.
  5. CONTATO FAKE  "100 S Main St, New York, NY", "+1 123 456 789",
                "contact@dentiacare.com" / "contact@dentiaclinic.com" (duas
                grafias diferentes!) aparecem em Footer.tsx, layout.tsx
                (menu lateral), contact/page.tsx e no rodapé de cada home.
                Grep e troca — o script não mexe nisso.
  6. FORMS        ContactForm.tsx e BookingForm.tsx usam EmailJS com chave
                vazia (\`YOUR_SERVICE_ID\` / strings vazias) — sem configurar,
                caem num fallback silencioso que abre um rascunho de e-mail
                (mailto:) para contact@dentiacare.com. Trocar por wa.me ou
                configurar o EmailJS de verdade antes de publicar.
  7. FOTOS        stock photo real (não silhueta) em quase toda página — mas
                é gente genérica de banco de imagem, não a equipe do
                cliente. Trocar pelas fotos reais quando existirem; senão
                deixar declarado que é ilustrativo.
  8. DEPLOY       é Next.js de verdade — \`vercel --prod\` na pasta detecta o
                framework sozinho, sem vercel.json. Projeto Vercel com slug
                do cliente (skill vercel-cliente-novo). Não precisa do
                out/export manual: a Vercel builda o Next.js nativamente.

FIM
