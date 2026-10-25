# Imóveis — Quick Sale (imóvel único)

Template pra destacar **UM imóvel só** — não é catálogo. Hero com endereço e
preço fixos, galeria, tour, formulário de agendamento de visita e um punhado
de páginas de blog/galeria genéricas do tema. 58 páginas HTML no pacote (a
maioria variação de layout), **base clara** com laranja `#fa6839` + faixa de
menu verde-limão `#98bd15`. Comprado como "Quick Sale — Single Property HTML
Template".

**Peso:** 7,8 MB em `html/` · **Stack:** HTML estático + Bootstrap-like
próprio do tema + jQuery + Isotope + calendário de agendamento · **Build:**
nenhum

---

## Para que serve

Corretor que quer uma página dedicada pra **um imóvel específico** —
lançamento, imóvel de alto padrão, "coming soon" — com endereço, preço,
galeria, tour e agendamento de visita em destaque. Todo `<title>` do pacote
diz literalmente "single property".

**Não serve** pra imobiliária ou corretor que quer mostrar um catálogo com
vários imóveis (ver `imoveis-lemanhouse/` ou `imoveis-domira/` na
biblioteca) — não tem grid de listagem, filtro por preço/tipo nem página de
"todos os imóveis".

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `appointment`,
`pages-subpages-contacts`, uma das galerias) — as outras ~54 são variação de
layout do mesmo conteúdo (5 homes, ~35 páginas de blog/galeria em
grid/masonry/colunas, algumas páginas de ferramenta do tema).

| Página | O que tem |
|---|---|
| `index.html` (e as outras 4 `homepage-*.html`) | 5 variações de home — todas mostram o MESMO imóvel (endereço, preço) em layouts diferentes (slider, vídeo, apresentação, portfólio) |
| `appointment.html` | Agendamento de visita com calendário (`Not available` fixo nos dias, sem backend real) |
| `tour.html` | Tour do imóvel (imagens/vídeo) |
| `projects.html` | Grid do tema (reaproveitável como "outros imóveis" se o corretor tiver mais de um) |
| `gallery-*.html` (30 páginas) | Variações de galeria de fotos em grid/masonry/colunas — escolher 1 e apagar o resto |
| `blog-*.html` (16 páginas) | Variações de blog em grid/masonry/colunas — escolher 1 e apagar o resto |
| `pages-subpages-*.html` | Sobre, serviços, equipe, tabela de preço, FAQ, contato — conteúdo institucional genérico |
| `pages-tools-*.html` | Shortcode, tipografia, suporte, IDX — **documentação do autor do tema**, não conteúdo de imóvel (ver Armadilhas) |

## Como personalizar

```bash
templates/sites/imoveis-quicksale/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

O tema tem um arquivo de "skin" próprio (`css/general.css`) com 3 cores
fixas por design: laranja `#fa6839` (botão principal), verde-limão `#98bd15`
(barra de menu inteira) e azul `#1f9ad6` (detalhe secundário, bem menos
visível). O script troca **laranja + verde** juntos pela cor do cliente
(botão e barra de menu ficam com a marca) e deixa o **azul fixo** como
terciário — ver cabeçalho do script pro raciocínio completo.

## Armadilhas

- **Não é catálogo — é site de um imóvel só.** Confirmar com o cliente antes
  de usar; ver `imoveis-lemanhouse/`/`imoveis-domira/` se ele quiser mostrar
  vários imóveis.
- **Endereço e preço são invenção do tema.** "123 [nome do cliente] Street,
  Chicago, IL 60606" e "\$599,000" vêm de um trocadilho do tema com o
  próprio nome ("123 QuickSale Street") — reescrever com dado real do
  imóvel ou marcar "ilustrativo".
- **Zero foto real.** Hero, galeria e o único vídeo de exemplo (`video/`,
  usado em `homepage-video-tour.html`) são todos placeholder cinza com a
  dimensão escrita dentro.
- **E-mail fake já veio neutralizado.** `info@yoursite.com` e
  `markus@yoursite.com` (contato de um "agente" fictício chamado Markus)
  viraram `[EMAIL]` (56 ocorrências) — preencher com o contato real. O site
  "httt://example.com" ao lado do e-mail do Markus é erro de digitação do
  próprio tema — apagar a linha.
- **Nenhum formulário funciona.** Agendamento e contato não têm backend na
  Vercel — trocar a ação por `wa.me` ou um serviço de formulário estático.
- **Menu "Tools" é lixo do autor do tema.** `pages-tools-idx.html`,
  `-shortcodes.html`, `-typography.html` e `-support.html` são páginas de
  exemplo/documentação do tema, não conteúdo de imóvel — tirar do menu
  antes de publicar. O link "Documentation" que apontava pra uma pasta
  `doc/` de 46 MB (não trazida pra cá) já foi neutralizado pra `href="#"`
  nas 58 páginas pra não dar 404.
- **~35 páginas de galeria/blog são variação de layout**, não conteúdo
  diferente — escolher uma de cada tipo pro menu final e apagar o resto,
  senão o site publica com um menu gigante sem sentido pra imóvel único.
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra pt-BR e
  reescrever com o tom de voz do `identidade.md`.
- **Pacote original vinha com 59 MB**; já tiramos os 46 MB de `doc/` (site
  de documentação do tema, nunca linkado de forma funcional) e os 5,4 MB de
  `custom_menu/` (código do seletor de cor do tema, referenciado só em
  comentário `<!-- -->`, nunca carregado) — ficou em 7,8 MB.
