# Advocacia — Quala Coat

Template para escritório de advocacia ou advogado autônomo. 27 páginas,
**base clara** (branco + dourado `#dcb04d`, com marrom escuro `#5a2918` no
botão de maior contraste). Comprado como "Quala Coat - Law Firm & Lawyers
HTML5 Template".

**Achado importante:** o CSS compilado (`css/styles.css`) traz no cabeçalho
a URL de origem `themeforest.net/item/repair-geek-laptop-and-computer-fixing-
service-center-html5-template` — ou seja, o Quala Coat é um reskin de um
template de **assistência técnica** ("Repair Geek"), não uma peça nascida
pra advocacia. Isso explica alguns vazamentos de conteúdo: o contador
"Successful Case" ao lado de "Devices Fixed" (ver `element-counter.html`), o
depoimento genérico que fala de carro entregue no mesmo dia, e o
`element-info-box.html` que ainda carrega o `<title>` de um TERCEIRO tema do
mesmo pacote ("Mobila Fixer - Mobile Phone Service Center"). Não é bug de
extração, é assim que o pacote comprado veio.

**Peso:** 4,7 MB em `html/` · **Stack:** HTML estático + Bootstrap 3.3.6 +
jQuery + Owl Carousel + WOW.js (scroll reveal) + Waypoints/Sticky + Venobox
(lightbox de galeria) + Stellar (parallax) + CounterUp (contador animado) +
Google Maps embed (`jquery.gmap`) + fontes via Google Fonts (Lora nos
títulos, Open Sans no corpo) · **Build:** nenhum

---

## Para que serve

Escritório de advocacia (qualquer área) ou advogado autônomo que precisa de
site institucional: apresentação, áreas de atuação, equipe, blog e contato.
Tem página de agendamento e formulário de orçamento no menu, mas nenhum dos
dois tem lógica real por trás — ver Armadilhas.

**Não serve** para quem precisa de conteúdo jurídico (blog é genérico, sem
estrutura de artigo técnico) pronto, nem para escritório que já tem qualquer
tipo de compromisso de divulgar índice de sucesso/resultado — o template
tenta empurrar exatamente isso e precisa ser podado antes de publicar (ver
Armadilhas, item OAB).

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `about-us`, `contact`,
`team`) — as outras seguem o mesmo header/menu/footer.

| Página | O que tem |
|---|---|
| `index.html` | Hero escuro (headline + 2 CTAs, dourado e marrom) · sobre resumido · contador (inclui "99.99% Successful Case", ver Armadilhas) · serviços em grid · "Our Clients" (8 logos de mentira) · depoimentos · CTA final |
| `about-us.html` | Sobre mais longo, repete contador e depoimentos |
| `service.html` / `service-details.html` | Lista de áreas de atuação em card e página de detalhe |
| `team.html` / `single-team.html` | Equipe em card e perfil individual de advogado |
| `appointment.html` | Formulário de "agendamento" sem data/hora e sem handler nenhum (não envia nada, nem tenta) |
| `contact.html` | Formulário de contato (funciona via PHP, ver Armadilhas) + telefone/endereço fixos + mapa |
| `blog.html` / `single.html` | Blog em lista e post individual |
| `gallery-1.html` / `gallery-2.html` / `gallery-3.html` | Três variações de grid de galeria com lightbox |
| `faq.html` | Perguntas frequentes em acordeão |
| `element-appointment.html`, `element-counter.html`, `element-cta.html`, `element-feedback.html`, `element-highlights.html`, `element-info-box.html`, `element-logos.html`, `element-pricing-table.html`, `element-service.html`, `element-subscribe.html`, `element-team.html` | Vitrine de componentes do tema (título "Element X" em todas) — sem conteúdo do escritório, não usar numa entrega |
| `coming-soon.html` / `404.html` | Páginas utilitárias do tema |

## Como personalizar

```bash
templates/sites/advocacia-qualacoat/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Não há CSS custom property aqui (nada de `--var`) — é hex cru repetido no
CSS compilado. Troca o dourado `#dcb04d` (186 usos em `css/styles.css` + 2
usos inline em `index.html`/`about-us.html`, um atributo `data-bg_img`
de seção com fundo padronado) pela COR escolhida, e o nome do cliente
(pré-processado em `html/` como `[NOME DO CLIENTE]`, inclusive no rodapé
onde antes dizia "Copyright © 2017-2018 ... by xenioushk" — nome do autor
do tema, trocado junto, igual o caso do Handify). **Não mexe** no marrom
escuro `#5a2918` (botão "Book Appointment"/"Get Started Now", o CTA de
maior contraste) — é cor funcional de contraste contra o dourado, não tem
garantia de que a cor do cliente combine como botão sobre ela mesma. Ver
cabeçalho do script para o detalhe de por que a escolha foi essa (decidida
batendo screenshot da index/about-us/contact antes de qualquer alteração).

