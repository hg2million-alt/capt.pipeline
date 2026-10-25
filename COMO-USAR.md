# Como usar — só pelo celular, sem computador

Tudo roda no **Claude Code na nuvem** (app do Claude no celular, aba Code, ou
claude.ai/code no navegador). Você só conversa; o Claude abre o Google Maps,
monta os sites e te manda os arquivos.

## O que muda em relação ao pacote original

- **Sem computador:** nada pra instalar. As ferramentas (navegador, fotos,
  vídeo) são preparadas sozinhas no começo de cada sessão.
- **Sem Vercel:** cada site chega pra você no chat como **um arquivo `.html`
  com o nome do comércio** (ex.: `Pizzaria Bella Napoli.html`). Toca no
  arquivo → abre no navegador do celular. Funciona até sem internet (só
  fontes e mapa precisam de internet).
- **Região:** Grande Natal/RN, foco nas áreas nobres — Ponta Negra, Capim
  Macio, Lagoa Nova, Candelária, Neópolis, Tirol, Petrópolis, Areia Preta,
  Barro Vermelho, Nova Parnamirim, Cotovelo e Pirangi do Norte.

## Configuração (uma vez só)

1. **Conectar o GitHub ao Claude:** https://claude.ai/connect-github (crie
   uma conta grátis no GitHub se não tiver). É lá que o projeto fica guardado
   — a sessão na nuvem é apagada quando fecha, o GitHub não.
2. **Projeto no GitHub:** o repositório privado com esta pasta (o Claude sobe
   ele pra você na primeira vez).
3. **Internet do ambiente:** no topo da sessão, menu do ambiente na nuvem →
   **Edit** → **Network access**: escolha acesso completo (ou adicione em
   *Allowed domains*: `google.com`, `www.google.com`, `maps.google.com`,
   `googleusercontent.com`, `instagram.com`, `cdninstagram.com`,
   `facebook.com`, `fbcdn.net`). Sem isso, a busca no Maps e no Instagram é
   bloqueada. Guia: https://code.claude.com/docs/en/cloud-environments#network-access

## Uso de toda rodada

Abra uma sessão nova **com o repositório do projeto selecionado** e digite:

1. `/captar 6 pizzaria` — ou `/captar 6` pra ele sugerir o nicho, ou
   `/captar 4 dentista em Ponta Negra` pra um bairro só. Volta uma lista de
   candidatos com o problema encontrado em cada um.
2. Responda aprovando: `aprovo 1, 3 e 4 — troca o 2`.
3. `/produzir` — monta os sites e **te manda os `.html`**, um por comércio,
   mais a mensagem de WhatsApp pronta pra copiar (balão por balão).
4. Mande a mensagem pro dono. Quando ele disser "pode mandar", envie o
   arquivo `.html` como **documento** no WhatsApp (clipe → Documento).
5. Quando ele responder, cole a conversa: `/resultado <nome-do-cliente>`. É
   isso que ensina o sistema a melhorar a próxima rodada.

Pra reenviar um site: "me manda de novo o html da Pizzaria X".

Tudo é salvo no GitHub sozinho no fim de cada etapa. Se aparecer aviso de
que não salvou, resolva antes de fechar a sessão.
