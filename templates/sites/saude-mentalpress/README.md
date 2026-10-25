# Psicólogo / consultório de saúde mental — MentalPress

Template para psicólogo, terapeuta ou consultório de saúde mental com foco
em tratamento (depressão, ansiedade, casal, infantil). 22 páginas, **base
clara** (cinza-claro + lilás `#957aca`). Comprado como "Psychology
Counseling & Medical Website Template — MentalPress" (tema WordPress de
Surjith S M, exportado pra HTML puro, Bootstrap 3).

**Peso:** 14 MB em `html/` · **Stack:** HTML estático + Bootstrap 3 + jQuery
+ Owl Carousel + Magnific Popup + Revolution-style slider próprio ·
**Build:** nenhum

---

## Para que serve

Psicólogo, terapeuta, consultório de saúde mental (o template é construído
em torno de UMA profissional — nome e credenciais viram `[NOME DO CLIENTE]`).
Tem hero com slider, tratamentos em destaque (depressão, ansiedade, casal,
infantil), bio da profissional, agendamento, contato com mapa e blog.

**Não serve** — ou serve mal — pra clínica com equipe grande (copy em
primeira pessoa) ou pra quem não vai usar as páginas de tratamento
específico — o menu já vem estruturado em torno de diagnósticos
(`anxiety-treatment.html`, `depression-treatment.html`,
`couples-therapy.html`, `children-therapy.html`, `individual-treatment.html`,
`post-divorce-recovery.html`), o que é ótimo se o cliente realmente atender
essas frentes, mas pede edição se não.

## As páginas

Preview de 4 em [`preview/`](preview/) (`index`, `about`, `appointment`,
`contact`).

| Página | O que tem |
|---|---|
| `index.html` | Hero com slider (citação + navegação) · tratamentos em destaque · bio resumida |
| `about.html` | Sobre a profissional, formação, abordagem |
| `anxiety-treatment.html` / `depression-treatment.html` / `couples-therapy.html` / `children-therapy.html` / `individual-treatment.html` / `post-divorce-recovery.html` | Uma página por tipo de tratamento |
| `appointment.html` | Formulário de agendamento |
| `contact.html` | E-mail/telefone/endereço + formulário + mapa |
| `blog.html` / `blog-single.html` | Blog em lista e post individual |
| `faq.html` | Perguntas frequentes |
| `brochure-box.html` | Material pra download (folheto/PDF) |
| `services.html` | Lista de serviços |
| `team.html` | Equipe (se o consultório tiver mais de um profissional) |
| `shop.html` / `shop-single.html` | Loja (WooCommerce simulado) — não faz sentido pra consultório, ver armadilhas |
| `extras.html` | Vitrine de shortcodes do tema — não é página de site |
| `index-fullwidth.html` / `index-rtl.html` / `index-slider.html` / `index-top-menu.html` | Variações de layout da home — escolher 1, não precisa manter as 4 |

## Como personalizar

```bash
templates/sites/saude-mentalpress/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Este é Bootstrap 3 **sem nenhuma variável CSS** (nem custom property, nem
LESS/Sass exposto) — a cor de marca é o hex `#957aca` (lilás) repetido 38
vezes em `assets/css/style.css`, sempre em classes Bootstrap semânticas de
verdade (`.btn-primary`, `.text-primary`, `.bg-primary`, `.panel-primary`,
item ativo do menu) — é o botão "Make an Appointment" e o destaque do menu,
confirmado por screenshot antes de decidir. O script troca esse hex e
preenche `[NOME DO CLIENTE]`. **Não mexe** em:

- `#1fa7da` (azul do link de texto) — cor de link padrão, não domina
  nenhum elemento grande, fica fixa;
- `.btn-danger` (vermelho do botão de telefone no cabeçalho) — classe
  semântica do Bootstrap reusada em erro de formulário/WooCommerce; trocar
  a cor de "danger" mudaria também avisos de erro. Ver script pra como
  ajustar manualmente se quiser esse botão na cor do cliente.

## Armadilhas

- **Logo é uma imagem só com nome E cargo/assinatura embutidos.**
  `assets/images/logo.png` (+ `logo_2x.png` retina + `logo_bw.png` no
  rodapé) tem "MentalPress" **e** "Jennifer Willinger, Ph.D" desenhados
  juntos dentro do PNG — nem o nome nem a credencial são texto de verdade.
  Trocar os 3 arquivos pela logo real do cliente.
- **E-mail precisou de placeholder isolado.** O domínio original era
  `info@mentalpress.com`; virar `info@[NOME DO CLIENTE].com` direto quebraria
  (nome com espaço/acento não é domínio válido) — foi isolado como `[EMAIL]`
  em `appointment.html` e `contact.html` (2 ocorrências cada, href e texto).
  Preencher com o e-mail real do cliente.
- **Menu vinha com promoção do próprio tema.** O topo do menu tinha "Buy
  Now" (link direto pro ThemeForest) e "Theme Documentation" (link pro site
  do autor) — já removidos dos 22 arquivos. O rodapé também tinha uma coluna
  inteira "Buy Now" ("...you probably really like our MentalPress theme...
  click the button below") — removida também. Os ícones de
  Facebook/Twitter do cabeçalho e rodapé apontavam pro perfil pessoal do
  autor do tema (`web3canvas`) — trocados por `"#"`, preencher com as redes
  reais do cliente.
- **Ícones de forma de pagamento no rodapé** (Visa/Mastercard/Amex/PayPal,
  "PAYMENT METHODS") são sobra de tema com loja — não fazem sentido pra
  consultório, remover a linha.
- **Formulário PHP** — `php/contact.php` e `php/appointment.php` não rodam
  na Vercel. Trocar a ação dos formulários por `wa.me` ou serviço de
  formulário estático antes de publicar.
- **Fotos já vêm com filtro "mosaico" (crystallize)** aplicado — dá pra ver
  no preview: todo retrato/ambiente foi estilizado assim de propósito pelo
  autor do tema. São todas de banco de imagem; sem foto real do
  profissional, trocar ou marcar como ilustrativo (esse filtro pode inclusive
  disfarçar que é banco de imagem à primeira vista — vale checar de perto).
- **Telefone e endereço são americanos** ("1-888-123-4567", "227 Marion
  Street, Columbia, SC 29201") e aparecem fixos em várias páginas — trocar
  pelo contato real.
- **Loja e "Extras" são vitrine do tema**, não conteúdo de site —
  `shop.html`, `shop-single.html`, `extras.html` — não incluir no menu do
  demo.
- **4 variações de home** (`index.html`, `index-fullwidth.html`,
  `index-slider.html`, `index-top-menu.html`) — escolher uma só antes de
  publicar, manter as 4 no menu confunde o cliente.
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra `pt-BR` e
  reescrever com o tom de voz do `identidade.md`, não traduzir ao pé da
  letra.
