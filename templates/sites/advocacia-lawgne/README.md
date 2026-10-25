# Advocacia — Lawgne

Template para escritório de advocacia, advogado autônomo ou consultoria
jurídica. 17 páginas, **base clara** com dois tons de marca: navy escuro
`#162542` (estrutural — heading, fundo de faixa escura) e dourado/bronze
`#b68c5a` (a cor de marca de verdade — botão, link, hover, ícone). Comprado
como "Lawgne — Attorney & Lawyer HTML Template", mas o pacote tem sobras de
outros produtos do mesmo estúdio: alt de logo com "Qempo" em vez de "Lawgne"
num dos dois lugares, e-mails de teste em `barky.com`. Ambos já foram
neutralizados no pré-processamento (ver "Armadilhas").

**Peso:** 7,1 MB em `html/` · **Stack:** HTML estático + Bootstrap 5 (grid +
Popper) + jQuery + jQuery UI + Isotope (filtro de grid) + Slick (carrossel) +
WOW.js/animate.css (scroll reveal) + Magnific Popup (lightbox) + Nice Select
+ Counterup + fonte via Google Fonts CDN (Frank Ruhl Libre serifada nos
títulos, Karla no corpo — precisa de internet, não é auto-hospedada) · fonte
de ícone Flaticon + Font Awesome, auto-hospedadas · **Build:** nenhum

---

## Para que serve

Escritório de advocacia (societário, família, imobiliário, trabalhista
etc.), advogado autônomo ou consultoria jurídica. Tem página de equipe
("Attorneys") em lista e perfil individual, área de atuação ("Practice
Areas") em lista e detalhe, "casos" em grid e detalhe, galeria, FAQ e blog.

**Não serve** — ou serve mal — para quem não é escritório/profissional
jurídico: não tem loja, cardápio nem agenda de horário marcado, só
formulário de contato/orçamento. E qualquer conteúdo de "case" ou estatística
de sucesso precisa passar pelo filtro da OAB antes de publicar — ver
"Armadilhas".

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `about-us`, `contact`,
`case-details`) — as outras 13 seguem o mesmo header/footer/faixa de banner.

| Página | O que tem |
|---|---|
| `index.html` / `index-2.html` | Hero em slider (headline + CTA duplo) · faixa de serviços · sobre resumido · barras de "habilidade" (ver armadilha OAB) · "cases" em destaque · depoimentos · CTA final. Duas versões de home com o mesmo conteúdo em layout diferente |
| `about-us.html` | Sobre mais longo, mesmas barras de "habilidade", galeria de fotos |
| `attorney.html` / `attorney-details.html` | Equipe em grid (nome, cargo, foto) e perfil individual do advogado |
| `practice-1.html` / `practice-2.html` / `practice-details.html` | Áreas de atuação em duas variações de grid e página de detalhe por área |
| `case-1.html` / `case-2.html` / `case-details.html` | "Casos" em duas variações de grid e página de detalhe — texto lorem ipsum, sem caso real |
| `gallery.html` | Galeria de fotos em grid com filtro (Isotope) |
| `faq.html` | Perguntas frequentes em acordeão |
| `blog-grid.html` / `blog-standard.html` / `blog-details.html` | Blog em grid, em lista e post individual |
| `contact.html` | Formulário de contato (sem backend) + telefone/e-mail fixos + mapa do Google embutido |

## Como personalizar

```bash
templates/sites/advocacia-lawgne/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

O template não usa CSS custom property — é hex cru repetido. Tem duas cores
em jogo: o script troca só o **dourado `#b68c5a`** (confirmado por
screenshot: botão "FREE QUOTE", "Get a Quote", "APPOINTMENT NOW", sublinhado
de subtítulo, hover de menu/link, ícone, back-to-top — 70 usos em hex + 3 em
`rgba(182, 140, 90, …)`, ambos convertidos). **Não mexe** no navy `#162542`
(cor de todo heading e fundo das faixas escuras) — é o tom estrutural do
template, trocar junto tira o contraste entre título e botão. Se o cliente
tiver uma segunda cor de marca escura, trocar `#162542` à mão depois de olhar
o preview.

## Armadilhas

- **Logo é placeholder puro, sem nome desenhado dentro.**
  `assets/images/logo/logo-1.png` e `logo-2.png` são cinza com "192X45"
  escrito dentro — mais simples que a maioria dos templates da biblioteca,
  mas ainda são 3 lugares por página (header, painel mobile, rodapé) mais o
  selo `about-logo.png` ("173X158") na seção "About".
