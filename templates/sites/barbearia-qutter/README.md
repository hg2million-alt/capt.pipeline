# Barbearia / Salão — Qutter

13 páginas (3 variações de home + 10 páginas internas, incluindo blog),
**base escura** (carvão + dourado `#d6a354`). Comprado como "Qutter — Barbers
& Hair Salon HTML Template" (o pacote original tinha 15 páginas; `shop.html`
e `product-details.html` — loja de produto genérico, fora do nicho — ficaram
de fora, ver Armadilhas).

**Peso:** 19 MB em `html/` (fontes + Font Awesome completo; zero foto real —
ver Armadilhas) · **Stack:** HTML estático + Bootstrap 4.5 + jQuery + Slick
Carousel + Magnific Popup + Nice Select + jQuery UI + WOW.js/animate.css ·
**Build:** nenhum (o pacote trazia `.sass` fonte em `assets/sass/`, mas o
HTML só carrega o `.css` já compilado em `assets/css/style.css` — o sass não
roda em runtime, fica só documentando a intenção original)

---

## Para que serve

Barbearia e salão de beleza/cabelo — igual o Trimly, o pacote original já é
"Barbers & Hair Salon", serve pros dois nichos sem mudar estrutura, só o
vocabulário. Tem 3 variações de home pra escolher layout, página de serviços
com detalhe individual, portfolio/galeria com página de detalhe (dá pra usar
como antes/depois ou trabalho em destaque), preço, ofertas/promoções, blog
(2 páginas — lista + post) e contato com formulário de agendamento.

**Quando preferir este ao `barbearia-trimly/` (hoje o padrão da categoria):**
o cliente quer base **escura** de cara (Qutter já nasce carvão+dourado, sem
precisar do modo "escuro" do `personalizar.sh` do Trimly) ou quer 3 opções de
home pra escolher layout antes de fechar. Fora isso, o Trimly continua sendo
a escolha mais testada (já foi pra cliente real, tem menos placeholder de
seção nonsense pra limpar).

**Não serve** — ou serve mal — pra: barbearia que só quer uma one-page rápida
(esse é multi-página, 13 telas); quem vende produto físico como carro-chefe
(a loja do pacote original foi removida da cópia, ver Armadilhas).

## As páginas

Preview de cada uma em [`preview/`](preview/).

| Página | O que tem |
|---|---|
| `index.html` / `index2.html` / `index3.html` | 3 variações de home — hero + vídeo institucional, sobre, categorias de serviço, agendamento embutido (index3), depoimentos, blog preview, preço (index/index3), horário de funcionamento (index2) |
| `about.html` | Sobre + "o que fazemos" + depoimentos |
| `services.html` | Cards de serviço + tabela de horário de funcionamento + formulário de agendamento embutido |
| `service-details.html` | Detalhe de 1 serviço + sidebar com lista de outros serviços + formulário de agendamento |
| `portfolio.html` / `portfolio-details.html` | Galeria de trabalho + detalhe de 1 peça (dá pra usar como "antes/depois") |
| `pricing.html` | 3 planos (Regular/Standard/Premium) — preço em dólar chutado, ver Armadilhas |
| `offers.html` | Promoções + repete a tabela de preço |
| `blog.html` / `blog-details.html` | Lista de posts + post individual — mantidos porque a home cross-linka muito neles (ver Armadilhas); útil pra dica de cuidado capilar/barba, bom pra SEO local |
| `contact.html` | Formulário de contato + mapa embutido + horário |

## Como personalizar

```bash
cd templates/sites/barbearia-qutter
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2e7d32' 'Barbearia XYZ'
```

## Onde fica a cor de marca

Igual o Oyoxo: **sem CSS var**, hex hardcoded direto no `.css` compilado (o
`.sass` fonte em `assets/sass/_variables.sass` mostra `$primary-color:
#d6a354`, mas não é usado em runtime).

