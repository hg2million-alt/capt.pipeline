# Cinema — Movflx

Template HTML de **plataforma de streaming** (tipo Netflix/Prime), reaproveitado
como base visual para **cinema físico** (exibidor de sessões, não serviço de
assinatura). 9 páginas, 2 homes, **base escura com acento amarelo**.

**Peso:** 16 MB · **Stack:** HTML estático + Bootstrap 5 + jQuery (Isotope, Slick, Owl
Carousel, Magnific Popup, Odometer, AOS, WOW.js) · **Build:** nenhum

---

## Para que serve

Quem exibe filme e vende ingresso de sessão: **cinema, cineclube, sala de
exibição**. A estrutura de card de filme (pôster + título + ano + duração +
classificação + nota) e as grades/carrosséis de "em cartaz" e "em breve" são
exatamente o que um cinema precisa mostrar — só a ação do botão muda.

Serve bem para marca de **base escura**: já nasce com fundo entre `#04081a` e
`#20212b` (sem variável CSS, vários tons soltos) e acento amarelo `#e4d804`
puro em botão, aba ativa, ícone e linha. Trocar o amarelo pela cor de marca é
um `sed` — é o que o `personalizar.sh` faz. O azul-marinho profundo do Cine
Itaúna (`#050556` institucional, `#7A2FA3` roxo promocional) encaixa direto,
sem precisar inverter nada.

**Para que não serve, sem adaptar:** o template inteiro fala a língua de
**assinatura de streaming**, não de bilheteria física — "Sign In", "Watch Now"
(abre popup de trailer do YouTube), "Download Your Shows Watch Offline",
`pricing.html` com 3 planos mensais em dólar, `tv-show.html` de série por
episódio/temporada. Nada disso existe num cinema de rua. Usar como base exige
reescrever a ação de cada CTA (assistir → comprar ingresso / ver sessões) e
decidir o destino de duas páginas inteiras (ver abaixo). Quem quer só "grade
de filme com pôster e nota", sem nenhuma dessas seções, sai mais barato
escrevendo do zero do que apagando metade de um template de streaming.

## As homes

Preview de cada página em [`preview/`](preview/).

`index.html`: hero com selo de classificação + gênero + ano/duração e botão
"Watch Now" (popup de trailer) · carrossel "Upcoming Movies" com abas TV
Shows/Movies/Anime · seção "download offline" com 2 diferenciais · grade
"Top Rated Movies" com filtro Isotope (TV Shows/Movies/documentary/sports) ·
banner "Live Movie" com contador odometer (K+ clientes) · carrossel "World
Best TV Series" · newsletter "Trial Start First 30 Days".

`index-2.html`: mesma spinha dorsal, com barra de anúncio no topo
("Subscription!"), busca de filme no header e hero em slider (3 slides) em
vez de imagem única.

## Páginas internas

`movie.html` (grade de filmes com filtro por gênero/idioma — vira "Em
Cartaz") · `movie-details.html` (ficha do filme: sinopse, elenco/canal,
"Watch Now" + "Download", relacionados — vira ficha de sessão) ·
`tv-show.html` (grade de série por temporada/episódio — não existe em cinema
físico; decidir entre apagar ou reaproveitar a grade para "Em Breve") ·
`pricing.html` (3 planos de assinatura mensal — não existe em cinema; a
grade de 3 cards dá pra virar combo de bomboniere ou tipo de ingresso,
trocando "$/mês" por preço de combo) · `blog.html` / `blog-details.html`
(sem conteúdo do cliente, geralmente sai) · `contact.html` (formulário +
mapa do Google genérico de Nova York + endereço/telefone de mentira).

---

## Como usar

```bash
cd templates/sites/cinema-movflx
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#050556' 'Cine XYZ'
```

O script copia o template para a pasta destino, troca **a cor de acento** e
preenche o nome do cliente. O original nunca é alterado. Depois disso sobra
trabalho manual pesado — este template dá mais trabalho que os outros da
biblioteca porque **não é do nicho certo de origem**. O script lista tudo ao
terminar.

---

## Onde fica a cor

Não há `:root` nem variável. Uma cor de acento só, em hex literal:

| Cor | Papel | Usos |
|---|---|---|
| `#e4d804` | Amarelo: botão, aba ativa (Isotope/tab), quality tag (HD/4K/8K), ícone, hover, linha, odometer | 49, quase todos em `css/style.css` |

O fundo (`#04081a` … `#20212b`, mais de 10 tons soltos sem variável) já é
escuro e **não precisa trocar** para uma marca escura — só o acento amarelo
briga com qualquer marca que não seja amarela/dourada.

Fonte: `Poppins` (títulos e corpo), via `@import` do Google Fonts no topo do
`css/style.css` — já bate com o "Poppins Bold" que a identidade do Cine
Itaúna pede pra títulos, sem precisar trocar nada.

---

## O que já foi limpo daqui

- `lang=""` virou `lang="pt-BR"` nas 9 páginas
- `<title>Movfix - Online Movies & TV Shows Template</title>` virou
  `<title>[NOME DO CLIENTE] — [DESCRIÇÃO CURTA]</title>` — slot que o
  `personalizar.sh` preenche
- Toda menção de texto à marca do autor (`Movflx`, no sub-title do hero e no
  rodapé "All Rights Reserved By Movflx") virou `[NOME DO CLIENTE]`
- `support@movflx.com` (único e-mail do autor, em `contact.html`) virou
  `[EMAIL DO CLIENTE]`
- A pasta `Documentation/` do autor original foi removida

