# Advocacia — Solven

Template para escritório de advocacia ou advogado autônomo. 16 páginas,
**base clara** (creme + dourado `#c08329`), sem variável CSS — a cor é hex
solto repetido, não `:root`. Comprado como "Solven — Lawyer HTML5 Template".

**Peso:** 3,1 MB em `html/` · **Stack:** HTML estático + Bootstrap +
jQuery + Owl Carousel + Fancybox + Magnific Popup + Slick + Odometer
(contador animado) + fontes auto-hospedadas · **Build:** nenhum

---

## Para que serve

Escritório de advocacia (qualquer área) ou advogado autônomo. Tem página de
equipe/advogado em lista e detalhe, área de atuação em lista e detalhe,
"case studies" em lista e detalhe, depoimentos, blog em três formatos e
formulário de contato/orçamento.

**Não serve** — ou serve mal — sem revisão de conteúdo: o template original
vem com estatística de "% de caso ganho" e uma seção inteira de "casos de
sucesso" no estilo portfólio comercial. Isso fere as regras de publicidade
da OAB (ver Armadilhas) e precisa ser removido ou reescrito antes de
qualquer demo virar site real — não é um template pra publicar de cara.

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `about`, `contact`,
`attrony`) — as outras 12 seguem o mesmo grid/header/footer.

| Página | O que tem |
|---|---|
| `index.html` | Hero (headline + CTA duplo "Check Areas"/"Our Attorneys") · 3 cards de diferencial · sobre resumido com contador "68+ Years of Trust" · áreas de atuação em grid · equipe em 3 cards · **case studies com estatística de % de sucesso** · depoimento · blog em cards · formulário de orçamento com telefone |
| `about.html` | Sobre mais longo, repete os 3 cards de diferencial |
| `attrony.html` / `attrony-single.html` | Equipe em card e perfil individual (telefone, e-mail, fax, redes) |
| `services.html` / `service-single.html` | Áreas de atuação em lista e detalhe |
| `case-studies.html` / `case-study-single.html` | **Casos "de sucesso" em lista e detalhe** — ver Armadilhas |
| `testimonials.html` | Depoimentos em lista |
| `blog.html` / `blog-fullwidth.html` / `blog-left-sidebar.html` / `blog-single.html` | Blog em três layouts de lista e post individual |
| `team.html` | Variante de listagem de equipe |
| `contact.html` | Formulário de contato/orçamento + telefone/endereço fixos + mapa |
| `404.html` | Página de erro |

## Como personalizar

```bash
templates/sites/advocacia-solven/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Troca a cor de marca (`#c08329`, dourado — hardcoded em 76 lugares de
`assets/css/style.css`, sem variável CSS: fundo do menu, botão padrão,
hover, linha decorativa, destaque de headline) e o nome do cliente
(pré-processado em `html/` como `[NOME DO CLIENTE]`, inclusive no rodapé).
**Não mexe** nos azuis (`#086ad8`/`#3454D1`) de CSS de variante de header
não usada nas páginas reais, no laranja de UI genérica (`#fc6e36`, botão
"voltar ao topo"/foco de formulário) nem nas variações próximas de dourado
usadas só em linha decorativa fina (`#c68e3c`/`#cd984a`) — ver cabeçalho do
script.

## Armadilhas

- **Logo é PNG transparente com o nome desenhado dentro.**
  `assets/images/logo.png` tem o ícone de balança + "SOLVEN" em branco sobre
  fundo transparente — o Read/preview mostra como área branca vazia até
  compor sobre um fundo escuro. O `personalizar.sh` não alcança PNG — trocar
  o arquivo inteiro pela logo real do cliente.
- **Telefone e fax de mentira fixos.** `+00 568 746 987` aparece em TODAS as
  16 páginas (topbar + rodapé) e `attrony-single.html` ainda tem um fax
  (`568 746 987`) — trocar por WhatsApp real ou marcar "a confirmar".
- **E-mail fake já veio neutralizado.** `attrony-single.html` tinha
  `youremail@gmail.com`, virou `[EMAIL]` no pré-processamento (não precisou
  virar antes do replace de nome porque o domínio não batia com "solven").
  `mail-contact.php` também tem um e-mail do autor do template, mas esse
  arquivo nem roda na Vercel (ver abaixo).
- **Equipe e depoimento inventados.** `attrony.html`/`attrony-single.html`
  trazem 3 advogados fictícios (Deirdre Starnes, Nicolette Corral, Roselyn
  Felton) com foto e bio genérica; `testimonials.html` reusa "Nicolette
  Corral" 4 vezes como cliente satisfeito — só publicar com selo
  "ilustrativo" visível, nunca como real.
- **ATENÇÃO OAB — promessa de resultado.** `case-studies.html`,
  `case-study-single.html` e o bloco "quote" do `index.html` trazem
  estatística de resultado de processo: "86% Case Complete", "72% Charges
  Dropped", "24% Counter Suits Filed", "37% Case Dismiss", além do título
  "Recent Successfully Completed Cases" ("25 Recent Successfully Completed
  Cases" no detalhe). Isso é **promessa de resultado e estatística de
  sucesso de causa**, vedado pelo **Provimento 205/2021 do CFOB** (proíbe
  promessa de resultado, captação de clientela indevida e mercantilização
  da advocacia). Precisa ser **removido ou reescrito** antes de publicar
  para qualquer cliente real — não é ajuste cosmético, é risco
  ético/disciplinar para quem assina a OAB.
- **Formulário não funciona na Vercel.** `mail-contact.php` precisa de
  hospedagem com PHP; sem backend, trocar a ação do `<form>` por `wa.me` ou
  um serviço de formulário estático antes de publicar.
- **Conteúdo em inglês**, incluindo `<html lang="en">` em todas as 16
  páginas — trocar pra `pt-BR` e reescrever com o tom de voz do
  `identidade.md`, não traduzir ao pé da letra.
- **16 páginas é mais do que qualquer demo precisa** — o pacote tem 4
  variantes de blog e 2 de case studies; descartar as que não servem em vez
  de publicar tudo.