- **Sem foto nenhuma.** Todo `assets/images/*.jpg` com nome "descritivo"
  (`about-1`, `attorney-1`, `case-1`, `testimonial-1` etc.) é placeholder
  cinza com a dimensão escrita dentro — 158 arquivos, nenhum é foto real.
- **Telefone e endereço de mentira fixos.** `+012 (345) 56 899` /
  `+012 (345) 56 998`, e "59 Main Street, USA" / "New York" (com mapa do
  Google embutido apontando pra "new york") aparecem em várias páginas.
- **E-mail já veio neutralizado.** O original tinha três endereços de teste
  (`hello@barky.com`, `info@barky.com`, `support@gmail.com` — sobra de outro
  produto do mesmo estúdio) trocados por `[EMAIL]` no pré-processamento de
  `html/`, antes do replace de nome (aqui não havia risco de quebrar domínio,
  mas o padrão da biblioteca é sempre isolar e-mail fake assim).
- **Logo teve um bug do próprio pacote corrigido.** Num dos dois `alt=` do
  logo do header (painel mobile), o original dizia `alt="Qempo"` em vez de
  `alt="Lawgne"` — sobra de outro template do mesmo estúdio. Já entrou no
  replace de nome junto com "Lawgne".
- **Uma classe CSS por pouco vira lixo.** `blog-standard.html` tem
  `class="lawgne-pagination"` — é seletor real em `style.css`, não nome de
  marca. O pré-processamento protegeu essa ocorrência antes do replace
  case-insensitive de "lawgne" e restaurou depois; `personalizar.sh` não
  mexe em CSS/JS, só em `.html`, então continua seguro em qualquer rodada.
- **Advogados e "casos" são todos inventados.** `attorney.html` e
  `attorney-details.html` vêm com nome, cargo e foto de mentira (Steven E.
  Hames, Brian M. Crouch, Lawrence S. Perez etc.); `case-1.html`, `case-2.html`
  e `case-details.html` descrevem "casos" com texto lorem ipsum — sem gente
  ou caso real, apagar a seção/página em vez de inventar detalhe de processo.
- **Atenção OAB.** `about-us.html`, `attorney.html` e `attorney-details.html`
  têm 3 barras de progresso estilo "skill bar" reaproveitadas de template
  não-jurídico — "Dedicated Lawyer 67%", "Dedicated Lawyer 87%", "Experiance
  Cases 76%", "Professional Team 69%". A frase "Experiance Cases 76%" lê como
  estatística de sucesso em processo, o que esbarra no **Provimento 205/2021
  do CFOB** (proíbe promessa de resultado, captação de clientela indevida e
  mercantilização da advocacia). Isso não é "dado a confirmar" — é conteúdo
  proibido e **precisa ser removido ou reescrito antes de publicar pra
  qualquer cliente real**. Nenhuma outra estatística de "% de casos ganhos"
  ou depoimento citando resultado de processo foi encontrada nesta revisão,
  mas reconferir se o conteúdo de "case"/depoimento for alterado.
- **Depoimento é genérico, sem resultado de processo citado** — o texto de
  `index.html`/`about-us.html` (assinado "Louis H. Sanders") não menciona
  vitória ou valor de causa, então não fere a regra da OAB por si só, mas
  ainda é inventado: só usar com selo "ilustrativo" visível.
- **Formulário não envia nada.** `contact.html` e o formulário de newsletter
  do rodapé são `<form>` sem `action` nem backend — não tem PHP no pacote
  (não precisa se preocupar com isso na Vercel), mas também não funciona
  sozinho. Trocar a ação por um link `wa.me` ou um serviço de formulário
  estático antes de publicar.
- **Crédito do estúdio autor no rodapé.** Todas as páginas dizem
  "Design By Webtend" ao lado do copyright — não é o nome do cliente nem de
  quem produziu o site, remover antes de publicar.
- **Conteúdo em inglês**, incluindo `<html lang="en">` — trocar pra `pt-BR` e
  reescrever com o tom de voz do `identidade.md`, não traduzir ao pé da
  letra.
- **Redes sociais apontam pra `href="#"`** no header e no rodapé — preencher
  ou remover os que não existem.
- **Fonte depende de internet.** `style.css` importa Frank Ruhl Libre e Karla
  direto do Google Fonts CDN — sem conexão, cai pra fonte padrão do sistema.
