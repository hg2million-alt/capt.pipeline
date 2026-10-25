# Imóveis — LemanHouse

Template de imobiliária/portal de imóveis completo: catálogo com busca e
filtro, ficha de imóvel, corretor, agência, blog e área de conta de usuário.
43 páginas, **base clara** (branco + azul-marinho `#13293d` no
header/menu/rodapé). Comprado como "LemanHouse — Real Estate HTML Template".

**Peso:** 7,6 MB em `html/` · **Stack:** HTML estático + Bootstrap 5 +
Isotope (filtro client-side) + Slick + fontes auto-hospedadas · **Build:**
nenhum

---

## Para que serve

Corretor autônomo ou pequena imobiliária que precisa de um **catálogo com
vários imóveis**: grid/lista com filtro "For Rent"/"For Sale", calculadora
de financiamento, ficha de imóvel com galeria e mapa, página de corretor e
de agência. É o template mais completo dos três de imóveis da biblioteca.

**Não serve** — ou serve mal — pra quem quer destacar UM imóvel só (ver
`imoveis-quicksale/`) nem pra quem não vai manter blog/cadastro de usuário
(dá pra tirar essas páginas do menu, mas elas vêm no pacote).

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`home`, `properties-grid`,
`properties-single1`, `contact`) — o pacote tem outras ~39 no mesmo
grid/header/footer.

| Página | O que tem |
|---|---|
| `home.html` (e `home2`–`home6`) | 6 variações de home — hero, busca rápida, imóveis em destaque, depoimentos |
| `properties-grid*.html` / `properties-list.html` / `properties-map-*.html` | Catálogo em grid, lista e com mapa, com calculadora de financiamento na lateral |
| `properties-single1..5.html` | 5 variações de ficha de imóvel (galeria, mapa, características) |
| `agent.html` / `agent-detail.html` | Corretor em lista e perfil individual |
| `agencies.html` / `agencies-detail.html` | Agência em lista e perfil individual |
| `add-step-01..05.html` | Cadastro de imóvel em 5 passos (simulação de UI, sem backend) |
| `membership.html` | Planos de assinatura |
| `my-properties.html` / `favourite-properties.html` / `user-profile.html` | Área de conta de usuário (login simulado) |
| `blog*.html` | Blog em 4 layouts + post individual |
| `contact.html` | Formulário de contato + mapa do Google (interativo) |
| `404.html` | Página de erro |

## Como personalizar

```bash
templates/sites/imoveis-lemanhouse/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Troca a cor de marca (hex `#13293d`, repetido em 3 arquivos CSS — o tema não
usa CSS custom property, o SCSS já veio compilado pra hex literal) e o nome
do cliente. **Não mexe** nos azuis/verdes de status do imóvel (`#56ccf2`
"For Rent", `#6dcd6d` "For Sale", `#114a82`/`#4c58a4` nos botões da
calculadora) — ver cabeçalho do script para o porquê.

## Armadilhas

- **Logo é imagem, não texto.** `images/logo.png` (e `images/logo2.png`,
  variante clara usada em home2/home6) tem "LemanHouse Real Estate"
  desenhado dentro do PNG — trocar pela logo real nos 2 arquivos.
- **Nenhuma foto é local.** Todo card de imóvel e todo banner apontava pra
  `https://via.placeholder.com/LxA` — esse serviço saiu do ar (testado: não
  responde mais). Já trocamos as ~690 URLs por `placehold.co` (mesmo
  formato, mesma caixa cinza com a dimensão escrita dentro) só pra não
  publicar com imagem quebrada. Ainda assim, **sem foto real o site inteiro
  depende de um serviço externo pra mostrar até o placeholder** — trocar
  pelas fotos reais do imóvel/fachada/equipe antes de publicar é ainda mais
  importante aqui do que nos outros templates da biblioteca.
- **Telefone e endereço são fixos e falsos.** `+1 246-345-0695` e "PO Box
  16122 Collins Street West Victoria 8007 Australia" aparecem em toda
  página — trocar ou marcar "a confirmar".
- **E-mail fake já veio neutralizado.** `info@LemanHouse.com` virou
  `[EMAIL]` (8 ocorrências em 4 páginas) porque um find/replace pelo nome
  do cliente quebraria o domínio. Um segundo fake, `polygontheme@gmail.com`
  (credencial de exemplo em `user-profile.html`), não foi tocado — é a
  página de conta de usuário, sem uso numa demo de captação.
- **Nenhum formulário está ligado a nada.** Todo `<form>` usa `action="#"`
  ou nem tem `action`, inclusive `contact.html`. Os arquivos
  `php/form-process.php` e `php/form-process2.php` existem no pacote mas
  não são referenciados por nenhum HTML — nem com hospedagem PHP eles
  disparariam sozinhos. Pra funcionar na Vercel, trocar a ação por `wa.me`
  ou um serviço de formulário estático.
- **Busca/filtro funciona sem backend.** `properties-grid*.html` filtra
  "For Rent"/"For Sale" via Isotope (JS no navegador) — funciona normal na
  Vercel. A busca por endereço no header é só campo de formulário.
- **Imóvel, corretor e agência são inventados** — endereço, preço, m²,
  quartos, banheiros, nome e foto de corretor/agência não têm dado real;
  marcar como "ilustrativo" ou remover antes de publicar.
- **Páginas de conta de usuário não funcionam** (`add-step-*`, `membership`,
  `my-properties`, `favourite-properties`, `user-profile`) — simulam
  login/cadastro sem backend nenhum; raramente cabem numa demo de captação.
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra pt-BR e
  reescrever com o tom de voz do `identidade.md`, não traduzir ao pé da
  letra.
