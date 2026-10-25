# Hospedagem — Leluxe

Site de hospedagem com cara de hotel-boutique: tela dividida (foto fixa à
esquerda, conteúdo à direita), título serifado (Eczar) + corpo em Work Sans,
tudo preto/branco/cinza com **um único acento amarelo `#ffd40d`**. Comprado
como "LeLuxe — Booking Hotel HTML Template" (2018). Nesta cópia foi
**traduzido e reescrito em pt-BR** para pousada/hotel pequeno do interior, com
reserva e contato indo para o WhatsApp.

**Peso:** 2,1 MB em `html/` (1,2 MB são as 4 fontes de ícone Material Design
Icons; 256 KB de imagens placeholder) · **Stack:** HTML estático + jQuery 3.3 +
Owl Carousel 2 + Zebra Datepicker + fancyBox 3 + Modernizr · **Build:**
nenhum — abre direto, sobe na Vercel como está.

---

## Para que serve

- **Pousada e hotel pequeno de cidade do interior** — é o encaixe natural:
  página de acomodações (lista + detalhe de um quarto com galeria), página de
  **café da manhã** em abas, galeria de fotos, pedido de reserva com datas e
  número de hóspedes, e a barra de reserva rápida fixa no rodapé da home.
- **Chalés / hospedagem rural** — funciona igual; "Chalé" já é um dos 4 tipos
  de exemplo.
- **Chácara/sítio de aluguel de fim de semana** — serve, mas com adaptação:
  a lista de "acomodações" vira "a casa / área de lazer / quartos", e a
  página de café da manhã provavelmente sai (ver personalizar.sh item 7).
  A barra de reserva (entrada/saída/adultos/crianças) encaixa bem.

**Não serve / serve mal para:**

- **Salão de eventos / chácara para festa** — não tem seção de capacidade de
  evento, pacotes, buffet nem formulário de orçamento de festa. Dá para
  adaptar, mas outro template de categoria de eventos seria melhor.
- **Hotel com motor de reserva de verdade** (disponibilidade, pagamento):
  aqui ninguém reserva nada pelo site, o pedido cai no WhatsApp.
- **Quem quer site colorido/rústico**: a linguagem é minimalista, branco e
  preto com um acento. Rústico de fazenda pede outro ponto de partida (ou
  cor terrosa + fotos fortes para compensar).

## As páginas (9)

Preview de todas em [`preview/`](preview/) (1440×1000, topo da página) +
`index-mobile.jpg` (390px).

| Página | O que tem |
|---|---|
| `index.html` | Home de tela cheia: carrossel de 2 fotos com frase, barra de reserva rápida (entrada/saída/adultos/crianças → WhatsApp), redes sociais |
| `about.html` | "Seja bem-vindo": foto + texto (tem `[HISTÓRIA DA CASA — ...]` para escrever) + barra de reserva |
| `accomodations.html` | Lista de 4 quartos de exemplo (Quarto Standard, Suíte Casal, Suíte Família, Chalé), foto larga + itens + "Consulte pelo WhatsApp" |
| `single-accomodation.html` | Detalhe da "Suíte Casal": carrossel de fotos à esquerda, itens, botão Reservar (leva para booking.html já com o quarto escolhido), compartilhar (Facebook/WhatsApp), galeria masonry de 6 fotos com legenda |
| `booking.html` | "Pedir reserva": nome, telefone, entrada, saída (calendário em pt-BR), adultos, crianças, acomodação, nº de quartos, observações → WhatsApp. Aceita `?room=&checkin=&adults=` na URL |
| `dinning.html` | Café da manhã: 4 abas (Quitandas, Do fogão, Frutas e sucos, Bebidas quentes), 12 itens de exemplo "Incluso na diária" + barra de reserva |
| `gallery.html` | Grade de fotos com lightbox (fancyBox) |
| `contact.html` | Mapa do Google (iframe, sem API key) + formulário → WhatsApp + endereço/telefone/e-mail |
| `404.html` | Página de erro em pt-BR com os links principais (a Vercel serve sozinha) |

**Removidas:** `styleguide.html` (vitrine de tipografia/botões do tema),
`blog.html` e `single-post.html` (pousada de interior não mantém blog; o post
trazia bio e link do autor do template), `sendmail.php`. Links para elas
(menu "Features", painel lateral, 404) foram refeitos. O menu ficou: Início ·
Sobre · Acomodações (▾ Todas / Suíte Casal / Pedir reserva) · Café da manhã ·
Fotos · Contato. Os nomes de arquivo originais (`accomodations`, `dinning`,
com a grafia errada do pacote) foram mantidos para não quebrar CSS/JS — o
visitante nunca vê.

## Como personalizar

```bash
cd templates/sites/hospedagem-leluxe
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2E5E4E' 'Pousada Recanto Verde'
```

