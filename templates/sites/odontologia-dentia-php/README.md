# Odontologia — Dentia (PHP)

Template comprado "Dentia — Dental Clinic and Dentist Website Template" (php
web template), guardado em 26/09/2026 já limpo. **É a variante PHP** — existe
uma segunda cópia do mesmo visual em `odontologia-dentia-next/` (Next.js),
empacotada em paralelo. Ver [Duas versões do mesmo Dentia](#duas-versões-do-mesmo-dentia)
antes de escolher qual usar.

**Stack: PHP com `include` simples (header/footer/menu) — sem framework, sem
CMS, sem banco de dados.** Não é Laravel, não é WordPress: são arquivos
`.php` que fazem `include 'includes/header.php';` no topo e
`include 'includes/footer.php';` no fim, e mais nada de dinâmico além disso.
Confirmado por grep: zero ocorrência de `mysqli`, `PDO`, `mysql_connect` ou
qualquer `$conn` no projeto inteiro.

**Peso:** ~31 MB · **Build:** nenhum · **Deploy:** precisa de runtime PHP
(a maioria dos deploys da oficina é estática — ver [Deploy](#deploy) abaixo)

---

## Para que serve

Clínica ou consultório odontológico multi-página: 10 variações de home,
serviços em grade, equipe, agendamento, FAQ, depoimentos, blog, contato.
**Nasce claro** — fundo branco, azul `#4A7CD2` de acento e navy `#00173c`-like
nas seções escuras (stats, CTA, rodapé). Titulo em fonte arredondada (tipo
"Fredoka"/similar, ver `<head>` de cada página), corpo em sans padrão.

Diferencial real deste template dentro da biblioteca: **as fotos são de
banco real** (equipe, depoimentos, hero) — não silhueta cinza como o
`odontologia-decare/`. Ajuda a mostrar como fica o layout preenchido antes de
trocar pela foto do cliente.

**Para que não serve:**

- Cliente que não tem quem hospede PHP corretamente, ou que não vai mexer
  em runtime PHP na Vercel — ver a seção Deploy antes de prometer prazo
- Marca escura ou minimalista sem grade de serviço/equipe/FAQ — o template é
  "clínica cheia de seção", igual ao Decare nesse sentido
- Demo de captação **sem foto do cliente** e sem querer avisar que são fotos
  de banco — ao contrário do Decare, aqui as fotos parecem reais o
  suficiente para enganar sem o aviso "ilustrativo"

## Páginas

Preview em [`preview/`](preview/) — 9 páginas em desktop + `index-celular.jpg`.
Todas as capturas foram feitas com o método descrito em
[Como os previews foram gerados](#como-os-previews-foram-gerados) — PHP não
está instalado nesta máquina (ver seção Deploy).

| Página | Serve para demo? | Observação |
|---|---|---|
| `index.php` | **Sim** | Home padrão: hero com foto real + "Google Rating 5.0 / Based on 23k Reviews" fixo (fake, marcar) |
| `homepage-2.php` a `homepage-10.php` | Só UMA | 9 variações da mesma home, mesma seções em ordem/estilo diferente. `homepage-3.php` e `homepage-7.php` são standalone — **não usam `includes/header.php` nem `includes/footer.php`**, duplicam tudo dentro do próprio arquivo |
| `about.php` | Sim | Sobre + "why choose us" + equipe (4 dentistas reais no layout, nomes fictícios) |
| `services.php` / `service-*.php` (6 arquivos) | Sim | Grade de 6 especialidades com ícone; cada uma tem página de detalhe própria |
| `dentists.php` | Só com equipe real | Mesmos 4 "Dr." de `about.php`, cartão maior |
| `booking.php` | Sim | Formulário de agendamento (serviço/data/hora/contato) — ver armadilha de `mail()` |
| `contact.php` | Sim | Formulário de contato — mesma armadilha de `mail()` |
| `faq.php` | Sim | Accordion, perguntas genéricas de clínica |
| `gallery.php` | Só com foto | Galeria isotope — antes/depois cabe aqui |
| `testimonials.php` | **Cuidado** | 18 depoimentos citando 18 "Dr." diferentes (Patel, Kim, Chen, Rodriguez...) que **não batem** com os 4 dentistas de `about.php`/`dentists.php` — cortar pra 4 depoimentos coerentes com a equipe real, ou trocar por depoimento real do cliente |
| `blog.php` / `blog-single.php` | **Não** | Posts inventados ("10 Easy Tips...", "Is Teeth Whitening Safe...") |

## Como os previews foram gerados

`php -v` não retornou nada nesta máquina (sem XAMPP/Laragon/WAMP instalado) —
não deu pra rodar `php -S localhost:8000` de verdade. Em vez de pular o
preview, os 9 arquivos `.php` mais relevantes foram "achatados" à mão: um
script Node descartável resolveu os `include 'includes/header.php'`,
`include 'menu.php'` e `include 'includes/footer.php'` e os laços
`foreach ($page_css ...)` / `foreach ($page_js ...)`, gerando `.html`
estático equivalente, servido por `python -m http.server` e fotografado via
Playwright (script não fica no template — só serviu pra tirar print). É
fidelidade alta pro que o navegador realmente renderiza (mesmo CSS/JS/imagem
rodando), mas **não é o mesmo que rodar o PHP de verdade** — confirmar layout
final com `php -S` depois de instalar PHP.

Achado no processo: os cards de serviço, stats, equipe e FAQ ficavam **em
branco** na primeira tentativa de screenshot — o template usa WOW.js
(`class="wow fadeInUp"`) pra revelar seção só quando ela entra no viewport
por scroll, e um screenshot `fullPage` instantâneo não dispara isso. Corrigido
injetando `.wow{opacity:1!important}` antes de cada print. Os contadores
animados ("0+ Happy Patients" etc.) ainda aparecem zerados nos prints — só
tocam a animação de verdade com JS de scroll rodando num navegador real,
irrelevante em produção.

Para gerar preview de verdade: `winget install PHP.PHP` (ou XAMPP/Laragon),
depois `cd php && php -S localhost:8000` e navegar em cada página.

---

## Como usar

```bash
cd templates/sites/odontologia-dentia-php
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#1A6B4F' 'Sorriso Feliz'
```

Argumentos: destino, **cor de acento**, nome do cliente, e opcional **cor de
acento 2** (derivada da primeira se não for passada). Testado em 26/09/2026
com verde `#1A6B4F`: variável CSS trocada, RGB recalculado certo, nome e ano
preenchidos no rodapé e nos forms. Sobram: título fixo em `includes/header.php`
(não é slot — editar na mão, ver Armadilhas), logo (PNG com nome desenhado
dentro) e os 7 ícones de serviço (PNG line-art azul).

## Onde fica a cor

**Um arquivo só, variável CSS de verdade — bem mais simples que o
`odontologia-decare/` (que tem hex espalhado em 4 CSS + inline):**

```css
/* css/colors/scheme-01.css */
* {
  --primary-color: #4A7CD2;
  --primary-color-rgb: 74, 124, 210;
  --secondary-color: #EAA638;
  --secondary-color-rgb: 59, 157, 31;   /* obs: já vinha errado no original —
                                            59,157,31 não é o RGB de #EAA638.
                                            O personalizar.sh sempre recalcula
                                            o RGB certo, não copia esse valor. */
}
```

Confirmado por grep: **zero** hex/rgb de marca duplicado em `style=""` inline,
`plugins.css`, `bootstrap.min.css` ou `swiper.css` — só esse arquivo. `--primary-color`
é usado via `var()` em todo `css/style.css` (botões, links, `.id-color`,
barra de agendamento, FAQ, CTA, rodapé).

**O que continua azul depois do script, porque é imagem, não CSS:**
- `images/logo-black.webp` / `logo-white.webp` — logo com o dente **e** o
  nome "dentia" desenhados dentro do arquivo, não é texto
- `images/icons/tooth-1.png` a `tooth-7.png` — ícones da grade de serviço,
  line-art PNG na cor azul original, fundo transparente
- `images/logo/1.png` a `10.png` — logos placeholder "Logoipsum" da faixa de
  parceiros em `homepage-7.php` (cortar a seção, não vale recolorir)

## Duas versões do mesmo Dentia

Este pacote (`odontologia-dentia-php/`) é a variante **PHP**: HTML/PHP puro,
sem build, roda em qualquer host com PHP — mas os formulários dependem de
`mail()` (ver Armadilhas) e o deploy na Vercel precisa de runtime PHP
explícito, fora do padrão estático da oficina.

Existe também `odontologia-dentia-next/`, empacotada em paralelo com o mesmo
visual em **Next.js**. Antes de escolher: se o destino é Vercel (padrão da
oficina) e o cliente não precisa de PHP por algum motivo específico, a
variante Next.js tende a encaixar melhor no fluxo de deploy já usado aqui —
usar a PHP quando o host final já é PHP, ou quando for só consulta rápida de
layout. Comparar o README de lá antes de decidir; este arquivo não foi
atualizado depois do empacotamento da variante Next.js, então confirme se o
comparativo de lá bate com o que está escrito aqui.

## Armadilhas

- **`mail()` do PHP em `action-contact.php` e `action-booking.php`** —
  ambos mandavam pro e-mail do autor (`contact@designesia.com`), já trocado
  por `[EMAIL DO CLIENTE]`. Mas o problema de fundo continua: `mail()`
  depende de um MTA configurado no host (sendmail/SMTP) e **não funciona de
  graça em runtime serverless** — Vercel PHP incluso. Preencher o e-mail não
  resolve sozinho; ou configura SMTP de verdade, ou troca o form por `wa.me`
  como o resto da biblioteca. Testar em produção antes de prometer que o
  formulário funciona
- **`includes/header.php` tem título fixo pra todas as páginas** — mesma
  `<title>` e meta description em `index.php`, `about.php`, `contact.php`...
  Não há variável de título por página. SEO de verdade exige criar essa
  variável e ajustar cada página
- **10 homes quase iguais** — escolher uma cedo evita trabalho de sed em
  9 páginas que vão ser apagadas. `homepage-3.php` e `homepage-7.php` são as
  únicas que **não** usam `includes/header.php`/`footer.php` — se sobrar uma
  delas, editar direto nela
- **Depoimentos citam 18 dentistas fictícios** que não existem na página de
  equipe (4 "Dr." reais no layout) — ver tabela de páginas
- **Logo com nome desenhado dentro do PNG** — mesmo padrão do
  `manutencao-handify/`: sem logo real do cliente, ou fica com "dentia"
  escrito, ou alguém regenera a arte
- **`js/theme.js`** (renomeado de `designesia.js` — nome original removido)
  tinha um handler morto: clique em `#dark-mode` redirecionava o visitante
  pro site do autor (`designesia.com/themes/gospace`). Nenhuma página tem
  esse `id`, então era inofensivo, mas removido — se algum dia um botão
  `#dark-mode` for adicionado por engano copiando de outro template
  Designesia, não vai mais sequestrar o visitante
- **`includes/subheader.php`** existe mas não é usado por nenhuma página —
  cada página implementa o próprio bloco de subheader inline. Arquivo morto,
  mantido só porque não custa nada
- Ícone `.icofont-license`/`@license` dentro de `fonts/icofont/icofont.css`
  é o cabeçalho padrão da própria biblioteca de ícones (aponta pro license
  do icofont, não é restrição do Envato/autor do Dentia) — deixado como está,
  não afeta uso nem aparece em página nenhuma
- Removido: `documentation/` (manual do Envato), `demo/` de topo (badges
  "Elite Author"/"Featured"/envato.png — **não** confundir com
  `images/demo/*.webp`, que são os thumbnails reais do mega menu e foram
  mantidos), `fonts/elegant_font/Licensing/` (GPL/MIT), `fonts/icofont/demo.html`
  (showcase do icofont, não usado), e toda menção a "Designesia" em CSS/JS/PHP

## Deploy

**Sem `vercel.json`.** E diferente da maioria da biblioteca (que é HTML
estático), este template **precisa de runtime PHP** pra funcionar — a
Vercel serve `.php` com o runtime comunitário `vercel-php`, não nativo, e
isso é uma complicação real: exige `vercel.json` apontando função PHP pros
arquivos `.php`, e o runtime tem suporte próprio (não é garantia de
paridade 1:1 com um Apache/Nginx+PHP-FPM tradicional). `mail()` em particular
tende a falhar em ambiente serverless sem SMTP configurado à parte — testar
antes de prometer que o formulário funciona. Se o prazo for curto e o
cliente não exige PHP especificamente, considerar a variante
`odontologia-dentia-next/` para manter o fluxo de deploy estático padrão da
oficina.

## Já usado em

Nenhum cliente ainda — empacotado em 26/09/2026.
