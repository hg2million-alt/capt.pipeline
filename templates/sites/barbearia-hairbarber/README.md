# Barbearia / Salão — Hairbarber

12 páginas (3 homes + 9 internas), base **escura** (carvão + dourado
`#B48E40`), título em Arima Madurai (cursiva/script, efeito vintage-
barbershop) e corpo em Arimo (sans). Comprado como "Hair Salon and Barber
Shop HTML Template" — internamente o pacote se chamava "BarbeX" (nome do
tema, já removido daqui, ver Armadilhas). O zip original tinha 16 páginas;
`price.html`, `blog-grid.html`, `blog-standard.html` e `blog-details.html`
ficaram de fora desta cópia (ver "As páginas").

**Peso:** 8,0 MB em `html/` · **Stack:** HTML estático + Bootstrap (via
`all.css` bundlado) + jQuery + Swiper + Magnific Popup + Mean Menu + Font
Awesome (Pro, webfonts inclusos) · **Build:** nenhum — `assets/sass/style.css`
já vem compilado, o `.scss` fonte não foi copiado pra cá (não é necessário em
runtime, só o `.css` gerado é servido pelo HTML)

---

## Para que serve

Barbearia e salão de beleza/cabelo — igual ao `barbearia-trimly/`, o pacote
original já cobre os dois nichos, só troca vocabulário de corte/barba por
coloração/escova se o cliente for salão. A diferença real para o Trimly é
que o Hairbarber **nasce com loja de produto** (carrinho, checkout, página de
produto) — serve melhor pra barbearia que também vende pomada, óleo de barba,
shampoo no balcão. Tem também **3 homes com enfoques diferentes** (a home 1 é
genérica "melhor salão da cidade", a home 2 é mais "solução pra queda de
cabelo", a home 3 tem FAQ e uma seção de tendência de corte) e uma página de
equipe com 6 barbeiros.

**Não serve** — ou serve mal — pra: barbearia que só quer uma página única
rápida (esse é multi-página, 12 telas, mais pesado que o `pizzaria-onepage/`-
nível de simplicidade); cliente que NÃO vende produto físico e não quer a
aparência de loja no menu (ver nota LOJA abaixo — ou cortar as 4 páginas de
shop, ou aceitar que "Shop" fica no menu sem processar pagamento nenhum).

## As páginas

Preview de cada uma em [`preview/`](preview/).

| Página | O que tem |
|---|---|
| `index.html` | Home 1 — hero + sobre + 6 categorias de serviço + CTA de agendamento + 4 produtos em destaque + Working Hours + 2 depoimentos + tira de logos |
| `index-2.html` | Home 2 — ângulo "solução pra queda de cabelo", sidebar de contato no menu mobile, carrossel de 4 depoimentos |
| `index-3.html` | Home 3 — "tendência de corte", FAQ de 5 perguntas (reescritas nesta limpeza, ver Armadilhas), sem seção de blog |
| `about.html` | História da marca ("Since 1996") com foto+nome+cargo de fundador, missão, 2 depoimentos |
| `services.html` | 8 serviços com ícone (sem preço), "Working Hours", CTA de agendamento |
| `services-details.html` | Detalhe de 1 serviço (Head Massage), sidebar de categorias + "precisa de ajuda" |
| `team.html` | 6 cards de barbeiro (nome + cargo) + 2 depoimentos |
| `product-page.html` | Grade de produto (loja) com sidebar de categoria/produto popular/tags, filtro visual (não funcional) |
| `product-details.html` | 1 produto — galeria, preço com desconto, quantidade, abas de descrição/info/review, relacionados |
| `cart.html` | Carrinho com 2 itens de exemplo, cupom, subtotal — **não processa nada de verdade** |
| `checkout.html` | Formulário de endereço/pagamento — **idem, é só front-end** |
| `contact.html` | Info de contato + formulário + iframe do Google Maps |

## Como usar

```bash
cd templates/sites/barbearia-hairbarber
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#B48E40' 'Barbearia XYZ'
```

Só 3 argumentos — cor, nome, e nada mais. Ao contrário do Trimly, este
template **não tem modo escuro/claro** pra inverter (nasce só escuro) e não
precisa de troca de fonte (Arima Madurai já tem o efeito vintage/script que a
maioria dos clientes de barbearia pede; ver nota em `personalizar.sh`).

O original em `html/` nunca é alterado — cada cliente sai de uma cópia. Ao
terminar, o script imprime a lista completa do que ainda depende de material
do cliente (logo, fotos, vídeo, equipe, depoimento, preço, contato, mapa,
texto, loja).

## Onde fica a cor de marca

Uma variável só: `--primary-color` em `assets/sass/style.css`, bloco `:root`
(linha ~649), ~156 usos em todo o CSS. Zero hex cru fora de variável no
arquivo inteiro. É o template mais simples de recolorir da biblioteca depois
do Trimly — um `sed` de uma linha no `personalizar.sh` resolve tudo.

## Armadilhas

- **O nome do tema ("BarbeX") estava em TRÊS lugares diferentes**, e só um
  deles aparecia em busca de texto: `<meta name="author">` e o rodapé
  "Copyright © 2022 ThemeOri Website by Barbex" saíam num grep normal, mas o
  **logo (`logo.png` e `logo-2.png`) tinha a palavra "Barbex" desenhada nos
  pixels**, em branco/escuro quase invisível contra fundo transparente — só
  apareceu depois de compor a imagem sobre um fundo sólido pra conferir (ver
  "PNG transparente engana no preview" na memória do workspace). As duas
  imagens foram recortadas pra manter só o ícone (tesoura+pente dourado),
  sem nome nenhum — reutilizável como fallback quando o cliente não tem logo
  própria.
- **A assinatura do "fundador" em `about.html` era a assinatura de verdade do
  piloto Dale Earnhardt** (`assets/img/avatar/signature.png`) — mais um caso
  de conteúdo baixado escondido em imagem, não em texto. A imagem foi
  **removida** (não dá pra "esconder com display:none" e reaproveitar depois,
  é assinatura de pessoa real morta em acidente famoso — sem uso possível).
  O slot agora mostra só nome + cargo ("Founder"), sem assinatura.
- **12 nomes fictícios no pacote original eram, na verdade, gente real
  famosa** — Devin Booker (NBA), Michelle Yeoh, David Fincher, Rooney Mara,
  Kevin Spacey, Aaron Sorkin, Ridley Scott (em depoimentos/equipe), e depois
  mais uma leva na home 2: David Beckham, Michele Morrone, Cansu Tuman e
  Michel Aoun (ex-presidente do Líbano) usados como "clientes satisfeitos".
  Todos os 12 foram trocados por nomes genéricos brasileiros (Marcus Silva,
  Rafael Costa, Camila Souza, Bruno Almeida, Lucas Pereira, Diego Martins,
  Pedro Henrique, Carla Mendes, Felipe Nogueira, Thiago Ramos, Larissa
  Freitas, Anderson Lima). Isso não estava em nenhum outro template da
  biblioteca até agora — vale conferir os próximos pacotes do mesmo lote por
  segurança, o autor claramente usava lista de nome pronta sem filtrar.
- **FAQ da home 3 e o texto "Benefit of our service" de `services-details.html`
  eram conteúdo de outro nicho colado sem revisar** — perguntas tipo "Protect
  Your Business with Insurance?" e "Open a Business Bank Account?" (FAQ de
  seguro/banco, nada a ver com salão) e um parágrafo de "Guia pra atrair
  cliente pra sua agência, Amazon, Walmart ou General Motors" no lugar da
  descrição de massagem capilar. Os dois foram reescritos com conteúdo
  coerente (ainda genérico/`[ILUSTRATIVO]`, mas pelo menos sobre barbearia).
  Não é uma limpeza de licença, é bug de conteúdo do autor original — mas
  ficaria péssimo entregue assim num demo de cliente.