Copia `html/`, troca a cor (e os 2 tons derivados), troca `[NOME DO CLIENTE]`
(escapando `&` e aspas), gera o `favicon.svg` com a inicial e a cor e, se a
cor for escura, escreve em `style-custom.css` o texto branco em cima dela. No
fim lista quantos placeholders ainda restam e o trabalho manual (10 itens).
Testado com `#2E5E4E` (verde escuro, nome com `&` e acento) e `#F2B4A0`
(salmão claro): 0 ocorrência da cor/nome antigos, original intacto.

## Onde fica a cor de marca

Conferido por screenshot: o site é preto/branco/cinza e **o amarelo
`#ffd40d` é a única cor** — botão "Reservar", marca-texto do item ativo do
menu e do botão WhatsApp, faixa atrás do preço, aba ativa do café, fundo do
submenu, dia selecionado no calendário, borda de campo em foco. Não há CSS
var: é hex cru.

| Valor | Usos | Onde |
|---|---|---|
| `#ffd40d` | 20 + 1 | `assets/css/style.css` (20) + `assets/css/zebra-datepicker.css` (1) |
| `#fffad4` | 2 | `style.css` — fundo de `<ins>` e `.alert.notice` (tom claro do amarelo) → o script deriva (88% branco) |
| `#fcf08d` | 1 | `style.css` — borda de `.alert.notice` → derivado (55% branco) |
| favicon | 1 | `favicon.svg` (gerado pelo script) |

Nenhum uso em `rgb()/rgba()`, SVG inline, PNG ou JS. `#f2f2f2`/`#000`/`#fff`
são os neutros do layout, não marca. Fontes: Google Fonts (Eczar 600 + Work
Sans 400/600) no `<head>` de cada página.

**Texto em cima da cor é preto** (pensado para amarelo). Cor escura → o
script mede a luminância (< 0,4) e vira esse texto branco, além de afinar o
marca-texto do menu e do preço para uma linha de 3–4px embaixo da palavra (em
10px escuro ele virava um risco por cima das letras — só aparece em
screenshot, não em grep).

## Fotos: tudo placeholder

O pacote não tinha **nenhuma** foto real — os `tmp/sample-*.jpg` eram
retângulos cinza lisos, e as duas "fotos" que apareciam no demo (vídeo do topo
da home e do café) eram **vídeos puxados do servidor do autor**
(`html.liviucerchez.com`), removidos. Nesta cópia `tmp/` virou
`assets/img/` com 14 placeholders cinza **legendados com o que deve entrar e o
tamanho** ("FOTO PRINCIPAL — fachada ou vista da propriedade · 1400×900",
"FOTO — item do café · 400×400"...). Trocar mantendo o nome do arquivo.

- `hero-1.jpg`/`hero-2.jpg`: só a home. `hero-2` é escuro de propósito — o
  slide tem `light-hero-colors` (texto e logo brancos). Foto real clara → tirar
  a classe.
- `topo-interno.jpg`: coluna esquerda de sobre/reservas/404.
  `quarto-topo-1/2.jpg`: carrossel do quarto. `cafe-topo.jpg`: café.
- Para pôr um vídeo do cliente no topo, o comentário no início do hero da
  `index.html` tem o markup (arquivo local em `assets/video/`, nunca link de
  terceiro).

## Armadilhas

- **Logo com 5 estrelas desenhadas.** O `tmp/logo.png` era "LeLuxe" + ★★★★★
  (classificação de 5 estrelas que nenhuma pousada do interior tem) e o
  favicon era "Le". Os dois foram descartados: o logo virou **texto** com o
  nome do cliente (`.text-logo`, Eczar, sem caixa alta — o `h1` do tema força
  uppercase, foi desligado). Nome longo quebra em 2–3 linhas (max-width 11em),
  aceitável. Com logo real, trocar o `<a class="custom-logo-link text-logo">`
  por `<img>` nas 9 páginas (markup no personalizar.sh).
- **Formulários não mandam e-mail — abrem o WhatsApp.** `sendmail.php`
  (PHP `mail()`, não roda na Vercel) e `jquery.form.min.js` foram removidos. O
  widget de reserva do original só levava para `booking.html`, que ignorava as
  datas. Agora `assets/js/wa-forms.js` monta a mensagem nos 3 formulários
  (reserva rápida, reserva completa, contato) e abre `wa.me/[WHATSAPP]`.
  **`[WHATSAPP]` aparece no JS e nos HTML** — trocar nos dois. Testado com
  Playwright: mensagens saem com datas `dd/mm/aaaa`, quarto escolhido e zero
  erro de JS. Ele precisa carregar **antes** do `functions.js` (preenche as
  datas iniciais — próxima sexta → domingo — antes do calendário montar).
- **Datas de 2018 fixas no HTML** (`13 Nov 18`) e calendário em inglês com
  semana começando na segunda: agora as datas vêm do JS e o calendário está em
  pt-BR (meses, "Dom Seg Ter...", domingo primeiro, formato `d/m/Y`).
