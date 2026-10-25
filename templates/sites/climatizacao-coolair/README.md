# Climatização / HVAC — CoolAir

Template para empresa de ar-condicionado, aquecimento e ventilação:
instalação, manutenção, reparo e venda de equipamento. 31 páginas (14 delas
são variações de home concorrentes), **base clara com header azul**
(`#234982` + `#678fd5`). Comprado como "CoolAir — Air Conditioner & Heating
& HVAC Website Template".

**Peso:** 56 MB em `html/` (quase todo em `images/`, fotos de banco de
imagens em alta resolução) · **Stack:** HTML estático + Bootstrap 5 + jQuery
+ Swiper (slider/carrossel) + fontes auto-hospedadas · **Build:** nenhum

---

## Para que serve

Empresa de ar-condicionado/HVAC: instalação, manutenção, reparo emergencial,
venda de equipamento (split, inverter, central). Tem página de serviço,
projeto/portfólio de instalações, produtos com preço, lista de preços por
tipo de serviço, blog e formulário de agendamento além do de contato.

**Não serve** — ou serve mal — pra prestador que não vende/instala
equipamento físico (aqui tem página de produto com preço e carrinho visual)
nem pra quem só faz reparo avulso sem nenhuma linha de produto.

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `about`, `contact`,
`products`) — as outras seguem o mesmo header/footer e sistema de cor.

| Página | O que tem |
|---|---|
| `index.html` | Slider hero (2 slides) · selos de confiança · sobre resumido · serviços · projetos recentes · depoimentos · logos de "clientes" · CTA final |
| `about.html` | Sobre mais longo, números/estatística, equipe |
| `service-area.html`, `repair.html`, `installation.html`, `maintenance.html` | Uma página por tipo de serviço |
| `products.html` / `product-details.html` / `product-details-new.html` | Catálogo de equipamento com preço e detalhe |
| `pricing-plans.html` | Seção focada em ligar/orçar, sem tabela de plano fixo |
| `price-list.html` | Tabela real de preço por tipo de serviço/equipamento (em dólar, chutada) |
| `projects.html` / `project-single.html` | Portfólio de instalações em grid e detalhe |
| `booking.html` | Formulário de agendamento (data/hora) |
| `contact.html` | Formulário de contato + endereço/telefone fixos + mapa |
| `blog.html` / `blog-single.html` | Blog em lista e post individual |
| `homepage-2.html` … `homepage-14.html`, `onepage-1.html` | 13 variações alternativas de home + versão one-page — demos concorrentes, escolher uma antes de publicar |
| `elements.html` | Vitrine de componentes do template (não é página de site) |

## Como personalizar

```bash
templates/sites/climatizacao-coolair/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

O template tem um trocador de esquema de cor de fábrica (3 arquivos prontos
em `css/colors/scheme-0{1,2,3}.css`, todos tons de azul/teal) — toda página
carrega sempre `scheme-01.css`, então é nele que o script mexe.

Ali dentro há duas variáveis, `--primary-color` (azul escuro, dominante:
topbar, logo, menu, botões) e `--secondary-color` (azul claro: ícones,
botão "Schedule Now", hover). Testado com screenshot antes de mexer:
**não são uma cor de marca + um acento de contraste** (como no caso do
Qlinest) — são o mesmo azul em dois tons, sempre lado a lado na tela. Por
isso o script pede só **uma** cor e deriva a secundária automaticamente
(mistura 40% em direção ao branco), pra manter os dois tons combinando com
qualquer cor de cliente. Também atualiza `--primary-color-rgb` e
`--secondary-color-rgb` (usadas em `rgba()` pra overlay/gradiente sobre as
fotos — sem isso o overlay das fotos ficava azul mesmo com a cor trocada).
`--tertiary-color` (quase-branco, fundo de seção neutra) fica fixo.

Troca também o nome do cliente (pré-processado em `html/` como
`[NOME DO CLIENTE]`, inclusive "Designesia", nome do estúdio autor no
rodapé) e o e-mail fake `contact@coolair.com`, neutralizado à parte como
`[EMAIL]` pra não quebrar durante o replace do nome.

## Armadilhas

- **Logo é imagem, não texto.** `images/logo.webp` (topo) e
  `images/logo-black.webp` (aparece ao rolar) trazem o ícone de onda + a
  palavra "CoolAir" desenhados dentro do arquivo — o `personalizar.sh` não
  alcança. Trocar os 2 arquivos pela logo real do cliente.
- **Fotos são banco de imagem genérico, não fachada/trabalho do cliente.**
  As ~180 fotos em `images/` (condensadora em telhado, técnico, controle
  remoto, prédio comercial) são stock, sem ligação nenhuma com quem vai
  usar o template — trocar pelas fotos reais onde existirem.
- **Telefone de mentira fixo.** `+929 333 9296` aparece em várias páginas
  (topbar, contato, seção de preço) — trocar ou marcar "a confirmar".
- **Formulário não funciona na Vercel.** `contact.php` e `booking.php`
  processam os dois formulários (contato e agendamento) e precisam de
  hospedagem com PHP — sem isso, nada é enviado; trocar a ação dos `<form>`
  por `wa.me` ou serviço de formulário estático antes de publicar.
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra `pt-BR` e
  reescrever com o tom de voz do `identidade.md`, não traduzir ao pé da
  letra.
- **Equipe com nome inventado repetido.** `about.html` tem 4 cards de
  equipe, todos com o mesmo nome ("Jeffery Mussman") e cargo — sem gente
  real, apagar a seção ou trocar por cargo genérico sem nome.
- **Depoimento inventado.** Os 3 depoimentos da home (Michael S., Robert L.,
  Jake M.) têm texto e avaliação chutados — usar só com selo "ilustrativo".
- **Preço chutado em dólar.** `price-list.html` tem tabela real por tipo de
  ar-condicionado (ex. "Window Type" \$30, "Window Type Inverter" \$40) —
  sem tabela real do cliente, converter/apagar ou marcar "a confirmar".
- **14 homes concorrendo.** O pacote original vem com `index.html` +
  13 variações (`homepage-2` a `homepage-14`) + `onepage-1.html`, todas
  ligadas no menu de navegação/demo — escolher uma (index.html é a mais
  completa) e tirar as outras do menu antes de publicar.
- **Redes sociais vazias.** Os ícones do topo (Facebook/X/Youtube/Pinterest/
  Instagram) apontam pra `href="#"` — preencher ou remover os que o cliente
  não tem.
- **Peso alto.** 56 MB majoritariamente em fotos de banco de imagem —
  considerar comprimir ou remover as variantes de home não usadas antes do
  deploy.
