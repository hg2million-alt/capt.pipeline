# Odontologia — Dentia (Next.js)

Template comprado "Dentia — Dentist & Dental Clinic" (2026), variante **Next.js**
do mesmo pack. Guardado em 26/09/2026 já limpo, buildado e testado.

**Stack: Next.js 16 (App Router) + React 19, TypeScript, sem Tailwind de
verdade (ver armadilha) · Peso: 22 MB (sem `node_modules`) · Build: `npm
install && npm run build` · Deploy: nativo na Vercel, framework detectado
sozinho, sem `vercel.json`.**

Existe uma **segunda versão do mesmo visual "Dentia" em PHP**, empacotada em
paralelo em `../odontologia-dentia-php/`. Mesma cara, dois motores diferentes.
**Esta pasta (Next.js) é a recomendada para deploy na Vercel** — é o
framework nativo da plataforma, build e preview automáticos, sem precisar de
runtime PHP nem de gambiarra de hospedagem. Use a versão PHP só se o destino
final for um host PHP tradicional (cPanel, servidor do próprio cliente etc.).

---

## Para que serve

Clínica ou consultório odontológico que quer site multi-página com sete
variações de home para escolher, cara de clínica família: hero com foto real
(banco de imagem, não silhueta), nota do Google como selo secundário, grade
de serviços com ícone, equipe/dentistas com bio, agendamento, FAQ,
depoimentos, contato. **Nasce claro** — fundo `#eaf0fc` (bege-azulado) nas
seções alternadas, branco no resto, acento azul `#4A7CD2` + dourado
`#EAA638`. Fonte arredondada tipo "Poppins Round"/Quicksand para títulos
(cheia de curvas, visual amigável — não serve para marca séria/corporativa).

Uma cor de acento + uma cor de acento 2 (usadas em gradiente), as duas
trocadas pelo `personalizar.sh` num arquivo só (ver "Onde fica a cor").

**Para que não serve:**

- **Marca séria, corporativa ou premium** (a fonte arredondada e os ícones de
  dente fofos entregam "clínica de bairro simpática", não "clínica de alto
  padrão" — para isso o `odontologia-decare/` da biblioteca, mais sóbrio,
  serve melhor)
- Cliente que não tem quem rode `npm install`/`npm run build` antes do
  deploy — isso NÃO é HTML estático que abre direto no navegador
- Demo de captação **sem foto do cliente**: ao contrário da maioria dos
  templates da biblioteca, este já vem com fotos reais de banco de imagem
  (não silhueta), o que ajuda a impressionar no primeiro contato — mas ainda
  não são fotos do cliente, então continuam sendo placeholder

## Páginas

Preview em [`preview/`](preview/) — desktop 1440px de cada página relevante e
`index-celular.jpg` em 390px.

| Página | Serve para demo? | Observação |
|---|---|---|
| `/` (`page.tsx`) | **Sim** | Home 1: hero com foto de família, nota do Google como selo abaixo do H1 (não é o destaque — certo por padrão), barra de contato/horário/e-mail logo abaixo |
| `/homepage-2` a `/homepage-7` | Só uma | Mesmo conteúdo abaixo do hero, hero muda (slider, vídeo, layout). Ficar com UMA, apagar as rotas das outras 6 e o submenu "Homepage 1..7" do header |
| `/about` | Sim | Sobre + "Professionals and Personalized Dental Excellence" + lista de diferenciais |
| `/services` | Sim | Grade de 6 serviços com ícone + 1 foto real no meio da grade |
| `/services/<slug>` (6 rotas) | Sim | Uma página por serviço (general/cosmetic/pediatric/restorative/preventive-dentistry, orthodontics) |
| `/dentists` | Só com equipe real | Bio de dentista fictício com credencial inventada: "Doctor of Dental Surgery (DDS), New York University College of Dentistry", prêmio "Top Dentist in Manhattan" — **não publicar como real, apagar ou marcar ilustrativo** |
| `/gallery` | Só com foto do cliente | Galeria com filtro (Dentists/Facilities/Services), 8 fotos de banco de imagem |
| `/booking` | Sim | Formulário de agendamento (serviço, data, hora) — sem destino real (ver Armadilhas) |
| `/contact` | Sim | Formulário de contato + horário + localização fake |
| `/faq` | Sim | Accordion por categoria (General Care / Cosmetic / Restorative / Insurance) |
| `/testimonials` | Só com depoimento real | Depoimentos inventados |
| `/blog`, `/blog/single` | **Não** | Post inventado |

---

## Como usar

```bash
cd templates/sites/odontologia-dentia-next
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1F6F54' 'Dra. Fulana'
cd /c/Dev/Captacao-CC/clientes/xyz/site
npm install
npm run dev      # http://localhost:3000, conferir antes de publicar
npm run build    # opcional: valida que builda; a Vercel builda sozinha no deploy
```

Argumentos do script: destino, **acento** e nome. **Acento 2** é opcional —
se não passar, o script deriva um tom mais claro do acento (gradiente de uma
cor só, discreto); passe explícito se quiser duas cores de marca de verdade
como no original (azul + dourado).

O script troca o arquivo de cor inteiro e faz `sed` de "Dentia" → nome do
cliente em `app/`, `components/`, `public/css/style.css` e
`public/js/on3step.js`. Testado em 26/09/2026 com verde `#1F6F54`: os quatro
valores do `scheme-01.css` saem certos, nome no `<title>`, no rodapé e no
menu lateral saem trocados, contagem de sobra dá 0.

**O script não roda `npm install` nem `npm run build`** — isso é sempre
manual, na pasta do cliente, depois de personalizar.

---

## Onde fica a cor

Diferente de quase todo o resto da biblioteca (hex espalhado por centenas de
linha), aqui a cor de marca mora **inteira em um arquivo de 6 linhas**:

