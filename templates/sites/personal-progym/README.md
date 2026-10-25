# Personal trainer — Progym

Template para personal trainer autônomo ou pequeno estúdio individual. 11
páginas, **base escura** (preto + verde neon `#9CFF1E`). Comprado como
"Progym — Personal Trainers & Fitness HTML Template" — o próprio nome do
pacote e o subtítulo "PERSONAL TRAINER" sob a logo já anunciam o nicho certo.

**Peso:** ~9 MB em `html/` · **Stack:** HTML estático + Bootstrap 5
(grid/reboot/utilities) + Swiper + fontes auto-hospedadas (Montserrat,
Pontano Sans) · **Build:** nenhum

---

## Para que serve

Personal trainer, treinador funcional autônomo, consultor de treino online —
profissional único ou dupla que vende programa de treino personalizado, não
uma academia com quadro de horário. Tem hero com CTA duplo, seção "sobre" em
primeira pessoa, grade de programas, tabela de preço, FAQ e formulário de
contato.

**Este é diferente do `academia-gymfito`:** o Gymfito é para o negócio físico
— a academia com aula, turma e horário fixo. O Progym é para o profissional
sozinho — a página fala "eu crio seu plano de treino", não "matricule-se na
nossa academia". Se o cliente é uma pessoa (o personal) e não um espaço com
placa na porta, comece aqui.

**Não serve** — ou serve mal — para academia com múltiplos professores e
grade de aula (isso é `academia-gymfito`), nem para consultoria 100% remota
sem nenhum componente presencial (a página assume "treino" no sentido físico,
não é copy de SaaS/infoproduto).

## As páginas

Preview de 4 delas em [`preview/`](preview/) (`index`, `about`, `contact`,
`team`) — as outras 7 seguem o mesmo grid/header/footer.

| Página | O que tem |
|---|---|
| `index.html` | Hero (headline + CTA duplo "Contact Us"/"Our Program") · sobre resumido · grade de programas · contador de anos/alunos · depoimentos · CTA final |
| `about.html` | Sobre mais longo, números/estatística |
| `program.html` / `program_detail.html` | Grade de programas de treino em card e página de detalhe |
| `price_plan.html` | 3 planos com preço fixo |
| `team.html` | Equipe de treinadores em card — pensado pra academia com vários profissionais, ver Armadilhas |
| `blog.html` / `single_blog.html` | Blog em lista e post individual |
| `faq.html` | Perguntas frequentes em acordeão |
| `contact.html` | Formulário de contato + telefone/e-mail/site fixos |
| `404.html` | Página de erro |

## Como personalizar

```bash
templates/sites/personal-progym/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Troca a cor de acento (`--accent-color`, variável CSS única, 107 usos, mais
3 gradientes de borda que escrevem o mesmo hex direto sem passar pela
variável) e o nome do cliente (pré-processado em `html/` como
`[NOME DO CLIENTE]`, inclusive no rodapé onde antes dizia "Copyright © 2024
Rometheme" e no autor fictício dos posts do blog — mesmo nome do estúdio que
fez o template, trocado junto). **Não mexe** nos cinzas de fundo/ícone
(`--accent-color-2/3/4`) — não são cor de marca, ver cabeçalho do script.

## Armadilhas

- **Logo é imagem, não texto.** `image/logo.png` já vem com "PROGYM"
  desenhado dentro do PNG — o `personalizar.sh` não alcança isso (só troca
  texto). Trocar pela logo real do cliente. Tem `Logo-1..5.png` soltos em
  `image/` (faixa de "clientes atendidos" que não existe mais no HTML final)
  — sobra do pacote original, pode ignorar ou apagar.
- **Sem foto nenhuma.** Todo `image/dummy-img-WxH.jpg` é placeholder cinza
  com a dimensão escrita dentro — 12 imagens ao todo.
- **`team.html` pressupõe vários profissionais.** Nome, cargo e foto de
  treinador são todos inventados, e a página só faz sentido se o cliente
  tiver mais de uma pessoa na equipe — para personal autônomo sozinho, o
  caminho mais barato costuma ser apagar a página e tirar do menu.
- **E-mail e site de mentira fixos.** `hello@domainsite.com` aparece no
  rodapé de todas as páginas — já veio trocado por `[EMAIL]` (não por
  `[NOME DO CLIENTE]`, isso quebraria o domínio). `www.domainsite.com` em
  `contact.html` virou `[SITE]` pelo mesmo motivo. Telefone
  `0761-8523-398` também é fixo em todas as páginas — trocar por WhatsApp
  real ou marcar "a confirmar".
- **Formulário não funciona na Vercel.** `php/form_process.php` precisa de
  hospedagem com PHP; a Vercel não roda. Sem backend, trocar a ação do
  `<form>` de `contact.html` por `wa.me` ou um serviço de formulário
  estático antes de publicar.
- **Conteúdo em inglês.** `<html lang="pt-BR">` já foi ajustado nas 11
  páginas, mas o texto em si continua em inglês — reescrever com o tom de
  voz do `identidade.md`, não traduzir ao pé da letra.
- **Preço, programa, depoimento e post de blog são todos inventados** — sem
  dado real do cliente, marcar como ilustrativo ou remover a seção/página.
- **Redes sociais apontam pra `href="#"`** no rodapé — preencher ou remover
  os que não existem.
