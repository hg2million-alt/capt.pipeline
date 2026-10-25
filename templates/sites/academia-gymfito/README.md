# Academia — Gymfito

Template HTML para academia, estúdio de treino e afins. 16 páginas, duas
variações de home, **base preta com acento laranja**.

**Peso:** 2,5 MB · **Stack:** HTML estático + Tailwind (Play CDN) · **Build:** nenhum

---

## Para que serve

Academia, estúdio de treinamento funcional, box de crossfit, personal trainer,
studio de pilates. É um template de **serviço com turma e horário** — nasceu
para vender aula, plano e acompanhamento.

Serve especialmente bem para marca de **estética escura e agressiva**: já nasce
com fundo `#01010F`, tipografia condensada em caixa alta e acento laranja. É o
oposto do Carlink — aqui, se o cliente quiser site escuro, **não precisa
inverter nada**.

**Para que não serve:** marca de base clara e tom suave (pilates leve, estúdio
de yoga, fisioterapia). Existe uma home clara, mas só uma — as 14 páginas
internas são todas escuras (ver Armadilhas).

## As 2 homes

Preview de cada página em [`preview/`](preview/).

| Arquivo | O que é | Marca visual |
|---|---|---|
| `index.html` | Home completa: hero dividido, sobre com contadores, aulas em slider, grade semanal, treinadores, depoimentos, IMC, preços | **Fundo escuro** `#01010F` — é a que representa o template |
| `index2.html` | Mesmo layout e mesmas seções | **Fundo branco.** Só o `<body>` muda |

## Páginas internas

`about` · `services` `service-details` · `classes` `class-details` ·
`trainer` `trainer-details` · `schedule` · `pricing` · `gallery` · `bmi`
(calculadora de IMC, funciona) · `blog` `blog-details` · `contact`

---

## Como usar

```bash
cd templates/sites/academia-gymfito
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#FF6A00' 'XYZ Fit'
```

O script copia o template para a pasta destino, troca **as duas cores de marca**
e preenche o nome do cliente. O original nunca é alterado.

Uma quarta opção define a cor secundária (bege, por padrão vira prata `#BFC0C2`):

```bash
./personalizar.sh <destino> '#FF6A00' 'XYZ Fit' '#BFC0C2'
```

Depois disso o que sobra é trabalho manual — logo, imagens, tradução, contato e
decidir quais páginas sobrevivem. O script lista tudo ao terminar.

---

## Onde ficam as cores

Não há `:root` nem variável. As cores são **arbitrary values do Tailwind
escritos inline no HTML**, tipo `bg-[#F67A45]`, repetidos página a página:

| Cor | Papel | Usos |
|---|---|---|
| `#F67A45` | Laranja: acento, CTA, título vazado, faixa corrida, ícone | 4.545 |
| `#D5BDA2` | Bege: 2ª camada dos hovers, células da grade, caixa do newsletter | 4.987 |
| `#01010F` | Quase-preto do fundo | 1.635 |
| `#E7E7E7` | Texto no `<body>` | 15 |

Por não ter variável, a troca é substituição de texto — mas como está tudo em
hex literal no HTML, um `sed` resolve. É **muito** mais barato que o Carlink.

**O bege é mais usado que o laranja.** Quem troca só o laranja fica com metade
do site num bege de template. O `personalizar.sh` cobre os dois.

O fundo `#01010F` **não** é trocado por padrão: quase toda marca desse nicho
quer escuro, e o preto do template já é praticamente neutro. Se precisar do
preto exato da marca, rodar um `sed` extra depois.

---

## O que já foi limpo daqui

Isso já está feito, não precisa refazer:

- `lang="en"` virou `lang="pt-BR"` nas 16 páginas
- `<title>Home</title>`, `<title>About</title>` etc viraram
  `<title>[NOME DO CLIENTE] — [DESCRIÇÃO CURTA]</title>` — slot que o
  `personalizar.sh` preenche
- `ajax.cdnjs.com` (alias legado, sem garantia) virou `cdnjs.cloudflare.com`,
  o host canônico — 112 referências. Os 7 caminhos foram conferidos um a um
- `.DS_Store` e `__MACOSX/`
- A documentação e a licença do autor original foram removidas


**Não havia** barra de marketplace, landing de demonstração, seletor de cores
nem script de rastreamento — o template veio limpo nesse ponto. Os números
suspeitos no `contact.html` são as coordenadas do mapa (Nova York), não pixel.
O logo já apontava para `index.html`, então não há link quebrado a repontar.

---

## Armadilhas

**`line-height` abaixo de 1 corta acento — a pior delas.** O template usa
`leading-[.92]` e equivalentes nos títulos grandes, valor pensado para inglês.
Em português isso **decepa o til e a cedilha**: o `Ã` de "NÃO" fica sem a
tampa, e título de duas linhas sobrepõe uma na outra. Medido na prática num
cliente real. Corrigir para `line-height: 1` em tudo que for display.

**As imagens são todas remotas, no GitHub de terceiro.** 97 imagens únicas,
1.082 referências, todas em
`raw.githubusercontent.com/uiaextend/gymfito/`. Inclusive o **logo**, nas 16
páginas. Funciona hoje, mas: não é CDN, tem rate limit, e some no dia em que o
autor apagar o repositório. Baixar o que for ficar. O template **não tem
nenhuma imagem local** — é por isso que ele pesa 2,5 MB e não 28 MB.

**Cinco páginas só existem preenchidas com dado inventado.** `pricing`
(tabela de planos), `schedule` (grade semanal com professor por horário),
`trainer` (perfis com nome e cargo), `classes` e `blog`. Sem preço, grade,
nome e depoimento reais do cliente, **apagar** — não completar no chute. Num
demo de captação isso costuma eliminar metade do template, e foi o motivo de
um cliente real ter virado one-page.

**A home clara é uma ilha.** `index2.html` é a única página de fundo branco;
as outras 15 são escuras. Escolher a `index2` significa reescrever o `<body>`
e as seções das internas, ou ficar com um site que troca de base ao navegar.

**Tailwind pelo Play CDN.** O `<script src="cdn.tailwindcss.com">` gera o CSS
no navegador em tempo de execução. Serve para demo, mas mostra aviso no
console, atrasa a primeira pintura e depende da CDN estar de pé. Para produção
de verdade, compilar o Tailwind.

**Classe utilitária repetida, não componentizada.** Cada botão carrega uma
pilha de 4 divs absolutas só para o hover. É o que dá o efeito bonito, e é
também por que o `index.html` tem **396 KB**. Editar à mão é desconfortável;
com editor, use busca por texto e não navegação visual.

**O conteúdo é demo em inglês**, e `example@email.com` e `(406) 555-0120`
aparecem 17 vezes cada, no header e no rodapé de todas as páginas.

**Abrir por `file://` funciona**, diferente do Carlink — não há requisição
same-origin bloqueada. Mas como as imagens são remotas, sem internet o
template abre sem nenhuma foto.

---

## Já usado em

| Cliente | Como foi usado | Resultado |
|---|---|---|
| Academia/estúdio (cliente real) | Como **referência de linguagem visual**, não como base de código: one-page própria reproduzindo título vazado, faixa corrida, selo giratório, moldura de canto e hover de camadas | Publicado |

Virou one-page porque 10 das seções do template exigiriam preço, grade e
depoimento que o cliente não mandou. Se o próximo cliente mandar esses dados,
o caminho barato é usar o `index.html` de verdade.
