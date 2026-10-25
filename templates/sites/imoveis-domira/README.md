# Imóveis — Domira

Template de imobiliária minimalista/editorial: catálogo com filtro,
comparação de imóveis, ficha de imóvel, blog e contato. 12 páginas, visual
preto + bege claro com um acento de cor (laranja `#FE5631` de fábrica) só em
detalhe. Comprado como "Domira — Real Estate HTML Template" (nome interno
confirmado no `<title>`; o pacote de origem chama a pasta de "domiara").

**Peso:** 5,5 MB em `html/` · **Stack:** HTML estático + GSAP (ScrollTrigger/
SplitText) + Swiper + Isotope (filtro) + fontes auto-hospedadas · **Build:**
nenhum

---

## Para que serve

Corretor autônomo ou pequena imobiliária que quer um catálogo com **visual
editorial/moderno** (tipografia grande, muito branco, cards em cor sólida em
vez de foto de capa) em vez do azul convencional de site de imóveis. Tem
filtro de listagem, comparação de imóveis, ficha de imóvel com calculadora e
blog.

**Não serve** pra quem quer destacar um imóvel só (ver `imoveis-quicksale/`)
nem pra marca que precisa de CTA na cor da marca — os botões principais
ficam pretos por design, só o detalhe secundário usa a cor do cliente (ver
Armadilhas).

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `listing-grid-full-width`,
`property-details`, `contact-us`) — as outras 8 seguem o mesmo
header/footer.

| Página | O que tem |
|---|---|
| `index.html` / `home-2.html` | 2 variações de home — hero com busca por cidade/tipo/preço, categorias de imóvel |
| `listing-grid-full-width.html` / `listing-filter-sidebar.html` / `listing-top-filter.html` / `listing-top-map.html` / `listing-half-map-grid.html` | 5 variações de catálogo — grid, com filtro lateral, filtro no topo, com mapa |
| `search-results.html` | Resultado de busca |
| `property-details.html` | Ficha de imóvel — galeria, características, calculadora, corretor responsável |
| `blog-defaults.html` / `blog-single.html` | Blog em lista e post individual |
| `contact-us.html` | Formulário de contato |

## Como personalizar

```bash
templates/sites/imoveis-domira/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Troca a cor de marca (`--Primary`, CSS custom property única, 41 usos) e o
nome do cliente. **Os botões sólidos principais** ("View Properties",
"Search Property", "Filters") **ficam pretos mesmo depois de trocar a
cor** — não é bug, é a paleta do tema: preto pro CTA, `--Primary` só pro
acento secundário (sublinhado do menu ativo, tag "For Rent"/"For Sale",
ícone em hover). Ver cabeçalho do script se quiser também recolorir os
botões pretos (não é troca de 1 linha).

## Armadilhas

- **Logo é SVG com o nome vetorizado.** `images/logo/logo.svg` tem "Domira"
  desenhado como contorno (texto convertido em `<path>`), não como texto de
  verdade — usado 3x por conjunto de páginas (header fixo + normal +
  rodapé). Trocar pelo SVG/PNG da logo real do cliente nos 3 lugares.
- **Nenhuma foto é real — nem placeholder com dimensão.** Ao contrário dos
  outros templates da biblioteca, `images/properties/`, `/agents/`,
  `/house/`, `/banner/`, `/section/`, `/avatar/` e `/blog/` são todo **bloco
  de cor sólida** (azul-claro, bege, cinza), sem nem o texto da dimensão
  escrito dentro — fica com cara de wireframe até entrar foto real.
- **E-mail do autor do tema exposto.** `themesflat@gmail.com` (contato do
  autor do tema) aparece em quase toda página, e `mccoy@domira.com` (e-mail
  de um corretor fictício) em `property-details.html` — ambos já vieram
  trocados por `[EMAIL]` (75 ocorrências). Sem essa troca, um formulário
  ligado a esse endereço mandaria mensagem do cliente pro autor do tema, não
  pro cliente.
- **2 páginas têm hex de marca direto no HTML, fora da variável CSS.**
  `property-details.html` e `blog-single.html` têm ícone SVG inline com
  `fill="#FE5631"` — o script já cobre isso além da variável `--Primary`.
- **Imóvel e corretor são inventados.** Endereço, preço, m², quartos,
  banheiros e o corretor "mccoy" (nome, foto, contato) em
  `property-details.html` não têm dado real — marcar "ilustrativo" ou
  remover antes de publicar.
- **Nenhum formulário está ligado a nada** — todo `<form>` usa `action="#"`,
  inclusive `contact-us.html`. Pra funcionar na Vercel, trocar a ação por
  `wa.me` ou um serviço de formulário estático.
- **Busca/filtro funciona sem backend** — `listing-*.html` filtra e ordena
  via JS no navegador (Isotope), funciona normal na Vercel.
- **Degradê de fundo é fixo, não é cor de marca.** O degradê bege→azul-claro
  do hero, da listagem e da ficha de imóvel (`#DCEDF5` → `#F9F1E5`) é
  hardcoded no CSS, sem variável — não muda com a COR do cliente.
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra pt-BR e
  reescrever com o tom de voz do `identidade.md`.
