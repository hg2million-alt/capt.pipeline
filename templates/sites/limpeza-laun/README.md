# Limpeza — Laun

Template pra diarista, empresa de limpeza residencial/comercial recorrente,
faxina avulsa, lavanderia ou lavagem a seco. 28 páginas, **base verde**
(`#8CC63F`) com acento azul fixo (`#2946B8`). Comprado como "Laun — Laundry
Service & Dry Cleaning HTML Template".

**Peso:** 32 MB em `html/` (24 MB são só a fonte de ícones Font Awesome Pro
completa) · **Stack:** HTML estático + Bootstrap 5 + jQuery 3.6 + Swiper
(slider do hero) + Isotope + imagesLoaded (filtro da galeria) + Magnific
Popup (lightbox) + CounterUp (contador animado) + jQuery UI + Nice Select
(select customizado do formulário) + fontes auto-hospedadas (Archivo, DM
Sans, Lobster) · **Build:** nenhum

---

## Para que serve

Diarista, empresa de limpeza residencial ou comercial, faxina recorrente ou
avulsa, lavanderia e lavagem a seco (dry cleaning). Tem 3 variações de home
(laundry padrão, dry cleaning, laundry+dry combinado), galeria com filtro,
página de equipe, blog e depoimentos.

**Não serve** — ou serve mal — pra quem não tem loja/operação de e-commerce:
o template vem com carrinho, checkout, lista de desejos e páginas de
"produto" (`cart.html`, `checkout.html`, `shop.html`, `shop-details.html`,
`wishlist.html`) que não fazem sentido pra diarista ou lavanderia de bairro
— ou não usar essas páginas, ou adaptar pra outra coisa.

## As páginas

Preview de 4 principais + o rodapé em [`preview/`](preview/) (rodapé à
parte porque é onde o nome do cliente aparece de verdade — o logo em si é
vetor, ver Armadilhas).

| Página | O que tem |
|---|---|
| `index.html` / `home-laundry-services.html` | Idênticas: hero cheio com carrossel de 3 slides (fundo azul), 3 selos "Save Time & Money / Pay Online / Satisfaction", grid de serviços, "como funciona", contador animado, depoimentos, blog, newsletter no rodapé |
| `home-dry-cleaning.html` | Variação "dry cleaning": hero com overlay decorativo (ver Armadilhas — imagem corrompida), mesma estrutura de seções com copy focado em lavagem a seco |
| `home-laundry-dry-services.html` | Terceira variação de home, combinando os dois serviços |
| `about.html` | Sobre, diferenciais, equipe resumida |
| `service.html` / `service-details.html` | Grid de serviços e detalhe de um serviço |
| `gallery.html` | Galeria com filtro (Isotope) — **tem um aviso de PHP vazado do build do vendedor cravado num item, ver Armadilhas** |
| `team.html` / `team-details.html` | Equipe em grid e perfil individual (com e-mail fake) |
| `price.html` | Tabela de planos/pacotes |
| `blog*.html` (7 variações) | Lista, grid 2/3 colunas, sidebar esquerda/direita, detalhe |
| `contact.html` | Formulário (via `mail.php`, PHP — não roda na Vercel), telefone/e-mail fixos, mapa |
| `cart.html`, `checkout.html`, `shop.html`, `shop-details.html`, `wishlist.html` | E-commerce que não serve pro nicho — ver "Para que serve" |
| `faq.html`, `error.html`, `typography.html` | Institucionais / guia de estilo do template |

## Como personalizar

```bash
templates/sites/limpeza-laun/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Troca a cor de marca (`--theme-color`, #8CC63F — 277 usos em CSS **mais**
dois gradientes e uma cor de texto cravados fora da variável **mais** 166
`fill=`/8 `stroke=` cravados em 22 ícones SVG soltos) e o nome do cliente.
**Não mexe** no acento azul fixo (`--theme-color2`, #2946B8) — ver
cabeçalho do script para o porquê.

## Armadilhas

- **A cor de marca não é só uma variável CSS.** `#8CC63F` aparece na
  declaração `--theme-color` (277 usos via `var()`), mas TAMBÉM cravado,
  literal, em mais dois gradientes decorativos e uma regra de cor dentro do
  mesmo `style.css`, e em 166 atributos `fill=`/8 `stroke=` espalhados por
  22 arquivos SVG soltos em `assets/img/icon/`, `assets/img/shape/` e nos
  três logos — incluindo o próprio `logo.svg`. Um `<img src="logo.svg">`
  não carrega CSS, então `var(--theme-color)` nunca alcançaria essas cores;
  o `personalizar.sh` já faz um `sed` abrangente por cima de CSS **e** SVG
  pra cobrir tudo isso de uma vez. Batido visualmente com screenshot RAW da
  `index.html` e da `home-dry-cleaning.html` antes de decidir: o verde
  domina fundo do header, nav, botões e CTA; o azul (`--theme-color2`)
  aparece só como acento pontual (hover de seta, um dos três cards de
  destaque, bordas) — por isso fica fixo.