- `#d6a354` (dourado) — 79 usos em `assets/css/style.css` (botão, preço,
  ícone ativo, borda de destaque, hover de menu). É A cor de marca.
- `#d69838` — 1 uso só (background do hover de botão), uma versão ~7% mais
  escura do dourado acima. O `personalizar.sh` deriva essa sombra
  automaticamente a partir da cor escolhida (mesma técnica do CoolAir pra
  cor secundária) em vez de deixar hardcoded.
- `rgba(214, 163, 84, X)` — 7 usos (fundo translúcido de card/ícone). O
  script converte a cor nova pro mesmo formato `R, G, B` automaticamente.
- `#ff7800` / `#ffaa17` — cor fixa do ícone de estrela (avaliação), **não é
  cor de marca**, o script não mexe.

## Limpeza já feita nesta cópia

- `Documentation/` (docs do tema + bibliotecas MIT de terceiro), `shop.html`,
  `product-details.html` e `assets/php/` (form-process.php, PHP `mail()`,
  não roda em hospedagem estática) — removidos. `blog.html`/`blog-details.html`
  foram mantidos (ver seção "As páginas").
- `lang="zxx"` → `lang="pt-BR"` nas 13 páginas.
- `<title>` genérico do tema → `[NOME DO CLIENTE] | Página`.
- Rodapé "Copyright © AAAA WebTend/Qutter. All Rights Reserved." → texto em
  pt-BR com `[NOME DO CLIENTE]` (WebTend é o estúdio autor do tema).
- Telefone/e-mail de exemplo (`012 (345) 67 895`, `support@gmail.com`) →
  `[WHATSAPP]` / `[EMAIL]`, inclusive dentro de `href`.
- **"Premium sponsors" removida** (`about.html`, `index.html`) — carrossel de
  logo de "empresa parceira" sem relação nenhuma com barbearia (os ícones em
  `assets/images/client-logos/` são um selo genérico de "Barber Shop", não
  marca real de terceiro — mas a seção dizia "sponsors", o que não fazia
  sentido pro nicho e não tinha como virar informação real do cliente).
- **Selo de "empresa" dentro de cada card de depoimento removido**
  (`about.html`, `index2.html`, `index3.html`, 15 ocorrências no total) — o
  pacote original citava uma logo de marca aleatória por depoimento (uma
  delas era literalmente **"natural mineral water"**), copiado sem adaptação
  de um template genérico corporate/SaaS. O texto do depoimento, nome e nota
  continuam fictícios (ver Armadilhas).
- Bug do formulário de agendamento corrigido: todo `<option>` do seletor de
  serviço (`services.html`) tinha `value="value1"` igual (qualquer escolha
  enviava o mesmo valor) — agora cada opção manda o nome do serviço.
- Typo do tema original corrigido: breadcrumb de `contact.html` dizia
  "Cotact Us".
- Nav: item "Shop" (dropdown "Pages") e o link "Beauty & Spa" do rodapé, que
  apontavam pra `shop.html`/`product-details.html`, removidos/repontados —
  sem isso ficavam 2 links mortos por página depois de tirar a loja.
- Formulários de contato/agendamento trocados pra abrir WhatsApp — ver
  próxima seção.

## Formulários (`assets/js/wa-forms.js`)

O pacote original manda o "send message" de `contact.html` pra
`assets/php/form-process.php` (PHP `mail()`) e os dois formulários de
"appointment" (`services.html`, `service-details.html`) tinham `action="#"`
sem JS nenhum atrás — os três eram mudos em qualquer hospedagem estática tipo
Vercel. `assets/js/wa-forms.js` intercepta os 3 (`#contactForm` e
`#appointmentForm` — os dois appointment ganharam o mesmo id) e abre
`https://wa.me/[WHATSAPP]?text=...` com a mensagem já montada a partir dos
campos preenchidos, igual o padrão do Trimly. **Falta preencher `[WHATSAPP]`
no próprio `wa-forms.js` (2 ocorrências) antes de publicar** — o
`personalizar.sh` não mexe nisso, só nos textos visíveis da página.

