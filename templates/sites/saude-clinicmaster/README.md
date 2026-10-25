# Clínica de emagrecimento / nutrição — ClinicMaster

Template para clínica de emagrecimento, nutricionista, personal ou consultório
que vende programa/acompanhamento de perda de peso. 26 páginas, **base clara**
(branco + rosa-coral `#F0588D`→`#F79C86` em degradê + azul-marinho `#002E71`
nos títulos). Comprado como "ClinicMaster — Fat Loss & Weight Management
Tailwind CSS Template".

**Peso:** 39 MB em `html/` (a maior parte em `assets/images/` e `src/images/`)
· **Stack:** HTML estático + **Tailwind CSS 4** já compilado (não precisa de
Node/build pra usar) + Swiper + WOW.js (scroll reveal) · **Build:** nenhum
para uso — o `package.json` original só serve pra quem quiser reabrir o
projeto fonte no Tailwind CLI, não é necessário pra publicar o site

---

## Para que serve

Clínica de emagrecimento, nutricionista, personal trainer com programa de
perda de peso, consultório de endocrinologia focado em obesidade. Tem hero de
"transformação", grid de serviços, "sobre", equipe médica, depoimento,
formulário de agendamento e blog.

**Não serve** — ou serve mal — para clínica generalista (psicologia,
odontologia, estética sem foco em peso) — toda a copy e os ícones giram em
torno de emagrecimento. Para psicólogo/terapeuta, ver `saude-counseling` ou
`saude-mentalpress` nesta mesma leva.

## Armadilha de arquitetura (leia antes de tudo)

Isto é **Tailwind CSS 4**, mas não caiu em nenhum dos dois padrões já vistos
na biblioteca (nem "1 variável CSS central" do Handify, nem "2 variáveis" do
Qlinest). O pacote comprado é a fonte (`package/src/*.html`, com classes
Tailwind) mais uma build já rodada (`assets/css/style.css`, compilada via
`npx @tailwindcss/cli`). Duas coisas fora do comum:

1. **A cor "de marca" está em ~10 lugares, não em 1.** O tema tenta um
   sistema de "skins" de demonstração (`html[data-theme-color="skin-1"]` até
   `"skin-9"`, cada um com seu `--primary`), mas **todas as 26 páginas usam
   fixo `data-theme-color="skin-7"`** — os outros 8 blocos são sobra, nunca
   renderizados. Dentro do skin-7, só texto/ícone/fundo sólido seguem a
   variável `--primary`; **botão, cartão de serviço, tag e sombra de
   acordeão foram compilados com o hex cru** (`#F0588D`/`#EF578D` e o tom
   coral `#FF8C70`/`#F79C86`/`#FF9478` do degradê), sem passar por variável.
   Confirmado batendo screenshot antes/depois: só trocar `--primary` deixava
   ícone e texto na cor nova mas o botão "Appointment" continuava rosa.
   `personalizar.sh` por isso varre uma **paleta de ~10 tokens** (hex e RGB
   decimal, com e sem vírgula) em vez de 1 sed por variável — ver cabeçalho
   do script pra lista completa.
2. **Não tem `index.html` na raiz.** `assets/`, `elements/` e `src/` são
   pastas irmãs; a página inicial é `html/src/index.html`. Pior: alguns
   `background-image:url(../../src/images/...)` já vêm **gravados no CSS
   compilado**, relativos à posição de `assets/css/style.css` — mover ou
   renomear qualquer uma dessas 3 pastas quebra essas imagens de fundo sem
   como consertar a não ser re-buildando com o Tailwind CLI. Por isso a
   estrutura original foi mantida intacta em vez de "achatada" pro padrão
   `html/index.html` do resto da biblioteca.

## As páginas

Preview de 4 em [`preview/`](preview/) (`index`, `about-us`, `services`,
`contact-us`) — as outras seguem o mesmo grid/header/footer.

