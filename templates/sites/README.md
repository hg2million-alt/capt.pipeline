# Catálogo de templates de site

> **Modo de entrega atual: `.html` único, uma página só, sem Vercel** (skill
> `entregar-html`). Menções a Vercel/deploy nas notas abaixo são da versão
> antiga. `odontologia-dentia-next/` e `odontologia-dentia-php/` não servem
> nesse modo; `automotivo-automec/` precisa de `npx vite build --base=./`.


Templates prontos, organizados por **categoria ampla** (não por nicho fechado),
disponíveis para qualquer projeto do Claude. Cada pasta é autossuficiente:
template, preview e instruções juntos.

## Como a biblioteca funciona (ler antes de escolher)

Reorganizado em 26/09/2026 — antes cada linha era um nicho isolado com 1-3
templates "donos" dele; isso levou a repetir sempre o mesmo template pro mesmo
nicho (ex.: 3 pizzarias seguidas todas em `pizzaria-onepage/`). A partir de
agora:

1. **Categoria ampla vence nicho exato.** Um template de "carro" serve
   qualquer negócio de carro (revenda, estética, oficina, lava-jato) — não
   precisa ter nascido pro nicho exato do cliente. Mesma lógica: um template
   de diarista pode virar site de encanador, um de dentista pode virar site
   de nutricionista, um de barbearia já serve salão de beleza. A tabela abaixo
   está agrupada por essas categorias, não mais por nicho isolado.
2. **Toda categoria tem pelo menos 2 templates, de propósito.** É pra ter o
   que escolher. Antes de decidir qual usar, checar (pedindo ao usuário ou
   olhando `captacoes/aprendizados.md`/histórico recente do projeto) quais
   templates da mesma categoria já foram usados nos últimos clientes — **não
   repetir o mesmo template para 2 clientes seguidos da mesma categoria**
   quando existe alternativa. Só as categorias sinalizadas como "opção única"
   abaixo (cinema) ainda não têm essa folga — variar lá vai exigir
   comprar/construir um segundo template quando incomodar.
3. **"Frankenstein" entre templates da mesma categoria é permitido e
   incentivado.** Pegar o hero de um template e a seção de galeria/depoimento
   de outro da mesma categoria é uma forma legítima de variar sem reescrever
   do zero — sobretudo quando os dois compartilham stack (Bootstrap+jQuery é
   o caso comum). Antes de misturar, checar se as versões de framework batem
   (Bootstrap 3 vs 5 têm classe diferente) e se a paleta de cor de um não
   vaza pro outro.
4. **Construir do zero é o último recurso**, reservado pra quando a categoria
   inteira não tem nada — não quando só o nicho exato está faltando dentro de
   uma categoria que já tem template.

## Catálogo por categoria

### Serviço residencial / reparo doméstico

Encanador, eletricista, diarista, limpeza, climatização — "alguém vem cuidar
da sua casa". 5 templates: a categoria com mais folga da biblioteca.

