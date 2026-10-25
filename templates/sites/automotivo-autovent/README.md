# Automotivo — Autovent

Template HTML para **evento automotivo** — feira/salão do automóvel, lançamento
de carro, encontro de test-drive, clube/exposição de carro antigo. 10 páginas
(5 homes + 5 internas), base escura com gradiente azul → verde-água.

**Peso:** 15 MB · **Stack:** HTML estático + jQuery (bundlado) + PHP (só o
formulário de contato) · **Build:** nenhum

---

## Nicho real: EVENTO, não revenda nem oficina

O nome do zip ("automotive event car expo exhibition") não engana: isto **não
é** um template de revenda de veículos nem de oficina/estética automotiva.
Confirmado abrindo as 10 páginas — tem programação/countdown, ingresso pago
(3 planos em dólar), grade de "Experts"/palestrantes, "Getting There"
(localização do evento) e galeria de fotos do evento, não catálogo de carro à
venda.

**Serve para:** feira automotiva, lançamento/reveal de carro, expo de
test-drive, encontro de clube de carro antigo, salão do automóvel.

**Não serve para:** revenda comum, concessionária, oficina, funilaria,
lava-jato, estética automotiva do dia a dia — para esses o template já
existente é o `automotivo-carlink/` (catálogo de veículo). Se aparecer um
cliente desse nicho, comece por lá, não por aqui.

## As 5 homes

Preview de 2 delas em [`preview/`](preview/) (as outras 3 não foram
renderizadas — ver nota no fim do README).

| Arquivo | Nome no menu | O que é | Marca visual |
|---|---|---|---|
| `index.html` | Home Expo One | One-page do evento: hero com carro + contagem regressiva, About, Experts, Schedule, Tickets, Gallery, Getting There | Escuro, gradiente azul→verde diagonal no hero |
| `index-expo-2.html` | Home Expo Two | Variante do one-page, hero com countdown mais proeminente | Igual ao One, layout do hero muda |
| `index-expo-3.html` | Home Expo Three | Variante com slider de heros (múltiplos slides, texto ainda em Lorem Ipsum) | Igual |
| `index-expo-4.html` | Home Expo Four | Quase idêntica à One | Única que nasce ligada a `css/colors/blue.css` em vez de `blue-teal.css` (ver Armadilhas) |
| `index-car-1.html` | Home Car One | Reveal de um carro só ("Falcon GT"): hero escuro cheio de tela, menu próprio (Home/About/Features/Gallery/Specs), sem countdown de evento | Escuro, mais dramático — serve bem pra lançamento de carro |

## Páginas internas

`contact.html` (endereço/telefone/e-mail fake + formulário PHP) ·
`gallery.html` (grade de fotos) · `news.html` (lista de posts) ·
`blog-single.html` (post individual) · `tickets.html` (3 planos de ingresso)

---

## Como usar

```bash
cd templates/sites/automotivo-autovent
./personalizar.sh /c/Dev/ExpoMotorX/site '#0072FF' 'Expo Motor X'
# ou com gradiente (cor secundaria explicita):
./personalizar.sh /c/Dev/ExpoMotorX/site '#0072FF' 'Expo Motor X' '#02D982'
```

O script copia o template para a pasta destino, reescreve as duas folhas de
cor (`css/colors/blue.css` e `blue-teal.css`) com a cor informada, e troca o
nome do evento nos `<title>`, no rodapé e nas menções em texto ("Autovent"
vira o nome passado). O original nunca é alterado. Lista completa do que
sobra pra fazer na mão ao final da execução.

---

## Onde fica a cor de marca

**Duas variáveis CSS, sem hex cru espalhado.** `css/colors/blue.css` e
`css/colors/blue-teal.css` definem `--primary-color`, `--primary-color-rgb`,
`--secondary-color` e `--secondary-color-rgb`. Todo o CSS grande
(`style.css`, 115 usos; `coloring.css`, 66 usos) só consome
`var(--primary-color)` / `var(--secondary-color)` — nada para caçar em hex.

Isso é bem mais limpo que o Carlink (que não tem variável nenhuma).

## O que já foi limpo daqui

- `documentation/` (redirecionava pro site do autor) e `changelog.txt` —
  removidos, eram metadado do item, não parte do site
- `demo/preview/` (screenshots de divulgação do autor) — removido, geramos
  preview próprio
- Todo arquivo de licença encontrado: `fonts/elegant_font/Licensing/`
  (gpl/mit), `fonts/font-awesome/HELP-US-OUT.txt`,
  `fonts/et-line-font/Read Me.txt`, e os `LICENSE` dentro de
  `vendor/composer/`, `vendor/FormGuide/`, `vendor/gregwar/captcha/` e
  `vendor/phpmailer/phpmailer/` (bibliotecas PHP de terceiro que o
  formulário de contato usa — o código continua funcionando, só a licença
  embutida foi apagada)
- **Redirecionamento morto pro site do autor** em `js/designesia.js`: havia um
  handler de clique em `#dark-mode` que mandava `window.location.href` pra
  `designesia.com/themes/gospace/...`. Nenhuma página tem elemento
  `id="dark-mode"`, então era código morto (sobra de outro template do mesmo
  autor) — removido inteiro, não só o link