```css
/* public/css/colors/scheme-01.css */
* {
  --primary-color: #4A7CD2;
  --primary-color-rgb: 74, 124, 210;
  --secondary-color: #EAA638;
  --secondary-color-rgb: 59, 157, 31;  /* bug do template: rgb não bate com o hex acima — o personalizar.sh sempre recalcula certo */
}
```

`public/css/style.css` consome essas 4 variáveis em ~100 pontos (62×
`var(--primary-color)`, 16× `var(--secondary-color)`, 41× as versões `-rgb`
dentro de `rgba()` para gradiente e opacidade). Trocar o arquivo de cima é
suficiente — não precisa tocar no CSS principal. `scheme-01.css` é carregado
por `<link id="colors">` direto no `app/layout.tsx`.

**O que continua na cor original, porque é imagem:** nenhum ícone de serviço
é PNG azul travado — são SVG inline (`icofont`) que já herdam a variável CSS.
A única cor fora do sistema é o logo (`logo-white.webp`/`logo-black.webp`,
que precisa virar o logo do cliente de qualquer forma) e as fotos de banco de
imagem.

---

## Armadilhas

- **`output: 'export'` no `next.config.ts`** — o projeto builda como site
  estático (gera `out/`), não como app Next com servidor. Isso não muda nada
  no deploy Vercel (ela builda e serve o Next.js normalmente, detecta o
  framework sozinho), mas **`next start` não funciona** para prévia local
  pós-build — use `npm run dev` (modo desenvolvimento, não usa `out/`) ou
  sirva `out/` com qualquer servidor estático (`npx serve out`) depois do
  build
- **`@tailwind base/components/utilities` em `app/globals.css` é resquício
  morto** — o projeto NÃO tem Tailwind instalado (não está no
  `package.json`, não há `tailwind.config`, nem `postcss.config`). Essas
  diretivas não fazem nada, o build não quebra por causa delas (confirmado:
  `npm run build` passa limpo), mas não adianta procurar classe `tw-` em
  lugar nenhum — todo o layout é Bootstrap 5 + CSS próprio com as variáveis
  acima
- **Prefetch do Next em 404 na prévia estática** — servindo `out/` com um
  servidor estático simples (não a Vercel, não `next dev`), o console mostra
  dezenas de 404 de arquivos `__next.<rota>.txt?_rsc=...`. É o Next tentando
  pré-buscar o payload de outras rotas ao passar o mouse no menu; a
  navegação em si funciona normal (carrega o HTML completo), é só ruído no
  console — não acontece rodando `next dev` nem em produção na Vercel
- **Sete homes quase idênticas** (`page.tsx` + `homepage-2` a `homepage-7`)
  — escolher uma cedo, porque o menu (`components/Header.tsx`) lista as
  sete em "Home ▾" e isso não faz sentido nenhum pro cliente final
- **Dois e-mails fake diferentes**: `contact@dentiacare.com` (na maioria das
  páginas) e `contact@dentiaclinic.com` (na barra de contato do hero da
  home) — são dois textos diferentes, grep por um só não pega o outro
- **EmailJS sem chave configurada** — `ContactForm.tsx` e `BookingForm.tsx`
  já vêm com fallback: sem `SERVICE_ID`/`TEMPLATE_ID`/`PUBLIC_KEY`
  preenchidos, o form abre um rascunho de e-mail (`mailto:`) em vez de
  quebrar. Funciona para demo, mas some se o cliente não tiver cliente de
  e-mail configurado no aparelho — trocar por link `wa.me` é mais confiável
  para o público de WhatsApp
- **Credencial profissional inventada em `/dentists`** — não é só nome
  fictício, é um currículo inteiro (universidade, certificação, prêmio de
  imprensa). Regra do workspace: nada inventado sem marcação de ilustrativo;
  aqui o risco é maior que depoimento porque parece credencial verificável
- Documentação original do autor (pasta `Documentation/` do zip, com CSS e
  imagens de instruções de instalação) e o `.git/` do projeto foram
  descartados na limpeza — não vieram para esta pasta

---

## Comparação com o resto da categoria

| | `odontologia-decare/` | `odontologia-dentia-next/` (este) | `odontologia-dentia-php/` (irmão) |
|---|---|---|---|
| Stack | HTML estático + Bootstrap 5 | **Next.js 16 + React 19** | PHP |
| Build | nenhum | `npm install && npm run build` | depende de host PHP |
| Deploy Vercel | direto, cria `vercel.json` | **nativo, framework detectado sozinho** | precisa de host com PHP, Vercel não roda PHP de forma nativa |
| Visual | sóbrio, azul+navy, sem foto | arredondado/amigável, azul+dourado, **com foto real de banco** | mesmo visual do Next.js (mesmo pack) |
| Cor de marca | ~30 hex espalhados em 4 arquivos CSS | **1 arquivo, 4 variáveis** | não verificado aqui — ver README da pasta PHP |
| Peso | 18 MB | 22 MB | não verificado aqui |

Para cliente que só quer o site no ar rápido na Vercel, **este (Next.js) é a
escolha padrão** entre os dois Dentia. A versão PHP só faz sentido se o
destino não for Vercel.

---

## Preview gerado

Rodado localmente em 26/09/2026: `npm install` (342 pacotes, ~51s) → `npm run
build` (Turbopack, 26 rotas, ~10s, sem erro) → servido com um Playwright
isolado (Chromium via `npx playwright install chromium`) para evitar
contaminação por outros templates rodando em paralelo no mesmo navegador
compartilhado do MCP. Nove capturas em `preview/`: `index`, `index-celular`
(390px), `about`, `services`, `contact`, `booking`, `gallery`, `dentists`,
`faq`.
