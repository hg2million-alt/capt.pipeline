# Restaurante / Fast Food — Foodio

Template para restaurante casual, hamburgueria ou lanchonete com cardápio à
mesa — 17 páginas, **3 variantes de home** (uma clara "de restaurante", duas
mais "fast food": uma clara com foco em promoção percentual, outra
**escura** com o clima de hamburgueria). Comprado como "Foodio — Fast Food &
Restaurant HTML Template".

**Peso:** 3,3 MB em `html/` · **Stack:** HTML estático + jQuery + Bootstrap +
Owl Carousel + Fancybox + Nice Select + SweetAlert · **Build:** nenhum (abre
o `.html` direto, sem `npm install` nem compilação)

---

## Para que serve

Restaurante casual, hamburgueria, lanchonete ou delivery de porção — o
cardápio já vem em 3 layouts (grade simples, com categoria, com destaque de
"prato da semana"), tem seção de chef/equipe, blog e loja. A home 3 (escura,
laranja/vermelho, "Kings Burger" no conteúdo original) é a que mais puxa pro
clima fast-food; a home 1 e 2 são mais genéricas de "restaurante com entrega".

Fica ao lado dos outros templates de alimentação da biblioteca:
- **Elegencia/Thesignature/Royate** são pra restaurante de mesa/bistrô/wine
  bar — fluxo de reserva, sem cardápio de delivery.
- **Fresheat** já cobre delivery/prato feito; **Foodio** é uma opção a mais
  nesse mesmo espaço, com a vantagem de ter 3 homes prontas (uma escura) e
  seção de chef mais desenvolvida.
- **Pizzaria-onepage** é one-page, mais simples; **Foodio** é multi-página
  (menu, blog, loja, chef, reserva).

**Para que não serve:** casa fina/fine dining com reserva formal — não tem
fluxo de reserva de mesa dedicado (só formulário de contato genérico) e o
tom visual (fonte arredondada Fredoka One, emojis de cardápio) é casual, não
elegante. Pra isso, `restaurante-elegencia/` ou `restaurante-thesignature/`.
Loja (`shop.html`, `shop-cart.html`, `cart-checkout.html`) e login
(`login.html`) são decorativos, sem backend — não serve se o cliente precisa
de e-commerce ou conta de usuário de verdade.

## As páginas

Preview em [`preview/`](preview/): `index` (home 1, clara), `index-3` (home
3, escura, "Kings Burger"), `menu-1` (cardápio), `chef-details`, `contact`.

| Grupo | Páginas | O que tem |
|---|---|---|
| Home | `index.html` (padrão), `index-2.html`, `index-3.html` | 3 heros diferentes — só `index.html` linkada no menu |
| Cardápio | `menu-1.html`, `menu-2.html`, `menu-3.html` | 3 layouts de cardápio (grade, categorias, destaque semanal) |
| Chef | `chef-details.html` | Perfil de 1 chef fictício ("James Smith") — a home também lista 3 chefs em cards |
| Institucional | `about.html`, `our-services.html` | Sobre e serviços |
| Blog | `our-blog.html`, `blog-details.html` | Lista de posts e post individual |
| Contato | `contact.html` | Formulário (PHP, não roda na Vercel) + mapa |
| Loja/conta | `shop.html`, `shop-cart.html`, `cart-checkout.html`, `product-details.html`, `login.html` | E-commerce e login decorativos, sem backend |

## Como personalizar

```bash
templates/sites/restaurante-foodio/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

A cor de marca (`#F3274C`, vermelho) **não é uma CSS var única** — está
hardcoded em 3 arquivos diferentes, confirmado por grep case-insensitive em
toda a árvore antes de escrever o script: `assets/css/color.css` (arquivo
dedicado só de cor, mas repete o hex em vez de usar variável — 3 usos),
`assets/css/style.css` (15 usos, incluindo uma ocorrência com canal alfa,
`#f3274ce8`, onde a troca de substring preserva o alfa sozinha) e
`assets/js/custom.js` (1 uso — cor do gradiente cônico da barra de progresso
de scroll). Nenhum HTML nem SVG carrega a cor. O script troca nos 3 lugares.

O nome do cliente já está pré-processado como `[NOME DO CLIENTE]` em todo
`html/` — substituiu as 35 ocorrências originais de "Foodio" (17 `<title>`,
17 `© 2023 Foodio` no rodapé, 1 "Welcome to Foodio" na home 2).

## Armadilhas

