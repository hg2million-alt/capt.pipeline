# Psicólogo / terapeuta — Cloe Brooks

Template para psicólogo, terapeuta ou consultório de terapia individual.
26 páginas, **base clara** (creme + pêssego/salmão `#EDB39B`). Comprado como
"Cloe Brooks — Multipurpose and Multiskin Responsive HTML Template" (tema
ThemeREX, originalmente WordPress, convertido/exportado pra HTML puro).

**Peso:** 14 MB em `html/` (a pasta `doc/` de documentação do tema, 41 MB,
foi excluída por não fazer parte do site) · **Stack:** HTML estático +
Bootstrap-like grid próprio do tema + jQuery + Revolution Slider + Slick +
Tooltipster · **Build:** nenhum (o CSS de cor já vem compilado do LESS)

---

## Para que serve

Psicólogo, terapeuta, psicanalista, consultório de terapia de casal/individual
que atende com agenda e quer uma presença pessoal (o template é construído
em torno de UMA profissional, "Cloe Brooks" — nome vira `[NOME DO CLIENTE]`).
Tem hero com slider, "como posso ajudar", sobre, agendamento, contato,
galeria e blog.

**Não serve** — ou serve mal — pra clínica com equipe grande (a copy é toda
em primeira pessoa, "I/my") ou pra quem precisa de loja/fórum/comunidade — o
tema é "multipurpose" e trouxe junto páginas de loja e fórum que não têm
lugar num site de terapeuta solo (ver "Armadilhas").

## As páginas

Preview de 4 em [`preview/`](preview/) (`index`, `about-me`, `appointment`,
`contact`).

| Página | O que tem |
|---|---|
| `index.html` | Hero com slider (Revolution Slider) + CTA · seção "Psychological Services" |
| `about-me.html` | "How I Can Help You" em 4 cards, sobre a profissional |
| `appointment.html` | Formulário de agendamento (plugin WordPress "Booked" — ver armadilha) |
| `contact.html` | E-mail/telefone/endereço + formulário de contato + mapa |
| `gallery-grid.html` / `gallery-masonry.html` / `gallery-cobbles.html` | Galeria de fotos em 3 layouts |
| `category-standard-blog.html` / `category-without-sidebar.html` / `category-post-formats.html` / `post-standard.html` | Blog em lista e post individual |
| `pricing.html` | Planos com preço fixo |
| `typography.html` / `shortcodes.html` | Vitrine de estilo do tema — não são páginas de site |
| `shop.html`, `product-single.html` | Loja (WooCommerce simulado) — não faz sentido pra consultório solo |
| `forums.html`, `groups.html`, `groups-single.html`, `members.html` | Fórum/comunidade (BuddyPress/bbPress simulado) — idem |

## Como personalizar

```bash
templates/sites/saude-counseling/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Troca a cor de marca (`#EDB39B`, 367 usos em `css/skins/less/skin.css` + 4 em
`css/style.css`) e preenche `[NOME DO CLIENTE]`. **Não mexe** no azul
petróleo de hover (`#72b5ca`) — é só o estado de hover de link/blockquote,
não domina nenhum elemento grande da tela (confirmado por screenshot antes
de decidir), fica fixo.

## Armadilhas

- **Existe um CSS morto no pacote.** `css/skin.css` (raiz de `css/`) tem o
  mesmo conteúdo do arquivo realmente usado, mas **salvo com espaços
  quebrados dentro de cada declaração** (`font - family: ... 15 px`,
  `1.85e m`) — parece artefato de conversão/OCR do pacote original. Nenhuma
  das 26 páginas carrega esse arquivo (todas usam
  `css/skins/less/skin.css`, que está normal) — pode ignorar, não é usado.
- **Sem logo de verdade.** O cabeçalho mostra só o nome em texto — funciona
  bem para um profissional solo, mas confirme com o cliente se ele quer um
  símbolo/logo além do nome.
- **Fotos são banco de imagem.** `images/`/`uploads/` trazem retrato de
  "terapeuta" genérico e ambiente de consultório — pra este nicho
  especificamente, foto real da pessoa pesa mais na primeira impressão que
  em qualquer outro template desta leva; evitar publicar com o rosto de
  banco de imagem se possível.
- **Contato inconsistente entre páginas.** O cabeçalho mostra um endereço
  ("123, New Lenox Chicago, IL 60606"), a página de contato mostra outro
  ("176 W Street Name, New York, NY 10014") e ainda dois telefones diferentes
  — tudo fake, mas sem padronizar dá pra vazar inconsistência num print do
  cliente. Unificar com o contato real ao personalizar.
- **Plugin de agendamento "Booked" não roda em HTML estático.**
  `appointment.html` e um bloco de `css/style.css` (~linha 7148) vieram do
  plugin WordPress "Booked" — sem WordPress/PHP por trás, o calendário não
  funciona. Trocar por `wa.me` ou serviço de agendamento externo (Calendly
  etc.) antes de publicar.
- **Formulário de contato usa PHP.** `include/sendmail.php` não roda na
  Vercel — mesma troca acima.
- **Link de documentação morto.** O menu (desktop e mobile) tinha 2 links
  "Documentation" apontando pra uma pasta de ajuda do tema (41 MB, não
  copiada pra este template) — os `href` já foram trocados por `"#"` pra não
  dar 404, mas o ideal é remover o item de menu de vez.
- **Bagagem de tema "multipurpose".** Loja, fórum, grupos e membros (ver
  tabela acima) são sobra do pacote genérico do ThemeREX — não fazem sentido
  pra um consultório solo; não linkar no menu do demo.
- **Conteúdo em inglês**, `<html lang="en">` incluso, incluindo o endereço
  americano — trocar pra `pt-BR`/endereço real e reescrever com o tom de voz
  do `identidade.md`, não traduzir ao pé da letra.
- **E-mail fake usa domínio placeholder óbvio** (`yoursite.com`/
  `yoursitename.com`) — não precisa de tratamento especial tipo `[EMAIL]`
  (já não parece domínio real), mas trocar pelo contato de verdade antes de
  publicar.
