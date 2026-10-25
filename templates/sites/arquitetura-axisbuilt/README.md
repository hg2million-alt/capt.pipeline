# Arquitetura / interiores — Axisbuilt

Template para escritório de arquitetura, design de interiores, construtora ou
estúdio de reforma. 18 páginas (6 variações de home), **base clara** (bege
`#F5F3EF` + preto `#0D0D0D`) com acento dourado `#CAA05C`. Comprado como
"Axisbuilt — Architecture & Interior Design HTML Website Template".

**Peso:** 11 MB em `html/` (quase todo em `assets/img/`, +150 placeholders)
· **Stack:** HTML estático + Bootstrap 5 + jQuery + GSAP (com ScrollTrigger e
SplitText) + Lenis (smooth scroll) + Swiper + Odometer (contador animado) +
FontAwesome + fontes auto-hospedadas (Titillium Web, Space Grotesk) ·
**Build:** nenhum — o CSS já vem compilado (`assets/sass/` está incluso como
fonte, mas não é necessário rodar nada pra usar o template)

---

## Para que serve

Escritório de arquitetura, design de interiores, construtora, estúdio de
reforma/remodelação — qualquer negócio que vende projeto e vive de mostrar
portfólio de obra. Tem hero de destaque, faixa de serviços em marquee,
portfólio de projetos em grid e detalhe, equipe, depoimentos, FAQ, blog e
página de preços.

**Não serve** — ou serve mal — para quem vende produto físico de construção
(isso é loja, não serviço de projeto) ou pra quem não tem nenhuma imagem de
obra/projeto pra mostrar: o nicho de arquitetura vive de portfólio visual, e
todo esse template vem 100% sem foto.

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `about-us`,
`services`, `contact-us`) — as outras seguem o mesmo grid/header/footer.

| Página | O que tem |
|---|---|
| `index.html` | Home principal — hero com CTA duplo, faixa de serviços em marquee, sobre resumido, portfólio em destaque, depoimentos, CTA final |
| `home-v2.html` a `home-v6.html` | 5 variações de home com layout/hero diferentes — escolher uma só antes de publicar (ver Armadilhas) |
| `about-us.html` | Sobre mais longo, estatística em contador animado, prêmios |
| `services.html` / `service-details.html` | Grid de serviços e página de detalhe por serviço |
| `portfolio.html` / `portfolio-details.html` | Portfólio de projetos em grid e detalhe |
| `pricing.html` | 3 planos com preço fixo |
| `team.html` / `team-details.html` | Equipe em card e perfil individual |
| `faq.html` | Perguntas frequentes em acordeão |
| `blog.html` / `blog-details.html` | Blog em lista e post individual |
| `contact-us.html` | Formulário de contato (web3forms) + mapa + telefone/e-mail fixos |

## Como personalizar

```bash
templates/sites/arquitetura-axisbuilt/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Troca a cor de acento (`--accent-color`, variável CSS, 145 usos — mais 1
gradiente decorativo com o hex direto que escapa da variável, o script pega
os dois) e o nome do cliente (pré-processado em `html/` como
`[NOME DO CLIENTE]`, inclusive no `<title>`, meta tags e rodapé, onde antes
também aparecia "Laralink" — nome do estúdio autor do template, trocado
junto). **Não mexe** em `--primary-color` (`#0D0D0D`, quase preto) — é texto
padrão e fundo de seção escura, funciona com qualquer cor de acento, ver
cabeçalho do script.

## Armadilhas

- **Logo é SVG com o nome vetorizado.** `assets/img/logo.svg` (header) e
  `logo2.svg` (rodapé) têm "AxisBuilt" desenhado como contorno (texto
  convertido em path) — não aparece em busca por nome, e o script não
  alcança. Tem também `footer-logo.webp`/`footer-logo2.webp` (ícone) e
  `logo-text.webp`/`logo-text2.webp` (o selo giratório "ARCHITECTURE &
  INTERIOR DESIGN") — 6 arquivos ao todo pra trocar pela identidade real.
- **Sem foto nenhuma — mais de 150 imagens.** Todo `assets/img/*.webp` de
  conteúdo (hero, about, portfólio, post, avatar, banner) é placeholder
  cinza com a dimensão escrita dentro. Pesa mais aqui do que em outros
  templates porque arquitetura vive de portfólio visual — sem foto real de
  obra, a demo não convence.
- **Formulário manda e-mail pra conta de outra pessoa.** `contact-us.html`
  usa `action="https://api.web3forms.com/submit"` com uma `access_key` que é
  da conta do autor do template — publicar sem trocar faz a mensagem do
  cliente cair na caixa de entrada de outra pessoa. Gerar uma `access_key`
  nova e grátis em web3forms.com pro e-mail do cliente, ou trocar por
  `wa.me`. As demais páginas (home, blog, newsletter) têm formulário com
  `action="#"`, que não envia nada.
- **E-mail fake já veio neutralizado.** `info@axisbuilt.com` e
  `admin@axisbuilt.com` (contact-us) viraram `[EMAIL]` em vez de
  `[NOME DO CLIENTE]` porque um find/replace pelo nome ia quebrar o domínio.
  Outros e-mails de mentira sem domínio de marca (`info@gmail.com`,
  `email@exmple.com`, `support@example.com`, espalhados por about-us,
  home-v2/v3/v6, services, team, team-details) também já viraram `[EMAIL]`.
  36 ocorrências ao todo — preencher com o e-mail real ou apagar se o
  cliente só usa WhatsApp.
- **Telefone sem padrão.** Cada página tem um número/Skype diferente e
  inventado (`001100110011`, `+01234567890`, `+0844560789`,
  `+25669872564`, `+123456789`, `+12318005678990`) — não dá pra trocar com
  um sed só, é ir página por página.
- **Mapa fixo em Nova York.** O iframe do Google Maps em `contact-us.html`
  usa as coordenadas do template original — trocar pelo endereço real ou
  remover a seção.
- **6 versões de home.** `index.html` + `home-v2` a `home-v6` — escolher uma
  só e apagar/deslincar as outras do menu antes de entregar.
- **Equipe, preço e blog são inventados.** `team.html`/`team-details.html`
  repetem 3 nomes fictícios (Savannah Nguyen, Leslie Alexander, Cameron
  Williamson) com foto placeholder; `pricing.html` tem 3 planos chutados
  ($69/$79/$99); blog é texto genérico em inglês. Sem dado real, marcar como
  ilustrativo, remover a seção ou tirar a página do menu.
- **Conteúdo em inglês**, incluindo `<html lang="en">` — trocar pra
  `pt-BR` e reescrever com o tom de voz do `identidade.md`, não traduzir ao
  pé da letra.
- **Sass incluso mas não necessário.** `assets/sass/` é o código-fonte do
  CSS compilado (`assets/css/style.css`), útil como referência se precisar
  editar algo estrutural, mas não faz parte do fluxo de personalização — o
  `personalizar.sh` mexe só no CSS já compilado.
