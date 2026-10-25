# Estética / Salão — Spa Magic

Template para spa, salão de beleza ou estúdio de bem-estar. 10 páginas
curadas, **base escura no topo + seções claras** (cinza-escuro no header/
hero/banners, creme claro no corpo), com um único acento rosa no original.
Comprado como "Spa Magic — Spa, Hair & Beauty Salon Landing Page Template".

**Peso:** 5,5 MB em `html/` · **Stack:** HTML estático + Bootstrap 4 +
jQuery + wsmenu (mega-menu), Owl Carousel, FlexSlider, Isotope (filtro de
galeria), TweenMax, `jquery.datetimepicker` (campo de data/hora do
agendamento) · **Build:** nenhum

---

## Qualidade do pack de origem

Ao contrário do `estetica-haircare` (curado de um framework multiuso
genérico com centenas de páginas de documentação), o Spa Magic é um
template **feito para spa/salão de verdade**: 30 páginas no original, todas
com conteúdo do nicho (nenhuma página de "shortcode" ou "layout variation"
misturada), formulários já organizados por função (`contactForm.php`,
`bookingForm.php`, `heroForm.php`, `commentForm.php`) e uma paleta de 4
temas prontos (pink/gold/rose/silk — cada um é o mesmo CSS completo com o
acento trocado). Desta cópia curada ficaram de fora: as 12 variações de
home (`demo-2` a `demo-12` — ficou só a `demo-1`, renomeada `index.html`),
o blog (`blog-classic.html`, `blog-masonry.html`, `blog-sidebar.html`,
`single-post.html` — nenhuma citação de blog sobrou nas páginas mantidas,
inclusive a prévia "Our Blog" que existia na home foi removida) e
`service-details.html` (a versão "1 serviço, 1 página" — `services.html`
já cobre a lista completa).

Mesmo assim, o pack **também tinha uma integração viva com o Mailchimp do
autor original** embutida em `js/custom.js` (`dsathemes.us3.list-manage.
com`) — já neutralizada nesta cópia (ver Armadilhas). Isso é comum em
templates comprados: sempre conferir `custom.js`/`main.js` por URLs de
terceiro antes de publicar qualquer template novo, mesmo um bem
comportado como este.

## Para que serve

Spa, clínica de estética, salão de beleza com portfólio de massagens/
terapias/tratamentos, agendamento online (formulário com campo de data e
hora), venda de gift card, tabela de preço por serviço e FAQ.

**Não serve** — ou serve mal — para barbearia clássica (ver
`barbearia-trimly`, template padrão da biblioteca pra esse nicho) nem para
quem precisa que o formulário de agendamento envie de verdade sem
hospedagem própria (os 4 formulários do pack são em PHP — não rodam na
Vercel, ver Armadilhas).

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `services`,
`gallery`, `pricing`).

| Página | O que tem |
|---|---|
| `index.html` | Hero com slider de 3 imagens · seção de boas-vindas com horário · prévia de serviços (ícone) · banner de desconto de primeira visita · prévia de tratamentos · prévia de galeria filtrável · prévia de preços · prévia de equipe · depoimentos |
| `about.html` | Sobre + repete prévia de serviços, preços, equipe e depoimentos (página "sobre" bem completa, quase um resumo do site) |
| `services.html` | Grid de serviços com ícone (massagens, terapias, tratamentos) + seção de features |
| `gallery.html` | Galeria com filtro por categoria (All / Body Treatments / Massage / Aroma Therapy / Herbs), via Isotope |
| `team.html` | Grid de equipe com foto, nome e cargo (ex. "Stacey Richardson — Beauty Expert") + ícones sociais |
| `pricing.html` | Tabela de preços por serviço (ex. "Swedish Massage — $60 / 50 Minute Session") |
| `gift-cards.html` | Página de venda de gift card/certificado |
| `booking.html` | Formulário de agendamento com campo de data/hora (`jquery.datetimepicker`) |
| `faqs.html` | Perguntas frequentes em acordeão |
| `contacts.html` | Info de contato + formulário |

## Como personalizar