| Pasta | Stack | Peso | Serve para |
|---|---|---|---|
| [`manutencao-handify/`](manutencao-handify/) | HTML + Bootstrap 5 + Swiper | 36 MB | Encanador, eletricista, chaveiro, marido de aluguel, reparo avulso. 15 páginas, nasce claro com laranja (`--accent-color`, var única). **Não tem foto nenhuma** — placeholder com a dimensão escrita dentro. Logo tem o nome desenhado dentro do PNG, script não alcança |
| [`manutencao-qlinest/`](manutencao-qlinest/) | HTML + Bootstrap 5 + jQuery | 2,6 MB | Diarista, limpeza residencial/comercial recorrente ou avulsa — mas serve de base pra qualquer reparo avulso também (é só trocar copy). 7 páginas, nasce azul cheio (`--dark-blue`) com CTA amarelo fixo. **Não tem foto nenhuma** apesar do nome de arquivo sugerir foto real. Logo é SVG com o nome vetorizado (contorno, não texto) |
| [`limpeza-laun/`](limpeza-laun/) | HTML + Bootstrap 5 + jQuery | 32 MB | Diarista, limpeza residencial/comercial, lavanderia e lavagem a seco. 28 páginas (5 de e-commerce que não cabem no nicho — não usar). Nasce verde (`--theme-color`, 277 usos) com azul fixo de acento; a cor de marca também está cravada em 22 SVGs soltos (ícones, logo) além do CSS — `personalizar.sh` troca os dois lugares. 1 imagem de fundo corrompida no zip original (só afeta a variação "Home Dry Cleaning"). Logo é SVG com o nome vetorizado |
| [`climatizacao-coolair/`](climatizacao-coolair/) | HTML + Bootstrap 5 + jQuery + Swiper | 56 MB | Empresa de ar-condicionado/HVAC completa, com catálogo de produto e portfólio. 31 páginas (14 homes concorrentes — escolher 1). Nasce azul em 3 esquemas de cor prontos; `personalizar.sh` pede 1 cor e deriva a secundária automaticamente, incluindo as versões `-rgb` usadas em overlay de foto. Único template da leva com fotos de banco de imagem reais (não placeholder). Logo raster com o nome desenhado dentro |
| [`climatizacao-oyoxo/`](climatizacao-oyoxo/) | HTML + Bootstrap 5 + jQuery | 3,4 MB | Aquecimento/ar-condicionado em formato one-page, com loja e blog anexados. Nasce azul `#3464e0` (hex cru, 118 usos claramente dominantes). **Sem foto nenhuma** — todo placeholder com a dimensão escrita dentro, ao contrário do Coolair. Loja vende produto genérico sem relação com HVAC — apagar. Logo é PNG com nome+subtítulo desenhados dentro |

### Imóveis, arquitetura e construção

Tudo que vende ou apresenta espaço/propriedade física — corretor, construtora,
escritório de arquitetura, reforma. 6 templates.

| Pasta | Stack | Peso | Serve para |
|---|---|---|---|
| [`imoveis-lemanhouse/`](imoveis-lemanhouse/) | HTML + Bootstrap 5 + Isotope | 7,6 MB | Corretor/imobiliária com catálogo de vários imóveis, filtro, ficha, blog. O mais completo dos 3 (43 páginas). Nasce navy `#13293d` hex cru. **Achado grave**: ~690 imagens apontavam pro `via.placeholder.com`, serviço que **saiu do ar** — já trocadas por `placehold.co` no template. Nenhum formulário tem backend real |
| [`imoveis-quicksale/`](imoveis-quicksale/) | HTML + jQuery + Isotope | 7,8 MB | **Não é catálogo — é site de UM imóvel só** (hero fixo com endereço/preço, galeria, agendamento de visita). Não usar por engano como imobiliária de catálogo. Skin de 3 acentos fixos por design (laranja+verde trocam juntos, azul terciário fica fixo) |
| [`imoveis-domira/`](imoveis-domira/) | HTML + GSAP + Swiper + Isotope | 5,5 MB | Corretor/imobiliária com visual editorial/minimalista (preto+bege, cards em cor sólida em vez de foto), comparação de imóveis. CSS var limpa (`--Primary`) + 14 usos de SVG inline fora da variável. E-mail do AUTOR do tema exposto em quase toda página — neutralizado, mas conferir se sobrou algum antes de publicar |
| [`arquitetura-axisbuilt/`](arquitetura-axisbuilt/) | HTML + Bootstrap 5 + jQuery + GSAP | 11 MB | Escritório de arquitetura, design de interiores, construtora, estúdio de reforma. 18 páginas (6 variações de home), nasce bege + preto com acento dourado. +150 imagens placeholder — maior volume da biblioteca. Formulário usa `web3forms.com` com chave de API do AUTOR — troca obrigatória antes de publicar. Logo é SVG com o nome vetorizado |
| [`construcao-construc/`](construcao-construc/) | HTML + Bootstrap 5 | 7,4 MB | Pedreiro, pintor, empreiteiro, construtora pequena. 11 páginas, nasce laranja cravado em 7 grafias hex diferentes (sem CSS var). Formulário manda pro Formspree do AUTOR — trocar antes de publicar. Maioria dos `<title>` diz "indastre" (sobra de outro tema do mesmo autor) — não mexer, colide com classe CSS real |
| [`construcao-renova/`](construcao-renova/) | HTML + Bootstrap 5 + AOS + Swiper | 8,5 MB | Pedreiro, pintor, empreiteiro, construtora pequena/média. 25 páginas (5 homes). Nasce laranja `#F66300` via CSS var limpa. **Cuidado**: "Renova" também é prefixo da fonte de ícone (391 usos) e substring de "Renovation" — replace de nome usa regex com fronteira de palavra, não sed ingênuo. Tem loja fora do nicho (não usar) |

