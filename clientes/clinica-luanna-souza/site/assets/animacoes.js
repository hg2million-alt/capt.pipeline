/* =====================================================================
   Animações e efeitos 3D: parte em JavaScript (sem dependências)
   Par do animacoes.css. Especificação: FRONT-END_CREATOR.md (itens 1a24).
   Exige no <head>, ANTES de tudo, o script inline do README (liga html.motion).
   ===================================================================== */
(function () {
  "use strict";
  window.__animOK = true;

  var html = document.documentElement;
  var reduzido = matchMedia("(prefers-reduced-motion: reduce)").matches;
  var temIO = "IntersectionObserver" in window;
  if (reduzido || !temIO) html.classList.remove("motion");

  function todos(sel, raiz) { return Array.prototype.slice.call((raiz || document).querySelectorAll(sel)); }

  /* ---------- Entradas que repetem a cada passagem (item 7) ---------- */
  // um observador compartilhado: revela com ~20% visível, rearma quando sai por completo
  function prepararStagger(c) {
    Array.prototype.forEach.call(c.children, function (filho, i) {
      filho.style.setProperty("--anim-delay", Math.min(i * 80, 480) + "ms");
    });
  }
  todos("[data-stagger]").forEach(function (c) {
    prepararStagger(c);
    // itens adicionados depois entram na sequência
    new MutationObserver(function () { prepararStagger(c); }).observe(c, { childList: true });
  });
  todos(".grade-check").forEach(function (g) {
    Array.prototype.forEach.call(g.children, function (f, i) { f.style.setProperty("--d", i); });
  });

  var alvosEntrada = "[data-anim], [data-stagger], .grade-check, .arco-destaque";
  if (temIO && !reduzido) {
    var obsEntrada = new IntersectionObserver(function (entradas) {
      entradas.forEach(function (e) {
        var el = e.target;
        if (e.isIntersecting && e.intersectionRatio >= 0.2) {
          el.classList.add("is-in");
        } else if (!e.isIntersecting && !el.hasAttribute("data-anim-uma-vez") && !el.contains(document.activeElement)) {
          el.classList.remove("is-in");
        }
      });
    }, { threshold: [0, 0.2] });
    todos(alvosEntrada).forEach(function (el) { obsEntrada.observe(el); });
    // foco de teclado num elemento ainda invisível: revela na hora
    document.addEventListener("focusin", function (ev) {
      var alvo = ev.target.closest && ev.target.closest(alvosEntrada);
      if (alvo) alvo.classList.add("is-in");
    });
  } else {
    todos(alvosEntrada).forEach(function (el) { el.classList.add("is-in"); });
  }

  /* ---------- 14: replay da entrada do hero ao voltar ao topo ---------- */
  if (temIO && !reduzido) {
    todos(".hero-entrada").forEach(function (hero) {
      Array.prototype.forEach.call(hero.children, function (f, i) {
        if (!f.style.getPropertyValue("--i")) f.style.setProperty("--i", i);
      });
      new IntersectionObserver(function (es) {
        es.forEach(function (e) {
          if (!e.isIntersecting) hero.setAttribute("data-replay", "");
          else if (hero.hasAttribute("data-replay")) {
            hero.removeAttribute("data-replay");
            void hero.offsetWidth; // reinicia a animação
          }
        });
      }).observe(hero);
    });
  }

  /* ---------- 12: tilt 3D seguindo o mouse ---------- */
  if (!reduzido && matchMedia("(hover: hover) and (pointer: fine)").matches) {
    todos("[data-tilt]").forEach(function (el) {
      var max = parseFloat(el.getAttribute("data-tilt")) || 7;
      var interno = el.querySelector(".tilt-interno");
      if (!interno) return;
      var quadro = 0, ultimo = null;
      function aplicar() {
        quadro = 0;
        var r = el.getBoundingClientRect();
        var x = (ultimo.clientX - r.left) / r.width, y = (ultimo.clientY - r.top) / r.height;
        el.style.setProperty("--tilt-x", ((0.5 - y) * 2 * max).toFixed(2) + "deg");
        el.style.setProperty("--tilt-y", ((x - 0.5) * 2 * max).toFixed(2) + "deg");
        el.style.setProperty("--glare-x", (x * 100).toFixed(1) + "%");
        el.style.setProperty("--glare-y", (y * 100).toFixed(1) + "%");
      }
      el.addEventListener("pointermove", function (ev) {
        if (ev.pointerType !== "mouse") return;
        ultimo = ev;
        el.classList.add("tilt-ativo");
        if (!quadro) quadro = requestAnimationFrame(aplicar);
      });
      el.addEventListener("pointerleave", function () {
        if (quadro) cancelAnimationFrame(quadro);
        quadro = 0;
        el.classList.remove("tilt-ativo");
        el.style.setProperty("--tilt-x", "0deg");
        el.style.setProperty("--tilt-y", "0deg");
      });
    });
  }

  /* ---------- 5: flip de card (botão, Enter e Espaço) ---------- */
  todos(".flip-card").forEach(function (card) {
    var frente = card.querySelector(".flip-frente"), verso = card.querySelector(".flip-verso");
    var botoes = todos(".flip-botao", card);
    function definir(virado) {
      card.classList.toggle("virado", virado);
      botoes.forEach(function (b) { b.setAttribute("aria-expanded", String(virado)); });
      if (verso) { verso.inert = !virado; verso.setAttribute("aria-hidden", String(!virado)); }
      if (frente) { frente.inert = virado; frente.setAttribute("aria-hidden", String(virado)); }
      var destino = (virado ? verso : frente);
      var botao = destino && destino.querySelector(".flip-botao");
      if (botao) setTimeout(function () { botao.focus({ preventScroll: true }); }, reduzido ? 0 : 650);
    }
    botoes.forEach(function (b) { b.addEventListener("click", function () { definir(!card.classList.contains("virado")); }); });
    definir(false);
  });

  /* ---------- 20: carrossel infinito (marquee) ---------- */
  todos(".marquee").forEach(function (m) {
    var trilha = m.querySelector(".marquee-trilha");
    if (!trilha || reduzido) return;
    Array.prototype.slice.call(trilha.children).forEach(function (item) {
      var copia = item.cloneNode(true);
      copia.setAttribute("aria-hidden", "true");
      copia.inert = true;
      trilha.appendChild(copia);
    });
    var botao = m.parentElement && m.parentElement.querySelector(".marquee-pausa");
    if (botao) botao.addEventListener("click", function () {
      var pausar = !m.classList.contains("pausado");
      todos(".marquee", m.parentElement).forEach(function (x) { x.classList.toggle("pausado", pausar); });
      botao.setAttribute("aria-pressed", String(pausar));
      botao.setAttribute("aria-label", pausar ? "Retomar animação" : "Pausar animação");
    });
    if (temIO) new IntersectionObserver(function (es) {
      trilha.style.animationPlayState = es[0].isIntersecting ? "" : "paused";
    }).observe(m);
  });

  /* ---------- 15: vitrine com troca automática ---------- */
  todos(".vitrine-auto").forEach(function (v) {
    var itens = todos(".vitrine-item", v);
    if (!itens.length) return;
    var ciclo = parseFloat(v.getAttribute("data-ciclo")) || 3600;
    v.style.setProperty("--vitrine-ciclo", ciclo + "ms");
    var barras = v.querySelector(".vitrine-barras"), nome = v.querySelector(".vitrine-nome");
    if (barras && !barras.children.length) itens.forEach(function () { barras.appendChild(document.createElement("span")).appendChild(document.createElement("i")); });
    var atual = 0, timer = 0, visivel = false, pausado = reduzido;
    function mostrar(i) {
      atual = i;
      itens.forEach(function (it, k) { it.classList.toggle("ativo", k === i); });
      if (barras) Array.prototype.forEach.call(barras.children, function (b, k) {
        b.className = k < i ? "feito" : k === i ? "atual" : "";
        var novo = b.firstChild.cloneNode(); b.replaceChild(novo, b.firstChild); // reinicia a barra
      });
      if (nome) nome.textContent = itens[i].getAttribute("data-nome") || "";
    }
    function agendar() {
      clearTimeout(timer);
      if (visivel && !pausado) timer = setTimeout(function () { mostrar((atual + 1) % itens.length); agendar(); }, ciclo);
    }
    var botao = v.querySelector(".vitrine-pausa");
    if (botao) botao.addEventListener("click", function () {
      pausado = !pausado;
      v.classList.toggle("pausado", pausado);
      botao.setAttribute("aria-label", pausado ? "Retomar troca automática" : "Pausar troca automática");
      if (!pausado) mostrar(atual);
      agendar();
    });
    v.addEventListener("pointerenter", function () { if (!reduzido) { v.classList.add("pausado"); clearTimeout(timer); } });
    v.addEventListener("pointerleave", function () { if (!pausado) { v.classList.remove("pausado"); mostrar(atual); agendar(); } });
    mostrar(0);
    if (temIO) new IntersectionObserver(function (es) {
      visivel = es[0].intersectionRatio >= 0.08;
      if (visivel && !pausado) mostrar(atual);
      agendar();
    }, { threshold: [0, 0.08] }).observe(v);
  });

  /* ---------- 24: header que ganha fundo ao rolar (sentinela) ---------- */
  var header = document.querySelector(".header-luxo");
  if (header && temIO) {
    var sentinela = document.createElement("div");
    sentinela.setAttribute("aria-hidden", "true");
    sentinela.style.cssText = "position:absolute;top:0;left:0;width:1px;height:80px;pointer-events:none";
    document.body.prepend(sentinela);
    new IntersectionObserver(function (es) { header.classList.toggle("rolou", !es[0].isIntersecting); }).observe(sentinela);
  }

  /* ---------- 24: WhatsApp flutuante: aparece depois do hero, some no contato ---------- */
  todos(".wa-flutuante").forEach(function (wa) {
    var depois = document.querySelector(wa.getAttribute("data-depois") || ".hero");
    var some = document.querySelector(wa.getAttribute("data-some-em") || "#contato");
    if (!temIO) { wa.classList.add("visivel"); return; }
    var heroVisivel = true, contatoVisivel = false;
    function atualizar() { wa.classList.toggle("visivel", !heroVisivel && !contatoVisivel); }
    if (depois) new IntersectionObserver(function (es) { heroVisivel = es[0].isIntersecting; atualizar(); }).observe(depois);
    if (some) new IntersectionObserver(function (es) { contatoVisivel = es[0].isIntersecting; atualizar(); }).observe(some);
  });

  /* ---------- 23: vídeo de fundo do hero: toca uma vez, recomeça ao voltar ---------- */
  todos("video[data-hero-video]").forEach(function (v) {
    var economia = navigator.connection && navigator.connection.saveData;
    if (reduzido || economia) return; // fica só o pôster (último quadro), sem baixar o vídeo
    var fonte = matchMedia("(max-width: 700px)").matches && v.getAttribute("data-src-mobile") ? v.getAttribute("data-src-mobile") : v.getAttribute("data-src");
    if (!fonte) return;
    v.muted = true; v.playsInline = true; v.loop = false;
    v.src = fonte;
    if (temIO) new IntersectionObserver(function (es) {
      if (es[0].isIntersecting) { if (v.ended || v.dataset.saiu) { v.currentTime = 0; delete v.dataset.saiu; } v.play().catch(function () {}); }
      else { v.pause(); v.dataset.saiu = "1"; }
    }, { threshold: 0.25 }).observe(v);
  });

  /* ---------- 24: bolha "digitando" seguida da mensagem ---------- */
  todos("[data-digitando]").forEach(function (b) {
    var msg = b.nextElementSibling;
    if (!msg || reduzido) return;
    msg.hidden = true;
    setTimeout(function () { b.hidden = true; msg.hidden = false; msg.classList.add("troca-conteudo"); }, parseFloat(b.getAttribute("data-digitando")) || 1600);
  });
})();
