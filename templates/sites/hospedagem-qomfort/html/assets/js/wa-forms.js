/*
  Formulários -> WhatsApp
  -----------------------
  Todo elemento com data-wa="reserva" ou data-wa="contato" (form ou div) vira
  um link https://wa.me/<NUMERO>?text=... com a mensagem montada a partir dos
  campos preenchidos. Não há backend: nada é enviado por e-mail.

  Onde aparece:
    data-wa="reserva"  -> caixa "Consulte a disponibilidade" (index, index3, faqs),
                          barra de reserva abaixo do hero (index2, room-grid,
                          room-list, room-2columns) e lateral do room-details
    data-wa="contato"  -> formulário de contact.html e o formulário da barra
                          lateral escondida (ícone de menu no header, toda página)

  TROCAR ANTES DE PUBLICAR: o número abaixo. Só dígitos, com DDI + DDD
  (ex: 5533999999999).
*/
(function () {
  "use strict";

  var WHATSAPP = "[WHATSAPP]";

  function dataBR(v) {
    // input type=date devolve AAAA-MM-DD
    var m = /^(\d{4})-(\d{2})-(\d{2})$/.exec(v || "");
    return m ? m[3] + "/" + m[2] + "/" + m[1] : v;
  }

  function valor(root, seletor) {
    var el = root.querySelector(seletor);
    return el && el.value ? el.value.trim() : "";
  }

  function abrir(texto) {
    var url = "https://wa.me/" + WHATSAPP + "?text=" + encodeURIComponent(texto);
    window.open(url, "_blank", "noopener");
  }

  function msgReserva(root) {
    var datas = root.querySelectorAll('input[type="date"], input[onfocus*="date"], input[name="entrada"], input[name="saida"]');
    var vistos = [], entrada = "", saida = "";
    Array.prototype.forEach.call(datas, function (el) { if (vistos.indexOf(el) < 0) vistos.push(el); });
    if (vistos[0]) entrada = dataBR(vistos[0].value);
    if (vistos[1]) saida = dataBR(vistos[1].value);
    var adultos = valor(root, 'select[name="adults"]');
    var criancas = valor(root, 'select[name="children"]');

    var linhas = ["Olá! Gostaria de consultar disponibilidade para hospedagem."];
    if (entrada) linhas.push("Entrada: " + entrada);
    if (saida) linhas.push("Saída: " + saida);
    if (adultos) linhas.push("Adultos: " + adultos);
    if (criancas) linhas.push("Crianças: " + criancas);
    return linhas.join("\n");
  }

  function msgContato(root) {
    var nome = valor(root, '[name="nome"], [name="name"]');
    var tel = valor(root, '[name="telefone"], [name="phone_number"]');
    var email = valor(root, '[name="email"]');
    var assunto = valor(root, '[name="subject"]');
    var msg = valor(root, '[name="mensagem"], [name="message"], textarea');

    var linhas = ["Olá! Vim pelo site."];
    if (nome) linhas.push("Nome: " + nome);
    if (tel) linhas.push("Telefone: " + tel);
    if (email) linhas.push("E-mail: " + email);
    if (assunto) linhas.push("Assunto: " + assunto);
    if (msg) linhas.push("", msg);
    return linhas.join("\n");
  }

  function ligar(root) {
    var tipo = root.getAttribute("data-wa");
    var montar = tipo === "reserva" ? msgReserva : msgContato;

    if (root.tagName === "FORM") {
      root.addEventListener("submit", function (e) {
        e.preventDefault();
        abrir(montar(root));
      });
    } else {
      // barra de reserva do index2/room-*: é <div>, não <form>, o botão fica solto
      var btn = root.querySelector("button, .theme-btn");
      if (btn) btn.addEventListener("click", function (e) {
        e.preventDefault();
        abrir(montar(root));
      });
    }
  }

  function init() {
    Array.prototype.forEach.call(document.querySelectorAll("[data-wa]"), ligar);
  }

  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", init);
  else init();
})();
