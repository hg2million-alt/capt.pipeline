# Reforma / construção civil — Construc

Template para pedreiro, pintor, empreiteiro ou construtora pequena. 11
páginas, **base clara** (branco + laranja), sem CSS custom property de cor
(laranja chumbado em hex, em 7 grafias diferentes). Comprado como "Construc —
Ultimate Construction Company Website".

**Peso:** 7,0 MB em `html/` · **Stack:** HTML estático + Bootstrap 5 +
Font Awesome + Bootstrap Icons + Venobox (lightbox) · **Build:** nenhum

O pacote original trazia **8 "homes"** (variações de home page) dentro de
`Construc-Buyerfile/construc/`, num total de 55 MB — só empacotamos **home1**
(a mais completa, 11 páginas). `home3` do pacote nem é construção: é um bundle
errado de outro tema do mesmo autor ("Consen - IT Startup"), descartado.

---

## Para que serve

Pedreiro, pintor, empreiteiro, construtora pequena, reforma residencial ou
comercial. Tem hero com slider, seção de serviço em grid e em detalhe,
portfólio de obra em grid e em detalhe, equipe, tabela de preço, blog e
formulário de contato.

**Não serve** — ou serve mal — para arquitetura/design de interiores como
produto principal (a copy é toda "we build", obra pesada, não projeto) nem
para quem já tem um portfólio fotográfico forte pra mostrar em destaque (o
layout de portfólio aqui é card padrão, sem ênfase em foto grande).

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `service`, `portfolio`,
`contact`) — as outras seguem o mesmo header/footer.

| Página | O que tem |
|---|---|
| `index.html` | Hero em slider · seção de serviços em grid · sobre resumido · portfólio em destaque · equipe · depoimentos · CTA final |
| `about.html` | Sobre mais longo, estatística/números |
| `service.html` / `service-details.html` | Lista de serviços em card e página de detalhe por serviço |
| `portfolio.html` / `portfolio-details.html` | Portfólio de obras em grid (com filtro) e página de detalhe por projeto |
| `pricing.html` | Planos/pacotes com preço fixo |
| `team.html` | Equipe em card |
| `blog.html` / `blog-details.html` | Blog em lista e post individual |
| `contact.html` | Formulário de contato (Formspree) + telefone/e-mail/endereço fixos |

## Como personalizar

```bash
templates/sites/construcao-construc/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Troca as **7 grafias hex** do laranja de marca (`#FF5E14`, `#FF5E15`,
`#FF5D13`, `#FF5F15`, `#F16722`, `#FF3C00`, `#FF5E16` — sem CSS var, o autor
foi cravando o tom à mão em pontos diferentes do CSS) e o nome do cliente
(pré-processado como `[NOME DO CLIENTE]`, só no rodapé — é o único lugar onde
"construc" aparecia como texto de verdade). E-mails de mentira
(`example@gmail.com`, `example@yahoo.com`, `yourmail@domain.com`) já vieram
trocados por `[EMAIL]`.

## Armadilhas

- **Nome do pacote é uma bagunça.** A pasta e o logo (imagem) dizem
  "Construc" — é o nome real do produto comprado — mas a maioria dos
  `<title>` das páginas diz "indastre" ou até "indastre-Finance Consulting"
  (sobra de outro tema do mesmo autor, inclusive com erro de digitação
  "Consuting" em `portfolio.html`). O script **não mexe em "indastre"**: esse
  texto está entranhado em nomes de classe CSS de verdade
  (`indastre_nav_manu`, `indastre-btn`, `indastre-service-single-item`) — um
  find/replace ia quebrar menu e botão. Reescrever os `<title>` à mão.
- **Logo é imagem, não texto.** `assets/images/logo.png` tem "Construc"
  desenhado dentro do PNG, usado 3× por página (header, header sticky,
  rodapé) — o script não alcança. Trocar pela logo real do cliente.
- **Formulário manda pra conta de outra pessoa.** `contact.html` tem
  `action="https://formspree.io/f/myyleorq"` — é o Formspree do autor do
  tema. Publicando assim, a mensagem de contato cai na caixa de outra
  pessoa, não do cliente. Trocar por um endpoint próprio ou por `wa.me`.
- **Sem foto nenhuma.** Todo `assets/images/**/*.jpg|png` é placeholder cinza
  com a dimensão escrita dentro (ex. "590x480") — 143 arquivos ao todo.
- **Telefone de mentira fixo.** `+980 123 (4567) 890` aparece no topo de toda
  página — trocar por WhatsApp real ou marcar "a confirmar".
- **Equipe, portfólio, preço e blog são todos inventados** — nome, cargo,
  foto, projeto e valor chutados pelo tema. Sem dado real do cliente, marcar
  como ilustrativo ou remover a seção/página.
- **Conteúdo em inglês**, `<html lang="en-US">` incluso — trocar pra `pt-BR`
  e reescrever com o tom de voz do `identidade.md`, não traduzir ao pé da
  letra.
- **`assets/js/particls.js` não é usado por nenhuma página do home1** que
  empacotamos (sobra de outro home do pacote original) — pode ignorar ou
  apagar.
