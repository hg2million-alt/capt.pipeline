// Navegador de reserva pra nuvem, quando o MCP do Playwright não subiu.
// Usa o Chromium que já vem instalado no ambiente do Claude Code na nuvem.
//
//   node navegar.js <url> texto                 texto visível da página
//   node navegar.js <url> print <saida.png>     screenshot (página inteira, 390 px = celular)
//   node navegar.js <url> js <arquivo.js>       roda a função do arquivo na página e imprime o JSON
//
// O arquivo .js do modo "js" contém só uma função, igual às que o SKILL.md da
// captar usa com browser_evaluate:  async () => { ...; return algo; }
const fs = require('fs');
const { chromium } = require('playwright');

(async () => {
  const [url, modo = 'texto', arg] = process.argv.slice(2);
  if (!url) {
    console.log('uso: node navegar.js <url> texto | print <saida.png> | js <arquivo.js>');
    process.exit(1);
  }
  const navegador = await chromium.launch();
  const contexto = await navegador.newContext({
    locale: 'pt-BR',
    viewport: modo === 'print' ? { width: 390, height: 844 } : { width: 1366, height: 900 },
  });
  const pagina = await contexto.newPage();
  await pagina.goto(url, { waitUntil: 'domcontentloaded', timeout: 60000 });
  await pagina.waitForTimeout(3000);
  // aceita o aviso de cookies do Google, se aparecer
  const aceitar = pagina.getByRole('button', { name: /Aceitar tudo|Accept all/i });
  if (await aceitar.count()) { await aceitar.first().click(); await pagina.waitForTimeout(2000); }

  if (modo === 'texto') {
    console.log(await pagina.evaluate(() => document.body.innerText));
  } else if (modo === 'print') {
    await pagina.screenshot({ path: arg || 'print.png', fullPage: true });
    console.log(arg || 'print.png');
  } else if (modo === 'js') {
    const fn = fs.readFileSync(arg, 'utf8');
    const resultado = await pagina.evaluate(`(${fn})()`);
    console.log(JSON.stringify(resultado, null, 2));
  }
  await navegador.close();
})();
