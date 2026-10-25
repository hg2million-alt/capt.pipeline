    $(function () {
        var owl = $('.our-team-con .owl-carousel');

        owl.owlCarousel({
            nav: true,
            loop: true,
            dots: false,
            autoplay: true,
            autoplayTimeout: 4500,

            navText: [
                "<img src='assets/images/left-arrow.png' class='custom-arrow'>",
                "<img src='assets/images/right-arrow.png' class='custom-arrow'>"
            ],

            responsive: {
                0: {
                    items: 1,
                    margin: 20,
                    center: true
                },
                576: {
                    items: 1,
                    margin: 20,
                    center: true
                },
                768: {
                    items: 2,
                    margin: 20,
                    center: false
                },
                992: {
                    items: 3,
                    margin: 40,
                    center: true
                },
                1200: {
                    items: 3,
                    margin: 40,
                    center: true
                }
            }
        });
    });
    // photo gallery script
    $(document).on('click', '[data-target="#lightbox"]', function () {
        var $lightbox = $('#lightbox'),
            $img = $(this).find('img'),
            src = $img.attr('src'),
            alt = $img.attr('alt'),
            css = {
                'maxWidth': $(window).width() - 100,
                'maxHeight': $(window).height() - 100
            };
        $lightbox.find('img').attr('src', src).attr('alt', alt).css(css);
    }).on('shown.bs.modal', '#lightbox', function () {
        var $img = $(this).find('img');
        $(this).find('.modal-dialog').css({
            'width': $img.width()
        });
        $(this).find('.close').removeClass('hidden');
    });

    // photo gallery script

    // Image Array
    let currentIndex = 0;
    let galleryImages = [];

    document.querySelectorAll('.zoom').forEach(function (el) {
        el.addEventListener('click', function (e) {
            e.preventDefault();

            // sari images collect karo dynamically
            galleryImages = Array.from(document.querySelectorAll('.zoom img'));

            currentIndex = galleryImages.indexOf(this.querySelector('img'));

            document.getElementById('popupImage').src =
                galleryImages[currentIndex].src;
        });
    });

    const popupImage = document.getElementById('popupImage');

    if (popupImage && galleryImages && galleryImages.length > 0) {
        popupImage.addEventListener('click', function () {
            currentIndex++;

            if (currentIndex >= galleryImages.length) {
                currentIndex = 0;
            }

            this.src = galleryImages[currentIndex].src;
        });
    }



    $(function () {
        $("#appointmentForm").on("submit", function (e) {
            e.preventDefault();
            var f = $(this);
            var nome = f.find('[name="nome"]').val() || "";
            var servico = f.find('[name="servico"]').val() || "";
            var telefone = f.find('[name="telefone"]').val() || "";
            var data = f.find('[name="data"]').val() || "";
            var obs = f.find('[name="obs"]').val() || "";
            var msg = "Olá! Quero agendar um horário.\n" +
                "Nome: " + nome + "\n" +
                "Serviço: " + servico + "\n" +
                (telefone ? "Meu contato: " + telefone + "\n" : "") +
                (data ? "Data/horário: " + data + "\n" : "") +
                (obs ? "Observações: " + obs + "\n" : "");
            window.open("https://wa.me/[WHATSAPP]?text=" + encodeURIComponent(msg), "_blank");
            this.reset();
        });

    });