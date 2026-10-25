/*
 * Envio por WhatsApp (sem backend)
 *
 * O pacote original mandava o contato para um sendmail.php (PHP mail(), não roda
 * na Vercel) e o widget de reserva só levava para booking.html, que não fazia
 * nada. Aqui os três formulários viram um link wa.me com a mensagem já montada:
 *   - #form-reserva-rapida  barra de reserva no rodapé (index, about, dinning)
 *   - #form-reserva         formulário completo (booking.html)
 *   - #contact_form         contato (contact.html)
 *
 * [WHATSAPP] = só dígitos com DDI + DDD (ex.: 5533999999999). Sem trocar, o link
 * abre o WhatsApp com o número literal "[WHATSAPP]" e falha. O HTML também tem
 * [WHATSAPP] em vários links — trocar em todos os arquivos de uma vez.
 *
 * Este arquivo precisa ser carregado ANTES de functions.js: ele preenche as datas
 * iniciais (próxima sexta → domingo) antes de o calendário ser montado.
 */
(function ($) {
	"use strict";

	var WHATSAPP = "[WHATSAPP]";
	var MESES = [ "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro" ];

	function abrirWhatsApp( msg ) {
		window.open( "https://wa.me/" + WHATSAPP + "?text=" + encodeURIComponent( msg ), "_blank" );
	}

	function dois( n ) {
		return ( n < 10 ? "0" : "" ) + n;
	}

	// Mesmo formato do calendário (functions.js, Zebra_DatePicker format: 'd/m/Y').
	function dataBR( d ) {
		return dois( d.getDate() ) + "/" + dois( d.getMonth() + 1 ) + "/" + d.getFullYear();
	}

	function proximaSexta() {
		var d = new Date();
		d.setHours( 0, 0, 0, 0 );
		do {
			d.setDate( d.getDate() + 1 );
		} while ( d.getDay() !== 5 );
		return d;
	}

	function campo( $form, nome ) {
		return ( $form.find( '[name="' + nome + '"]' ).val() || "" ).trim();
	}

	$( function () {
		var entrada = proximaSexta(),
			saida = new Date( entrada.getTime() );
		saida.setDate( saida.getDate() + 2 );

		$( ".ano-atual" ).text( new Date().getFullYear() );

		// Datas iniciais da barra de reserva rápida.
		function marcarData( seletor, d ) {
			var $f = $( seletor );
			$f.find( "input[type=hidden]" ).val( dataBR( d ) );
			$f.find( ".short" ).text( d.getDate() + " " + MESES[ d.getMonth() ].slice( 0, 3 ) );
			$f.find( ".long" ).text( d.getDate() + " de " + MESES[ d.getMonth() ].toLowerCase() );
		}
		marcarData( ".booking-form .field-checkin", entrada );
		marcarData( ".booking-form .field-checkout", saida );

		// Formulário completo: aceita ?checkin=&checkout=&adults=&children=&room= na URL.
		var $completo = $( "#form-reserva" );
		if ( $completo.length ) {
			var q = new URLSearchParams( window.location.search );
			$completo.find( "#checkin" ).val( q.get( "checkin" ) || dataBR( entrada ) );
			$completo.find( "#checkout" ).val( q.get( "checkout" ) || dataBR( saida ) );
			[ "adults", "children", "room" ].forEach( function ( nome ) {
				var v = q.get( nome );
				if ( v !== null && $completo.find( '[name="' + nome + '"] option[value="' + v + '"]' ).length ) {
					$completo.find( '[name="' + nome + '"]' ).val( v );
				}
			});
		}

		$( "#form-reserva-rapida" ).on( "submit", function ( e ) {
			e.preventDefault();
			var f = $( this );
			var msg = "Olá! Vim pelo site e queria saber a disponibilidade:\n";
			msg += "Entrada: " + ( campo( f, "checkin" ) ) + "\n";
			msg += "Saída: " + ( campo( f, "checkout" ) ) + "\n";
			msg += "Adultos: " + campo( f, "adults" ) + "\n";
			msg += "Crianças: " + campo( f, "children" );
			abrirWhatsApp( msg );
		});

		$completo.on( "submit", function ( e ) {
			e.preventDefault();
			var f = $( this );
			var msg = "Olá! Quero pedir uma reserva pelo site.\n";
			msg += "Nome: " + campo( f, "name" ) + "\n";
			if ( campo( f, "phone" ) ) msg += "Telefone: " + campo( f, "phone" ) + "\n";
			msg += "Entrada: " + ( campo( f, "checkin" ) ) + "\n";
			msg += "Saída: " + ( campo( f, "checkout" ) ) + "\n";
			msg += "Adultos: " + campo( f, "adults" ) + " | Crianças: " + campo( f, "children" ) + "\n";
			msg += "Acomodação: " + ( campo( f, "room" ) || "tanto faz" ) + " | Quartos: " + campo( f, "room-no" ) + "\n";
			if ( campo( f, "notes" ) ) msg += "Observações: " + campo( f, "notes" );
			abrirWhatsApp( msg );
		});

		$( "#contact_form" ).on( "submit", function ( e ) {
			e.preventDefault();
			var f = $( this );
			var msg = "Olá! Vim pelo site.\n";
			msg += "Nome: " + campo( f, "name" ) + "\n";
			if ( campo( f, "phone" ) ) msg += "Telefone: " + campo( f, "phone" ) + "\n";
			msg += "Mensagem: " + campo( f, "message" );
			abrirWhatsApp( msg );
			this.reset();
		});

		// "Consulte pelo WhatsApp" dos quartos: a mensagem usa o título do quarto
		// da própria página, então renomear o <h2> já basta.
		$( "a[data-wa-quarto]" ).each( function () {
			var quarto = $( this ).closest( ".entry-accomodation" ).find( ".entry-title" ).first().text().trim();
			this.href = "https://wa.me/" + WHATSAPP + "?text=" + encodeURIComponent( "Olá! Vim pelo site e queria saber o valor da diária: " + quarto + "." );
		});

		// Botões de compartilhar (single-accomodation): LINK vira a URL da página.
		$( "#share-widget a" ).each( function () {
			this.href = this.href.replace( "LINK", encodeURIComponent( window.location.href ) );
		});
	});
}( jQuery ));
