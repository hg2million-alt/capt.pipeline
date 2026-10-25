# Barbearia / Salão — Barberon

Segunda opção de template pra barbearia (a primeira é `barbearia-trimly/`).
7 páginas, **base escura** fixa (sem variante clara), título em Playfair
Display (serifada display) já de fábrica, e — a maior diferença pra tudo
mais na biblioteca — **fotos de banco reais em preto e branco**, não
placeholder cinza com dimensão escrita dentro. Comprado como "Barberon —
Barbershop & Hair Salon Web Template" (o pacote original tinha 15 páginas
em 8 variações de home; só 7 entraram na cópia).

**Peso:** 14 MB em `html/` (maior que o Trimly por causa das fotos reais) ·
**Stack:** HTML estático + Bootstrap 5 + jQuery + Swiper + Owl Carousel +
GSAP (ScrollTrigger, SplitText) · **Build:** nenhum

---

## Para que serve

Barbearia e salão de beleza/cabelo — igual ao Trimly, o pacote original já
é "Barbershop & Hair Salon". Tem agendamento com formulário completo (nome,
e-mail, telefone, serviço, data, hora, observações → WhatsApp), equipe,
galeria, depoimentos e horário de funcionamento.

**Não serve** — ou serve mal — pra: cliente que não tem fotos reais e não
vai investir em banco de imagens/sessão de fotos própria (ver Armadilhas —
aqui isso pesa mais que no Trimly, porque o template inteiro foi desenhado
em volta de fotografia de qualidade, não de blocos de texto); barbearia que
quer base clara (não existe aqui, só no Trimly).

## Barberon x Trimly — quando usar qual

| | **Barberon** | **Trimly** |
|---|---|---|
| Fotos | Reais (banco, P&B, alta qualidade) | 100% placeholder cinza |
| Base | Só escura | Clara nativa, escura via script |
| Título | Playfair Display (serifada) de fábrica | Teko (condensada) → script troca pra Fraunces |
| Páginas | 7 | 9 |
| Preço nas páginas | services.html tem (fictício, apagar) | men-services.html não tem |
| Pede mais do cliente | Fotos reais de qualidade (senão os placeholders somem e sobra só banco genérico) | Nada — publica só com texto se precisar |

Regra prática: cliente já tem fotos boas (ou vai fazer sessão) → Barberon
aproveita isso melhor, o template inteiro foi desenhado pra fotografia.
Cliente sem foto nenhuma, ou só com foto de celular fraca → Trimly, porque
lá a ausência de foto real é o padrão esperado, não uma lacuna visível.
Também serve pra variar visualmente entre dois clientes do mesmo nicho na
mesma região — não repetir sempre o mesmo template.

## As páginas

Preview de cada uma em [`preview/`](preview/).

| Página | O que tem |
|---|---|
| `index.html` | Hero com slider de fotos reais + headline rotativo (Owl Carousel) + citação de abertura assinada · sobre resumido · categorias de serviço · prévia de galeria · prévia de equipe · depoimentos · rodapé com endereço/telefone |
| `about.html` | Sobre mais longo, com "Since 1998" fixo no topo (ano de fundação inventado — ver Armadilhas) |
| `services.html` | 6 cards de serviço com foto real + **preço chutado** (ver Armadilhas) |
| `team.html` | 3 barbeiros com nome inventado em destaque gigante (Sam, Leo, Max) + cargo + redes sociais "#" |
| `gallery.html` | Grade de 5 fotos reais de corte/estilo |
| `reviews.html` | 4 depoimentos fictícios em carrossel horizontal, cada um citando o nome da barbearia pelo nome |
| `booking.html` | Formulário de agendamento (nome/e-mail/telefone/serviço/data/hora/observações → WhatsApp) + horário de funcionamento da semana |

Fora da cópia: `blog.html` e `blog-single.html` (blog com posts fictícios,
baixo valor pra barbearia local, mesma lógica do Trimly não ter blog) e as
outras 7 variações de home do pacote original (`index-dark-slider`,
`index-dark-static-image`, `index-dark-video-background`, `onepage-index`
e as 3 versões one-page correspondentes) — todas eram a mesma página com
hero diferente; ficou só a "Main" (slider), que já usa fotos reais.

## Como usar

```bash
cd templates/sites/barbearia-barberon
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#8A5A2B' 'Barbearia XYZ'
```

Não tem modo `escuro`/`claro` (só existe a base escura) nem troca de fonte
(já nasce serifada) — os únicos parâmetros são pasta, cor e nome. O script
sempre: gera `css/colors/custom.css` a partir da cor informada (primária +
secundária derivada por HSL + 3 fundos quase-pretos tingidos no mesmo
matiz — mesma ideia do `climatizacao-coolair/personalizar.sh`, que também
deriva a secundária sozinho); aponta as 7 páginas pra esse arquivo novo
(os 10 presets originais — amber, burgundy, copper, emerald, gold, purple,
rosegold, sapphire, silver, teal — ficam intactos em `css/colors/` como
referência); e preenche `[NOME DO CLIENTE]` em título, meta, logo alt e
rodapé. O cabeçalho do próprio `personalizar.sh` documenta cada passo, e a
lista impressa ao final cobre tudo que precisa de edição manual (logo,
fotos, equipe, fundador, depoimento, preço, contato, agendamento, texto,
title, QA visual).

O original em `html/` nunca é alterado — cada cliente sai de uma cópia.

## Onde fica a cor

