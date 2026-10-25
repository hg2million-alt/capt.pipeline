# Barbearia / Salão — Trimly

Template padrão para barbearia e salão de beleza/cabelo. 9 páginas, **base
clara** (branco + dourado) com título em Teko (condensada, sem serifa), e um
`personalizar.sh` que sempre troca o título pra uma serifada display e
opcionalmente inverte pra base escura. Comprado como "Trimly — Modern
Barbershop & Hair Salon HTML Template" (o pacote original tinha ~30 páginas;
só 9 entraram na cópia).

**Peso:** 3,4 MB em `html/` · **Stack:** HTML estático + Bootstrap 5 + jQuery
+ Owl Carousel + jQuery UI (datetime picker) + WOW.js/animate.css · **Build:**
nenhum

---

## Para que serve

Barbearia, salão de beleza, salão de cabelo — o pacote original já é
"Barbershop & Hair Salon", então serve pros dois nichos sem mudar estrutura,
só o vocabulário (trocar "corte/barba" por "coloração/escova/tratamento" se o
cliente for salão de cabelo, por exemplo). Tem página de agendamento com
formulário completo (nome, serviço, data/hora, observações), equipe, galeria,
depoimentos e uma seção de "clube"/fidelidade pronta pra virar programa de
recorrência.

**Não serve** — ou serve mal — pra: barbearia que só quer uma one-page rápida
(esse é multi-página, 9 telas); salão que vende produto físico como carro-
chefe (isso é `academia-gymfito/`-nível de estrutura errada, aqui não tem
carrinho/loja).

## As páginas

Preview de cada uma em [`preview/`](preview/).

| Página | O que tem |
|---|---|
| `index.html` | Hero (headline gigante + subtítulo + CTA) · sobre · 3 categorias de serviço com foto · seção de agendamento embutida · prévia de galeria + bastidores · prévia de equipe · seção "Club" (fidelidade/comunidade) · depoimentos · contato + rodapé |
| `about.html` | Sobre mais longo, com o mesmo bloco de categorias/serviço e "Club" repetidos |
| `men-services.html` | Cards de serviço (nome + descrição, **sem preço** por padrão — ver Armadilhas) + galeria filtrável de fotos do próprio serviço |
| `team.html` | Carrossel de cards de equipe — vem com nome/cargo/Instagram **inventados** por pessoa (John, David, Alex...) |
| `gallery.html` | Grade de fotos + seção "Bastidores" pronta pra 3 vídeos verticais tipo reel (ver `.bastidores-grid` no CSS) |
| `testimonials.html` | Carrossel de depoimentos — texto, nota e foto de cliente são **fictícios** por padrão |
| `booking.html` | A página de agendamento sozinha, mesmo formulário do index |
| `contact.html` | Info de contato (telefone/e-mail/endereço/horário fictícios) + mapa embutido |
| `404.html` | Página de erro — fica fora de toda a limpeza de nav/rodapé/cor de fundo, é só o que tem |

## Como usar

```bash
cd templates/sites/barbearia-trimly

# base clara (como o template nasce), só troca a cor de destaque
./personalizar.sh clientes/xyz/site '#be8644' 'Barbearia XYZ'

# base escura: FUNDO1 = fundo principal, FUNDO2 = fundo alternado das seções
./personalizar.sh clientes/xyz/site '#35A7D8' 'Barbearia ABC' escuro '#102B3B' '#191C1B'
```

Em qualquer um dos dois modos o script sempre: troca o título de Teko
(condensada) pra Fraunces (serifada display — a maioria das barbearias pede
vintage/serifada, não a fonte condensada original); troca os 8 fundos de
seção/banner que só existiam como PNG/JPG de placeholder com a dimensão
escrita dentro por um gradiente nas próprias cores; esconde a silhueta+setas
do hero e o watermark "TRIMLY STYLE" pintado dentro de `vector.png`; dá crop
circular no slot de foto do "Club". Em modo escuro, também corrige duas
variáveis de CSS que fazem dupla função no original (cor de fundo E cor de
texto — ver Armadilhas) e seta `background-color` no `<body>`. O cabeçalho do
próprio `personalizar.sh` documenta cada passo em detalhe.

O original em `html/` nunca é alterado — cada cliente sai de uma cópia.

## Onde ficam as cores

