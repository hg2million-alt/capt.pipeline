# Estética / Salão — Hair Care

Template para salão de beleza, salão de cabelo, barbearia ou estúdio de
estética (maquiagem, unhas, tratamento facial/corporal). 7 páginas
curadas, **base clara** (branco + cinza-claro) com um único acento de cor
(lemon no original). Comprado como "HairCare — Beauty Salon & Barber HTML5
Template".

**Peso:** 8,9 MB em `html/` · **Stack:** HTML estático + Bootstrap 3 +
jQuery + `jquery-plugin-collection.js` (bundle com Owl Carousel, lightbox,
masonry, Google Maps init) + fontes auto-hospedadas · **Build:** nenhum

---

## Atenção antes de usar: este pack é um framework genérico, não um site pronto

O download original tinha **533 arquivos HTML** e um mega-menu com
centenas de links (layouts "boxed", "RTL", "dark", "magazine home",
"portfolio home", dezenas de shortcodes de documentação, 60+ variações de
Revolution Slider). É um framework multiuso de ThemeForest reskinado pra
"salão", não um site de salão desenhado do zero — o `index.html` original,
por exemplo, era uma página de **documentação** listando todas as variações
do tema, não uma homepage.

Esta pasta já é o resultado da curadoria: **7 páginas** foram escolhidas,
renomeadas, tiveram o mega-menu de ~770 linhas trocado por uma navegação
enxuta de 7 itens, e tiveram conteúdo de documentação (grids de galeria
repetidos 9x, 3 estilos de equipe duplicados) cortado até sobrar 1 versão de
cada. Isso já está feito — não precisa refazer — mas é bom saber que o
volume gigante do pacote original não é sinal de riqueza de conteúdo, é
sinal de que era uma vitrine de recursos do framework.

**Este pack também tinha lixo de terceiro embutido de fábrica**, já
neutralizado nesta cópia (ver Armadilhas): um formulário de newsletter que
postava pro Mailchimp *do autor original*, um widget de Twitter puxando a
conta @Envato (o marketplace), e uma API key do Google Maps que também é do
autor original (essa ainda está lá — não dá pra gerar uma nova sem conta do
cliente, ver Armadilhas item 3).

## Hair Care × Trimly (barbearia já existente na biblioteca)

Este template **compete diretamente** com `barbearia-trimly/` no mesmo
nicho amplo (salão/barbearia) — a sobreposição é real, não é uma
diferenciação forçada:

- **Trimly é a opção melhor na maioria dos casos.** Foi curado de um pack
  já orientado a barbearia/salão de verdade (30 páginas originais, sem lixo
  de framework genérico), o `personalizar.sh` já resolve claro↔escuro e
  troca tipografia pra serifada, o formulário de agendamento já monta um
  link `wa.me` funcional sem depender de PHP, e já foi testado num cliente
  real de barbearia.
- **Hair Care só vale a pena se o gap for maquiagem/unhas/estética.** A
  única coisa que este template tem e o Trimly não tem de forma nativa é
  uma página de "Services" com ícones prontos pra **Make Up, Nails Design e
  Beauty Services** (ver `css/flaticon-set-salon.css`) — se o cliente for
  salão que vende esses serviços como carro-chefe (não corte/barba), Hair
  Care encaixa melhor de cara. Fora isso, é estritamente inferior: os
  formulários dependem de PHP (não roda na Vercel, contra o `wa.me` pronto
  do Trimly), a página de equipe e a galeria vieram de documentação de
  shortcode e precisaram de poda manual, e tinha três integrações de
  terceiro (Mailchimp, Twitter, Maps) vazando pro cliente errado.

**Recomendação:** usar `barbearia-trimly` como primeira opção pra qualquer
barbearia/salão de cabelo. Só puxar este Hair Care se o serviço principal do
cliente for maquiagem, unhas ou estética facial/corporal — ou se o cliente
já tiver aprovado especificamente o visual deste pack.

## Para que serve

Salão de beleza, salão de cabelo, estúdio de maquiagem/unhas/estética.
Tem hero, seção "sobre" com horário de funcionamento, tabela de preços,
formulário de agendamento embutido na home, prévia de equipe, prévia de
clientes atendidos (placeholder), galeria de fotos, página de serviços com
ícones (make up / unhas / beleza), página de equipe e contato com mapa.

**Não serve** — ou serve mal — para barbearia clássica (usar `barbearia-
trimly`, ver comparação acima) nem para quem precisa de agendamento online
de verdade com confirmação automática (aqui o formulário só existe se
alguém hospedar o PHP — não roda na Vercel, ver Armadilhas).

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `services`,
`gallery`, `team`).

| Página | O que tem |
|---|---|
| `index.html` | Hero em tela cheia · horário de funcionamento + texto de boas-vindas · faixa de estatísticas (inventadas) · tabela de preços (4 pacotes, valor chutado) · formulário de agendamento embutido (`includes/reservation.php`) · prévia de galeria · prévia de serviços · carrossel "Our hair Expert" (equipe, 5x o mesmo nome fictício) · faixa de logos de clientes (placeholder) |
| `about.html` | Sobre mais longo, repete blocos de serviço/horário |
| `services.html` | 3 cards de serviço com ícone (Make Up, Nails Design, Beauty Services) + seção de features + estatística |
| `gallery.html` | Grid de 8 fotos-placeholder, 4 colunas (o original tinha o mesmo álbum repetido em 9 variações de coluna — cortado pra 1) |
| `team.html` | 4 cards de equipe (o original tinha 3 estilos duplicados do mesmo shortcode — cortado pra 1) |
| `booking.html` | Formulário de agendamento como página própria (`includes/appointment.php`) |
| `contact.html` | Info de contato + mapa do Google (com API key do autor original, ver Armadilhas) + formulário (`includes/sendmail.php`) |