## Armadilhas

- **OAB — ATENÇÃO.** `index.html` e `about-us.html` têm um contador
  "99.99% Successful Case". Isso é estatística de resultado de processo, o
  que fere o Provimento 205/2021 do Conselho Federal da OAB (proíbe
  promessa de resultado, captação de clientela indevida e mercantilização
  da advocacia). **Tem que ser removido ou reescrito antes de publicar para
  qualquer cliente real** — trocar por algo neutro (anos de atuação, áreas
  de atuação), nunca preencher com número de sucesso de verdade também.
- **Logo é imagem, não texto.** `images/logo.png` (nas 27 páginas) tem
  "QUALA COAT" + "YOUR TRUSTED LAW PARTNER" desenhado dentro do PNG — o
  script não alcança. Trocar pela logo real do escritório.
- **Quase todo o conteúdo fotográfico é placeholder cinza com marca d'água
  "DEMO"**, não foto de banco de imagens: hero slides, fotos de equipe
  (`team_5..8.jpg`), serviços (`service_1..6.jpg`), galeria
  (`gallery_1..8.jpg`), avatares (`user_1..4.jpg`). O pacote comprado veio
  sem as fotos originais do preview. Ícones e o `pattern_1.png` decorativo
  estão OK.
- **"Our Clients"** (seção do `index.html`, 8 `logo_N.png`) é uma faixa de
  clientes de mentira tipo Logoipsum — apagar, nunca inventar cliente do
  escritório.
- **Telefone, endereço e e-mail são todos fixos e falsos**: telefones no
  padrão de Bangladesh (`+880-1911-623-458` etc.), endereço inconsistente
  (`Saifa Summit, Bangladesh` no header vs `3100 C/A Mouchak, Sylhet, UK`
  em `contact.html`), e-mails de rodapé `support-us@swimes.com` /
  `helpmenow@swimes.com` (sobra de outro template, "Swimes", repetida nas
  27 páginas) e `query@yourdomain.com` em `contact.html`. Nenhum domínio
  contém "quala"/"coat", então o replace do nome não quebrou nada — mas
  também não os tocou; trocar à mão.
- **Formulário de contato funciona só com PHP.** `contact_email.php` é
  chamado via AJAX por `js/custom-scripts.js` (`url: "contact_email.php"`)
  a partir do `#contact-form` de `contact.html` — não roda na Vercel sem
  backend. `free_quote_email.php` está no pacote mas **órfão**: nada no
  HTML/JS chama esse arquivo.
- **`appointment.html` não agenda nada.** O formulário (nome/e-mail/
  telefone/mensagem, sem campo de data/hora) não tem `action` nem handler
  no `custom-scripts.js` — ao contrário do `contact.html`, aqui o botão
  "enviar" literalmente não faz nada, nem tenta um POST. "Book Appointment"
  no menu é só rótulo.
- **Depoimentos são genéricos e nem falam de advocacia** — um deles menciona
  carro entregue no mesmo dia (sobra do template de origem "Repair Geek").
  Reescrever do zero; se usar, com selo "ilustrativo" visível.
- **Equipe inventada.** `team.html`/`single-team.html` vêm com nome, cargo e
  foto de advogado que não existe.
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra `pt-BR` e
  reescrever com o tom de voz do `identidade.md`, não traduzir ao pé da
  letra.
- **Hover do dourado não acompanha a cor nova.** `#e4c378`, `#ce9b28` e
  `#a37b20` são `lighten()`/`darken()` do dourado original já compilados em
  hex fixo no CSS (o LESS-fonte está em `css/less/`, mas quem roda é o
  `.css` compilado) — o `personalizar.sh` só troca o `#dcb04d` base, então o
  hover de link/botão/ícone pode ficar com um resquício do dourado antigo.
  Ver cabeçalho do script se isso incomodar visualmente.
- **11 páginas "element-*" + `coming-soon.html` + `404.html`** são
  vitrine/utilitário do tema, sem conteúdo do escritório — não usar numa
  entrega de verdade.
