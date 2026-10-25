# Personal trainer — Samantha

Template para personal trainer autônomo, comprado como "Samantha — Personal
Trainer & Fitness Gym Template". 14 páginas, **base clara** (branco + verde-
limão). É o mais "editorial"/pessoal dos três: o site inteiro é narrado em
primeira pessoa, como o portfólio de uma única profissional, não de uma
empresa.

**Peso:** ~9 MB em `html/` · **Stack:** HTML estático + Bootstrap 5 + jQuery
+ AOS (scroll reveal) + Owl Carousel + Fancybox + Nice Select · **Build:**
nenhum

---

## Para que serve

Personal trainer autônomo(a) que quer uma página com cara de portfólio
pessoal — "sobre mim", calculadora de IMC, agenda de horário, planos e blog
em nome próprio. É o mais indicado dos três desta prateleira quando o
cliente é uma única pessoa e quer que o site fale na primeira pessoa ("eu
crio seu treino"), não na terceira ("nossa equipe").

**Não serve** para estúdio com mais de um profissional (não tem seção de
equipe) nem para quem precisa de agendamento online funcional de verdade —
as páginas de agenda (`apointment-1/2.html`, `online-schedule.html`,
`schedule.html`) são só visuais, sem back-end.

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `about`, `contact`,
`pricing-table`) — as outras 10 seguem o mesmo grid/header/footer.

| Página | O que tem |
|---|---|
| `index.html` | Hero com foto + citação de depoimento · contadores (certificados/anos/alunos) · seção "fique saudável" · trecho de "sobre" · prévia de blog |
| `about.html` | "Sobre mim" em primeira pessoa, diplomas/certificados |
| `apointment-1.html` / `apointment-2.html` | Formulário de agendamento (2 layouts), sem back-end |
| `online-schedule.html` / `schedule.html` | Grade de horário semanal, visual |
| `pricing-table.html` | Planos com preço fixo |
| `portfolio.html` / `portfolio-details.html` | Cases de aluno em grid e detalhe |
| `blog-style-1.html` / `blog-style-2.html` / `blog-details.html` | Blog em 2 layouts de lista e post individual |
| `contact.html` | Formulário de contato + telefone/e-mail fixos + mapa |
| `404.html` | Página de erro |

## Como personalizar

```bash
templates/sites/personal-samantha/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Este é o único template da biblioteca **sem nenhuma CSS custom property** —
a cor de marca está em hex literal, com três grafias quase idênticas do
mesmo verde-limão (`#bde800`, `#bee800`, `#d8ff56`) espalhadas por
`css/style.css` e `css/color.css`. O script trata as três como a mesma cor
(ver o porquê no cabeçalho do script) e troca todas pela cor do cliente.

Também já veio resolvido um detalhe que só aparece testando: o template tem
**dois nomes de mentira diferentes** — "Samantha" (nome do produto, só no
título da aba/tela de carregamento/copyright) e "Hana Evans" (o nome da
personal fictícia, usada em primeira pessoa no "Sobre" e como autora dos
posts). Os dois já foram trocados por `[NOME DO CLIENTE]`.

## Armadilhas

- **Nome duplo no original.** Ver acima — "Samantha" era só o produto,
  "Hana Evans" era a persona narrada em primeira pessoa. Depois de rodar o
  script, reler `about.html` e `blog-details.html` pra conferir se a frase
  ainda faz sentido gramaticalmente com o nome do cliente no lugar.
- **Logo é SVG com o nome vetorizado.** `img/logo.svg` e `logo-w.svg` (versão
  branca) têm o nome desenhado como contorno (texto convertido em path) —
  não aparece em grep e o script não alcança. Trocar pela arte real.
- **Foto do hero já vem borrada de propósito no arquivo** (`img/Photo.jpg`,
  `img/blur*.png`) — não é imagem quebrada, é o placeholder "de privacidade"
  do autor. Trocar pela foto real deixa nítido; testar a composição, o
  design pode ter contado com esse desfoque como efeito visual.
- **Fotos com nome de arquivo "de verdade" que ainda são placeholder** —
  `Photo-about.jpg`, `card-1.jpg`, `portfolio-1.jpg` etc. têm nome
  descritivo mas mostram gente/academia que não é o cliente — conferir uma
  a uma, não confiar só no nome do arquivo.
- **E-mail de mentira com bug do próprio template.** `hana_evans@gmail.com`
  virou `[EMAIL]`; um dos dois links originais estava sem o prefixo
  `mailto:` (`href="hana_evans@gmail.com"` puro) — ao preencher o e-mail
  real, adicionar `mailto:` nesse link também.
- **Telefone fixo com protocolo incomum.** `+1 (495) 231 17 82` aparece em
  todas as páginas via link `callto:` (não `tel:`) — trocar por WhatsApp
  real e ajustar o protocolo do link.
- **Formulário sem ação nenhuma.** Diferente dos outros templates da
  biblioteca, aqui não tem nem PHP fake pra desligar: os `<form>` de
  `contact.html`, `about.html` e `apointment-1/2.html` não têm `action` —
  o botão não faz nada. Precisa ligar um `wa.me` ou formulário estático do
  zero.
- **Mapa fixado na Ucrânia.** O iframe do Google Maps em `contact.html` usa
  as coordenadas do template original — trocar pela localização real ou
  remover se o atendimento for só online/a domicílio.
- **Agenda, portfólio, preço e blog são todos inventados** — sem dado real
  do cliente, marcar como ilustrativo ou remover a seção/página.
- **Conteúdo em inglês** — só o atributo `lang` já foi ajustado pra
  `pt-BR`; o texto em si precisa ser reescrito com o tom de voz do
  `identidade.md`, não traduzido ao pé da letra.