- **Mapa exigia API key** (`maps/api/js?key=YOUR_API_KEY`, mostrava "Ops! Algo
  deu errado"). Virou iframe de embed sem chave, em cinza (como o original),
  subido 160px para esconder o cartão do Google que ficaria embaixo do logo.
  Com `[ENDEREÇO]` não trocado o mapa mostra **um lugar aleatório** (o
  preview mostra uma zona rural qualquer) — no iframe, `&` do endereço vira
  `%26`.
- **Seletor de idioma En/Fr/De** (fake, links `#`) virou um botão único
  "WhatsApp" no mesmo lugar; no celular era bolinha de 40px e o texto vazava —
  corrigido para pílula.
- **Preço em dólar** (`$50`–`$250 / night`): removido. Todos os quartos
  mostram **"Consulte pelo WhatsApp"** e o link já leva a mensagem com o nome
  do quarto (lido do `<h2>` pelo JS — renomear o título basta). Com tabela
  real, o comentário no topo de `accomodations.html` tem o markup com `R$`.
  No celular "Consulte" não cabia no canto e cobria o nome do quarto — o preço
  desce para baixo da lista abaixo de 992px.
- **Conteúdo de exemplo que PARECE fato**: os 4 quartos e seus itens
  (capacidade, "Banheiro privativo", "Café da manhã incluso", "Varanda com
  vista"), os 12 itens do café "Incluso na diária", legendas da galeria do
  quarto e as frases do topo são genéricos de pousada mineira — confirmar ou
  cortar tudo com o identidade.md. O que não dá para chutar ficou como
  placeholder visível: `[HISTÓRIA DA CASA — ...]`, `[DESCRIÇÃO DO QUARTO —
  ...]`, `[HORÁRIO DO CAFÉ]`.
- **Placeholders de contato:** `[WHATSAPP]` (só dígitos, DDI+DDD),
  `[TELEFONE]`, `[EMAIL]`, `[SITE]`, `[ENDEREÇO]`, `[INSTAGRAM]`,
  `[FACEBOOK]` — o script lista quantos restam. E-mail e site têm placeholder
  próprio, então trocar o nome nunca quebra domínio. O painel lateral (menu ☰
  em desktop ≥1200px) também tem endereço/telefone/e-mail.
- **Sem depoimento, estrela nem avaliação** em lugar nenhum — o tema não tinha
  seção de depoimentos, e o logo de 5 estrelas saiu.
- **Hifenização automática** do tema em pt-BR quebrava títulos no celular
  ("ver-dade") — desligada nos títulos.
- **CSS morto do blog** (`.author-box`, `.comment-list`, `.searchform`) ficou
  no `style.css` — inofensivo, invisível; não vale o risco de mexer.
- **fancyBox 3 (lightbox da galeria) é GPLv3 / licença comercial da
  fancyApps** — é de terceiro, veio no pacote, o header foi mantido. Para site
  comercial de cliente, o correto é a licença comercial da fancyApps ou trocar
  o lightbox (ex.: GLightbox, MIT). Os demais terceiros mantêm seus headers:
  jQuery, Owl Carousel, Modernizr e Bootstrap Reboot (MIT) e Zebra Datepicker
  (LGPL, sem header no .min).

## O que foi removido de autor/licença

- Header `LeLuxe - Hotel HTML Site Template / themeforest.net/user/liviu_cerchez`
  do `style.css`; "Animations for LeLuxe" do `style-animations.css`;
  namespaces `.leluxe` e funções `theme*` do `functions.js` renomeados.
- Bio, foto e 2 links do autor ("Published by Liviu Cerchez", liviucerchez.com)
  do `single-post.html` (página apagada).
- 14 URLs de vídeo/poster hospedados no servidor do autor
  (`html.liviucerchez.com/leluxe/tmp/...`) em index, about, blog, gallery e
  dinning.
- Meta `keywords` "Castilo, HTML, Template..." e description "LeLuxe is fully
  responsive creative HTML site template" das 12 páginas; rodapé "© 2018
  LeLuxe Hotel"; e-mails `contact@leluxe.com`/`suggestions@leluxe.com`,
  endereço de Lyon e telefones `+23` fictícios; créditos inventados de
  "arquitetos" (Kun Grigorshon, Anna Krikov).
- A pasta `Documentation/` do pacote não entrou. Não havia `__MACOSX`,
  `.DS_Store`, `node_modules` nem arquivo de licença dentro de `HTML/`.

Grep final (`envato|themeforest|licen|copyright|author|designed by|template
by|themes?|©|liviu|cerchez|castilo|leluxe`) só acha: classes CSS
`.entry-copyright`/`.author-box` (seletor, não texto), o `©` do rodapé do
próprio cliente e os headers de licença das bibliotecas de terceiros.

## Já usado em

Nenhum cliente ainda — entrou na biblioteca em 28/09/2026.