| Página | O que tem |
|---|---|
| `src/index.html` | Hero "Lose Weight, Gain Confidence" + CTA duplo · grid de serviços · sobre resumido · equipe · depoimento · CTA final |
| `src/about-us.html` | Sobre mais longo, números/estatística |
| `src/services.html` / `service-detail.html` | Lista de serviços em card e detalhe por serviço |
| `src/appointment.html` | Formulário de agendamento |
| `src/team.html` | Equipe médica em card |
| `src/testimonial.html` | Depoimentos em lista |
| `src/pricing-table.html` | Planos com preço fixo |
| `src/faqs.html` | Perguntas frequentes em acordeão |
| `src/contact-us.html` | Formulário de contato + telefone/redes fixos |
| `src/blog-grid.html` / `blog-grid-sidebar.html` / `blog-list-sidebar.html` / `blog-details.html` | Blog em grid, lista e post individual |
| `src/error-404.html` / `coming-soon.html` / `under-construction.html` | Páginas de utilidade |
| `src/audio-post.html`, `corner-post.html`, `gutenberg-post.html`, `header-image.html`, `link-post.html`, `post-gallery.html`, `post-slider.html`, `standard-post.html`, `video-post.html` | Formatos de post de blog (showcase de tema WordPress-like) — normalmente fora do escopo de um demo de captação |
| `elements/*.html` (~30 arquivos) | Folha de estilo do tema: grid, botões, cards, accordions soltos — referência visual, não são páginas de site |

## Como personalizar

```bash
templates/sites/saude-clinicmaster/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Troca a **paleta rosa/coral** (não é 1 variável — ver "Armadilha de
arquitetura" acima) pela cor recebida (tom principal) e por um tom claro
derivado dela (segundo estágio dos degradês), e preenche `[NOME DO CLIENTE]`
em título, logo-texto (onde é HTML, não SVG) e rodapé. **Não mexe** em:

- `--secondary` (`#002E71`, azul-marinho) — é cor de título/texto, fica fixa,
  mesma lógica do `--primary-color` quase-preto do Qlinest;
- os ~30 outros `--*-gradient` do CSS (banner, card, título, divisor) — são
  véus quase-brancos com uma pitada de rosa/creme, não a cor de marca; ver
  "Falta fazer na mão" no próprio script se destoar com cor fria.

## Armadilhas

- **Logo é SVG com o nome vetorizado E cor cravada.** `src/images/logo.svg`
  (2× por página) tem "ClinicMaster" desenhado como path (não é `<text>`) e
  o ícone de cruz usa o gradiente `#F0588D→#F79C86` cru — nem nome nem cor
  são alcançados pelo script. `src/images/logo.gif` (splash de carregamento)
  tem o mesmo problema. Trocar os dois arquivos pela logo real do cliente.
- **Fundo do hero fica rosado mesmo com outra cor.** O véu de fundo quase
  branco (`--banner-2-gradient`/`--banner-3-gradient`) tem uma pitada de
  rosa/creme fixa, não derivada da cor de marca — geralmente passa
  despercebido (é bem sutil), mas com cor fria de cliente (azul/verde) vale
  conferir se não destoa.
- **Créditos do rodapé já vieram limpos.** O link
  `href="https://themeforest.net/user/dexignzone"` (autor do tema) foi
  trocado por `href="#"` e o texto "DexignZone Theme. All Rights Reserved."
  virou "[NOME DO CLIENTE]. Todos os direitos reservados." — pré-processado,
  não precisa mexer.
- **E-mail fake usa domínio reservado.** Todos os `@example.com`
  (`clinicmaster@example.com`, `info@example.com` etc.) — domínio que nunca
  resolve de verdade, então vira `[NOME DO CLIENTE]@example.com` sem quebrar
  nada; ainda assim, trocar pelo contato real antes de publicar.
- **Formulário não funciona na Vercel.** `assets/script/contact.php`,
  `contact_smtp.php`, `mailchimp.php` (+ vendor PHPMailer) precisam de
  hospedagem com PHP. Trocar a ação do formulário por `wa.me` ou um serviço
  de formulário estático antes de publicar.
- **Promessa de resultado clínico é copy de vitrine.** Frases como "Lose
  Weight, Gain Confidence", percentuais e prazos de emagreciento nas páginas
  de serviço não são fato do cliente — em área de saúde isso é sensível
  (propaganda enganosa), reescrever como exemplo ilustrativo claramente
  marcado, nunca manter como promessa real.
- **Equipe, depoimento, preço e "12k+ avaliações"/"215 doctors" são
  inventados** — sem dado real do cliente, marcar como ilustrativo ou apagar
  a seção/página.
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra `pt-BR` e
  reescrever com o tom de voz do `identidade.md`, não traduzir ao pé da
  letra.
- **Entrada é `html/src/index.html`, não `html/index.html`** — ver
  "Armadilha de arquitetura" acima antes de mover qualquer pasta.
