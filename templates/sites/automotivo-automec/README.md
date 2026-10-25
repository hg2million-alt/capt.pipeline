# Automotivo — Automec

> **Este template é REACT (Vite + TypeScript), não HTML estático.** É o único
> da biblioteca até agora que funciona assim — todos os outros 33 abrem
> direto no navegador. Aqui, depois de copiar com `personalizar.sh`, ainda é
> preciso `npm install` e `npm run dev` (ou `npm run build`) antes de ver
> qualquer coisa. Ver "Como usar" abaixo.

Template "Automec — Car Service & Repair React Template" comprado. Nicho:
oficina, estética automotiva, funilaria, revisão, lava-jato — serviço, não
venda de veículo.

**Peso:** ~15 MB (11 MB são as fontes Font Awesome — Pro completo, 6 pesos —
e a webfont Yantramanav) · **Stack:** React 18 + TypeScript + Vite 6 +
Bootstrap 5 (CSS) + Sass (só como referência, ver abaixo) · **Build:**
`npm install && npm run build`

---

## Para que serve

Serviço automotivo: oficina mecânica, funilaria/pintura, estética automotiva,
lava-jato, revisão, troca de óleo. 2 homes, mais páginas internas de
serviços, projetos (portfólio de trabalhos), equipe, blog e contato — ver
"Páginas" abaixo.

## Para que NÃO serve

- **Revenda/concessionária/aluguel de carro** — isso é o nicho do
  `automotivo-carlink` (catálogo de veículo, busca por marca/modelo, ficha
  técnica). Automec não tem nenhuma dessas seções; é site de serviço, com
  "Projects" no lugar de catálogo (funciona melhor como portfólio de
  trabalhos feitos — carro antes/depois — do que como estoque).
- Cliente que só quer abrir uma pasta e publicar sem instalar nada. Se isso
  for um bloqueador, considere adaptar o `automotivo-carlink` mesmo fora do
  nicho ideal, ou orçar o tempo de build neste.

## As 2 homes

Preview de cada uma em [`preview/`](preview/).

| Arquivo/rota | O que é |
|---|---|
| `Home1.tsx` (`/`) | Hero dividido em blocos com efeito de destaque, cartão de estatísticas sobreposto (clientes, equipe, prêmios, avaliações) |
| `Home2.tsx` (`/home-2`) | Hero mais simples, foco em CTA de orçamento |

## Páginas internas

`about` (`/about`) · `services` (`/services`) + `service-details/:id` ·
`projects` (`/projects`) + `project-details/:id` (portfólio de trabalhos) ·
`team` (`/team`) + `team-details/:id` · `blog` (`/blog`) + `blog-details/:id`
· `contact` (`/contact`)

Rotas definidas em `app/src/Routers.tsx`.

---

## Como usar

```bash
cd templates/sites/automotivo-automec
./personalizar.sh /c/Dev/ClienteX/site '#0EA5E9' 'Cliente X'
cd /c/Dev/ClienteX/site
npm install
npm run dev      # http://localhost:5173 — conferir localmente
npm run build    # gera dist/ — isso é o que sobe pro Vercel (framework Vite)
```

O `personalizar.sh` copia o template pra pasta destino e troca:

- **A cor de marca** — `#EB3300` (hex sólido, 199 usos) **e** os 4
  `rgba(235, 51, 0, <alpha>)` que aparecem em overlays/sombras. Os dois
  precisam ser trocados juntos, senão sobra laranja translúcido por trás da
  cor nova.
- **O nome "Automec"** — no `<title>` (via Helmet em `App.tsx`), no
  copyright do rodapé e nos comentários de cabeçalho do CSS.

`node_modules/`, `dist/` e `tsconfig.app.tsbuildinfo` nunca são copiados nem
ficam no template guardado — o script já limpa isso se sobrar.

Depois disso, o script lista o que falta fazer na mão (logo, escolha de home,
textos, contato, redes). A lista completa está no final da saída do
`personalizar.sh` e repetida em "Armadilhas" abaixo.

Na Vercel, o projeto é detectado automaticamente como Vite — não precisa
configurar build command manualmente, mas confirme que o **Root Directory**
aponta pra pasta onde está o `package.json` (a raiz da cópia, não `src/`).

---

## Onde fica a cor de marca

**Não é `tailwind.config.js`, não é `:root` — o template não usa nem
Tailwind nem CSS custom properties.** A cor está chumbada em dois arquivos
CSS já compilados que o app importa direto:

- `app/src/assets/css/style.css` — 198 ocorrências
- `app/src/assets/css/custom.css` — 1 ocorrência

Existe também `app/src/assets/sass/_variables.scss` com
`$primary-color: #EB3300`, mas **isso é decorativo** — `sass` não está nem
nas dependências do `package.json`, e `App.tsx` importa
`src/assets/css/style.css` diretamente, não um `.scss`. Editar o `.scss` não
muda nada no site rodando. O `personalizar.sh` troca a cor nos dois lugares
(scss e css compilado) por consistência, mas o que importa de verdade é o
CSS.

Nenhum componente `.tsx` tem hex de cor inline — todos os componentes usam
classes CSS (`background-primary`, `text-primary`, etc.) que apontam pro CSS
compilado acima.

---

## O que já foi limpo daqui

- `documentation/` inteira (pasta de documentação estilo ThemeForest/Envato,
  com screenshots de cPanel, FTP e instruções de instalação do autor) —
  removida
