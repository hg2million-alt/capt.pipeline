# Manutenção residencial — Handify

Template para encanador, eletricista, chaveiro, marido de aluguel e qualquer
prestador de reparo/manutenção residencial avulsa. 15 páginas, **base clara**
(branco + laranja `#F05A30`), sem jQuery. Comprado como "Handify — Home
Services & Repairman HTML Template".

**Peso:** 36 MB em `html/` (quase todo em `image/`) · **Stack:** HTML
estático + Bootstrap 5 (grid/reboot/utilities) + Swiper + Masonry + fontes
auto-hospedadas (Inter, Montserrat) · **Build:** nenhum

---

## Para que serve

Encanador, eletricista, técnico de manutenção geral, chaveiro, marido de
aluguel — qualquer prestador que atende chamado avulso residencial. Tem
página de serviço em lista e em detalhe, orçamento/planos, equipe, portfólio
de trabalhos feitos ("work") e blog.

**Não serve** — ou serve mal — para quem vende produto físico (isso é loja,
não serviço) ou para prestador que trabalha por agenda fixa de horário
marcado (não tem seção de agendamento, só formulário de contato/orçamento).

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `service`, `about`,
`contact`) — as outras 11 seguem o mesmo grid/header/footer.

| Página | O que tem |
|---|---|
| `index.html` | Hero (headline + CTA duplo + selo "24-Hour Ready Support") · seção de serviços em grid · sobre resumido · portfólio de trabalhos · depoimentos · CTA final |
| `about.html` | Sobre mais longo, equipe resumida, números/estatística |
| `service.html` / `service_detail.html` | Lista de serviços em card e página de detalhe por serviço |
| `pricing_plan.html` | 3 planos com preço fixo |
| `work.html` / `work_detail.html` | Portfólio de trabalhos executados, em grid e detalhe |
| `team.html` / `team_detail.html` | Equipe em card e perfil individual |
| `testimonial.html` | Depoimentos em lista |
| `blog.html` / `single_blog.html` | Blog em lista e post individual |
| `faq.html` | Perguntas frequentes em acordeão |
| `contact.html` | Formulário de contato + telefone/endereço fixos |
| `404.html` | Página de erro |

## Como personalizar

```bash
templates/sites/manutencao-handify/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Troca a cor de acento (`--accent-color`, variável CSS única, 92 usos) e o
nome do cliente (pré-processado em `html/` como `[NOME DO CLIENTE]`, inclusive
no rodapé onde antes dizia "Copyright © 2025 Rometheme" — nome do estúdio
autor, trocado junto). **Não mexe** no amarelo das estrelas de avaliação
(`#FFD43B`) nem nos hex soltos de gradiente decorativo — não são cor de
marca, ver cabeçalho do script.

## Armadilhas

- **Logo é imagem, não texto.** `image/logo.png` já vem com "Handify"
  desenhado dentro do PNG — o `personalizar.sh` não alcança isso (só troca
  texto). Trocar pela logo real do cliente à mão, nos 2 lugares (header e
  rodapé) por página.
- **Sem foto nenhuma.** Todo `image/dummy-img-WxH.jpg` é placeholder cinza
  com a dimensão escrita dentro — 46 imagens ao todo.
- **Telefone de mentira fixo.** `+1 (212) 555-1212` aparece em pelo menos 4
  lugares (header, seção de contato, cards) — trocar ou marcar "a confirmar".
- **Formulário não funciona na Vercel.** `php/form_process.php` precisa de
  hospedagem com PHP; a Vercel não roda. Sem backend, trocar a ação do
  `<form>` por `wa.me` ou um serviço de formulário estático antes de publicar.
- **Conteúdo em inglês**, incluindo `<html lang="en">` — trocar pra `pt-BR` e
  reescrever com o tom de voz do `identidade.md`, não traduzir ao pé da letra.
- **Preço, equipe, depoimento e post de blog são todos inventados** — sem
  dado real do cliente, marcar como ilustrativo ou remover a seção/página.
- **Pasta `image/` tem sobra do pacote original** (`Logo-1..5.png`,
  `Logo-grey-1..5.png`, `bank-building.png/svg`, `blueprint.png`) que não é
  referenciada em nenhum HTML — pode ignorar ou apagar.
