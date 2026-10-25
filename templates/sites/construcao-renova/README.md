# Reforma / construção civil — Renova

Template para pedreiro, pintor, empreiteiro ou construtora pequena/média. 25
páginas (5 homes + páginas internas), **base clara** com laranja de marca
`#F66300` numa CSS custom property só (`--tg-theme-primary`, 166 usos).
Comprado como "Renova — Construction Building & Renovation Template".

**Peso:** 8,0 MB em `html/` · **Stack:** HTML estático + Bootstrap 5 +
AOS (scroll reveal) + Swiper + jQuery UI + fonte de ícone própria
(`fontello`, prefixo `renova-`) · **Build:** nenhum (vem com o `assets/scss`
fonte, mas o CSS já compilado em `assets/css/main.css` é o que os HTML usam)

---

## Para que serve

Pedreiro, pintor, empreiteiro, construtora pequena/média, reforma predial.
Tem 5 variações de home, portfólio de obra em grid e detalhe, equipe,
timeline de história da empresa, FAQ, blog e até um formulário de
"appointment" (visita/orçamento agendado).

**Não serve** puro pra quem só quer uma one-page simples — o pacote é grande
e modular (25 páginas, com **um módulo de loja/e-commerce bolado** que não
faz sentido pro nicho, ver Armadilhas). Também não serve pra quem precisa do
formulário de contato funcionando de cara: nenhum formulário do template tem
backend real (ver Armadilhas).

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `services`, `project`,
`team` — este último em página inteira, mostrando o rodapé com o nome do
cliente já preenchido).

| Página | O que tem |
|---|---|
| `index.html` / `index-2..5.html` | 5 variações de home page (layouts diferentes de hero/seções); `index-5` é rotulada "Renovation" na documentação original do tema |
| `about.html` / `company.html` / `office.html` | Sobre a empresa, em 3 variações de layout |
| `history.html` | Timeline de "fundação" da empresa (texto inventado, ver Armadilhas) |
| `services.html` / `services-details.html` | Lista de serviços e página de detalhe |
| `project.html` / `project-details.html` | Portfólio de obra em grid (com filtro) e detalhe por projeto |
| `team.html` / `team-details.html` | Equipe em card e perfil individual |
| `clients.html` | Grid de "clientes atendidos" (logos placeholder) |
| `appointment.html` | Formulário de agendamento de visita/orçamento (decorativo, ver Armadilhas) |
| `faq.html` | Perguntas frequentes em acordeão |
| `blog.html` / `blog-2.html` / `blog-3.html` / `blog-details.html` | Blog em 3 layouts de lista e post individual |
| `shop.html` / `shop-details.html` | Loja/e-commerce (catálogo de produto + carrinho) — módulo fora do nicho, ver Armadilhas |
| `contact.html` | Formulário de contato (PHP, não roda em hospedagem estática) + telefone/e-mail/mapa |

## Como personalizar

```bash
templates/sites/construcao-renova/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Troca `--tg-theme-primary` (laranja, cor de marca de verdade — botão, link
ativo, ícone de destaque, hover) e o nome do cliente. **Não mexe** em
`--tg-theme-secondary` (preto quase puro, é neutro escuro do tema — texto
padrão e fundo de hover — confirmado lendo o uso de cada ocorrência, não só
o nome da variável, mesmo cuidado do `manutencao-qlinest`).

O nome da marca só é trocado quando "Renova" aparece como **palavra isolada**
(seguida de espaço, ponto, apóstrofo ou fim de tag) — nunca quando é seguida
de hífen ou de outra letra. Isso é proposital, ver Armadilhas.

## Armadilhas

- **"Renova" colide com a fonte de ícone inteira E com "Renovation".** Esta é
  a armadilha grande do template: o nome da marca é ao mesmo tempo (1) o
  prefixo de TODA a fonte de ícone customizada — `.renova-right-arrow` (391
  usos!), `.renova-cart`, `.renova-search`, `.renova-phone` etc., centenas de
  classes — e (2) um substring de "Renovation"/"Renovate", palavra do próprio
  nicho que aparece dezenas de vezes como texto normal ("Building
  Renovation", "Home Renovation Services"...). Um find/replace ingênuo de
  "Renova" apagaria **todo ícone do site** e viraria "Renovation" em
  "[Nome]tion" por toda parte. O `personalizar.sh` usa um regex com contexto
  pra evitar as duas coisas — testado, 0 ícone quebrado, 0 "Renovation"
  afetada — mas vale conferir de novo se migrar a mão pra outro cliente.
- **Logo é SVG com o nome vetorizado.** `assets/img/logo/logo.svg` (e
  `w_logo.svg`, versão branca) têm "RENOVA" + "CONSTRUCTION" desenhados como
  **path** (contorno, não texto de verdade) — não aparece em grep de nome, o
  script não alcança. Trocar pela logo real do cliente.
- **E-mail fake com domínio da marca, já veio neutralizado.** O tema tinha
  `info@renova.com`, `service@renova.com`, `info@renova-construction.com`,
  `help@renova-mail.com`, `info@renova-build.com` e até um `24/7@renova.com`
  (gag de "suporte 24/7" disfarçado de e-mail) — todos virados `[EMAIL]`
  *antes* do replace de nome, porque senão o domínio ficaria
  `[Nome].com` (quebrado). Preencher com o contato real ou apagar.
- **Loja (shop) fora do nicho.** `shop.html`, `shop-details.html`, o ícone de
  carrinho no header e a faixa "Express delivery and free returns within 24
  hours" no topo de toda página são sobra de um módulo de e-commerce que não
  faz sentido pra pedreiro/pintor/construtora — remover a seção e o item de
  menu antes de publicar.
- **Formulário não envia nada em lugar nenhum.** `contact.html` manda pra
  `assets/mail.php` (PHP — não roda em hospedagem estática tipo Vercel);
  `appointment.html` e os outros formulários (newsletter, offcanvas) têm
  `action="#"` — são só decorativos, nunca funcionaram nem no pacote
  original. Trocar tudo por `wa.me` ou um serviço de formulário estático.
- **História da empresa inventada.** `history.html` repete 4× "[Nome] is
  founded in Berlin" — fato de mentira do tema original. Apagar ou reescrever
  com a história real do cliente, nunca deixar como está.
- **Sem foto nenhuma.** Todo `assets/img/**/*.jpg` é placeholder cinza com a
  dimensão escrita dentro (ex. "790x800") — 220 arquivos ao todo.
- **Telefone de mentira fixo.** `+0989 7876 9865 9` e `+(090) 8765 86543 85`
  aparecem no menu lateral (offcanvas) de toda página — trocar por WhatsApp
  real ou marcar "a confirmar".
- **Equipe, depoimento, blog e estatística ("K800" etc.) são todos
  inventados** — sem dado real do cliente, marcar como ilustrativo ou
  remover.
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra `pt-BR` e
  reescrever com o tom de voz do `identidade.md`, não traduzir ao pé da
  letra. Os `<title>`/`<meta description>` ficam como "[Nome] - Construction
  Building & Renovation Template" (metadado de aba, baixa visibilidade, mas
  revisar).
- **5 homes pra escolher.** O pacote trouxe `index.html` + `index-2..5.html`
  como layouts alternativos de home — decidir uma como principal e o que
  fazer com as outras (apagar do menu ou manter como página extra), igual se
  faz no `restaurante-elegencia` e no `odontologia-decare`.