- `README.md` original (era o boilerplate genérico "React + TypeScript +
  Vite" do `create-vite`, sem nada específico do template) — substituído por
  este
- `node_modules/`, `dist/`, `.git/`, `__MACOSX/`, `.DS_Store` — nenhum
  desses veio no zip, mas o `personalizar.sh` remove de qualquer cópia por
  garantia
- **Não havia** arquivo `LICENSE`, texto "Regular License" nem qualquer
  menção a Envato/ThemeForest fora da pasta `documentation/` já removida —
  não sobrou nada de licença ou atribuição ao autor pra limpar
- **Não havia** chave de API exposta nem endpoint de formulário externo —
  todos os `<form>` (orçamento, contato, newsletter, comentário de blog)
  apontam pra `action="#"`, sem backend de terceiro. Diferente do
  `arquitetura-axisbuilt`, aqui não tem nada pra trocar nesse quesito além do
  próprio conteúdo

## O que ficou (documentado, não removido — é conteúdo de demo, não risco)

- Redes sociais do rodapé (`SocialShare.tsx`) linkam pra `facebook.com`,
  `twitter.com`, `linkedin.com`, `pinterest.com` genéricos — não são contas
  do autor original, mas também não são do cliente. Trocar antes de publicar
- Endereço "Dhaka", telefone "+88 0123456789" e e-mail
  "info@exampleyourmail.com" são placeholder de demo, não dado inventado
  atribuído a alguém real
- Mapa embutido (`ContactMap.tsx`) mostra Los Angeles via iframe simples do
  Google Maps, sem chave de API — funciona, mas mostra o lugar errado até
  trocar as coordenadas

---

## Armadilhas

**Logo é PNG com o nome desenhado dentro.** `public/images/logo/logo.png`,
`logo-white.png` e `favicon.png` têm "Automec" + ícone de engrenagem
vetorizados na imagem — não é texto HTML, não sai em find/replace de nome.
Precisa substituir os arquivos pelo logo real do cliente (mesmo padrão já
visto em outros templates da biblioteca: PNG com nome embutido).

**Hero é placeholder com a dimensão escrita dentro.** As duas homes usam uma
imagem cinza no hero com "534x722" impresso nela (estilo
`via.placeholder.com`, mas embutida como arquivo local, não busca URL
externa). Trocar por foto real antes de publicar — ver nota da skill sobre
PNG/placeholder enganando no preview.

**Um <title> só para o site inteiro.** Diferente dos templates HTML da
biblioteca (que têm `<title>` por página), aqui o título é definido uma
única vez via `react-helmet-async` em `App.tsx`, fora do sistema de rotas.
Não há título por página — se isso importar para SEO, precisa adicionar
`<Helmet>` dentro de cada página em `src/pages/`.

**Imagem de fundo quebrada por caminho relativo errado.** Em
`src/assets/css/style.css` (linha ~4973), o fundo do card de depoimento
estilo 2 usa `url("../../images/section-bg/testimonial-two-bg.png")` — um
caminho relativo ao próprio arquivo CSS (`src/assets/css/`), que resolve pra
`src/images/section-bg/...` e não existe aí. A imagem real está em
`public/images/section-bg/testimonial-two-bg.png`. O Vite avisa isso no
build ("didn't resolve at build time") mas não falha — o fundo simplesmente
não carrega no navegador. Corrigir pra `url("/images/section-bg/testimonial-two-bg.png")`
antes de publicar se essa seção de depoimento for usada.

**Fontes pesam 11 MB dos ~15 MB do template.** É o Font Awesome Pro completo
(6 pesos: solid, regular, light, thin, duotone, brands) mais a webfont
Yantramanav. Se o cliente final não precisar de ícones duotone/thin/light,
dá pra cortar bastante — mas isso é decisão por cliente, não algo que o
`personalizar.sh` faz automaticamente (cortar peso de fonte errado quebra
ícone usado em outra página).

**Build gera um chunk JS de ~680 KB e CSS de ~1 MB** (avisos do Vite no
`npm run build` sobre "chunks larger than 500 kB"). Funciona, mas não foi
otimizado com code-splitting — não é bug, é característica do template como
comprado.

**`npm audit` acusa 22 vulnerabilidades** (3 low, 4 moderate, 15 high) nas
dependências do template no momento em que isso foi empacotado (26/09/2026).
Não foi rodado `npm audit fix` porque isso pode quebrar versões fixadas no
`package-lock.json` sem teste — se for publicar em produção de verdade (não
só demo), vale rodar `npm audit` de novo no cliente e avaliar.

---

## Preview

Gerado com `npm run dev` + Playwright, servidor local, viewport 1440×900,
cor original do template (antes de qualquer `personalizar.sh`):

| Arquivo | Página |
|---|---|
| `home-1.jpg` | Home 1 (`/`) |
| `home-2.jpg` | Home 2 (`/home-2`) |
| `about.jpg` | Sobre (`/about`) |
| `services.jpg` | Serviços (`/services`) |
| `contact.jpg` | Contato (`/contact`) |

Páginas de detalhe (`service-details`, `project-details`, `team-details`,
`blog-details`) e as listagens de `projects`, `team` e `blog` não têm preview
— menos centrais pro caso de uso (oficina/lava-jato vendendo serviço, não
portfólio de conteúdo). Rodar `npm run dev` localmente pra ver as demais.
