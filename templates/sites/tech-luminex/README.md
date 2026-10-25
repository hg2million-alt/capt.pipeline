# Tech Luminex — pack multipurpose de TI/tecnologia

Pack comprado "Luminex - Multipurpose IT Business & Tech" — **6 demos
completos e independentes**, cada um pra um sub-nicho diferente de empresa de
tecnologia. Não é "3 homes da mesma marca" como o Decare/Elegencia: são 6
sites distintos, com copy, seções e paleta próprias.

## Para que serve

Empresa de tecnologia que **vende serviço ou software**, não loja física.
Escolher o demo pelo negócio real do cliente:

| Demo | Sub-nicho | Nasce | Acento original |
|---|---|---|---|
| `bitelo` | Startup de tecnologia genérica | claro | azul `#2868ED` |
| `codexa` | Empresa de SaaS/software | claro | azul `#267DFF` |
| `fortexa` | Cibersegurança | escuro | verde neon `#1AFF7C` (⚠️ não é a `--accent-color` — ver Armadilhas) |
| `luminex` | IA / Machine Learning | escuro | roxo `#9E56E6` + rosa `#FF77E9` |
| `storedge` | Armazenamento em nuvem / infra | escuro | azul `#2563EB` |
| `visora` | Consultoria de TI | claro | laranja `#FF6800` |

**Para que NÃO serve:** loja física de tech (assistência técnica, venda de
celular/acessório no balcão) — foi o caso testado: uma loja + assistência
técnica real **não usou nenhum desses 6 demos como base**, porque o pack
inteiro é copy de SaaS/startup/consultoria B2B (features, planos de software,
"book a demo", case study) — nada de produto físico, prateleira ou conserto.
Pra loja/assistência de tecnologia, construir do zero é o caminho, não
partir deste pack.

Também não serve pra quem precisa de e-commerce de verdade (carrinho,
checkout) — `shop`/`shop-details` não existem aqui como existem no Decare;
os planos de `pricing` são só cards estáticos.

## Peso e dependências

HTML + Bootstrap 5 + jQuery + fonte auto-hospedada (bem mais pesado que os
outros templates da biblioteca por causa disso). Sem build, sem framework.

- **144 MB no total** (6 demos completos + previews) — mas o cliente final
  só recebe UM demo: `personalizar.sh` copia só a pasta escolhida
  (8,8 MB o mais leve — `bitelo` — a 37 MB o mais pesado — `fortexa`),
  o mesmo patamar dos outros templates da biblioteca (Carlink 28 MB,
  Thesignature 30 MB)
- O peso principal de cada demo é `font/` (20-37 MB): as fontes vêm
  auto-hospedadas em vários pesos + variable font + Font Awesome + um ícone
  customizado (`rtmicon`). Todos os outros sites deste workspace carregam
  fonte via Google Fonts CDN no `<head>` (ver qualquer `clientes/*/site/index.html`)
  — considerar trocar em vez de subir os arquivos locais, principalmente se
  o deploy for a Vercel de um plano pequeno
- `image/` é só placeholder (~700 KB-1,2 MB): tudo `dummy-img-*.jpg` cinza,
  sem foto real nenhuma — mesmo padrão do Decare/Elegencia/Thesignature

## Onde ficam as cores da marca

Diferente do Decare (cor chumbada em ~30 lugares) e mais parecido com o
Elegencia: cada demo declara a paleta em **custom properties CSS**, no topo
de `css/style.css`, dentro de `:root { --accent-color: ...; }`. Só que
**cada demo usa uma variável diferente pra cor de verdade** — documentado
demo a demo dentro do `personalizar.sh` (bloco `case "$DEMO" in`).

A armadilha mais importante: em `fortexa`, `--accent-color` é `#e6e6e6`
(cinza claro de texto/ícone) — a cor de marca de verdade (o verde neon) está
em `--accent-hover` e `--text-color-2`. Se alguém for trocar a cor na mão
sem olhar essa observação, vai mexer na variável errada e nada muda
visualmente.

Além da variável, a mesma cor se repete:
- como **hex literal** em gradientes (`linear-gradient(...#267DFF...)`)
- como **decimal `rgba(38, 125, 255, 1)`** em outros gradientes — a MESMA
  cor, duas notações diferentes, nem sempre nos dois formatos ao mesmo tempo
- **URL-encoded** (`%23` no lugar do `#`) dentro de `background-image:
  url('data:image/svg+xml,...fill="%23267DFF"...')` — os ícones de
  accordion (+/−) e seta do Bootstrap inline

`personalizar.sh` troca as três formas (ver função `trocar_hex`, que cobre
hex + `%23`hex de uma vez, e as chamadas de `trocar` com `hex_rgb` pro
decimal). Ainda assim, alguns tons de gradiente sem variável própria (2ª ou
3ª parada de um degradê decorativo) foram deixados de fora quando o ganho
não compensava o risco — documentado inline no script, no estilo do
Decare ("não vale o sed").

## Como personalizar

```bash
templates/sites/tech-luminex/personalizar.sh <demo> <destino> '#COR' 'Nome do Cliente'
```

`<demo>` é obrigatório: `bitelo`, `codexa`, `fortexa`, `luminex`, `storedge`
ou `visora`. Mostrar os previews em `preview/` (5 por demo: index, about,
services, pricing, contact) e deixar o cliente/usuário escolher olhando —
os 6 têm tom visual bem diferente (do neon escuro do Fortexa ao laranja
claro do Visora).

## Armadilhas

- **Todo o copy é em inglês e é discurso de SaaS/startup** — "book a demo",
  planos de assinatura, métricas de "customer satisfaction". Precisa reescrever
  seção por seção pro negócio real, não só traduzir
- **`pricing`/`pricing_plan`, `blog`, `team`, `gallery` e
  `case_study`/`study_case`/`project` só existem com dado inventado** — apagar
  o que o cliente não tem, e tirar a seção correspondente da home também
- **Fortexa: `--accent-color` não é a cor de marca** (ver seção de cores acima)
- **Fontes auto-hospedadas pesam 20-37 MB por demo** — considerar Google Fonts
  CDN como todo o resto do workspace
- **Sem foto nenhuma** — todo `<img>` é placeholder cinza com o tamanho
  escrito dentro
- **Formulário de contato sem back-end** — configurar `wa.me` ou apagar
- **Sem `vercel.json`** — criar com `"framework": null` antes do deploy
  (skill `vercel-cliente-novo`)