Tudo em `assets/css/style.css`, bloco `:root` (linha ~62), 11 variáveis:
`--primary--color` (destaque — botão, preço, ícone), `--secondary--color`
(fundo principal), `--accent--color` (fundo alternado), `--black--color`
(texto/ícone que precisa ficar claro sobre fundo escuro), `--smoke--color`
(mesma dupla função de `--secondary--color`, ver Armadilhas),
`--text--color`/`2`/`3` (corpo de texto), `--border--color`,
`--light--grey--color`/`2`. **Só 2 cores soltas fora de variável** no CSS
inteiro (`#fff` e `#1f2328`, ambas texto) — o resto é 100% CSS custom
properties, o que torna esse template incomum na biblioteca: dá pra inverter
tema só mexendo em 11 linhas, sem precisar de um `tools/claro.js` dedicado
como o Elegencia.

## Armadilhas

Tudo isso já está corrigido pelo `personalizar.sh` — fica documentado aqui
pro caso de o próximo cliente pedir algo fora do padrão e for preciso mexer
na mão:

- **Variável de cor com dupla função.** `--secondary--color` e
  `--smoke--color` serviam, no original claro, tanto de **cor de fundo**
  quanto de **cor de texto claro fixo** (menu sobre o hero, títulos grandes,
  selos de confiança do agendamento, texto do "Club") — em modo claro as duas
  leituras davam a mesma cor (branco/cinza-escuro), escondendo que eram papéis
  diferentes. Ao inverter só a variável pro modo escuro, os usos-como-texto
  viram invisíveis (mesma cor do fundo ao redor). Nenhum desses casos aparece
  em `grep` — só em QA visual real, rolando a página. O script já troca os
  pontos confirmados (menu, hambúrguer mobile, títulos `.text-size-80`/`40`,
  `.smoke-text`, lista de confiança do agendamento, "Club", ícone do
  carrossel) pra `--black--color` fixo.
- **Watermark pintado dentro do PNG**, não como texto — `assets/images/
  vector.png` tem "TRIMLY STYLE" desenhado nos pixels. Não sai em nenhum
  find/replace de nome, já vem escondido por padrão (`display:none` na
  `.about-vector`).
- **`about-icon.png`** é um círculo cinza chapado sem ícone nenhum desenhado
  dentro — outro placeholder nunca finalizado do pacote comprado. Também já
  vem escondido.
- **Fonte + headline colidem se reativar o silhueta do hero.** A troca
  Teko→Fraunces deixa o `<h1>` mais largo; o silhueta decorativa
  (`banner-img1.png`) e as setas (`banner-left/right-arrow.png`) foram
  desenhadas pra largura da fonte antiga e ficam por cima do texto novo — por
  isso saem escondidas (`display:none`) por padrão em vez de repostas.
- **Altura do hero no mobile** (`responsive.css`, `@media max-width:575px`)
  já vem recalibrada pra 500px (era 670px) por causa da mesma troca de fonte
  — testado num cliente real, texto padrão "Seu estilo fala antes de você." Se o
  headline do próximo cliente for bem mais longo/curto, medir nas ferramentas
  do dev tools antes de considerar pronto.
- **8 fundos de seção eram placeholder com a dimensão escrita dentro**
  (ex.: "1920 × 702") — nenhuma dessas imagens é foto de verdade, em nenhum
  dos dois modos. O script troca por gradiente nas próprias cores. Se o
  cliente mandar uma foto real de fachada/salão pro hero da home, ver a nota
  "HERO" que o próprio `personalizar.sh` imprime ao terminar — a técnica
  usada (fundo num `::before`, zoom sutil via `@keyframes`) está documentada
  lá e testada num cliente real.
- **Preço, nome de equipe e depoimento são fictícios por padrão** — `men-
  services.html` não tem preço nas 3 categorias, mas o `index.html` original
  do pacote TINHA uma seção "Transparent Pricing" com preço chutado (o
  script não mexe nisso, é conteúdo, não estrutura — apagar na mão se o
  cliente não mandar tabela real). `team.html` vem com nome/Instagram
  inventados por barbeiro — trocar por cargo genérico sem nome, nunca por
  outro nome inventado. `testimonials.html` vem com depoimento fictício —
  marcar como ilustrativo, nunca como real.
- **Formulário de agendamento já é honesto por padrão** — `#appointmentForm`
  (em `index.html`, `booking.html`, `men-services.html`) não finge sucesso
  nem posta pra um PHP que não existe mais: o JS (`assets/js/carousel.js`)
  monta uma mensagem a partir dos campos preenchidos e abre um link
  `wa.me/[WHATSAPP]?text=...`. Preencher o número real antes de publicar —
  ou, sem número ainda, trocar esse link por algo que não quebre (âncora pra
  seção de contato com selo "a confirmar" visível), nunca deixar um
  `wa.me/` sem número.

## Referência

Já testado num cliente real de barbearia (base escura, ciano + navy +
carvão) — validou a inversão claro→escuro e a troca de fonte descritas acima.