```bash
templates/sites/estetica-spamagic/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Como no Hair Care, a cor de marca é um hex repetido dentro de um arquivo de
tema completo (`css/pink-theme.css`: 31 usos sólidos do acento `#efa697` +
9 usos do tom escuro de hover `#b7948e` + 1 em `rgba()`) — não uma CSS
custom property. O script troca os dois hex e recalcula o `rgba()`; o tom
de hover é **calculado** (22% mais escuro que a cor nova em cada canal RGB),
não copiado do original, porque o hover não teria relação nenhuma com uma
cor de marca diferente do rosa. Os 3 outros temas prontos do pack (gold,
rose, silk) foram apagados na curadoria — nenhuma das 10 páginas os carrega.
**Não mexe** nos tons de fundo creme/bege (`bg-color-01/02/04/05`, usados
1-4 vezes cada) nem num `rgba(255, 248, 245...)` de overlay claro (13 usos)
— são a paleta de fundo do tema, não o acento de marca.

## Armadilhas

- **Logo com nome e cor do ícone travados no PNG.** `images/logo-01.png`
  tem "SPA MAGIC / BEAUTY & WELLNESS" desenhado como texto raster mais um
  ícone de flor de lótus na cor rosa ORIGINAL — nem o nome nem a cor do
  ícone são alcançados pelo script. `images/logo-white.png` é a versão
  branca (header transparente sobre o hero) — abre parecendo em branco
  puro num visualizador de fundo branco porque é PNG transparente; sempre
  compor sobre um fundo escuro antes de julgar. Trocar os 2 arquivos pela
  logo real do cliente.
- **Newsletter apontava pro Mailchimp do autor original.** `js/custom.js`
  tinha `$('.newsletter-form').ajaxChimp({ url:
  'https://dsathemes.us3.list-manage.com/...' })`, usado no formulário de
  newsletter de `about.html`, `index.html`, `pricing.html` e
  `services.html` — já neutralizado nesta cópia (`url: ''`). Sem ESP
  próprio do cliente, plugar um serviço de verdade ou remover o formulário
  antes de publicar.
- **4 formulários em PHP que não rodam na Vercel** —
  `php/contactForm.php`, `php/bookingForm.php`, `php/heroForm.php` e
  `php/commentForm.php`, chamados via AJAX por `js/contact-form.js`,
  `js/booking-form.js` e `js/hero-form.js`. Sem hospedagem PHP, contato,
  agendamento e o mini-formulário do hero não enviam nada. Trocar por
  `wa.me` ou um serviço de formulário estático antes de publicar.
- **Fotos são placeholder de verdade, mas locais.** Diferente do Hair
  Care (que dependia de um serviço externo hoje fora do ar), aqui todo
  `images/*.jpg` de hero/galeria/equipe/serviço já é um arquivo JPG
  cinza-escuro com a dimensão escrita dentro (ex. "1920 x 1080") — sem
  dependência de rede, mas continua sendo maquete. Sem fotos reais do
  espaço/tratamento/equipe, o site fica com cara de maquete.
- **E-mail e Skype fictícios, já isolados.** `yourdomain@mail.com` e
  `hello@yourdomain.com` viraram `[EMAIL]`; o "Skype: support.spamagic"
  citado em contato/agendamento/equipe virou `[SKYPE]`. Preencher com o
  contato real ou apagar a linha.
- **Telefone fixo fictício.** `tel:123456789` / "+12 9 8765 4321" aparece
  no menu de todas as páginas (item de telefone) e de novo nas páginas de
  contato/agendamento — trocar pelo WhatsApp real ou marcar "a confirmar".
- **Feed de Instagram fake.** A faixa de 6 fotos "insta-img" no rodapé
  (presente na maioria das páginas) linka pra `href="#"` — vitrine sem
  conta real por trás. Trocar pelo Instagram do cliente ou apagar a seção.
- **Equipe, depoimento e preço são do pacote, não do cliente.** Nomes como
  "Stacey Richardson — Beauty Expert" e os valores da tabela de preço
  (ex. "$60", "$119") são fictícios — sem dado real, trocar por cargo
  genérico sem nome ou marcar "a confirmar", nunca inventar um nome ou
  preço novo.
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra `pt-BR`
  e reescrever com o tom de voz do `identidade.md`, não traduzir ao pé da
  letra. O `<meta name="keywords">` ainda cita "Jthemes" (autor original) —
  irrelevante pra SEO hoje, não foi tocado.