- **Todas as imagens são placeholder cinza com a dimensão escrita dentro**
  (ex.: "1920x950", "600x600"), **apesar de as pastas terem nome de foto de
  verdade** (`about/`, `avatar/`, `features/gallery-*`, `products/`,
  `team-*.jpg`) — só o nome da pasta sugere foto real, nenhuma imagem é.
  Mesmo padrão do `climatizacao-oyoxo/` (100% placeholder), ao contrário do
  Coolair ou do Trimly (que pelo menos tinham foto real ou fundo tratável).
- **`price.html` e as 3 páginas de blog foram cortadas desta cópia** — a
  primeira porque tinha cards de preço estilo assinatura SaaS ("$47/mês") sem
  nada a ver com tabela de serviço de barbearia; as de blog porque o pacote
  não trouxe conteúdo de blog de verdade (só 3 posts fake linkando pra
  `blog-details.html`, mesmo texto reciclado). O menu, o rodapé e as seções
  de prévia de blog em `index.html`/`index-2.html` foram todos ajustados pra
  não linkar mais pra essas páginas — sem link morto no site que sobrou.
- **`isotope.pkgd.min.js` foi removido** — vinha no zip mas não é carregado
  por nenhuma página (nenhum `<script>` aponta pra ele, é lixo do pacote
  original), e o cabeçalho do arquivo cita "Isotope Commercial License for
  commercial use" como alternativa ao GPLv3 — como não tem uso nenhum, mais
  simples tirar do que decidir se a licença serve pro João.