## Como personalizar

```bash
templates/sites/estetica-haircare/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

A cor de marca não é uma CSS custom property (como no Handify) — é um hex
repetido dentro de `css/colors/theme-skin-lemon.css` (146 usos sólidos + 24
em `rgba()`) mais 1 uso solto em `css/style-main.css`. O script troca os
dois arquivos e recalcula o `rgba()` a partir do novo hex. **Não mexe** nos
~14 tons derivados (hover/gradiente) pré-calculados pelo autor a partir do
lemon original — ficam com um matiz levemente diferente da cor nova; ver
cabeçalho do script.

## Armadilhas

- **Logo é imagem, com nome E cor de ícone travados no PNG.**
  `images/logo-wide.png` (cabeçalho das páginas internas) e `images/logo-
  wide-white.png` (home + rodapé de todas as páginas) têm "HAIR CARE"
  desenhado como texto raster e um ícone de folha na cor lemon original —
  o script não alcança nem o nome nem a cor do ícone. Trocar os 2 arquivos
  pela logo real. `logo-wide@2x.png`/`logo-wide-white@2x.png` existem mas
  não são referenciados em HTML nenhum — sobra, pode apagar.
- **Placeholder de imagem trocado de serviço.** O pack original usa
  `http://placehold.it`, que está **fora do ar** (retorna 403). Esta cópia
  já trocou tudo para `https://placehold.co` (ativo) só para não publicar
  com imagem quebrada — mas continua sendo placeholder cinza com a
  dimensão escrita dentro, não foto nenhuma.
- **Google Maps com API key do autor original.** `contact.html` carrega o
  mapa com uma key de terceiro embutida no pacote comprado — não é
  placeholder inofensivo, é uma credencial de outra conta que pode parar de
  funcionar (restrição de domínio) a qualquer momento. Trocar pela key do
  cliente ou de uma conta própria antes de publicar.
- **Newsletter e Twitter feed apontavam pra fora.** O formulário
  "Subscribe" do rodapé (7 páginas) postava pro Mailchimp ao vivo do autor
  original (`thememascot.us9.list-manage.com`) — já neutralizado nesta
  cópia. Um widget de feed do Twitter (5 páginas) puxava a conta `@Envato`
  (o marketplace) — já trocado pelo placeholder
  `[INSTAGRAM_OU_TWITTER_DO_CLIENTE]`. Sem conta/ESP real do cliente,
  remover os dois em vez de deixar apontando pra ninguém.
- **3 formulários em PHP que não rodam na Vercel** —
  `includes/reservation.php` (home), `includes/appointment.php`
  (`booking.html`) e `includes/sendmail.php` (`contact.html`). Trocar a
  ação de cada `<form>` por `wa.me` ou um serviço de formulário estático
  antes de publicar.
- **Equipe 100% fictícia e repetida.** `team.html` tem 4 cards com o mesmo
  nome ("Hasan Jacobson") e o mesmo cargo ("Businessman" — nem é vocabulário
  de salão, sobrou de um reskin genérico do framework). O carrossel "Our
  hair Expert" da home repete "Steve Smith / Master, English" 5 vezes. Sem
  equipe real, trocar por cargo genérico sem nome, nunca inventar um nome
  novo.
- **Preço, estatística e depoimento de cliente inventados.** A seção
  Pricing da home tem 4 pacotes com valor chutado (ex. "Woman's Haircut
  $80"); a faixa de estatísticas tem "754 Happy People", "984 People
  Likes", "106 Award Won", "469 Cup Of Coffee"; a faixa de "clientes
  atendidos" é 8 logos placeholder sem marca nenhuma. Apagar cada seção sem
  dado real, nunca preencher no chute.
- **Sobra de reskins anteriores do mesmo framework genérico**, já corrigida
  nesta cópia: o popup do mapa dizia "CharityFund Office" (virou
  `[NOME DO CLIENTE]`), a home tinha "Welcome to the salonZone" e "Join our
  gymzone club" (reescritos), o endereço fake do rodapé citava "Envato
  Labs" (virou "endereço fictício"). O `<meta name="keywords">` de todas as
  páginas ainda lista "building,business,construction,cleaning,transport,
  workshop" — sobra do mesmo framework, irrelevante pra SEO hoje, não foi
  tocado.
- **E-mail, endereço e telefone fictícios.** `contact@yourdomain.com` e
  `you@yourdomain.com` já viraram `[EMAIL]` nesta cópia (o domínio não
  deriva do nome do tema, então um replace pelo nome do cliente não ia
  quebrar isso — marcar só deixa óbvio que é fake). Endereço
  ("203, Behind Alis Steet, Melbourne, Australia" no rodapé; "121 King
  Street, Melbourne Victoria 3000 Australia" em `contact.html` e no pino do
  mapa) e telefones ("123-456-789", "+262 695 2601") continuam fictícios,
  sem marcador — preencher com dado real ou "a confirmar".
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra `pt-BR` e
  reescrever com o tom de voz do `identidade.md`, não traduzir ao pé da
  letra.
- **Top bar com links mortos.** As 6 páginas internas têm uma barra
  superior com "FAQ | Help Desk | Support" apontando pra `href="#"` — não
  existem essas páginas neste template curado. Remover ou trocar por
  Instagram/WhatsApp antes de publicar.
