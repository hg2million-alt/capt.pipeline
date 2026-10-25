# Personal trainer — Fitmas

Template comprado como "Fitmas — Gym & Fitness Center HTML Template". 23
páginas, **base clara com hero escuro** (branco + vermelho `#F41E1E`).

**Peso:** 36 MB em `html/` (quase todo em `assets/img`, são fotos reais, não
placeholder) · **Stack:** HTML estático + Bootstrap 5 + Swiper + Slick +
Magnific Popup + fontes do Google Fonts (Kanit, Kumbh Sans) · **Build:**
nenhum

---

## Aviso: isto é conteúdo de ACADEMIA, não de personal autônomo

Apesar de estar na prateleira de personal trainer, o "Fitmas" original é uma
academia física: fala de matrícula, mensalidade, quadro de vários
treinadores (`team.html`, `team-2.html`) e até uma loja de suplemento/
equipamento (`shop.html`). Não é a copy de "eu crio seu plano de treino" de
um profissional sozinho — é a copy de "matricule-se na nossa academia".

Se o cliente é um personal autônomo de verdade, **prefira o
`personal-progym`**, que já nasce com esse tom. Use o Fitmas quando: (a) o
cliente for um pequeno estúdio/box com mais de um profissional, ou (b) você
quiser só a linguagem visual (hero com números de fundo, cards vazados,
paleta clara+vermelho) como referência, reconstruindo a copy do zero — como
já foi feito com o Gymfito num cliente real de academia.

## Para que serve

Estúdio de treino pequeno, box de treino funcional, personal com equipe (2+
profissionais) que quer visual clean e claro em vez do escuro-agressivo do
Gymfito. Tem hero com números gigantes de fundo, seção de programas/serviço,
portfólio de projetos, blog, galeria e loja.

**Não serve** para personal 100% sozinho sem querer editar bastante (ver
aviso acima), nem para quem precisa de fundo escuro em todas as páginas — o
Fitmas é predominantemente claro, só o hero nasce escuro.

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `about`, `contact`,
`team`) — as outras 19 seguem o mesmo grid/header/footer.

| Página | O que tem |
|---|---|
| `index.html` / `home-2.html` / `home-3.html` | 3 variações de home completas, trocáveis por um submenu "Home" no menu — decidir qual fica antes de publicar |
| `about.html` | Sobre mais longo, números/estatística (gráfico circular animado) |
| `service.html` / `service-details.html` | Lista de serviços/programas em card e página de detalhe |
| `pricing.html` | Planos de mensalidade com preço fixo |
| `team.html` / `team-2.html` / `team-details.html` | Equipe de treinadores em card e perfil individual — pensado pra várias pessoas |
| `project.html` / `project-details.html` | Portfólio de "projetos"/resultados em grid e detalhe |
| `gallery.html` / `gallery-2.html` | Galeria de fotos |
| `shop.html` / `shop-details.html` | Loja de produto (suplemento/equipamento) com preço |
| `blog.html` / `blog-2.html` / `blog-details.html` | Blog em lista (2 layouts) e post individual |
| `contact.html` | Formulário de contato + telefone/e-mail fixos |
| `error.html` | Página de erro |

## Como personalizar

```bash
templates/sites/personal-fitmas/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Troca a cor de marca (`--theme-color`, variável CSS única) **e também o
mesmo hex escrito direto**, sem passar pela variável, em 15 ícones SVG, no
símbolo da logo e num gráfico circular do JavaScript (`main.js`) — os quatro
lugares em que o vermelho `#F41E1E` aparece fora do CSS. Também preenche o
nome do cliente (pré-processado como `[NOME DO CLIENTE]`) e já trocou 5
e-mails de mentira por `[EMAIL]` (dois deles usavam o próprio nome do
template no domínio, ex. "info@Fitmas.com" — trocados antes do nome pra não
quebrar o domínio) e o atributo de idioma pra `pt-BR`.

## Armadilhas

- **Logo é SVG com o nome vetorizado.** `assets/img/logo.svg`,
  `logo-white.svg` e `logo2.svg` têm "Fitmas" desenhado como contorno (texto
  convertido em path), não como texto de verdade — o script não alcança. O
  círculo/swoosh do símbolo já muda de cor com a marca (mesmo hex), só o
  texto propriamente precisa ser trocado pela arte real do cliente.
- **Não tem placeholder cinza — são fotos de banco de imagens reais.**
  Diferente do padrão "dummy-img-WxHxx.jpg com a dimensão escrita dentro",
  aqui `assets/img/hero`, `team`, `blog`, `gallery` e `project` são fotos de
  verdade de pessoas e academias que não são o cliente — mais enganoso que
  um cinza óbvio, então é ainda mais importante trocar todas antes de
  mostrar o demo.
- **5 e-mails de mentira espalhados**: `health@Fitmas.com`,
  `info@Fitmas.com`, `info@gmail.com`, `support@gmail.com`,
  `info@tronix.com` — todos já viraram `[EMAIL]`. Pelo menos 3 telefones
  fixos em links `tel:` (ex. `+259 (0) 256 215` no header) — trocar por
  WhatsApp real.
- **Formulário não funciona na Vercel.** `mail.php` precisa de hospedagem
  com PHP; a Vercel não roda. Trocar a ação do `<form>` em `contact.html`
  por um link `wa.me` ou um serviço de formulário estático antes de
  publicar.
- **Depoimentos repetem o mesmo texto.** Os 3 cards de depoimento da home
  têm literalmente a mesma frase ("I have been a member of Fitmas for over
  a year now...") só trocando nome/foto — nem inventaram variação. Usar só
  com selo "ilustrativo" visível, ou reescrever do zero.
- **Preço, equipe, produto de loja e post de blog são todos inventados** —
  sem dado real do cliente, marcar como ilustrativo ou remover a
  seção/página.
- **Conteúdo em inglês** — só o atributo `lang` já foi ajustado pra
  `pt-BR`; o texto em si precisa ser reescrito com o tom de voz do
  `identidade.md`, não traduzido ao pé da letra.
- **Redes sociais** no header/rodapé (Facebook/Twitter/Pinterest/Instagram/
  Discord/LinkedIn/YouTube/Google) apontam pra `www.<rede>.com` genérico —
  preencher ou remover as que não existem.
- **`assets/css/theme.css` e `assets/sass/`** (duplicata não usada e fonte
  SCSS não compilada) já foram removidos deste template — nenhuma página os
  carregava, eram só peso morto do pacote original.