**Não havia** `__MACOSX/`, `.DS_Store`, barra de marketplace, seletor de
cores de demo nem script de rastreamento. Uma única menção solta a "Envato
Bottle 88" como nome de filme fake em `index-2.html` (conteúdo de exemplo,
não entulho de build).

---

## Armadilhas

**Toda imagem de conteúdo é um placeholder cinza com o tamanho escrito
dentro** — não é "foto de baixa qualidade", é literalmente um retângulo
`#c9c9c9` com o texto `"1920X602"` ou `"303X430"` desenhado nele. Banner do
hero, pôster de filme (10 arquivos em `img/poster/`), imagem de "serviços",
imagem "live" e capa de blog: nenhuma é foto de verdade. Isso vale tanto
para o índice quanto para as páginas internas. **Sem pôster/foto real do
cliente, todo card de filme fica com o número do tamanho escrito nele** — é
a primeira coisa a resolver, não a última. Numa demo de captação, o caminho
mais rápido costuma ser gerar uma arte de pôster ilustrativa por filme
(nome do filme + selo "pôster ilustrativo"), não deixar o placeholder cru.

**O hero é imagem estática, não vídeo.** `banner_bg01.jpg` (`index.html`) e
os 3 slides de `index-2.html` são `data-background` de imagem via CSS. Se o
cliente mandou vídeo de fundo (já aconteceu num cliente real), trocar por
`<video autoplay muted loop>` atrás do conteúdo do hero é reescrita manual —
o `personalizar.sh` não mexe nisso.

**Trocar o `banner_bg01.jpg` por foto real exige overlay novo, não só cor.**
O template nasceu pra um placeholder cinza chapado — não tem nenhum overlay
escuro no `.banner-area`, porque não precisava. Com foto de verdade atrás do
texto, uma camada só com gradiente diagonal (comum pra dar profundidade)
deixa a ponta mais clara sem contraste nenhum — nesse cliente real sumiu bem em
cima do próprio letreiro iluminado da fachada. Resolve com **duas camadas**:
o gradiente diagonal por cima de uma cor sólida semi-transparente por baixo
(`rgba(marca, .5)+` mínimo), garantindo escurecimento em qualquer trecho da
foto, mais `text-shadow` no título como reforço.

**`.banner-meta ul li` é `display:flex`, feito pra 1-3 palavras curtas
("Pg 18", "HD", "Romance, Drama") — não aguenta frase.** Reaproveitar o
`<li class="category">` pra uma frase inteira (3 `<a>` formando "Escolha seu
filme, compre seu ingresso e partiu cinema!") quebra no mobile: o
`flex-shrink` padrão espreme cada `<a>` pra caber na linha, e o texto embrulha
dentro de cada um, virando 3 blocos de 2 linhas desalinhados em vez de uma
frase corrida. Pra texto livre no hero, usar um `<p>` normal (sem `display:
flex` no pai) e estilizar à parte — não a classe `category`.

**Dois `banner-btn` lado a lado com `margin-left` manual desalinham ao
quebrar linha no mobile.** Sem `flex-wrap` + `gap` no pai, o segundo botão
herda a margem também na linha de baixo quando os dois não cabem mais lado a
lado — fica com um recuo a mais que o primeiro, em vez de alinhado. Envolver
os dois num contêiner `display:flex; flex-wrap:wrap; gap:Npx` resolve nos
dois breakpoints de uma vez.

**`pricing.html` e `tv-show.html` não têm equivalente em cinema físico.**
Ver "Para que não serve" acima. Decidir o destino de cada uma antes de
gastar tempo traduzindo o conteúdo — traduzir primeiro e decidir depois
inverte o trabalho.

**"Watch Now" abre um vídeo do YouTube num popup (Magnific Popup),
apontando pro canal oficial do Movflx.** Serve bem para trocar por trailer
oficial do filme (YouTube), mas continua sendo vídeo de terceiro embutido —
não é onde o cinema vende ingresso. O CTA de venda de ingresso de verdade
(link externo de bilheteria, ou WhatsApp) precisa de botão novo, não existe
no template.

**Contador "Active Customer" (`odometer`, "20K+") e "2.7 million" views em
`movie-details.html` são número de mentira do autor.** Sem dado real do
cliente, apagar — não é algo que um cinema de bairro tem como provar.

**Mapa do `contact.html` é um iframe do Google Maps fixo em Nova York**
(W38 Park Road), com telefone `(09) 123 854 365`. Trocar o embed pelo
endereço real ou remover a seção até ter endereço confirmado.

**Newsletter, "FAQs", "About Us" da barra superior de `index-2.html`, ícone
de idioma (EN/AU/AR/TU) e barra de busca "Find Favorite Movie" são recursos
de plataforma de conteúdo, não de cinema local** — geralmente saem.

**Abrir por `file://` funciona** — não há requisição same-origin bloqueada.

---

## Já usado em

| Cliente | Como foi usado | Resultado |
|---|---|---|
| Cinema (cliente real) | Acento amarelo → roxo `#7A2FA3`; `pricing.html` virou "Combos da Bomboniere"; `tv-show.html`/`blog*`/`index-2` saíram; pôster de filme virou card de gradiente CSS ("cartaz ilustrativo") porque o cliente não mandou pôster real; hero e "Conheça o espaço" usam still reais extraídos de um vídeo de reportagem de TV que o cliente guardou. Ajuste pós-QA mobile: overlay do hero ganhou camada sólida (só diagonal não bastava sobre foto real), frase do hero saiu do `<li class="category">` pra um `<p>`, e os dois `banner-btn` passaram a viver num `flex;wrap;gap` — ver Armadilhas | Publicado |
