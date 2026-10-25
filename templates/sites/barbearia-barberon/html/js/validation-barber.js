// O template original tentava um POST para "booking-barber.php" — esse
// arquivo nunca existiu no pacote comprado (era referência morta desde a
// origem). Reescrito para montar a mensagem e abrir o WhatsApp direto,
// mesmo padrão usado no template barbearia-trimly.
//
// [WHATSAPP] é o número do cliente, sem formatação (ex: 5533999999999) —
// personalizar.sh não preenche isso sozinho, trocar na mão antes de publicar.
const WHATSAPP_NUMERO = '[WHATSAPP]';

$(document).ready(function () {

    $('#contact_form').on('submit', function (e) {

        e.preventDefault();

        let error = false;

        const name    = $('#name').val().trim();
        const email   = $('#email').val().trim();
        const phone   = $('#phone').val().trim();
        const service = $('#service').val();
        const date    = $('#date').val();
        const time    = $('#time').val();
        const message = $('#message').val().trim();

        $('.error_input').removeClass('error_input');

        if (name === '') {
            $('#name').addClass('error_input');
            error = true;
        }

        if (email === '' || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            $('#email').addClass('error_input');
            error = true;
        }

        if (phone === '') {
            $('#phone').addClass('error_input');
            error = true;
        }

        if (!service) {
            $('#service').addClass('error_input');
            error = true;
        }

        if (date === '') {
            $('#date').addClass('error_input');
            error = true;
        }

        if (time === '') {
            $('#time').addClass('error_input');
            error = true;
        }

        if (!error) {

            const linhas = [
                'Agendamento pelo site:',
                `Nome: ${name}`,
                `E-mail: ${email}`,
                `Telefone: ${phone}`,
                `Serviço: ${service}`,
                `Data: ${date}`,
                `Horário: ${time}`,
            ];
            if (message) {
                linhas.push(`Observações: ${message}`);
            }
            const texto = encodeURIComponent(linhas.join('\n'));

            $('#contact_form').trigger('reset');
            $('#success_message').fadeIn(500);
            $('#error_message').hide();

            window.open(`https://wa.me/${WHATSAPP_NUMERO}?text=${texto}`, '_blank');
        }

    });

});