Inteira num arquivo pequeno: `css/colors/gold.css` (a paleta ligada por
padrão nas 7 páginas via `<link id="colors" href="css/colors/gold.css">`).
4 variáveis: `--primary-color` (destaque — botões, ícones, preço, links),
`--secondary-color` (variante clara da primária, usada em gradientes),
`--bg-dark-1/2/3` (3 tons de fundo quase-preto tingidos pela cor escolhida
— é isso que faz o site inteiro parecer "da cor do cliente" mesmo sendo
90% preto). As `-rgb` de cada uma (ex: `--primary-color-rgb: 200, 164,
106;`) alimentam `rgba()` em overlays/gradientes — o `personalizar.sh`
calcula as duas formas (hex e rgb) juntas. Conferido: **zero hex de marca
solto fora de variável** em `style.css` (158 usos de `var(--primary/
secondary/bg-dark...)`, os poucos hex crus que existem são todos cinza/
branco/preto neutro) — mais limpo nesse quesito até que o Trimly (que tinha
2 hex soltos).

## Armadilhas

Tudo isso já está corrigido pela cópia em `html/` ou documentado pelo
`personalizar.sh` — fica registrado aqui pro caso de precisar mexer na mão:

- **Logo com o nome do produto pintado dentro do PNG, não como texto.**
  `images/logo-white.webp` (header + rodapé, 3 usos por página) parece só
  um brasão pequeno numa prévia rápida — mas é porque o texto ao lado é
  **branco sobre fundo transparente**: abrindo o arquivo direto (fundo
  branco do visualizador) o texto “BARBERON” fica invisível por coincidência
  de cor, só aparece composto sobre o fundo escuro real do site. Mesma
  categoria de armadilha do "TRIMLY STYLE" do outro template, mas aqui é a
  logo principal, exibida em toda página — trocar pelo logo real do cliente
  antes de publicar, nunca só confiar numa olhada rápida do arquivo isolado.
  `images/misc/signature.webp` tem o mesmo problema por um motivo diferente:
  é uma assinatura cursiva de verdade (não texto) desenhando "Samuel
  Barberon" — usada na citação de abertura da home. Escondida/substituída
  junto com o item FUNDADOR do checklist do script.
- **Referência de imagem quebrada desde o zip original.** As 7 páginas
  apontavam pra `images/misc/logo-wm-1.webp` (marca-d'água decorativa a 10%
  de opacidade atrás de 3 seções) — esse arquivo **nunca existiu** no
  pacote comprado (não é coisa que a limpeza quebrou). Só apareceu rodando
  um script Python comparando todo `src=`/`data-bgimage=` contra o disco;
  navegando não dá pra notar, porque em 10% de opacidade uma imagem ausente
  e uma imagem quebrada parecem a mesma coisa (nada). Corrigido redirecionando
  pra `images/logo-icon.webp` (o brasão já usado em outro lugar da página).
- **Preço chutado em `services.html`**, um por card (\$30/\$20/\$35/\$25/
  \$45/\$25) — só apareceu na captura de tela, **não em grep de "price" ou
  "\$"** (o valor vive sozinho num `<p>`, sem palavra-chave por perto).
  Prova de que checagem visual real (a regra do AGENTS.md) pega coisa que
  busca de texto não pega. Sem tabela real do cliente, apagar os preços.
- **"Since 1998" fixo em `about.html`** — ano de fundação inventado, sem
  token, achado na mesma checagem visual. Trocar pelo ano real ou apagar.
- **Formulário de agendamento morto desde a origem.** `#contact_form`
  (em `index.html` e `booking.html`) tentava um `$.ajax POST` pra
  `booking-barber.php` — arquivo que **não vem no zip comprado**, então o
  agendamento nunca funcionou nem na demo original do autor. Reescrito em
  `js/validation-barber.js` pra montar a mensagem com os campos preenchidos
  e abrir `wa.me/[WHATSAPP]?text=...`, mesmo padrão do `barbearia-trimly`.
  Falta preencher `WHATSAPP_NUMERO` no topo do arquivo.
- **Equipe com só o primeiro nome, em destaque gigante.** `team.html` usa
  o nome como elemento de design (h2 enorme: "Sam", "Leo", "Max"), não só
  como legenda — diferente do Trimly, aqui não dá pra simplesmente apagar o
  nome e deixar o cargo, o layout depende de ter uma palavra grande ali.
  Sem nome real, pensar numa alternativa (inicial, cargo em maiúsculas
  curto) em vez de inventar outro nome.
- **Fotos são reais, e isso é uma faca de dois gumes.** Ao contrário de
  todo o resto da biblioteca, as fotos aqui (slider, serviços, equipe,
  galeria, depoimentos, banners internos) são fotografia de banco de
  verdade — preto e branco, alta produção. Isso torna o demo muito mais
  bonito de cara, mas também mais fácil de "esquecer" que não é o barbeiro
  nem o salão real do cliente. Regra do AGENTS.md vale igual: nunca publicar
  pra valer com essas fotos passando por reais sem aviso, trocar sempre que
  o cliente mandar material próprio.
- **`coloring.css`** (504 linhas, ligado em toda página) é CSS morto —
  nenhuma das classes que ele estiliza aparece em nenhum HTML da cópia
  (sobra de outro template do mesmo autor, com um laranja `#fa6a2e` que não
  é a cor de marca daqui). Zero impacto visual, deixado ligado por
  segurança; não precisa mexer.
- **`images/logo-big.webp`** era referenciado só nas páginas descartadas
  (blog e variações de home) — removido da cópia por não ter mais uso.

## Referência

Nenhum cliente ainda saiu deste template (adicionado à biblioteca em
26/09/2026, testado só com `personalizar.sh` em pasta de rascunho).