O "newsletter subscribe" do rodapé (presente em toda página) continua sem
back-end nenhum — é decorativo, não foi wireado.

## Armadilhas

- **Zero foto real — nível Oyoxo.** Hero, banner interno de página, galeria
  (`gellary/`), equipe (`team/`), depoimento (`testimonials/`), post de blog
  — todo retângulo cinza com a dimensão escrita dentro (ex. "1920X500",
  "1365X880"). O `personalizar.sh` já troca os **25 fundos que são CSS
  `background-image`** (banner interno, os 3 heroes de home e mais fundos de
  seção) por um gradiente na cor de marca — mas toda foto que é `<img>` solta
  continua placeholder até entrar foto real do cliente.
- **Logo em 2 arquivos, não 1.** `assets/images/logos/logo.png` (header, quase
  toda página) e `assets/images/hero/logo.png` (variante usada só em
  `index3.html`) trazem o ícone (tesoura+bigode) + "QUTTER" + "Hair Salon"
  desenhados dentro do PNG — os 2 precisam trocar, esquecer o segundo deixa
  a home 3 com a marca errada.
- **Selo "EST. 1996" pintado dentro do PNG.**
  `assets/images/about/logo.png` é um selo circular "Barber Shop — Haircuts
  & Shaves — EST. 1996" usado em destaque em `about.html` e `index2.html`
  (não é rodapé escondido, fica logo acima do texto "sobre"). 1996 é
  fictício — não é texto, `personalizar.sh` não alcança. Sem confirmação do
  ano real de fundação do cliente, esconder o elemento (`.about-content-two
  .logo`) em vez de publicar um selo de fundação inventado.
- **Vídeo do hero é do tema, não do cliente.** O botão de play
  (`about.html`, `index.html`, `index2.html`, `service-details.html`) abre
  um vídeo do YouTube que é conteúdo de demonstração do pacote comprado —
  trocar pelo vídeo real do salão ou remover o botão antes de publicar.
- **Preço chutado.** `pricing.html` (3 planos) e a seção "smart offer" de
  `offers.html` trazem valor em dólar sem relação com o cliente — sem tabela
  real, apagar a seção.
- **Depoimento, equipe e "premium sponsors"** — texto/nome/nota de
  depoimento continuam fictícios mesmo depois da limpeza (usar só com aviso
  "ilustrativo"); fotos de equipe (`team/memberN.jpg`) não vêm com nome
  atrelado nesta cópia (só `alt="Member"`), o que ajuda — trocar a FOTO já
  resolve, sem precisar inventar nome de funcionário.
- **Blog puxado pela home.** As 3 homes citam post de blog em preview/link
  (até 18 ocorrências de `blog-details.html` numa página só) — por isso
  `blog.html`/`blog-details.html` foram mantidos na cópia (diferente do
  Trimly, que não tinha blog no recorte de 9 páginas). Se o cliente não
  quiser seção de blog, tirar o link do menu **e** o bloco "Latest Blog &
  News" de cada home, não só a página.
- **`assets/js/jquery.ajaxchimp.min.js`** carrega em toda página mas nunca é
  inicializado (sem chamada `.ajaxchimp()` em `script.js`) — plugin morto,
  inofensivo, mas também não plugar nele achando que o newsletter já manda
  pra algum Mailchimp: não manda pra lugar nenhum.
- **Texto em inglês.** Só `lang`, formulário e os textos já listados acima
  foram para pt-BR — parágrafo/título de seção (estilo "Lorem ipsum") segue
  em inglês, reescrever com o tom de voz do `identidade.md` do cliente.

## Referência

Ainda não usado em cliente real — ficou pronto na biblioteca em 26/09/2026.