- **Sidebar de "Tags" em `product-page.html` linkava pra `blog-standard.html`
  com categorias de blog genérico** (Design, Brochure, Business, Marketing,
  Branding) — na verdade não tem nada a ver com produto de barbearia.
  Trocado por tags de produto reais do nicho (Shampoo, Pomada, Barba, Óleo,
  Kit, Skincare), linkando pra `product-page.html`.
- **Contato**: telefone, e-mail (`support@gamil.com` — até o e-mail fake
  tinha erro de digitação), endereço (Plus Code de Buxton/Welshpool, Reino
  Unido) e "Working Hours" (segunda, quinta e quarta fora de ordem, sem os
  outros dias) viraram `[WHATSAPP]`, `[EMAIL]`, `[ENDERECO]` e `[HORARIO]` —
  inclusive dentro de `href="https://wa.me/..."` e `mailto:`. O iframe do
  Google Maps em `contact.html` continua apontando pra um embed genérico de
  Nova York (não dá pra virar placeholder de texto, é um iframe) — trocar
  pelo embed real antes de publicar.
- **Vídeo de terceiro no botão de play do hero/"Working Hours"** (`index.html`,
  `index-2.html`, `index-3.html`) abre um YouTube público que não é nem do
  autor do tema nem do cliente — trocar pelo vídeo real ou remover o botão.
- **Typos do pacote original corrigidos**: "Need Yor any help Contact with
  Us" → "Need Any Help? Contact Us" (`contact.html`); "Showing 1-12 oh 36
  Result" → "Showing 1-12 of 15 Results" (`product-page.html`, e o número 36
  também estava errado — a grade só tem 15 produtos no total); "Facial Hair
  trip" → "Facial Hair Trim" (sidebar de `product-page.html` e
  `services-details.html`); "Call Mow" → "Call Now" (`index.html`).
- **A loja (cart/checkout/product-page/product-details) é só front-end** —
  "Add to Cart", "+/-" de quantidade e "Place Order" funcionam visualmente
  (JS local) mas não cobram ninguém nem gravam pedido em lugar nenhum. Só
  publicar essas 4 páginas se o cliente vende produto físico de balcão E o
  time entende que não é checkout de verdade — do contrário, cortar as 4
  páginas e os links "Shop" do menu (ver "Bloco de template sem uso não
  entra no demo" na memória do workspace).

## Comparação com os outros templates da categoria

- **`barbearia-trimly/`** continua sendo o padrão pra quem só precisa de site
  institucional (9 páginas, agendamento embutido, sem loja) e é o único com
  inversão clara↔escuro pronta via script. O Hairbarber é para quando o
  cliente pede loja de produto ou quer variar mais de uma home — mas em
  compensação, nasce só escuro (sem opção clara) e chegou com bem mais lixo
  de conteúdo pra limpar (nome de gente real em texto E em imagem, FAQ fora
  do nicho, links mortos de blog/preço) do que o Trimly teve.
- **`barbearia-barberon/`** — outro agente está empacotando esse template em
  paralelo; na hora em que este README foi escrito ainda não existia na
  biblioteca. Sem material pra comparar ainda; quando os dois existirem, vale
  registrar no catálogo central qual serve melhor pra quê (isso não é
  trabalho deste agente — ver "Não faça" da tarefa).

## Referência

Ainda sem cliente publicado a partir deste template (empacotado em
26/09/2026, biblioteca pura). Testado só com `Barbearia Teste` / verde
`#2E7D5B` neste processo de limpeza — ver `preview/` para o resultado visual
real (cor + nome já trocados, placeholders intactos).
