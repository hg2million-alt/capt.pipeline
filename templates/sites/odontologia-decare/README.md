# Odontologia — Decare

Template comprado "Decare – Dentist & Dental Clinic" (zcube, 2022), guardado em
14/09/2026 já limpo. **Primeira opção para dentista, clínica odontológica,
ortodontia, harmonização feita por dentista.**

**Peso:** 18 MB (10 MB é o vídeo do hero da home 3) · **Stack:** HTML estático +
Bootstrap 5 + jQuery · **Build:** nenhum · **Deploy:** criar `vercel.json`

---

## Para que serve

Clínica ou consultório odontológico que quer site multi-página com cara de
clínica: serviços em grade com ícone, "sobre", agendamento, FAQ, contato.
**Nasce claro** — fundo branco, azul `#3660d9` de acento e navy `#00173c`
nas seções escuras (FAQ, CTA, rodapé). Fonte Poppins (títulos e corpo).

Uma cor de acento + uma escura, ambas trocadas pelo `personalizar.sh`.
Clínica de identidade clara e uma cor de marca cai direto.

**Para que não serve:**

- **Marca pessoal de dentista com estética premium / boutique** (verde
  profundo + dourado, serifada, muito espaço vazio). O template é *clínica*:
  grade de 6 serviços com ícone de dente, barra de agendamento azul, equipe de
  4, planos com preço, blog, loja. Dá para usar como base, mas o trabalho é
  tirar seção, não preencher — e a serifada nos títulos entra por cima do CSS
- Marca escura (fundo preto dominante): 200 KB de CSS chumbado com fundo
  branco em quase toda regra — mesmo problema medido no Carlink
- Demo de captação **sem foto do cliente**: todo `<img>` é silhueta cinza.
  Hero, sobre, equipe, galeria, depoimento — nada vem preenchido

## Páginas

Preview em [`preview/`](preview/) — desktop de cada página e `index-celular.jpg`.

| Página | Serve para demo? | Observação |
|---|---|---|
| `index.html` | **Sim** | Hero dividido: texto à esquerda, foto recortada à direita com cartão flutuante "Dr. Nome" |
| `index-2.html` | Sim | Mesma home, hero vira slider com fundo claro |
| `index-3.html` | Sim | Mesma home, hero com **vídeo de fundo** (`img/slider/slider-vedio.mp4`, 10 MB) |
| `about.html` | Sim | Sobre + números + equipe + depoimento |
| `services.html` / `single-service.html` | Sim | Grade de serviços com ícone; detalhe com sidebar |
| `contact.html` | Sim | Form posta em `mail.php`, que foi apagado — trocar por `wa.me` |
| `faq.html` | Sim | Accordion |
| `projects.html` | Só com foto | Galeria isotope — antes/depois cabe aqui |
| `team.html` / `team-single.html` | Só com equipe real | Dentista solo: apagar |
| `pricing.html` | **Não** | Plano mensal com preço — inventa dado |
| `shop.html` / `shop-details.html` | **Não** | Loja de produto |
| `blog.html` / `blog-details.html` | **Não** | Post inventado; forms de busca e comentário já apontam para `#` (apontavam para um WordPress do autor) |
| `thank-you.html` | — | Pós-form |

As três homes são idênticas abaixo do hero. Seções da home, em ordem: hero →
6 serviços em grade (`#service-details2`) → sobre com "50 anos" →
**barra de agendamento** (`#booking`, nome/local/departamento — form sem
destino) → depoimentos (slider) → planos com preço (`#pricing`) → FAQ sobre
navy → equipe de 4 → CTA "Book Appointment" sobre navy → newsletter →
rodapé de 4 colunas.

---

## Como usar

```bash
cd templates/sites/odontologia-decare
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#263A32' 'Dra. Fulana' '#526259' '#1B1E1C' '#F5F2EC'
```

Argumentos: destino, **acento**, nome, e opcionais **acento 2** (outra ponta
do gradiente dos botões e fundo do breadcrumb), **escuro** (títulos e seções
escuras) e **claro** (bordas e tint) — derivados do acento se não forem
passados. O script troca ~30 hex e 3 `rgb()` em CSS e nos `style=""` inline,
o nome no `<title>`, no hero e no copyright, e o ano. Depois imprime a lista
de trabalho manual: escolher a home, apagar página que inventa dado, logo,
fonte, tradução, contato fake, forms sem destino, fotos, `vercel.json`.

Testado em 14/09/2026 com verde `#263A32` + grafite: botões, barra de
agendamento, FAQ, CTA, rodapé e copyright saem na cor. Sobra azul só no que
é imagem.