### Beleza e estética pessoal

Barbearia, salão de cabelo, estética facial/corporal, maquiagem, unhas — já
unificado, uma cliente de estética pode sair de qualquer um dos 6. 6 templates.

| Pasta | Stack | Peso | Serve para |
|---|---|---|---|
| [`barbearia-trimly/`](barbearia-trimly/) | HTML + Bootstrap 5 + jQuery | 3,4 MB | **Primeira opção pra barbearia e salão de beleza/cabelo** (o pacote original já é "Barbershop & Hair Salon"). 9 páginas, agendamento com formulário completo (some no WhatsApp em vez de fingir sucesso). Nasce claro com dourado e título em Teko; `personalizar.sh` sempre troca o título pra Fraunces e opcionalmente inverte pra base escura — CSS 100% via custom properties. **Não tem foto nenhuma**. Testado num cliente real (escuro) |
| [`barbearia-barberon/`](barbearia-barberon/) | HTML + Bootstrap 5 + jQuery + Swiper + GSAP | 15 MB | Barbearia (7 páginas, base escura, dourado). **Tem fotos de banco reais** (P&B, alta qualidade) em vez de placeholder — visualmente mais pronto que o Trimly, mas por isso mais fácil esquecer que não é o barbeiro real do cliente. Regra prática: cliente com fotos boas ou disposto a sessão → Barberon; cliente sem foto nenhuma → Trimly. Preço e "Since 1998" fictícios só apareceram em screenshot, não em grep — checar visual sempre |
| [`barbearia-qutter/`](barbearia-qutter/) | HTML + Bootstrap 4.5 + jQuery + Slick | 20 MB | Barbearia/salão (13 páginas, 3 homes, dourado `#d6a354`). **Zero foto real** — nível Oyoxo, todo placeholder cinza. Formulários mudos (PHP/`action="#"`) já trocados por WhatsApp. Boa 3ª opção pra variar visual sem repetir Trimly/Barberon |
| [`barbearia-hairbarber/`](barbearia-hairbarber/) | HTML + Bootstrap + jQuery + Swiper | 9,4 MB | Barbearia/salão de cabelo (12 páginas, 3 homes, base escura, variável única de cor — o mais simples de recolorir depois do Trimly). **Achado grave já corrigido**: depoimentos/equipe usavam nome e foto de gente real famosa (Dale Earnhardt, Devin Booker, Michelle Yeoh, David Beckham, entre outros) — trocados por nomes fictícios brasileiros |
| [`estetica-haircare/`](estetica-haircare/) | HTML + Bootstrap 3 + jQuery | 9 MB | Salão de beleza/cabelo, estúdio de maquiagem/unhas/estética. Cobre o mesmo território do Trimly — usar este quando quiser variar visual (é mais "salão clássico") ou quando o gap for puramente maquiagem/unhas/estética. Pack original era framework genérico de 533 HTMLs reskinado — curadoria pesada já feita. Mapa da página de contato usa API key do autor original, vai falhar — trocar é prioridade máxima |
| [`estetica-spamagic/`](estetica-spamagic/) | HTML + Bootstrap 4 + jQuery + Isotope | 5,5 MB | Spa, clínica de estética, salão com agendamento online e venda de gift card. Pack genuinamente feito pro nicho, 10 páginas depois da curadoria — a melhor opção de acabamento quando o cliente é mais "spa/clínica" que "salão de bairro". Tinha integração viva com Mailchimp do autor original — neutralizada |

### Corpo em movimento (fitness)

Academia, estúdio funcional, personal trainer — negócio físico e personal
autônomo agora na mesma categoria, cada um com sua melhor opção. 4 templates.

