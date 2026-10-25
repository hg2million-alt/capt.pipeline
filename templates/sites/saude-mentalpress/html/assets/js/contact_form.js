/*

Script  : Contact Form
Version : 1.0

Copyright © All rights Reserved

*/

$(function() {

    "use strict";

    /* ================================================
       jQuery Validate - Reset Defaults
       ================================================ */

    $.validator.setDefaults({
        highlight: function(element) {
            $(element).closest('.c-form-group').addClass('has-error');
        },
        unhighlight: function(element) {
            $(element).closest('.c-form-group').removeClass('has-error');
        },
        errorElement: 'small',
        errorClass: 'help-block',
        errorPlacement: function(error, element) {
            if (element.parent('.input-group').length) {
                error.insertAfter(element.parent());
            }
            if (element.parent('label').length) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
        }
    });

    /* 
    VALIDATE
    -------- */

    $("#phpcontactform").submit(function(e) {
        e.preventDefault();
    }).validate({
        rules: {
            name: "required",
            email: {
                required: true,
                email: true
            },
            subject: "required",
            message: "required",
        },
        messages: {
            name: "Your full name please",
            email: {
                required: "We need your email address",
                email: "That doesn't look like an email id"
            },
            subject: "Enter a subject",
            message: "Please enter your message",
        },
        submitHandler: function(form) {

            $("#js-contact-btn").attr("disabled", true);

            /* 
            CHECK PAGE FOR REDIRECT (Thank you page)
            ---------------------------------------- */

            var redirect = $('#phpcontactform').data('redirect');
            var noredirect = false;
            if (redirect == 'none' || redirect == "" || redirect == null) {
                noredirect = true;
            }

            $("#js-contact-result").html('<div class="alert alert-warning">Please wait...</div>');

            /* 
            FETCH SUCCESS / ERROR MSG FROM HTML DATA-ATTR
            --------------------------------------------- */

            var success_msg = $('#js-contact-result').data('success-msg');
            var error_msg = $('#js-contact-result').data('error-msg');

            var dataString = $(form).serialize();

            /* 
             AJAX POST
             --------- */

            $.ajax({
                type: "POST",
                data: dataString,
                url: "php/contact.php",
                cache: false,
                success: function(d) {
                    $(".form-group").removeClass("has-success");
                    if (d == 'success') {
                        if (noredirect) {
                            $('#js-contact-result').fadeIn('slow').html('<div class="alert alert-success">' + success_msg + '</div>').delay(3000).fadeOut('slow');
                            $('#phpcontactform').trigger("reset");
                        } else {
                            window.location.href = redirect;
                        }
                    } else {
                        $('#js-contact-result').fadeIn('slow').html('<div class="alert alert-danger">' + error_msg + '</div>').delay(3000).fadeOut('slow');
                    }
                    $("#js-contact-btn").attr("disabled", false);
                }
            });
            return false;

        }
    });

})