- `"Copyright 2026 - Autovent by Designesia"` no rodapé das 10 páginas virou
  `"Copyright 2026 - [NOME DO EVENTO]"` — a marca "by Designesia" some, o
  slot de ano fica manual (o script não mexe no ano)
- Comentário `/* created by designesia */` no topo do `style.css`
- `lang="zxx"` virou `lang="pt-BR"` nas 10 páginas
- `<title>Autovent - Car Vehicle Automotive Event Website Template</title>` e
  a meta description equivalente viraram
  `[NOME DO EVENTO] — [DESCRIÇÃO CURTA]`
- Sem `__MACOSX/`, `.DS_Store`, `node_modules/` ou `.git/` — conferido

**O que ficou e por quê:** os ícones de fonte (`font-awesome`, `icofont`,
`elegant_font`) carregam um aviso OFL/SIL padrão *dentro do binário da fonte*
(`.ttf`/`.svg`/`.otf`) — não é atribuição ao autor do template, é a licença de
uso do próprio glifo, embutida pelo fabricante da fonte; não dá pra tirar sem
quebrar o arquivo, e não é o tipo de restrição que este projeto precisa
remover.

## Armadilhas

**São duas folhas de cor divergentes no original** (antes do script rodar):
9 das 10 páginas carregam `blue-teal.css` (`--primary` azul, `--secondary`
verde-água — gera o gradiente visto no hero); só `index-expo-4.html` carrega
`blue.css`, que tinha primary = secondary = o mesmo azul (sem gradiente). O
`personalizar.sh` já escreve as duas com a mesma cor, então esse problema não
aparece no cliente — mas se algum dia editar `css/colors/` na mão, lembrar
que são dois arquivos.

**O formulário de contato é PHP de verdade, não estático.** `contact.html`
manda um AJAX (`form.js`) pra `handler.php`, que usa PHPMailer + validação +
reCAPTCHA opcional (`src/`, `vendor/`). Numa Vercel comum (estático) isso
**não funciona** — o formulário fica mudo. Ou publica em host com PHP, ou
troca o `action`/JS por Formspree/web3forms antes de entregar. Os dois
placeholders que precisam de valor real estão em `handler.php`:
`'your-email-here'` (destino do e-mail) e `'copy-your-secret-key-here'`
(chave secreta do reCAPTCHA, em `getReCaptcha()->initSecretKey(...)`) — são
placeholders genéricos do autor, não e-mail/chave real de ninguém.

**Contato de demonstração falso, repetido em todas as páginas:** endereço
"100 Mainstreet Center, NY", telefone "+1 333 9296", e-mail
"contact@suppport.com" (com erro de digitação no domínio, do próprio
template). Aparece no rodapé de todas as 10 páginas e de novo em
`contact.html`. Trocar antes de publicar — não é dado do autor, é dado de
demonstração genérico, mas ilustra preço/contato fictício se for esquecido.

**Ícones sociais apontam pra `#`.** O autor original já tinha tirado os
próprios links (diferente do Carlink, que ainda tinha `href="#"` mas pelo
menos não vazava rede do autor) — aqui não há nada pra trocar por segurança,
só preencher com as redes reais do evento quando existirem.

**4 famílias de ícone carregadas ao mesmo tempo** (`font-awesome`, `icofont`,
`elegant_font`, `et-line-font`) — 6,4 MB só de fontes, a maior fatia do
template. Provavelmente dá pra cortar 2 ou 3 depois de mapear quais classes
cada página realmente usa, mas não foi feito aqui (risco de quebrar ícone sem
testar todas as 10 páginas visualmente).

**`index-expo-3.html` tem hero em slider com texto ainda em Lorem Ipsum** nos
slides secundários — não é conteúdo demo em inglês pra traduzir, é
placeholder de verdade, then precisa de texto novo, não só tradução.

**Depende de jQuery, mas tudo bundlado.** `js/plugins.js` (596 KB) já inclui
jQuery + Owl Carousel + WOW.js + o que mais o template usa, minificado num
arquivo só. Mais `designesia.js` (o script principal), `custom-marquee.js` e
o par `jquery.countdown.js`/`countdown-custom.js` pra contagem regressiva.
Cinco arquivos ao todo, nada de CDN.

**Abrir por HTTP, não por `file://`.** Testado nesta sessão: renderiza
certinho servido por HTTP (`python -m http.server`); não foi testado por
`file://` mas dado o padrão dos outros templates da leva (Carlink teve o
mesmo problema por causa de ícone via fetch), o mais seguro é sempre subir um
servidor local:

```bash
cd html && python -m http.server 8899   # depois abrir http://localhost:8899/index.html
```

---

## Sobre os previews

Só 2 das 5 homes foram renderizadas (`home-expo-1.jpg` = `index.html`,
`home-car-1.jpg` = `index-car-1.html`). O navegador Playwright desta máquina
estava compartilhado por vários agentes rodando em paralelo no momento da
produção deste template (mesmo lote de 24 templates, cada agente
screenshotando o seu) — a maioria das tentativas de captura das outras 3
homes e das páginas internas (`tickets.html`, `contact.html` etc.) pegou a
aba de outro agente no meio da corrida. As 2 capturas que ficaram foram
conferidas manualmente (screenshot lido e comparado ao HTML esperado) antes
de salvar. Vale gerar os previews que faltam depois, num momento sem outros
agentes disputando o mesmo navegador.
