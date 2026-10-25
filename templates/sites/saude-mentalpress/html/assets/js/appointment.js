/*

Script  : Reservation Form
Version : 1.0

*/

$(function() {

    "use strict";

    /* ================================================
       jQuery Validate - Reset Defaults
       ================================================ */

    $.validator.setDefaults({
        ignore: [],
        highlight: function(element) {
            $(element).closest('.c-form-group').addClass('has-error');
        },
        unhighlight: function(element) {
            $(element).closest('.c-form-group').removeClass('has-error');
        },
        errorElement: 'small',
        errorClass: 'help-block',
        errorPlacement: function(error, element) {
            if (element.parent('.input-group').length || element.parent('label').length) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
        }
    });

    /* 
    VALIDATE
    -------- */

    $("#appointmentform").submit(function(e) {
        e.preventDefault();
    }).validate({
        rules: {
            email: {
                required: true,
                email: true
            },
            phone: {
                required: true
            }
        },
        submitHandler: function(form) {

            $("#js-appointment-btn").attr("disabled", true);

            /* 
            CHECK PAGE FOR REDIRECT (Thank you page)
            ---------------------------------------- */

            var redirect = $('#appointmentform').data('redirect');
            var noredirect = false;
            if (redirect == 'none' || redirect == "" || redirect == null) {
                noredirect = true;
            }

            $("#js-appointment-result").html('<div class="alert alert-warning">Please wait...</div>');

            /* 
            FETCH SUCCESS / ERROR MSG FROM HTML DATA-ATTR
            --------------------------------------------- */

            var success_msg = $('#js-appointment-result').data('success-msg');
            var error_msg = $('#js-appointment-result').data('error-msg');

            var dataString = $(form).serialize();

            /* 
             AJAX POST
             --------- */

            $.ajax({
                type: "POST",
                data: dataString,
                url: "php/appointment.php",
                cache: false,
                success: function(d) {
                    $(".form-group").removeClass("has-success");
                    if (d == 'success') {
                        if (noredirect) {
                            $('#js-appointment-result').fadeIn('slow').html('<div class="alert alert-success">' + success_msg + '</div>').delay(3000).fadeOut('slow');
                            $('#appointmentform').trigger("reset");
                        } else {
                            window.location.href = redirect;
                        }
                    } else {
                        $('#js-appointment-result').fadeIn('slow').html('<div class="alert alert-danger">' + error_msg + '</div>').delay(3000).fadeOut('slow');
                    }
                    $("#js-appointment-btn").attr("disabled", false);
                }
            });
            return false;

        }
    });

})
