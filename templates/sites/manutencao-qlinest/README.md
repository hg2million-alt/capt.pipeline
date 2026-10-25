# Manutenção residencial — Qlinest

Template pra diarista, empresa de limpeza residencial/comercial recorrente ou
serviço de faxina avulsa. 7 páginas, **base azul** (`#1F77D6`) com botão de
CTA amarelo fixo. Comprado como "Qlinest — Home Cleaning Service Website HTML
Template".

**Peso:** 2,6 MB em `html/` · **Stack:** HTML estático + Bootstrap 5 + jQuery
+ AOS (scroll reveal) + Lenis (smooth scroll) + Slick + Odometer (contador
animado) + Tom Select + fontes auto-hospedadas (Inter, Plus Jakarta Sans) ·
**Build:** nenhum

---

## Para que serve

Diarista, empresa de limpeza residencial ou comercial, faxina recorrente ou
avulsa. Tem seção de "como funciona" em 3 passos, cards de serviço, contador
de clientes atendidos, depoimento e blog.

**Não serve** — ou serve mal — pra prestador que vende produto (não é loja) ou
pra serviço que precisa de agendamento com calendário (aqui só tem formulário
de contato, sem escolha de data/hora).

## As páginas

Preview das 4 principais em [`preview/`](preview/).

| Página | O que tem |
|---|---|
| `index.html` | Hero (fundo azul cheio, CTA amarelo, contador "100K+ clientes", logos de "clientes atendidos") · sobre resumido · grid de serviços · "como funciona" em 3 passos · depoimentos · CTA final · newsletter no rodapé |
| `about-us.html` | Sobre mais longo, repete grade de serviços e depoimentos |
| `services.html` | Grid completo de serviços oferecidos |
| `service-details.html` | Detalhe de um serviço específico |
| `blog.html` / `blog-details.html` | Blog em lista e post individual |
| `contact-us.html` | Formulário de contato + telefone/e-mail fixos + mapa |

## Como personalizar

```bash
templates/sites/manutencao-qlinest/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Troca a cor de marca (`--dark-blue`, fundo do header/hero/CTA/rodapé — 37
usos) e o nome do cliente. **Não mexe** no botão amarelo fixo (`--accent-color`)
nem nos tons claros de azul dos selos (`--light-blue`/`--lightest-blue`) — ver
cabeçalho do script para o porquê.

## Armadilhas

- **Logo é SVG com o nome vetorizado.** `assets/img/logo.svg` tem "Qlinest"
  desenhado como contorno (texto convertido em path), não como texto de
  verdade — não aparece em busca por nome, e o script não alcança. Trocar o
  arquivo inteiro pela logo do cliente.
- **Fotos "com nome de foto de verdade" que são placeholder.** Os arquivos em
  `assets/img/` têm nome descritivo (`hero-img1.jpg`, `about-img1.jpg`) mas
  são todos cinza com a dimensão escrita dentro — não confundir com foto real
  só pelo nome do arquivo.
- **E-mail fake já veio neutralizado.** `hello@qlinest.co` virou `[EMAIL]`
  (não `[NOME DO CLIENTE]`, porque isso quebraria o domínio) em
  `contact-us.html` — preencher com o contato real.
- **"100K+ satisfied customer" e os 4 logos "Logoipsum"** no hero são
  estatística e cliente inventados — apagar, nunca preencher no chute.
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra `pt-BR`.
- **Depoimentos com nome, foto e nota inventados** — usar só com selo
  "ilustrativo" visível, nunca como depoimento real.
