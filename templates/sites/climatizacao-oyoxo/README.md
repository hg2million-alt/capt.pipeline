# Climatização / HVAC — Oyoxo

Template para empresa de aquecimento e ar-condicionado, estrutura
**one-page** (Home/Sobre/Serviço/Produtos/Contato são seções por âncora
dentro de `index.html`) com blog e loja completos à parte. Base clara,
header azul (`#3464e0`). Comprado como "Oyoxo — Heating Air-conditioning
Services HTML Template".

**Peso:** 3,4 MB em `html/` (bem mais leve que outros templates da
biblioteca — não tem nenhuma foto real, só placeholder) · **Stack:** HTML
estático + Bootstrap 5 + plugins jQuery (carrossel, slider) · **Build:**
nenhum (o pacote traz um `.scss` fonte em `assets/scss/`, mas não é usado em
runtime — só o `.css` já compilado)

---

## Para que serve

Empresa de aquecimento/ar-condicionado que também vende equipamento — o
template já vem com loja (carrinho, checkout, lista de desejos, conta) além
do institucional. Serve bem pra quem quer uma home enxuta de uma página só
com loja de produto anexada.

**Não serve** — ou exige mais trabalho de limpeza — pra quem não vende
produto (a loja fica sobrando, com itens genéricos tipo aspirador de pó) nem
pra quem precisa de páginas de serviço separadas (aqui é tudo seção da
mesma home).

## As páginas

Preview de 3 delas em [`preview/`](preview/) (`index`, `shop`, `blog`) —
cobrem os 3 "modos" do template (one-page institucional, loja, blog).

| Página | O que tem |
|---|---|
| `index.html` | Slider hero (3 slides, todos placeholder) · seções por âncora: About, Service, Products (preview), Why Us, Team, Testimonial, Brand logos, Contact (formulário + mapa) |
| `index-2.html` | Segunda variação de home, mesmas seções em outra ordem/estilo |
| `shop.html` / `shop-leftsidebar.html` | Catálogo de produto com filtro de preço/categoria (itens genéricos, não HVAC) |
| `product-details.html` / `product-details-leftsidebar.html` | Detalhe de produto |
| `cart.html` / `checkout.html` / `wishlist.html` / `my-account.html` | Fluxo de loja completo (carrinho, fechamento de pedido, lista de desejo, conta) |
| `blog.html` / `blog-leftsidebar.html` | Blog em lista, com e sem barra lateral |
| `blog-details*.html` (galeria, vídeo, áudio, com/sem sidebar) | 5 variações de post individual por tipo de mídia |
| `login-register.html` | Login e cadastro de conta da loja |

A pasta `oyoxo-rtl/` do pacote original (mesmo site espelhado pra idioma
right-to-left) e a `Documentation/` não foram trazidas pra cá — não servem
pra demo em português.

## Como personalizar

```bash
templates/sites/climatizacao-oyoxo/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Este template **não usa variável CSS** — as cores estão hardcoded em hex
direto em `assets/css/style.css` (o `.scss` fonte em `assets/scss/` não é
compilado em runtime, só documenta a intenção original). O `.scss` mostra
duas candidatas, `$color-theme: #3464e0` e `$color-secondary: #3498db`;
conferido no CSS compilado, `#3464e0` tem 118 usos (topbar, logo, hover de
menu, botões, ícone ativo) contra 1 uso isolado de `#3498db` — por isso o
script troca só o `#3464e0`, igual o caso de uma cor única (Handify), só que
aqui é hex literal em vez de `var()`.

Troca também o nome do cliente (pré-processado em `html/` como
`[NOME DO CLIENTE]`, inclusive "ThemeMarch", nome do estúdio autor no
crédito do rodapé) e o e-mail `contact@oyoxo.com`, neutralizado à parte como
`[EMAIL]`. O link externo do rodapé para o estúdio autor
(`https://thememarch.com/`) foi neutralizado para `href="#"` no
pré-processamento — sem isso, o replace de nome ia gerar um domínio
inventado tipo `https://nomedocliente.com/`.

## Armadilhas

- **Logo é imagem, não texto.** `assets/images/logo/logo.png` (usado no
  header) e `logo-white.png` (preloader) trazem o ícone + a palavra "OYOXO"
  + o subtítulo "Heating air conditioning" desenhados dentro do arquivo —
  o `personalizar.sh` não alcança. Trocar os 2 pela logo real do cliente.
- **Zero foto real — é o template mais "maquete" da biblioteca até agora.**
  Diferente do CoolAir (fotos de banco reais), aqui hero, banners internos e
  imagem de produto/post são todos retângulo cinza com a dimensão escrita
  dentro (`1920x817`, `420x513`, `800x398` etc.) — sem foto real do cliente
  em cada uma, o site fica com cara de maquete.
- **Loja com produto genérico sem nada a ver com HVAC**, tipo "Multimedia
  alarm device" e "Vacuum cleaner", preço chutado em dólar — ou substitui
  por equipamento real do cliente (split, inverter, peça) ou tira a loja do
  menu inteira.
- **Equipe com nome/foto repetidos.** A seção de equipe da home repete
  "Brian Bader / Engineer" com a mesma foto em todos os cards — sem gente
  real, apagar a seção ou trocar por cargo genérico sem nome.
- **Telefone americano fixo.** "1-800-915-6270" aparece no topo e no meio
  da home — trocar por WhatsApp real ou marcar "a confirmar".
- **Três e-mails fake, só um neutralizado.** `contact@oyoxo.com` virou
  `[EMAIL]` porque colidia com o nome do template. `contact@example.com` e
  `info@example.com` são placeholder genérico do framework, não colidem com
  nome nenhum e continuam como estavam no HTML — também são fake, preencher
  ou apagar junto.
- **Formulário não funciona na Vercel.** "Make an Appointment"
  (`assets/php/appointment.php`) e o formulário de contato
  (`assets/php/mailer.php`) dependem de hospedagem PHP — sem backend, nada é
  enviado; trocar a ação dos formulários por `wa.me` ou serviço de
  formulário estático antes de publicar.
- **Crédito de rodapé.** "Designed by [NOME DO CLIENTE]" no rodapé é sobra
  do link pro estúdio autor — o link já foi neutralizado (`href="#"`), mas a
  frase em si não faz sentido num site do próprio cliente; considerar
  apagar a linha toda.
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra `pt-BR` e
  reescrever com o tom de voz do `identidade.md`.
- **Estrutura one-page, não por página.** About/Service/Products/Contact
  são seções dentro do próprio `index.html` (âncoras `#tm-home-area` etc.),
  não páginas separadas — só Blog e Loja são de fato páginas à parte. Editar
  seção por seção dentro do `index.html`.