| Pasta | Stack | Peso | Serve para |
|---|---|---|---|
| [`academia-gymfito/`](academia-gymfito/) | HTML + Tailwind (CDN) | 2,5 MB | Academia, estúdio de treino funcional, box. Já nasce preto com acento laranja. Primeira opção quando o negócio é um espaço físico com equipe, não um profissional solo |
| [`personal-progym/`](personal-progym/) | HTML + Bootstrap 5 + Swiper | 9 MB | Personal autônomo — **melhor primeira opção pra solo**, copy já fala em 1ª pessoa de plano de treino, não de matrícula de academia. Nasce escuro + verde-neon `#9CFF1E`. `team.html` pressupõe vários treinadores, não serve pra 1 pessoa só |
| [`personal-fitmas/`](personal-fitmas/) | HTML + Bootstrap 5 | 36 MB | Puxa mais pra "academia/estúdio pequeno" que personal solo (mensalidade, matrícula, loja de suplemento, equipe) — usar quando o cliente tiver mais de 1 profissional, ou como variação visual do Progym. Nasce claro + vermelho `#F41E1E`, com fotos de banco reais |
| [`personal-samantha/`](personal-samantha/) | HTML + Bootstrap 5 | 9 MB | Personal solo "editorial", narrado em 1ª pessoa (about/blog assinado) — variação de tom mais pessoal que o Progym. **Tem 2 nomes de mentira** (produto "Samantha" + persona fictícia "Hana Evans") — os dois precisam virar o nome do cliente. Fotos do hero vêm desfocadas de propósito |

### Saúde e bem-estar clínico

Dentista, nutricionista, psicólogo, clínica de emagrecimento — decisão lenta,
identidade/confiança pesa mais que preço. Odontologia e saúde
mental/nutrição unificadas: a mesma base de "consultório com agenda" serve
pros dois, ajustando especialidade. 7 templates.

| Pasta | Stack | Peso | Serve para |
|---|---|---|---|
| [`odontologia-decare/`](odontologia-decare/) | HTML + Bootstrap 5 + jQuery | 18 MB | Dentista, clínica odontológica, ortodontia, harmonização — mas a estrutura (hero claro, 3 homes, seção de especialidades) serve igual pra nutricionista/clínica de estética facial trocando a copy. Nasce claro com azul de acento; 3 homes, 17 páginas, `personalizar.sh` troca ~30 cores. **Não tem foto nenhuma** |
| [`odontologia-dentisto/`](odontologia-dentisto/) | HTML + Bootstrap 4 + jQuery | 7,9 MB | Dentista (17 páginas). Cor de marca bem organizada, 1 `:root` central. Fotos são mix real (banners/avatares reais tingidos) + placeholder (cards de equipe/blog). **Achado curioso**: iframe do Maps apontava pro endereço real da sede da Envato em Melbourne — corrigido. Boa 2ª opção pra variar do Decare |
| [`odontologia-dentia-php/`](odontologia-dentia-php/) | PHP (includes simples, **sem banco de dados**) | 34 MB | Dentista (visual "Dentia" claro). Mesmo visual da variante Next.js abaixo — escolher PHP só se o host for PHP tradicional, não Vercel. Formulários usam `mail()` PHP puro — **não funciona em runtime serverless**, trocar por WhatsApp/SMTP antes de publicar |
| [`odontologia-dentia-next/`](odontologia-dentia-next/) | Next.js 16 (App Router) + React 19 + TS | 22 MB | Dentista (visual "Dentia", 7 homes). **Variante preferida pra deploy na Vercel** (framework nativo) frente à PHP acima. `npm install` + build testados do zero. **Achado grave**: página `/dentists` tinha credencial profissional inventada e verificável-parecendo ("DDS, New York University") — marcar sempre como ilustrativo, mais grave que depoimento comum |
| [`saude-clinicmaster/`](saude-clinicmaster/) | Tailwind CSS 4 | 39 MB | Clínica de emagrecimento, nutricionista, personal com programa de perda de peso — serve também pra dentista/clínica geral que queira visual mais moderno/Tailwind em vez do Decare. Cor de marca espalhada em ~10 tokens Tailwind — `personalizar.sh` varre a paleta inteira. Promessa de resultado clínico na copy original — reescrever, não manter como fato |
| [`saude-counseling/`](saude-counseling/) | HTML + jQuery + LESS pré-compilado | 14 MB | Psicólogo, terapeuta, consultório solo — copy em 1ª pessoa. Nasce pêssego `#EDB39B`. Pacote "multipurpose" tinha bagagem de loja/fórum/membros removida |
| [`saude-mentalpress/`](saude-mentalpress/) | HTML + Bootstrap 3 | 14 MB | Psicólogo/consultório com páginas por tipo de tratamento (ansiedade, casal, infantil) — variação de estrutura quando o cliente quer uma página por especialidade em vez de one-page. Nasce roxo `#957aca` hex cru. Logo tem nome E credencial fictícia cozidos na mesma imagem |

