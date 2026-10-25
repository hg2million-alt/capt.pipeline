# Automotivo — Carlink

Template HTML para o nicho automotivo. 13 páginas prontas, 5 variações de home,
base branca com acento vermelho.

**Peso:** 28 MB · **Stack:** HTML estático + jQuery · **Build:** nenhum

---

## Para que serve

Revenda de veículos, aluguel de carros, concessionária, táxi e frota. É um
template de **catálogo de veículo** — nasceu para listar carro, não para vender
serviço. Se o cliente vende serviço (estética automotiva, oficina, funilaria),
dá para usar a estrutura, mas boa parte das seções (busca por marca/modelo,
ficha técnica, calculadora de financiamento) vai sobrar.

## As 5 homes

Preview de cada uma em [`preview/`](preview/).

| Arquivo | O que é | Marca visual |
|---|---|---|
| `home-1.html` | Marketplace de veículos. Busca por marca/modelo/carroceria, topbar com painel de vendedor e login | Fundo claro, faixa vermelha diagonal |
| `home-2.html` | Revenda. Hero cortado na diagonal, busca compacta, marcas, **calculadora de financiamento**, depoimentos | Claro, hero dividido |
| `home-3.html` | Concessionária premium. Hero escuro com slider de veículo em destaque e ficha técnica, catálogo em abas, seção de equipe | **Hero escuro** — a única que já nasce dark |
| `home-4.html` | Aluguel de carros com aplicativo. Botões App Store e Google Play, carrossel de veículos | Claro, minimalista |
| `home-5.html` | Serviço de táxi. Reserva de corrida, planos, motoristas | Amarelo e xadrez, identidade própria |

## Páginas internas

`listing-1` `listing-2` (listagem com filtro) · `detail` `detail_v2` (ficha do
veículo) · `blog-1` `blog-2` `article` (conteúdo) · `contacts`

---

## Como usar

```bash
cd templates/sites/automotivo-carlink
./personalizar.sh /c/Dev/ClienteX/site '#F36A21' 'Cliente X'
```

O script copia o template para a pasta destino, troca **os dois vermelhos de
marca** pela cor informada e preenche o nome do cliente nos `<title>`. O
original nunca é alterado — cada cliente sai de uma cópia limpa.

Depois disso, o que sobra é trabalho manual: logo, escolha da home, tradução dos
textos, contato e fotos. O script lista tudo isso ao terminar.

---

## O que já foi limpo daqui

Isso já está feito, não precisa refazer:

- Barra de promoção do autor e o `index.html` de demonstração que linkava para a
  loja de origem. Como o logo de todas as páginas apontava para ele, os links
  foram repontados para `home-1.html`
- O seletor de cores de demonstração (o botão de engrenagem flutuante) e a pasta
  `assets/js/switcher/` inteira
- `__MACOSX/` e `.DS_Store`
- `lang="zxx"` virou `lang="pt-BR"` nas 13 páginas
- `<title>CARLINK PAGE</title>` virou `<title>[NOME DO CLIENTE] — [DESCRIÇÃO CURTA]</title>`

---

## Armadilhas

**O CSS não tem variáveis.** São 23.008 linhas em `main.css` com tudo chumbado,
15 folhas de estilo ao todo. Não existe `:root` para editar — é por isso que a
troca de cor é feita por substituição de texto e não por variável.

**São dois vermelhos, não um.** `#DD0005` é o acento geral (159 usos) e
`#DD1F06` pinta a classe `.style-color1`, que é o destaque do título do hero.
Trocar só o primeiro deixa o título vermelho no meio do site novo. O
`personalizar.sh` já cobre os dois.

**A base é branca.** Se o cliente precisa de site escuro, comece pela `home-3`,
que é a única com hero escuro — e mesmo assim o corpo da página é claro.
Inverter o template inteiro para dark custa mais do que escrever CSS do zero:
são 78 regras de fundo branco contra 37 escuras. Já foi medido.

**Depende de jQuery.** Além dele: uikit, Swiper, Slick, WOW.js, anime.js,
taxi.js (transição de página), nouislider, ion.rangeSlider, flatpickr e fancybox
— 22 arquivos em `assets/js/`. Tudo local, nada de CDN.

**As imagens pesam.** 407 arquivos, 18 MB dos 28 MB do template. Antes de
publicar, apagar o que não for usado.

**O conteúdo é demo em inglês** e o telefone `(265) 005 369` aparece no header e
no footer de todas as páginas.

**Abrir por HTTP, não por `file://`.** As listagens buscam dois ícones
(`images/icons/list.svg` e `grid.svg`) por requisição, que o Chrome bloqueia em
`file://` por same-origin — os arquivos existem e estão íntegros, mas somem na
tela. Servido por HTTP carrega tudo. Para conferir localmente:

```bash
cd html && python -m http.server 8899   # depois abrir http://localhost:8899/home-1.html
```
