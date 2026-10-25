/*
 * Hospedagem — envio de reserva/contato por WhatsApp
 *
 * O pacote original tinha um mail.php (PHP mail(), não roda na Vercel nem em
 * hospedagem estática) e as barras de reserva ("Check-in / Check-out /
 * Quartos / Hóspedes") eram só visuais: o botão apontava pra room.html e não
 * mandava nada. Este arquivo troca tudo por um link wa.me com a mensagem já
 * montada a partir dos campos preenchidos — sem backend nenhum.
 *
 * Como funciona (marcação já aplicada nas páginas):
 *   [data-wa="reserva"] ou [data-wa="contato"]  → o bloco do formulário
 *   [data-wa-campo="Rótulo"]                     → cada campo que entra na mensagem
 *        input/textarea → valor digitado
 *        select         → texto da opção (a 1ª opção é o rótulo e é ignorada)
 *        div.nice-select sem <select> → texto do ".current"
 *   [data-wa-enviar]                             → o botão/link que envia
 *
 * [WHATSAPP] é o número do cliente, só dígitos com DDI+DDD
 * (ex: 5533999999999). Sem trocar, o link abre o WhatsApp com o número
 * literal "[WHATSAPP]" e falha. O personalizar.sh NÃO preenche isso sozinho.
 */
(function ($) {
    "use strict";

    var WHATSAPP = "[WHATSAPP]";

    function valorDoCampo($el) {
        if ($el.is("input, textarea")) {
            return ($el.val() || "").trim();
        }
        if ($el.is("select")) {
            var el = $el.get(0);
            if (!el || el.selectedIndex <= 0) return "";
            return $(el.options[el.selectedIndex]).text().trim();
        }
        return ($el.find(".current").first().text() || "").trim();
    }

    function montarMensagem($bloco) {
        var tipo = $bloco.attr("data-wa");
        var linhas = [];
        if (tipo === "contato") {
            linhas.push("Olá! Vim pelo site e quero falar com vocês.");
        } else {
            linhas.push("Olá! Vim pelo site e quero consultar disponibilidade.");
        }
        $bloco.find("[data-wa-campo]").each(function () {
            var $campo = $(this);
            var valor = valorDoCampo($campo);
            if (valor) linhas.push($campo.attr("data-wa-campo") + ": " + valor);
        });
        return linhas.join("\n");
    }

    $(document).on("click", "[data-wa-enviar]", function (e) {
        e.preventDefault();
        var $bloco = $(this).closest("[data-wa]");
        if (!$bloco.length) return;

        if ($bloco.attr("data-wa") === "contato") {
            var $nome = $bloco.find('[data-wa-campo="Nome"]');
            if ($nome.length && !valorDoCampo($nome)) {
                $nome.trigger("focus");
                return;
            }
        }

        var url = "https://wa.me/" + WHATSAPP + "?text=" + encodeURIComponent(montarMensagem($bloco));
        window.open(url, "_blank");
    });
}(jQuery));