### Advocacia / serviços jurídicos

Escritório ou advogado autônomo. Categoria fechada em si — não há par óbvio
em outra categoria da biblioteca. 3 templates, já com folga.

| Pasta | Stack | Peso | Serve para |
|---|---|---|---|
| [`advocacia-solven/`](advocacia-solven/) | HTML + Bootstrap + jQuery | 3,1 MB | Escritório de advocacia ou advogado autônomo. 16 páginas, nasce dourado `#c08329` (hex cru). **⚠️ OAB**: `case-studies.html` e o quote da home trazem estatística de "% de casos ganhos" — vedado pelo Provimento 205/2021 CFOB, remover/reescrever antes de publicar |
| [`advocacia-lawgne/`](advocacia-lawgne/) | HTML + Bootstrap 5 + jQuery | 7,1 MB | Escritório de advocacia, advogado autônomo ou consultoria jurídica. 17 páginas, nasce navy + dourado `#b68c5a`. **⚠️ OAB**: barra "Experiance Cases 76%" — mesma vedação, remover antes de publicar. Sem foto nenhuma (158 placeholders) |
| [`advocacia-qualacoat/`](advocacia-qualacoat/) | HTML + Bootstrap 3 + jQuery | 4,7 MB | Escritório de advocacia ou advogado autônomo. 27 páginas (11 vitrine sem conteúdo real). **⚠️ 99.99% Successful Case** na home/about, mesma vedação OAB. Fotos placeholder cinza com marca d'água "DEMO" |

### Alimentação / gastronomia

Pizzaria, delivery, restaurante, buffet — tudo que serve comida, unificado
numa categoria só. Antes cada um "pertencia" a um nicho fixo (pizzaria sempre
`pizzaria-onepage/`); agora são 8 variações pra rotacionar por tom e formato.

