/*
 * Reserva e contato pelo WhatsApp — substitui o back-end original (admin-ajax.php
 * do WordPress e o Quform em PHP), que não existe em hospedagem estática/Vercel.
 *
 * Trocar [WHATSAPP] pelo número só com dígitos, com DDI+DDD: 5533999999999
 * Tudo que tiver class="js-whatsapp" vira link pro WhatsApp.
 */
(function () {
  var WHATSAPP = '[WHATSAPP]';
  var NOME = '[NOME DO CLIENTE]';

  function numero() { return String(WHATSAPP).replace(/\D/g, ''); }
  function link(msg) {
    return 'https://wa.me/' + numero() + (msg ? '?text=' + encodeURIComponent(msg) : '');
  }
  function abrir(msg) { window.open(link(msg), '_blank', 'noopener'); }

  function campo(form, sel) {
    var el = form.querySelector(sel);
    if (!el) return '';
    if (el.tagName === 'SELECT') {
      var op = el.options[el.selectedIndex];
      return op ? (op.value === '' ? '' : op.text) : '';
    }
    return (el.value || '').trim();
  }
  function soma(form, sel) {
    var t = 0, achou = false;
    form.querySelectorAll(sel).forEach(function (el) { achou = true; t += parseInt(el.value, 10) || 0; });
    return achou ? String(t) : '';
  }

  function mensagemReserva(form) {
    var linhas = ['Olá, ' + NOME + '! Vim pelo site e gostaria de consultar a disponibilidade.'];
    var titulo = document.querySelector('.hm-pagina-acomodacao .gdlr-page-title');
    if (titulo) linhas.push('Acomodação: ' + titulo.textContent.trim());
    var unidade = campo(form, '#gdlr-hotel-branches');
    if (unidade) linhas.push('Unidade: ' + unidade);
    var entrada = campo(form, '#gdlr-check-in');
    var saida = campo(form, '#gdlr-check-out');
    var noites = campo(form, '#gdlr-night');
    if (entrada) linhas.push('Entrada: ' + entrada);
    if (saida) linhas.push('Saída: ' + saida);
    if (noites) linhas.push('Noites: ' + noites);
    var adultos = soma(form, 'select[name="gdlr-adult-number[]"]');
    var criancas = soma(form, 'select[name="gdlr-children-number[]"]');
    var quartos = campo(form, '#gdlr-room-number');
    var ehHospedes = form.querySelector('#gdlr-room-number') && !adultos;
    if (quartos) linhas.push((ehHospedes ? 'Hóspedes: ' : 'Quartos: ') + quartos);
    if (adultos) linhas.push('Adultos: ' + adultos);
    if (criancas) linhas.push('Crianças: ' + criancas);
    return linhas.join('\n');
  }

  function mensagemContato(form) {
    var linhas = ['Olá, ' + NOME + '! Vim pelo site.'];
    var n = campo(form, '[name="nome"]'), t = campo(form, '[name="telefone"]'), m = campo(form, '[name="mensagem"]');
    if (n) linhas.push('Nome: ' + n);
    if (t) linhas.push('Telefone: ' + t);
    if (m) linhas.push('', m);
    return linhas.join('\n');
  }

  var SEL_RESERVA = 'form.gdlr-hotel-availability, form.gdlr-reservation-bar';

  function tratar(form, e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    abrir(form.matches('.form-whatsapp') ? mensagemContato(form) : mensagemReserva(form));
  }

  // fase de captura: roda antes dos handlers jQuery do tema (que chamariam o admin-ajax)
  document.addEventListener('click', function (e) {
    var bt = e.target.closest && e.target.closest('#gdlr-reservation-bar-button, .gdlr-reservation-bar-button, .form-whatsapp [type="submit"]');
    if (!bt) return;
    var form = bt.closest(SEL_RESERVA + ', form.form-whatsapp');
    if (form) tratar(form, e);
  }, true);
  document.addEventListener('submit', function (e) {
    var form = e.target;
    if (form.matches && form.matches(SEL_RESERVA + ', form.form-whatsapp')) tratar(form, e);
  }, true);

  function ligarLinks() {
    document.querySelectorAll('.js-whatsapp').forEach(function (a) {
      a.setAttribute('href', link('Olá, ' + NOME + '! Vim pelo site.'));
      a.setAttribute('target', '_blank');
      a.setAttribute('rel', 'noopener');
    });
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', ligarLinks);
  else ligarLinks();

  // O pack veio com datas fixas de 2018 no value dos campos. Depois que o tema
  // monta o datepicker, puxa entrada pra hoje e saída pra amanhã quando ficaram no passado.
  if (window.jQuery) {
    jQuery(function ($) {
      function lerAlt($el) {
        var v = $el.siblings('.gdlr-datepicker-alt').val() || '';
        var m = v.match(/^(\d{4})-(\d{2})-(\d{2})$/);
        return m ? new Date(+m[1], +m[2] - 1, +m[3]) : null;
      }
      try {
        var $in = $('#gdlr-check-in'), $out = $('#gdlr-check-out');
        if (!$in.length || !$in.hasClass('hasDatepicker')) return;
        var hoje = new Date(); hoje.setHours(0, 0, 0, 0);
        var d = lerAlt($in);
        if (!d || d < hoje) d = hoje;
        $in.datepicker('setDate', d);
        if ($out.length && $out.hasClass('hasDatepicker')) {
          var o = lerAlt($out);
          if (!o || o <= d) { o = new Date(d); o.setDate(o.getDate() + 1); }
          $out.datepicker('setDate', o);
        }
      } catch (e) { /* datas ficam como o tema deixou */ }
    });
  }
})();