- **Logo com nome desenhado, não vetorizado.** `assets/img/logo.png`,
  `logo-white.png`, `logo-white-color.png` e `logo-icon.png` têm o ícone de
  tigela E a palavra "Foodio" desenhados juntos no PNG, na cor de marca —
  script não mexe em raster, trocar pela logo real do cliente.
- **Zero foto real.** O template inteiro roda em cima de `placehold.co`
  (336 ocorrências: hero, cardápio, chefs, galeria, blog) — parecido com
  Handify/Qlinest, mas usando o serviço `placehold.co` que ainda está no ar
  (diferente do `via.placeholder.com` morto que afetava o Lemanhouse). Sem
  foto real do prato/salão, o site fica com cara de maquete.
- **Bug do template: URL de imagem duplicada colada.** `index.html` original
  tinha `src="https://placehold.co/590x588https://placehold.co/590x588"` (a
  URL repetida sem separador, imagem não carregava) — já corrigido na cópia
  mestra em `html/index.html` antes de qualquer personalização.
- **Textura com a cor antiga queimada no arquivo.** `assets/img/patron.jpg`
  e `patron-black.jpg` (background decorativo de ícones de comida, usado
  atrás do hero em algumas homes) já vêm tingidos na cor de marca original
  (#F3274C) dentro do próprio JPG — trocar a cor no CSS não muda essas
  imagens. Pra outra cor, ou aceita o vermelho residual por trás do overlay,
  ou re-tinge/substitui os 2 arquivos na mão.
- **Chefs fictícios.** A home lista 3 chefs (Thomas Walim, James Jhonson,
  Room Minal) e `chef-details.html` tem um 4º (James Smith, com telefone
  "1234-0129-123" e e-mail "username@domain.com" de mentira, ambos já no
  padrão óbvio de placeholder). Sem equipe nomeada real, apagar a seção ou
  usar cargo genérico sem nome.
- **Depoimentos inventados** espalhados pelas homes — usar só com selo
  "ilustrativo".
- **Cardápio em dólar.** `menu-1/2/3.html` têm ~135 preços no formato
  "$12.60" — trocar por R$ com o valor real do cliente; não é só find/replace
  do símbolo porque o separador decimal também muda (12.60 → 12,60).
- **Formulário sem backend na Vercel.** `contact.php` e `reservation.php`
  usam `mail()` do PHP puro — não rodam em hospedagem estática. O e-mail de
  destino já vem como placeholder genérico (`add_user_email_here`, sem
  vazar contato do autor original), mas nada é enviado sem um backend PHP de
  verdade. Trocar a ação do `<form>` por `wa.me` ou remover antes de
  publicar.
- **Loja/carrinho/login decorativos**, sem backend — considerar remover do
  menu em demo de captação.
- **3 homes**, só `index.html` linkada no menu — escolher uma antes de
  publicar (a escura/`index-3.html` é a que mais puxa pro clima fast-food).
- **`<html lang="zxx">` no original** (código ISO para "sem conteúdo
  linguístico", claramente um erro do gerador do template) — já corrigido
  para `lang="en"` na cópia mestra; trocar pra `pt-BR` durante a
  personalização e reescrever com o tom de voz do `identidade.md` do
  cliente, não traduzir ao pé da letra.
- **Redes sociais** do header/rodapé apontam pra `href="#"` — preencher com
  o Instagram real ou remover.
- **Vídeo do YouTube de estoque** (mesmo id embutido em 8 páginas, botão de
  "play" via Fancybox) — trocar pelo vídeo real do cliente ou remover o
  botão.
- **Nenhum arquivo de licença/autor sobrou.** `Documentation/` (com o texto
  de licença Envato/ThemeForest e a logo "Blesso" do autor) não foi
  copiada — só o conteúdo de `main_files/` (renomeado `html/`) entrou na
  biblioteca. Os únicos comentários de cabeçalho que sobraram em
  `style.css`/`custom.js` citam o nome do produto ("Project: Foodio...") sem
  nome de autor nem link de licença — deixados como estão, não têm carga
  jurídica.

## Preview

Gerado com Playwright renderizando a cópia mestra em `html/` (sem
personalização) num servidor HTTP local. O ambiente de geração estava com um
navegador Playwright compartilhado por várias sessões simultâneas — algumas
capturas saíram de outro template (`Dentia`, `Home Two` etc.) por contenção
de aba/navegação concorrente e precisaram ser refeitas e conferidas visual
uma a uma antes de salvar; as 5 imagens em `preview/` foram confirmadas
como sendo de fato do Foodio antes de entrar na pasta.