| Pasta | Stack | Peso | Serve para |
|---|---|---|---|
| [`pizzaria-onepage/`](pizzaria-onepage/) | HTML + Bootstrap 4 + jQuery | 3,6 MB | Pizzaria, esfiharia, hamburgueria, lanchonete com delivery. One-page pronta para demo: cardápio ilustrativo marcado, selos "a confirmar", reels, WhatsApp em todo CTA. Derivada do Thesignature. Formato mais rápido de produzir da categoria — usar quando o gap for "sem cardápio digital" e o cliente não tem salão/experiência de mesa |
| [`restaurante-thesignature/`](restaurante-thesignature/) | HTML + Bootstrap 4 + jQuery | 30 MB | Restaurante, pizzaria, hamburgueria, bar com cozinha. Já nasce preto com acento amarelo; hero com foto circular — boa alternativa à pizzaria-onepage quando o cliente tem salão/ambiente pra mostrar, não só delivery. **Não tem foto nenhuma** |
| [`restaurante-elegencia/`](restaurante-elegencia/) | HTML + Bootstrap 5 + jQuery + GSAP | 5,9 MB | **Primeira opção para restaurante fino, bistrô, buffet e casa de eventos.** 16 páginas, 3 homes, editorial (serifada grande, filete dourado). Nasce azul-petróleo + dourado; `personalizar.sh ... claro '#COR_TITULO'` inverte para base branca (testado num cliente real de buffet). **Não** serve pra delivery ou pizzaria popular — não dá fome |
| [`restaurante-fresheat/`](restaurante-fresheat/) | HTML + Bootstrap 5 + Swiper | 18 MB | Marmitaria, comida rápida/delivery de prato feito, hamburgueria — cardápio com preço na cara e "ORDER NOW". Boa alternativa à pizzaria-onepage quando o cliente quer visual mais comercial/direto em vez de one-page enxuta. Nasce vermelho `#EB0029` + laranja fixo |
| [`restaurante-royate/`](restaurante-royate/) | HTML + jQuery + Bootstrap + Revolution Slider | 31 MB | Restaurante de salão médio, bistrô, wine bar — reserva com data/hora, chefs em destaque. Fica entre o Elegencia (mais editorial) e o Thesignature (mais escuro) em tom — a 3ª opção pra variar dentro de "restaurante de mesa". Cor dourada `#CDAA7C` aparece em 4 lugares diferentes, os 4 precisam trocar juntos |
| [`restaurante-foodio/`](restaurante-foodio/) | HTML + Bootstrap + jQuery + Owl Carousel | 3,7 MB | Fast food/hamburgueria (17 páginas, 3 homes). Boa alternativa rápida à pizzaria-onepage/Fresheat pra delivery casual. Cardápio em dólar (~135 preços, precisa virar R$). Formulário PHP `mail()` — não roda na Vercel, trocar por WhatsApp |
| [`restaurante-foodu/`](restaurante-foodu/) | HTML + Bootstrap 5 + jQuery + GSAP + Swiper | 26 MB | Fast food/hamburgueria (33 páginas, 12 homes — 6 claras + 6 escuras). Cor em 2 CSS vars limpas. Formulários de "reserva" são 100% decorativos desde o original (sem backend nem JS) — documentar isso ao cliente. Boa opção quando quiser escolher entre visual claro/escuro sem trocar de template |
| [`restaurante-grillino/`](restaurante-grillino/) | HTML + Bootstrap + jQuery + LayerSlider | 39 MB | Grill/churrasco/restaurante de carnes (49 páginas). **Atenção**: nome "Grillino" está vetorizado dentro do path do logo SVG, não sai em find/replace — só aparece no screenshot, precisa trocar o arquivo. Formulário PHP `mail()`, trocar por WhatsApp |

### Automotivo

Revenda, estética, oficina, lava-jato, evento automotivo — "de carro" cobre
a categoria inteira. 4 templates.

| Pasta | Stack | Peso | Serve para |
|---|---|---|---|
| [`automotivo-carlink/`](automotivo-carlink/) | HTML + jQuery | 28 MB | Revenda, aluguel, concessionária, táxi, frota, **e também** estética automotiva/lava-jato/oficina — pra serviço, usar a estrutura e cortar o que é específico de catálogo (busca por marca/modelo, ficha técnica, financiamento). Testado num cliente real de estética automotiva |
| [`automotivo-kars/`](automotivo-kars/) | HTML + jQuery | 21 MB (era 37 MB, cortados 17 MB de fonte morta) | Revenda/catálogo (36 páginas, 6 homes). **Diferencial sobre o Carlink**: `home-3` já é uma landing pronta de oficina/auto repair (serviços, equipe, agendamento) — primeira opção quando o cliente é oficina/funilaria/estética, não revenda. Maioria das ~300 imagens é placeholder apesar do nome do arquivo sugerir foto real. `home-6` é loja genérica (barco!) — não usar |
| [`automotivo-automec/`](automotivo-automec/) | **React (Vite 6 + React 18 + TS)** — precisa `npm install`+`npm run build` | 16 MB | Oficina/reparo automotivo (visual mais "serviço" que os outros dois). Único template React da biblioteca — fluxo de personalização e deploy é diferente dos demais (todos HTML estático). Cor em CSS compilado, não Tailwind/var |
| [`automotivo-autovent/`](automotivo-autovent/) | HTML + jQuery + PHP (formulário) | 15 MB | **Nicho diferente dos outros 3**: feira/evento automotivo (lançamento de carro, expo, test-drive, encontro de clube) — não revenda nem oficina comum. Formulário PHP real (PHPMailer) — não roda na Vercel sem trocar |

