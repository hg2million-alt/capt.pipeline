$(function () {
    $('.nav-btn').on('mouseenter mouseleave', function () {
        $(this).toggleClass('open');
    });
});

$(function () {
    $(window).scroll(function () {
        var scroll = $(window).scrollTop();
        if (scroll > 100) {
            $("#header").addClass('glass-effect');
        } else {
            $("#header").removeClass("glass-effect");
        }
    });

    const tabDuration = $('#tab-duration');

    // Ambil tab yang aktif pertama kali
    let durationActive = tabDuration.find('.tab.active');
    let dataDurationActive = durationActive.data('duration');

    // Filter pertama kali saat halaman dimuat
    filterDuration(dataDurationActive);

    // Event click pada tab
    tabDuration.find('.tab').on('click', function (e) {
        e.preventDefault();
        let duration = $(this).data('duration');
        filterDuration(duration);
        $(this).addClass('active');
        $(this).siblings().removeClass('active');
    });

    // Fungsi untuk filter berdasarkan durasi
    function filterDuration(duration) {
        $('.class-duration').each(function () {
            const durations = $(this).attr('data-duration') || '';
            if (durations === duration) {
                $(this).addClass('active').show();
            } else {
                $(this).removeClass('active').hide();
            }
        });
    }
});

$(function () {
    $(window).scroll(function () {
        var scroll = $(window).scrollTop();
        if (scroll > 100) {
            $("#header").addClass('glass-effect');
        } else {
            $("#header").removeClass("glass-effect");
        }
    });

    $(".tab").click(function () {
        let tabs = $(this).closest('.tabs');
        let tabContent = tabs.siblings('.tab-content');
        let backgroundContainer = tabs.siblings('.background-container');

        // Hapus kelas "active" dari semua tab dan tambahkan ke tab yang dihover
        tabs.find('.tab').removeClass('active');
        $(this).addClass("active");

        // Sembunyikan semua konten dan tampilkan yang sesuai dengan tab yang dihover
        let selectedTab = $(this).data("tab");
        tabContent.find(".content").removeClass("active");
        tabContent.find("#" + selectedTab).addClass("active");
    });
})

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

// Scroll listener
$(window).on('scroll', checkScroll);

// Jalankan saat halaman load
$(window).on('load', checkScroll);

$(function () {
    $('.marquee-container').each(function () {
        const cont = $(this); // Mengambil marquee-container saat ini
        const content = cont.find('.marquee-content');
        const clone = content.clone();
        const clone2 = clone.clone();
        cont.append(clone);
        cont.append(clone2); // Clone hanya untuk container ini

        cont.find('.marquee-content').addClass('marquee'); // Tambahkan class marquee pada konten yang di-clone
    });
});

$(function () {
    const $rows = $('.offer');

    const closeAll = () => {
        $rows.removeClass('active');
    };

    // reset dulu, lalu aktifkan baris pertama
    closeAll();
    $rows.eq(0).addClass('active');

    // event handler
    $rows.on('mouseenter', function () {
        if ($(this).hasClass('active')) return;

        closeAll();
        $(this).addClass('active');
    });
});

// Ambil semua elemen h3.text
$(".text").each(function () {
    var $this = $(this);
    var contents = $this.contents(); // ambil node: bisa teks / elemen

    $this.empty();

    contents.each(function () {
        if (this.nodeType === 3) {
            // Node teks → pecah per karakter
            var chars = this.nodeValue.trim().split("");
            $.each(chars, function (i, char) {
                $this.append($("<span>").text(char));
            });
        } else {
            // Node elemen (misal <img>) → masukkan langsung
            $this.append(this);
        }
    });
});

// Scroll detection
$(window).on("scroll", function () {
    $(".text").each(function () {
        var $textElement = $(this);
        var $spans = $textElement.find("span");

        var windowBottom = $(window).scrollTop() + $(window).height();
        var elementTop = $textElement.offset().top;
        var elementHeight = $textElement.outerHeight();

        // Kalau elemen masuk viewport
        if (windowBottom >= elementTop) {
            var visiblePart = Math.min(windowBottom - elementTop, elementHeight);
            var progress = visiblePart / elementHeight;
            var totalChars = $spans.length;
            var activeChars = Math.floor(progress * totalChars);

            $spans.each(function (index) {
                if (index < activeChars) {
                    $(this).addClass("active").removeClass("active_");
                } else {
                    $(this).removeClass("active").addClass("active_");
                }
            });
        }
    });
});

function animatedWave() {
    const canvas = document.getElementById("wave");
    const ctx = canvas.getContext("2d");

    function resize() {
        const parent = canvas.parentElement;
        canvas.width = parent.offsetWidth;
        canvas.height = parent.offsetHeight;
    }
    window.addEventListener("resize", resize);
    resize();

    let t = 0;

    function drawWave() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        const gradient = ctx.createLinearGradient(0, 0, 0, canvas.height);
        gradient.addColorStop(0, "#FF6800");
        gradient.addColorStop(0.4, "#FF6800");
        gradient.addColorStop(1, "#ffffff");
        ctx.fillStyle = gradient;

        ctx.beginPath();
        ctx.moveTo(0, canvas.height);

        for (let x = 0; x <= canvas.width; x++) {
            const mid = x / canvas.width - 0.5;
            const amplitude = (1 - Math.pow(mid * 2, 2)) * 350;

            const y =
                Math.sin(x * 0.004 - t * 1.2) * amplitude +
                Math.sin(x * 0.008 - t * 0.6) * 40 +
                Math.sin(x * 0.0015 - t * 2.0) * 25 +
                canvas.height * 0.7;

            ctx.lineTo(x, y);
        }

        ctx.lineTo(canvas.width, canvas.height);
        ctx.closePath();
        ctx.fill();

        t += 0.015;
        requestAnimationFrame(drawWave);
    }

    drawWave();
}
