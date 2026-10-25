$(function () {

    // 🔹 Hover nav button
    $(document).on('mouseenter mouseleave', '.nav-btn', function () {
        $(this).toggleClass('open');
    });

    // 🔹 Scroll header glass effect
    $(window).on('scroll', function () {
        const scroll = $(window).scrollTop();
        $("#header").toggleClass('glass-effect', scroll > 100);
    });

    // 🔹 Tab click activation
    $(document).on('click', '.tab', function () {
        const tabs = $(this).closest('.tabs');
        const tabContent = tabs.siblings('.tab-content');
        const selectedTab = $(this).data("tab");

        tabs.find('.tab').removeClass('active');
        $(this).addClass("active");

        tabContent.find(".content").removeClass("active");
        tabContent.find("#" + selectedTab).addClass("active");
    });

    // 🔹 Split each character into <span>
    $(".text").each(function () {
        const $this = $(this);
        const text = $this.text().trim();
        $this.empty().append($.map(text.split(""), c => $("<span>").text(c)));
    });

    // 🔹 Animate text visibility on scroll
    $(window).on("scroll", function () {
        $(".text").each(function () {
            const $el = $(this), $spans = $el.find("span");
            const winBottom = $(window).scrollTop() + $(window).height();
            const elTop = $el.offset().top;
            const elHeight = $el.outerHeight();

            if (winBottom >= elTop) {
                const progress = Math.min(winBottom - elTop, elHeight) / elHeight;
                const activeChars = Math.floor(progress * $spans.length);
                $spans.each(function (i) {
                    $(this)
                        .toggleClass("active", i < activeChars)
                        .toggleClass("active_", i >= activeChars);
                });
            }
        });
    });

    // 🔹 Icon box click activation
    $(document).on('click', '.icon-box', function () {
        $('.icon-box').removeClass('active');
        $(this).addClass('active');
    });

    // 🔹 Number animation
    function animateNumber($element, targetNumber, duration, decimals) {
        const startTime = performance.now();
        const startNumber = 0;

        function updateNumber(currentTime) {
            const elapsedTime = currentTime - startTime;
            const progress = Math.min(elapsedTime / duration, 1);
            const currentNumber = startNumber + progress * (targetNumber - startNumber);

            $element.text(currentNumber.toLocaleString("en-US", {
                minimumFractionDigits: decimals,
                maximumFractionDigits: decimals
            }));

            if (progress < 1) {
                requestAnimationFrame(updateNumber);
            }
        }

        requestAnimationFrame(updateNumber);
    }

    // 🔹 Check if number is visible, then animate
    function checkScroll() {
        $('.number').each(function () {
            const $el = $(this);

            if (!$el.hasClass('animated')) {
                const targetValue = parseFloat($el.attr("data-target"));
                const durationValue = parseInt($el.attr("data-duration"), 10);
                const decimals = ($el.attr("data-target").split(".")[1] || "").length;

                const rect = this.getBoundingClientRect();
                if (rect.top >= 0 && rect.bottom <= window.innerHeight) {
                    animateNumber($el, targetValue, durationValue, decimals);
                    $el.addClass('animated');
                }
            }
        });
    }

    // 🔹 Bind scroll & load event for number animation
    $(window).on('scroll', checkScroll);
    $(window).on('load', checkScroll);

    // 🔹 Marquee duplication setup
    $('.marquee-container').each(function () {
        const cont = $(this);
        const content = cont.find('.marquee-content');
        cont.append(content.clone(), content.clone().clone());
        cont.find('.marquee-content').addClass('marquee');
    });

});
