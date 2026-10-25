/* Pizzaria one-page — comportamentos por cima do template */
(function () {
	'use strict';

	/* Reels: tocam só quando aparecem na tela, param quando saem */
	var videos = document.querySelectorAll('video[data-auto]');
	if ('IntersectionObserver' in window) {
		var obs = new IntersectionObserver(function (entradas) {
			entradas.forEach(function (e) {
				var v = e.target;
				if (e.isIntersecting) { var p = v.play(); if (p) p.catch(function () {}); }
				else v.pause();
			});
		}, { threshold: 0.3 });
		videos.forEach(function (v) { obs.observe(v); });
	} else {
		videos.forEach(function (v) { v.setAttribute('autoplay', ''); });
	}

	/* Ano do rodapé */
	var ano = document.querySelector('[data-ano]');
	if (ano) ano.textContent = String(new Date().getFullYear());
})();