- **Logo é SVG com o nome vetorizado, igual ao Qlinest.** `logo.svg` e
  `logo-white.svg` são um ícone (swirl/gota, cor `--theme-color`) MAIS a
  palavra "Laun" desenhada como path vetorial (contorno, cor
  `--title-color` #00151D) — não é texto de verdade, não aparece em busca
  por nome e o script não alcança. O `alt="Laun"` da tag `<img>` é texto de
  verdade e já foi trocado por `[NOME DO CLIENTE]`, mas isso não muda o que
  aparece visualmente na tela — só o texto lido por leitor de tela/SEO.
  Trocar o arquivo inteiro pela logo real do cliente.
- **Favicons são PNG rasterizado do ícone verde**, não SVG — 16 arquivos em
  `assets/img/favicons/`, o script não alcança (sed só mexe em texto).
- **"Laun" é substring de "Laundry" em ~800 lugares.** O pré-processamento
  usa fronteira de palavra (`\bLaun\b`) pra não virar "[NOME DO
  CLIENTE]dry Service" — confirmado que nenhuma ocorrência de "Laundry",
  "Laundering" ou "laundromats" foi tocada.
- **E-mail fake em 6 variações, não uma só.** `info@laun.com`,
  `info@Laun.com`, `help24/7@Laun.com`, `help24/7@gmail.com`,
  `info.example@gmail.com` e `kristinwatson@gmail.com` (esse último no
  card de um "funcionário" fictício em `team-details.html`) já vieram
  trocados por `[EMAIL]` (não `[NOME DO CLIENTE]`, pra não quebrar o
  domínio) — preencher com o contato real.
- **Telefone fake varia por página**, não é um número só (`+163-654-3569`,
  `+163-654-3579`, `+256 214 203 215` no rodapé de outra home) — trocar
  todos pelo real, conferir cada página em vez de confiar num find/replace
  único.
- **Fotos "com nome de foto de verdade" que são placeholder.** `hero/`,
  `service/`, `gallery/`, `team/` etc. têm nomes descritivos mas são todo
  cinza com a dimensão escrita dentro (ex. "845 x 850", "366 x 244") —
  confirmado batendo screenshot antes de mexer em qualquer coisa.
- **Imagem corrompida (bad CRC) na extração do zip**:
  `assets/img/hero/hero_overlay_2.png`. Confirmado lendo os chunks do PNG
  byte a byte (não só o aviso do unzip) — o arquivo está truncado de
  verdade. É usada 3x em `home-dry-cleaning.html` (as 3 slides do hero
  dessa variação específica) — **não** aparece em `index.html`, que usa
  `hero_overlay_1.png` (esse OK). Só vira problema se a variação
  "Home Dry Cleaning" for escolhida como página inicial; não foi
  recriada aqui, só documentada.
  A outra imagem corrompida do zip original, `documentation/images/output2.png`,
  ficou de fora porque a pasta inteira `documentation/` é a landing do
  vendedor (não o site) e não foi copiada — ver "Duas pastas no zip"
  abaixo.
- **Duas pastas no zip, só uma é o site.** O pacote original tinha
  `documentation/` (a página de apresentação do vendedor, com Bootstrap
  próprio e screenshots) e `download-version/` (o site de verdade, com as
  28 páginas listadas acima). Só `download-version/` foi copiada pra
  `html/`.
- **`gallery.html` tem um aviso de PHP vazado do build do autor** —
  "Undefined array key 8" com o caminho local
  `E:\web-dev\angfuzsoft\html\laun\build\...` cravado dentro do atributo
  `class` de um item de filtro (linha ~479). É sobra de exportação
  malfeita do vendedor, não conteúdo do site — vale limpar à mão antes de
  mostrar essa página pro cliente (não foi removida aqui, só documentada).
- **Formulário de contato usa PHP** (`mail.php`) — não roda em hospedagem
  estática como a Vercel. Trocar por `wa.me` ou serviço de formulário
  externo.
- **Conteúdo em inglês**, `<html lang="zxx">` (nem "en" — código ISO pra
  "sem conteúdo linguístico") — trocar pra `pt-BR` e reescrever com o tom
  do `identidade.md` do cliente.
- **Depoimentos e equipe são inventados** (nome, foto, cargo, nota) — usar
  só com selo "ilustrativo" visível, nunca como real.
- **Peso**: 32 MB é bem mais que os outros templates de limpeza/manutenção
  da biblioteca (Qlinest tem 2,6 MB) — quase tudo é a fonte de ícones Font
  Awesome Pro completa (24 MB, todos os pesos/estilos, não só os usados).
  Nenhuma imagem grande foi cortada; se o peso incomodar, dá pra podar os
  formatos de fonte não usados.
