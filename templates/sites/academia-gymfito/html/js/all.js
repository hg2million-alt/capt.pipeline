
"use strict";

window.gsap && (function(){
	
	gsap.registerPlugin( ScrollTrigger );
	
	document.querySelectorAll('[data-scroll]').forEach(function( el ){
		var i = el.querySelectorAll(el.getAttribute('data-scroll')),
			c = JSON.parse(el.querySelector('[data-scroll-cog=""]').innerHTML)
		;
		c.scrollTrigger.onUpdate = function(o){
			o.trigger.classList[o.isActive ? 'add': 'remove']("c-active");
			o.trigger.dispatchEvent(new CustomEvent('gsap-' + o.trigger.getAttribute('data-scroll-item'), {detail: o}));
		};
		c.scrollTrigger.trigger = i;
		gsap.to( i, c );
	});
	
	
	
})();

/* odometer */
window.Odometer && (function(){
	
	document.querySelectorAll('[data-scroll-item="odometer"]').forEach(function(el){
		
		el.addEventListener('gsap-odometer', function(o){
			
			o.target.querySelectorAll('.odometer').forEach(function(eo){
				eo.innerHTML = o.detail.isActive ? eo.getAttribute('data-v') : 0;
			});
		});
		
	});
	
})();

/* toggle */
(function(){
	
	function s(el)
	{
		el.addEventListener('click', function(e){
			
			e.preventDefault();
			
			var t = document.querySelector(this.hash),
				n = this.getAttribute('data-c-toggle')
			;
			
			t.setAttribute(
				'data-t', 
				t.getAttribute('data-t') == n && !t.getAttribute('data-twice') ? '' : n
			);
			
			return false;
		});
	}
	
	document.querySelectorAll('[data-c-toggle]').forEach(s);
	
})();

/* tns */
window.tns && (function(d){
	
	function s(el)
	{
		var c = JSON.parse(el.querySelector('[data-slider-cog]').innerHTML),
			r = tns(c)
		;
		
		c.onIndexChanged && r.events.on('indexChanged', function(f){
			
			var a = 'tns-slide-index';
			
			for(var i=0; i < f.slideCountNew; i++)
			{
				f.slideItems[i].classList.remove(a);
			}
			f.slideItems[f.index].classList.add(a);
		});
	}
	
	d.querySelectorAll('[data-slider]').forEach(s);
	
})(document);

