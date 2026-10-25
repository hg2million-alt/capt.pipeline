# Restaurante — Fresheat

Template para marmitaria, comida rápida, delivery de prato feito, hamburgueria
de balcão — cardápio com preço, botão "peça agora" e cara de banco de imagem
de comida de verdade, não decoração fina de mesa. 43 páginas, **base clara**
(branco), vermelho `#EB0029` + laranja `#FC791A`. Comprado como "Fresheat
Food & Restaurant Html Template".

**Peso:** 18 MB em `html/` · **Stack:** HTML estático + Bootstrap 5 + Swiper +
WOW.js (animação de entrada) + Nice Select + Font Awesome 6 Pro (webfont) ·
**Build:** nenhum

---

## Para que serve

Quem vende **comida pra viagem ou entrega rápida**, sem experiência de mesa:
marmitaria, comida japonesa/chinesa de delivery, hamburgueria, frango frito,
lanchonete de bairro. O tom é direto e comercial — preço grande, "ORDER NOW"
em vermelho, selo "50% OFF", cardápio em cards com foto e valor visível. Bem
diferente dos outros dois templates de restaurante da biblioteca:

- **Elegencia** (`restaurante-elegencia/`) é editorial e lento — feito pra
  quem vende experiência à mesa (bistrô, buffet, evento), preço não aparece.
- **Thesignature** (`restaurante-thesignature/`) é salão escuro com reserva
  de mesa e chef — restaurante de jantar, não delivery.
- **Fresheat** é o oposto dos dois: preço na cara, botão de pedido, cardápio
  tipo cardápio de delivery/app — serve pra quem vende comida rápida ou porção,
  não jantar.

**Para que não serve:** restaurante fino, buffet de evento, qualquer negócio
que venda experiência de mesa em vez de prato pra viagem (aí entra Elegencia
ou Thesignature). Também tem lógica de e-commerce completa (carrinho, conta,
checkout) que não serve pra nenhum cliente de captação sem loja online real.

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `menu`, `about`,
`contact`). O pacote tem **9 variantes de home** (`index.html`,
`index-2.html`, `index-3.html` + as três com sufixo `-dark`, mais
`index-one-page.html`, `index-two-page.html`, `index-three-page.html`) —
só `index.html` está linkada no menu, as outras existem soltas.

| Grupo | Páginas | O que tem |
|---|---|---|
| Home | `index.html` (padrão) + 8 variantes | Hero com foto grande + kicker "WELCOME" + título + "ORDER NOW" · 3 cards de promoção (cores alternadas vermelho/laranja) · cardápio popular · depoimentos · newsletter |
| Cardápio | `menu.html`, `menu2.html` | Prato com foto, categoria e preço, em grid |
| Institucional | `about.html`, `about-2.html`, `services.html`, `service-details.html` | Sobre, diferenciais, "serviços" (entrega, retirada etc.) |
| Equipe/chef | `chef.html`, `chef-details.html`, `chef-details2.html` | Perfil de cozinheiro/chef |
| Blog | `blog.html`, `blog-details.html`, `blog-left-sidebar.html`, `blog-standard.html` | Lista e post de blog |
| Loja | `shop.html`, `shop-details.html`, `shop-list.html`, `shop-list-right-sidebar.html`, `shop-right-sidebar.html`, `cart.html`, `checkout.html`, `wishlist.html`, `account.html` | E-commerce completo decorativo — sem backend, nenhum botão funciona |
| Reserva/contato | `reservation.html`, `contact.html`, `contact2.html`, `faq.html` | Formulário (sem backend funcional na Vercel), FAQ em acordeão |
| Outras | `testimonials.html`, `gallery.html`, `404.html` | Depoimentos em lista, galeria de fotos, página de erro |

## Como personalizar

```bash
templates/sites/restaurante-fresheat/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

O template tem **duas cores reais**, não uma: `--theme` (vermelho `#EB0029`,
209 usos — header, botão de pedido, breadcrumb) é a que o script troca pela
COR do cliente, junto com 6 SVGs de ícone que já nasceram nesse vermelho
(inclusive o ícone da logo) e um SVG de aspas de citação hardcoded dentro de
`blog-details.html`. `--theme2` (laranja `#FC791A`, usado no kicker "WELCOME"
e num card de promoção inteiro) fica **fixo** por padrão — ver cabeçalho do
`personalizar.sh` para o porquê. O nome do cliente já está pré-processado
como `[NOME DO CLIENTE]` em todo `html/`.

## Armadilhas

- **Logo com nome vetorizado.** `assets/img/logo/logo.svg` (e a variante
  `logo3.svg`) tem o ícone de prato E a palavra "FRESHEAT RESPONDENT"
  desenhados juntos — mas o nome é caminho vetorial, não texto real, então
  não aparece em busca por nome e o script só alcança a cor do ícone, não a
  geometria do nome (igual ao caso da Qlinest). Trocar o arquivo pela logo
  real do cliente.
- **E-mail com o próprio nome do template no domínio.** Um dos e-mails falsos
  era literalmente `info@fresheat.com` — um find/replace direto do nome
  quebraria isso em `info@[nome do cliente].com`. Todos os e-mails falsos
  (inclusive um leftover de outro template, `info@enofik.com`, e um
  `info@exmple.com` com erro de grafia) já vieram trocados por `[EMAIL]` no
  pré-processamento.
- **Telefone de mentira fixo.** `+11002345909` e `+013-003-003-9993` aparecem
  38 vezes cada, espalhados pelas páginas.
- **Fotos são de banco de imagem, não placeholder cinza.** Diferente de
  Handify/Qlinest, boa parte de `assets/img/*.jpg` já é foto de prato de
  verdade — mas é do banco de imagens do template, não do cliente. Fácil de
  confundir com foto real numa olhada rápida.
- **Nove homes diferentes**, só uma linkada no menu — escolher uma antes de
  publicar, não faz sentido oferecer 9 versões da mesma página num site de
  captação.
- **Loja completa sem backend** (`shop.html`, `cart.html`, `checkout.html`,
  `account.html`, `wishlist.html`) — nenhum botão funciona de verdade;
  considerar remover do menu.
- **Cardápio e preço são inventados** (`Chinese Pasta`, `Spicy Fried
  Chicken`, `$25`/`$28`/`$55` etc.) — sem cardápio real do cliente, marcar
  como "a confirmar".
- **Depoimentos com nome, foto e nota inventados** — usar só com selo
  "ilustrativo" visível.
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra `pt-BR` e
  reescrever com o tom de voz do `identidade.md`, não traduzir ao pé da letra.
