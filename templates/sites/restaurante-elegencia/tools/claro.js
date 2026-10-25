// Inverte o style.css do Elegencia de base escura para base clara.
//
//   node claro.js <style.css> <#COR> <#COR_TITULO>
//
//   COR         acento claro: linhas, bordas, filetes, hover (ex.: dourado)
//   COR_TITULO  acento escuro: títulos e botões cheios (ex.: bordô, navy)
//
// O template nasce com 5 cores: dourado #FFD28D (título + detalhe), branco
// (texto), #4F4836 (linha), preto e #040D10 (fundo). A inversão é por regra,
// não por cor: um seletor que continua em superfície escura (hero sobre foto,
// lightbox, botão preto, preloader) mantém o texto branco; o resto vira grafite.
const fs = require('fs');
const [,, file, COR, COR_TITULO] = process.argv;
if (!file || !/^#[0-9a-f]{6}$/i.test(COR || '') || !/^#[0-9a-f]{6}$/i.test(COR_TITULO || '')) {
  console.error('uso: node claro.js <style.css> <#COR> <#COR_TITULO>'); process.exit(1);
}
const rgb = (h) => [1, 3, 5].map(i => parseInt(h.slice(i, i + 2), 16));
const mix = (h, a) => '#' + rgb(h).map(c => Math.round(255 * (1 - a) + c * a).toString(16).padStart(2, '0')).join('');
const BASE = '#ffffff';
const BASE2 = mix(COR, 0.10);   // fundo de seção alternada (champanhe se COR for dourado)
const LINHA = mix(COR, 0.40);   // filete, borda, hr
const TEXTO = '#171717';
const CORPO = '#4a4a4a';
const COR_RGB = rgb(COR).join(', ');

// seletores que continuam em superfície escura: texto branco fica, dourado fica dourado
const ESCURO = /hero|preloader|video-popup|\.lg-|ak-scrollup|ak-white-color|pagination-item\.active|btn-style-3|accordion|faq-nav|\.ak-moving-section|overlay|overlap|img-overlay|sidebar-hero-3|footer-btn/i;

let css = fs.readFileSync(file, 'utf8');

css = css.replace(/([^{}]+)\{([^{}]*)\}/g, (m, sel, body) => {
  // o texto antes do { carrega comentários (o cabeçalho lista "Hero", "Preloader"…): testa só o seletor
  const escuro = ESCURO.test(sel.replace(/\/\*[\s\S]*?\*\//g, ''));
  let b = body;
  // texto branco → grafite (só em superfície clara). "(^|[^-])" evita background-color
  if (!escuro) b = b.replace(/(^|[^-\w])color:\s*#fff\b/gi, '$1color: ' + TEXTO);
  // dourado: em texto vira COR_TITULO (ou COR se a superfície é escura); em borda/fundo/traço vira COR
  b = b.replace(/(^|[^-\w])color:\s*#ffd28d/gi, '$1color: ' + (escuro ? COR : COR_TITULO));
  b = b.replace(/--heading-color:\s*#ffd28d/i, '--heading-color: ' + COR_TITULO);
  b = b.replace(/#ffd28d/gi, COR);
  b = b.replace(/rgba\(255, 210, 141,/g, 'rgba(' + COR_RGB + ',');
  // fundos escuros → base clara
  b = b.replace(/#040d10/gi, escuro ? '#0b0b0b' : BASE);
  b = b.replace(/#(091e24|051114|05161a)/gi, escuro ? '#111111' : BASE2);
  b = b.replace(/#001528/gi, COR_TITULO);
  b = b.replace(/linear-gradient\(267\.18deg, #161616 0%, #080808 100%\)/i, BASE2);
  // linhas
  b = b.replace(/#(4f4836|635542|f2f1ff)/gi, LINHA);
  b = b.replace(/#ba9774/gi, COR);
  b = b.replace(/#c8c8c8/gi, CORPO);
  b = b.replace(/#999696/gi, '#8a8a8a');
  b = b.replace(/rgba\(255, 255, 255, 0\.15\)/g, 'rgba(0, 0, 0, 0.06)');
  // header fixo, dropdown e menu mobile: preto translúcido → branco translúcido
  b = b.replace(/rgba\(0, 0, 0, 0\.(8549019608|9058823529)\)/g, 'rgba(255, 255, 255, 0.96)');
  b = b.replace(/rgba\(77, 77, 77, 0\.3215686275\)/g, LINHA);
  return sel + '{' + b + '}';
});

// botões e blocos que eram brancos/pretos sobre fundo escuro
css += `

/* ---- claro.js: ajustes de superfície ---- */
/* h1-h6 viraram COR_TITULO; dentro do hero (sobre foto) o título herda e some — volta ao acento */
.ak-hero h1, .ak-hero h2, .ak-hero .hero-main-title-1, .ak-hero .hero-main-title-1.style-2 { color: ${COR}; }
.ak-hero .hero-main-title { color: #fff; }
.ak-btn.style-5 { color: #fff; }
.ak-btn.style-5::before { background-color: ${COR_TITULO}; }
.ak-btn.style-5:hover { color: ${COR_TITULO}; }
.ak-btn.style-5.color-yellow-bg { color: ${TEXTO}; }
.ak-btn.style-5.color-yellow-bg:hover { color: ${COR_TITULO}; }
.contact-content .contact-form .contact-btn { background-color: ${COR_TITULO}; color: #fff; }
.ak-scrollup, .ak-pagination-item, .ak-faq-nav,
.ak-accordeon .ak-accordion-item.ak-color-1 .ak-accordion-header { background-color: ${COR_TITULO}; }
.ak-white-bg { background-color: ${BASE2}; }
.ak-munu_dropdown_toggle_1:before, .ak-munu_dropdown_toggle_1:after,
.footer-main .footer-eamil-menu .footer-email::after,
.ak-post-meta.ak-style1 > *:not(:last-child)::before { background-color: ${TEXTO}; }
.ak-preloader .loader-section { background-color: ${BASE}; }
.ak-nav .ak-nav_list a, .ak-nav .ak-nav_list > li { color: ${TEXTO}; }
.ak-site_header.ak-style1 .header-top .wrapper .header-logo .logo { color: ${TEXTO}; }
.ak-form-field { color: ${TEXTO}; border-color: #cfcfcf; }
.booking-system-form .ak-form-select,
.booking-system-form .ak-form-time-date .ak-time .time-input,
.booking-system-form .ak-form-time-date .ak-date .date-input,
.select-input-style1 .select-option, .date-input-style1 .date-input { color: ${TEXTO}; }
.footer-btn .ak-btn.style-5 { color: #fff; }
`;

fs.writeFileSync(file, css);
const sobra = (css.match(/#ffd28d|#040d10|#4f4836|#c8c8c8/gi) || []).length;
console.log(`claro.js: ${file} — base ${BASE}, seção ${BASE2}, linha ${LINHA}, título ${COR_TITULO}, acento ${COR}; sobras: ${sobra}`);
