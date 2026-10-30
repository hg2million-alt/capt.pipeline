# Rodada 2026-10-30 — restaurante/pizzaria (rotina 9h)

**Resultado: nenhum candidato aprovado. Demo NÃO produzido.**

## Bloqueio
- Google Maps (www.google.com/maps, via MCP Playwright e via `navegar.js`) abre as fichas
  em **"visão limitada"**: sem total de avaliações, sem galeria de fotos, sem link de
  Instagram/Facebook. Só aparecem nome, nota, endereço, telefone e site (campo "Site").
- Consequência: não dá pra cumprir o Passo 4 (avaliações suficientes) nem o Passo 6
  (fotos reais, logo, paleta). Busca web (WebSearch) não achou Instagram nem volume de
  avaliações recente para os pré-selecionados. Instagram não foi aberto: sem handle
  confirmado por fonte (regra: não chutar handle).

## Triagem (busca "pizzaria Ponta Negra Natal", ~7 fichas abertas de 36 listadas)
Sem site próprio (ficha sem site) — pré-selecionados, **NÃO validados**:
- Prazeres da pizza — Vila de Ponta Negra, nota 4,9, +55 84 99685-2541, ficha sem site.
- Tomatino Pizzeria — R. Praia de Guajiru, 9224, nota 4,5, +55 84 3086-6512, ficha sem site.
Só cardápio de plataforma de terceiros (conta como sem site, a validar): La Tavola Pizzas e
Massas (cardapioweb, 4,8), Pizza Natalense (anota.ai, 4,9), Curva do Vento (xmenu, 4,5).
Descartados por ter site próprio: Páprika (paprikanatal.com.br), Piazzale Italia (piazzaleitalia.com.br).
Fichas restantes da lista não foram abertas.

## Próximo passo
Rodar de novo quando o Maps abrir em visão completa (ou liberar a Places API), começando
pelos pré-selecionados acima.