---

## Onde ficam as cores

Tudo hex/rgb literal, sem variável CSS, espalhado por `css/style.css`,
`css/default.css`, `css/responsive.css` e `style=""` inline nos HTML. O
`personalizar.sh` troca:

| Papel | Cores originais | Onde dói |
|---|---|---|
| Acento | `#3660d9` (238x), `rgb(54,96,217)` (27x, gradiente), `rgba(54, 96, 217, .3)` (sombra), `#1f53db` (borda de botão) | Botões, links, kicker, ícones de fonte |
| Acento 2 | `rgb(9,152,230)` (27x) e `#4e6087` (inline) | Outra ponta do gradiente dos botões e da barra de agendamento; fundo do breadcrumb das internas |
| Hover | `#3763eb` | Botão |
| Escuro | `#00173c` (49x), `#0e264f`/`rgb(14,38,79)`, `#010f2e`, `#030c26`, `#002e5b`, `#08162f`, `#00081b`, `#101c38`, `#162542`, `#12265a`, `#2a436c`, `#00163b`, `#010c26` | Títulos, FAQ, CTA (inline), rodapé (inline), copyright, botão da barra, **menu offcanvas do celular** |
| Claro | `#eaedff` (29x), `#bacdff`, `#d7dff7`, `#e4e9ff`, `#cacfef` | Bordas de card, tint, hover de link |
| Cinzas azulados → neutros | `#444d69`, `#8990b0`, `#b2c0d8` | Texto, placeholder, link do rodapé |

**O que continua azul depois do script, porque é imagem:** `img/icon/*.png`
(ícones dos 6 serviços e dos planos), `img/testimonial/qt-icon.png` (aspas),
`img/logo/*.png`, `img/slider/slider_bg.png` (degradê azul-claro do hero 1) e
`img/favicon.ico`. Fundos navy que eram PNG chapado (`call-bg.png` da CTA,
`bdrc-bg.png` do breadcrumb) já viraram `background-color` inline — por isso
o script alcança.

Não trocado de propósito: `#6f7172` (cinza de texto), `#f5f5f5`/`#e4e4e4`
(fundos), `#f4f4fe` (tint da seção de depoimento), `#8fb569`/`#4cc3c1`
(verde e ciano de ícone), `#fe4536` (erro) e uma cauda de 1x cada (cor de
rede social etc.) que não aparece na home.

Fontes: Poppins + Roboto por `<link>` do Google Fonts no `<head>` de cada
página; `style.css` ainda cita Playfair Display (4x) e Titillium (1x) sem
carregar — resquício.

---

## Armadilhas

- **Header top (`.header-top`)** com e-mail, telefone e redes fake — está em
  todas as 17 páginas; trocar por `sed`, não na mão
- **`lang`, `<title>` e copyright** já viraram slot (`[NOME DO CLIENTE]`,
  `[ANO]`); "welcome To Decare" no hero da home 1 também
- **FontAwesome 5 Pro** — o template usa `fal` (light) em 140 ícones. Já
  veio enxuto: só `fontawesome/css/all.min.css` + `woff`/`woff2`/`ttf`
  (4,1 MB; eram 28 MB com less/scss/metadata/svg/eot). Os 3 `::before` que
  citavam "Font Awesome 5 Free" sem carregar a fonte foram apontados para Pro
- **`img/blog/inner_b4.jpg`** era um cinza chapado de 16 MB — agora 6 KB
- **`mail.php` e `news-mail.php` apagados** — mandavam o formulário de
  contato e a newsletter para o e-mail pessoal do autor do template
  (`mdsubhan.53@gmail.com`). Em hospedagem PHP isso iria ao ar sem ninguém
  perceber. Os forms de `contact.html` e da home ficaram sem destino
- **Vídeo do hero 3** — só `.mp4` existe; `.ogv` e `.webm` referenciados
  não vieram. Sem usar a home 3, apagar o mp4
- `js/main.js` inicializa slick, isotope, magnific, wow, counterup, typed e
  particles mesmo em página que não usa — inofensivo, mas não estranhar

---

## Já usado em

| Cliente | Como foi usado | Resultado |
|---|---|---|
| Odontologia (cliente real) | Base de código: header, hero dividido, grid, botões, footer e a pilha de JS (sticky, meanmenu). Todas as seções de clínica saíram (planos, equipe, blog, loja, barra de agendamento, newsletter); serifada, dourado e seções próprias entraram por um CSS próprio. Reveal do WOW trocado por IntersectionObserver | Publicado |