### Hospedagem (hotel, pousada, chácara/sítio de aluguel)

Tudo que vende pernoite ou diária de espaço: hotel de cidade pequena,
pousada, hostel, chalé, chácara/sítio/casa de temporada (inclusive chácara
que vive de evento). Categoria criada em 28/09/2026 com 4 templates, somando
11 visuais diferentes (o Hotel Master tem 5 demos e o Boostay tem 4 homes).
Nos 4, reserva e contato **já abrem o WhatsApp** com a mensagem montada a
partir dos campos. Nenhum faz reserva online real nem mostra disponibilidade de
verdade. **Nenhum tem foto real**, e em hospedagem a foto é o produto: não
publicar demo sem as fotos do cliente (Maps/Instagram).

| Pasta | Stack | Peso | Serve para |
|---|---|---|---|
| [`hospedagem-leluxe/`](hospedagem-leluxe/) | HTML + jQuery (Owl, Zebra Datepicker, fancyBox) | 2,1 MB | **O mais pronto da categoria**: 9 páginas já traduzidas e reescritas em pt-BR, sem preço inventado ("Consulte pelo WhatsApp"). Serve para pousada ou hotel pequeno do interior e para chalé; chácara de aluguel serve com adaptação (tirar a página de café da manhã, renomear os "quartos"). Visual minimalista preto e branco com um único acento amarelo `#ffd40d` (hex cru, cerca de 24 usos). Se a cor for escura, o script ajusta o contraste sozinho. O logo virou texto. **Não serve** para chácara de festa/evento nem para visual rústico. fancyBox 3 é GPLv3 (troca sugerida no README) |
| [`hospedagem-boostay/`](hospedagem-boostay/) | HTML + Bootstrap 5 + jQuery/jQuery UI | 9,3 MB | 9 páginas com 4 homes: `index`/`index-5` para pousada ou hotel, `index-3` para chácara ou pousada rural, `index-2` para **chácara de eventos** (tem página `event`). Cores: dourado `#AF8C3E` (var + hex + SVG inline + PNG, que o script recolore com Pillow) e marinho `#0E1730`, este opcional no 5º argumento. `personalizar.sh <destino> '#COR' 'Nome' [home] ['#COR_ESCURA']`. A fonte de título foi trocada para Marcellus porque a original não tinha ç/ã. Preços em dólar, contadores e depoimentos fictícios e corpo do texto em inglês |
| [`hospedagem-qomfort/`](hospedagem-qomfort/) | HTML + Bootstrap 5 + jQuery (Slick, FullCalendar) | 19 MB (16 MB é Font Awesome Pro) | 14 páginas com 3 homes: `index2` para pousada ou hotel pequeno, `index3` para **chácara ou casa de temporada** (reserva ao lado do hero e 3 pacotes que viram Diária/Fim de semana/Evento), `index` é a opção "resort". Cor cobre `#AB6034` (var com 109 usos + 56 rgba + 3 PNGs). `personalizar.sh <destino> '#COR' 'Nome' [index\|index2\|index3]`. **O logo PNG ainda diz "QOMFORT"**, trocar. Diária `$59` repetida 38 vezes, "Awards Winning 25+ Years", contadores em `data-stop` (não aparecem em grep) e vocabulário de resort (Spa, Jacuzzi) |
| [`hospedagem-hotelmaster/`](hospedagem-hotelmaster/) | HTML + jQuery 1.12 + Master Slider (tema WordPress exportado) | 21 MB (3,4 a 4,0 MB por demo) | **Pack com 5 demos**, o cliente recebe só 1: `masterhotel` (hotel ou pousada clássica, claro), `masterhotel-dark` (pousada boutique, fundo preto), `hostel` (hostel/albergue), `modern` (hotel com **mais de uma unidade**; apagar o seletor "Unidade" se tiver só uma) e `apartment` (**chácara, sítio, casa de temporada**: casa inteira com preço por noite). `personalizar.sh <demo> <destino> '#COR' 'Nome' ['#COR2']`, que precisa de node e recalcula em HSL a família de tons (sem CSS var). Das 430 páginas sobraram 42. Preços em dólar, contadores "2800 guests / 99.9%" e fundo de título com montanha nevada de banco. Master Slider é de terceiro e não é MIT |

