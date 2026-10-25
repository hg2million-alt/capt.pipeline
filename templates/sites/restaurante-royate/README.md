# Restaurante — Royate

Template para restaurante de mesa, bistrô ou wine bar de porte médio — menu
completo (home, reserva, galeria, chefs, blog, loja), **base clara** (cinza
claro/branco) com um dourado suave de acento. 46 páginas, **15 variantes de
home**. Comprado como "Royate — Restaurant HTML5 Template".

**Peso:** 31 MB em `html/` · **Stack:** HTML estático + jQuery + Bootstrap +
Owl Carousel + Revolution Slider + AOS/Animate.css + date-picker + jQuery
Timepicker + hcmobilenav (menu mobile) · **Build:** nenhum

---

## Para que serve

Restaurante de salão de porte médio, bistrô, wine bar — quem quer reserva de
mesa com data/hora, cardápio em página própria, chefs em destaque e ainda
uma home entre 15 opções prontas pra escolher o clima (mais fotográfica, mais
texto, com slider, com menu lateral fixo etc.). Fica no meio do caminho entre
os outros dois templates de restaurante da biblioteca:

- **Elegencia** (`restaurante-elegencia/`) é mais editorial/luxuoso — título
  serifado grande, GSAP, dourado sobre fundo quase preto, pensado pra
  restaurante fino ou casa de evento.
- **Thesignature** (`restaurante-thesignature/`) é mais quente/casual —
  fundo escuro com textura de pedra, foto redonda de prato, reserva simples.
- **Royate** é o mais claro e "corporativo" dos três: fundo cinza claro,
  dourado discreto só como acento (não domina a página), estrutura de menu
  mais robusta (15 homes, galeria em 4 layouts, blog em 6 formatos).

**Para que não serve:** comida rápida/delivery/porção (pra isso,
`restaurante-fresheat/` ou `pizzaria-onepage/`) — aqui o fluxo inteiro supõe
reserva de mesa e prato servido, não pedido pra viagem. Também não serve se o
cliente precisar de loja ou login funcionando de verdade: `shop-*.html`,
`sign-in.html` e `sign-up.html` são só fachada, sem backend nenhum.

## As páginas

Preview em [`preview/`](preview/): `index` (hero), `index-welcome` (rolagem
até a seção "Welcome to [NOME DO CLIENTE]", pra confirmar o pré-processamento),
`menu`, `about-us`, `contact-us`.

| Grupo | Páginas | O que tem |
|---|---|---|
| Home | `index.html` (padrão) + `index-2.html` a `index-15.html` | 15 heros diferentes (slider de texto, slider de foto, vídeo, menu lateral fixo etc.) — só `index.html` linkada no menu |
| Cardápio | `menu.html` | Cardápio em duas colunas, categoria + preço |
| Institucional | `about-us.html`, `meet-the-chefs.html`, `project.html` | Sobre, equipe de chefs, portfólio de projeto/evento |
| Reserva | `reservation_v1.html`, `reservation_v2.html` | Formulário de data/hora/pessoas — decorativo, `action="#"` |
| Contato | `contact-us.html` | Formulário (PHP, não roda na Vercel) + endereço + mapa |
| Galeria | `gallery-three-columns(-wide).html`, `gallery-four-columns(-wide).html`, `masonry-grid.html`, `masonry-wide.html` | Grade de fotos em 4 variações de coluna |
| Blog | `blog-masonry(-wide).html`, `blog-single.html`, `blog-standard-*-sidebar.html` | Lista em masonry ou padrão, com/sem barra lateral, e post individual |
| Loja/conta | `shop-*.html`, `shop-cart.html`, `checkout.html`, `sign-in.html`, `sign-up.html` | E-commerce e login decorativos, sem backend |
| Outras | `coming-soon.html`, `404.html` | Página "em breve" e erro |

## Como personalizar

```bash
templates/sites/restaurante-royate/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

O CSS nasceu de SCSS com 8 variáveis de cor, mas só uma sobrevive no HTML
entregue: `#CDAA7C` (dourado — nome no header, título de destaque, aba de
menu ativa). As outras sete são "skins" alternativos do pacote original
(`.bg-third-color`, `.bg-fourth-color` etc.) que não são usados em nenhuma
página deste template — confirmado com screenshot da index crua antes de
mexer em qualquer coisa. O script troca essa cor em 4 lugares: `css/style.css`
(onde ela realmente vale), `vendor/hcmobilenav/demo.css` (item ativo do menu
mobile — customizado à parte do CSS principal), `css/style.scss` (fonte, só
por coerência) e o atributo `data-color="#cdaa7c"` dentro de
`index.html`/`index-2/5/6/7.html` (cor do texto configurada direto na tag do
Revolution Slider). O nome do cliente já está pré-processado como
`[NOME DO CLIENTE]` em todo `html/`.

## Armadilhas

- **Logo com nome pintado, não vetorizado.** `images/logo.png` (77×68) e
  `images/logo-menu-sidebar.png` têm o ícone de taça E a palavra "ROYATE"
  desenhados juntos no PNG — só fica visível de verdade em tamanho grande;
  olhando o thumbnail pequeno é fácil não perceber que o nome está lá. O
  script não mexe em raster; trocar os 2 arquivos pela logo real.
- **Site/domínio no rodapé.** Toda página tinha `www.royate.com` como texto
  solto (não é e-mail, então não seria pego pela proteção de domínio comum)
  — um find/replace direto do nome quebraria isso em
  `www.[nome do cliente].com`. Já veio trocado por `[SITE]`, separado do
  `[EMAIL]`, no pré-processamento.
- **E-mail fake.** Era `Eric-82@example.com` (84 ocorrências) e
  `kathryn-92@example.com` (2, só em `contact-us.html`) — já veio trocado por
  `[EMAIL]`.
- **Reserva e contato não enviam nada de verdade.**
  `reservation_v1.html`/`reservation_v2.html` têm `action="#"` (decorativo);
  `contact-us.html` usa `includes/contact-form.php`, que precisa de
  hospedagem PHP e não roda na Vercel. Trocar por `wa.me` ou remover antes de
  publicar.
- **15 homes**, só uma linkada no menu — escolher uma antes de publicar.
- **Telefone fixo**: `+1 (561) 800-366-6666` (~51 ocorrências, formato varia)
  e `(849) 490-4283` (2, só em `contact-us.html`).
- **Cardápio e preço inventados** em `menu.html` — marcar "a confirmar" sem
  dado real do cliente.
- **Depoimentos com nome, foto e nota inventados**, espalhados pelas homes —
  usar só com selo "ilustrativo".
- **Loja e login sem backend** (`shop-*.html`, `checkout.html`,
  `sign-in.html`, `sign-up.html`) — considerar remover do menu.
- **Fontes de licença (Lato, Satisfy) já removidas** da matéria-prima
  original (estavam em `documentation/`, não em `html/`); se sobrar
  referência quebrada a elas em algum CSS, não é conteúdo do site, pode
  ignorar.
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra `pt-BR` e
  reescrever com o tom de voz do `identidade.md`, não traduzir ao pé da letra.
