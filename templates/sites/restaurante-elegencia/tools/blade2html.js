// Renderiza as views Blade do Elegencia (restaurant) em HTML estático.
// Uso: node blade2html.js <pasta-laravel> <pasta-saida>
const fs = require('fs');
const path = require('path');

const [,, src, out] = process.argv;
const views = path.join(src, 'resources', 'views');
const comp = (n) => fs.readFileSync(path.join(views, 'components', n + '.blade.php'), 'utf8');
const layout = fs.readFileSync(path.join(views, 'layout', 'layout.blade.php'), 'utf8');

const compFile = { head: 'head', header: 'header', hero: 'hero', preloader: 'preloader',
  footer: 'footer', scrollup: 'scrollup', videopopup: 'videoPopUp', script: 'script' };

const routeFile = (name) => name + '.html';

function renderHero(title, sub) {
  return comp('hero')
    .replace(/<\?php echo \(isset\(\$title\)[^?]*\?[^?]*\?>/, title)
    .replace(/<\?php echo \(isset\(\$subTitle\)[^?]*\?[^?]*\?>/, sub);
}

function expand(html, vars) {
  // componentes <x-nome ... />
  html = html.replace(/<x-([a-zA-Z]+)([^>]*?)\/>/g, (m, name, attrs) => {
    const key = name.toLowerCase();
    if (key === 'hero') return renderHero(vars.title || '', vars.subTitle || '');
    if (!compFile[key]) throw new Error('componente desconhecido: ' + name);
    return comp(compFile[key]);
  });
  // <?php echo (isset($script) ...) ?> e restos
  html = html.replace(/<\?php echo \(isset\(\$script\)[^?]*\?[^?]*\?>\n?/g, '');
  // asset() e route()
  html = html.replace(/\{\{\s*asset\('([^']+)'\)\s*\}\}/g, '$1');
  html = html.replace(/\{\{\s*route\('([^']+)'\)\s*\}\}/g, (m, r) => routeFile(r));
  return html;
}

fs.mkdirSync(out, { recursive: true });
const pages = fs.readdirSync(path.join(views, 'home')).filter(f => f.endsWith('.blade.php'));
for (const f of pages) {
  const name = f.replace('.blade.php', '');
  let raw = fs.readFileSync(path.join(views, 'home', f), 'utf8');
  let html;
  if (/@extends\('layout\.layout'\)/.test(raw)) {
    const vars = {};
    const php = raw.match(/@php([\s\S]*?)@endphp/);
    if (php) for (const m of php[1].matchAll(/\$(\w+)\s*=\s*'([^']*)'/g)) vars[m[1].toLowerCase() === 'title' ? 'title' : m[1]] = m[2];
    const sec = raw.match(/@section\('content'\)([\s\S]*?)@endsection/);
    if (!sec) throw new Error('sem @section content em ' + f);
    html = layout.replace(/<x-hero[^>]*\/>/, '<x-hero/>').replace("@yield('content')", () => sec[1]);
    html = expand(html, vars);
  } else {
    html = expand(raw, {});
  }
  const left = html.match(/\{\{[^}]*\}\}|<\?php|@(extends|section|php|yield)/g);
  if (left) throw new Error(f + ' sobrou Blade: ' + left.slice(0, 5).join(' | '));
  fs.writeFileSync(path.join(out, name + '.html'), html);
  console.log('ok', name + '.html', html.length);
}
