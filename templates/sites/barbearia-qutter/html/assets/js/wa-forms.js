/*
 * Qutter — envio por WhatsApp
 *
 * O template original manda o formulário de contato pra um form-process.php
 * (PHP mail(), não roda em hospedagem estática tipo Vercel) e o formulário de
 * agendamento (services.html, service-details.html) tinha action="#" sem
 * nenhum JS por trás — os dois eram mudos. Este arquivo troca os dois por um
 * link wa.me com a mensagem já montada a partir dos campos preenchidos, sem
 * precisar de backend nenhum.
 *
 * [WHATSAPP] é o placeholder trocado pelo identidade.md do cliente (só
 * dígitos, com DDI+DDD, ex: 5533999999999) — sem substituir, o link abre o
 * WhatsApp Web com o número literal "[WHATSAPP]" e falha. Preencher antes de
 * publicar.
 */
(function ($) {
    "use strict";

    function valorDe(form, nome) {
        return (form.find('[name="' + nome + '"]').val() || "").trim();
    }

    function enviarContato(e) {
        e.preventDefault();
        var f = $(this);
        var nome = valorDe(f, "name");
        var telefone = valorDe(f, "phone");
        var email = valorDe(f, "email");
        var assunto = valorDe(f, "subject");
        var mensagem = valorDe(f, "message");

        var msg = "Olá! Vim pelo site.\n";
        msg += "Nome: " + nome + "\n";
        if (telefone) msg += "Meu contato: " + telefone + "\n";
        if (email) msg += "E-mail: " + email + "\n";
        if (assunto) msg += "Assunto: " + assunto + "\n";
        if (mensagem) msg += "Mensagem: " + mensagem + "\n";

        window.open("https://wa.me/[WHATSAPP]?text=" + encodeURIComponent(msg), "_blank");
        this.reset();
    }

    function enviarAgendamento(e) {
        e.preventDefault();
        var f = $(this);
        var nome = valorDe(f, "name");
        var telefone = valorDe(f, "phone");
        var email = valorDe(f, "email");
        var servico = valorDe(f, "select-category");
        var dataHora = valorDe(f, "date-time");

        var msg = "Olá! Quero agendar um horário.\n";
        msg += "Nome: " + nome + "\n";
        if (telefone) msg += "Meu contato: " + telefone + "\n";
        if (email) msg += "E-mail: " + email + "\n";
        if (servico) msg += "Serviço: " + servico + "\n";
        if (dataHora) msg += "Data/horário: " + dataHora + "\n";

        window.open("https://wa.me/[WHATSAPP]?text=" + encodeURIComponent(msg), "_blank");
        this.reset();
    }

    $(function () {
        $("#contactForm").on("submit", enviarContato);
        $("#appointmentForm").on("submit", enviarAgendamento);
    });
}(jQuery));