### Cinema / entretenimento — opção única (categoria ainda sem folga)

| Pasta | Stack | Peso | Serve para |
|---|---|---|---|
| [`cinema-movflx/`](cinema-movflx/) | HTML + Bootstrap 5 + jQuery | 16 MB | Cinema, sala de exibição. Template original é de streaming/assinatura — adapta CTA de "assistir" para "ingresso" e decide destino de `pricing.html`/`tv-show.html`. Já nasce escuro com acento amarelo. **Não tem foto/pôster nenhum** |

### Tecnologia / TI

| Pasta | Stack | Peso | Serve para |
|---|---|---|---|
| [`tech-luminex/`](tech-luminex/) | HTML + Bootstrap 5 + jQuery | 144 MB (6 demos; cliente recebe só 1, de 8,8 a 37 MB) | Startup, SaaS, cibersegurança, IA, cloud storage ou consultoria de TI — pack com **6 demos independentes** (`bitelo` `codexa` `fortexa` `luminex` `storedge` `visora`), já dá variedade sem precisar de 2ª pasta. `personalizar.sh <demo> <destino> '#COR' 'Nome'` pede o demo primeiro. Copy 100% SaaS/startup B2B — **não serve para loja física de tech** (nesse caso, construir do zero) |

*(vai crescendo — cada template novo entra na categoria certa; se a categoria
não existe ainda, criar uma nova seção)*

## Como usar num projeto

1. Identificar a **categoria** do cliente (não só o nicho exato) e abrir a
   seção certa acima
2. Se a categoria tem mais de um template, checar o que já foi usado
   recentemente na mesma categoria (perguntar ao usuário se não tiver certeza)
   e escolher outro — ou montar um frankenstein com seções de mais de um
3. Abrir o `README.md` da pasta escolhida e olhar os previews
4. Rodar o script de personalização, que **copia** o template para a pasta do
   cliente já com a cor e o nome trocados:

   ```bash
   templates/sites/<pasta>/personalizar.sh <destino> '#COR' 'Nome'
   ```

5. Seguir a lista de trabalho manual que o script imprime no fim

O template original nunca é modificado. Cada cliente sai de uma cópia.

## Como adicionar um template novo

Nomear a pasta como `<nicho>-<nome-do-template>` — o nicho na frente ainda
ajuda a identificar o template sozinho, mesmo que a tabela agrupe por
categoria. Dentro, manter sempre a mesma forma:

```
<nicho>-<template>/
├── README.md          o que é, para que serve, como personalizar, armadilhas
├── personalizar.sh    copia + troca cor e nome; nunca altera o original
├── preview/           um .jpg por página relevante
└── html/  (ou src/)   o template
```

O `README.md` precisa responder quatro coisas, porque é o que decide se o
template serve antes de você abrir qualquer arquivo:

- **Para que serve** e, principalmente, para que **não** serve
- **Peso e dependências** — se puxa jQuery, se tem build, quanto ocupa
- **Onde ficam as cores da marca** — quantas são e em que arquivo
- **Armadilhas** — o que quebra, o que custa caro mudar, o que já foi medido

Ao terminar, acrescentar a linha na **categoria certa** da tabela acima (criar
categoria nova só se não houver nenhuma parecida) e atualizar a skill global
`templates-de-site`, que é o que faz o Claude achar isso de outro projeto. Se
só uma das duas for atualizada, elas divergem.

## Limpeza esperada antes de guardar

Template comprado vem com entulho que atrapalha reuso. Tirar sempre:

- Barra ou banner de promoção do marketplace e a landing de demonstração
- Seletor de cores / painel de opções do demo
- `__MACOSX/`, `.DS_Store`, `node_modules/`, `.git/`
- `lang` errado no `<html>` e `<title>` com o nome do template

Se apagar uma página, conferir antes quem linkava para ela — em template
comprado o logo costuma apontar para a landing de demonstração.
