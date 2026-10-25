$(function () {
    $('.nav-btn').on('hover', function () {
        $(this).toggleClass('open');
    });
});

$(document).ready(function () {
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


    // Ambil semua elemen h3.text
    $(".text").each(function () {
        var $this = $(this);
        var textContent = $this.text().trim(); // Ambil teks murni

        // Hapus isi h3, lalu isi ulang dengan karakter yang dibungkus <span>
        $this.empty();
        $.each(textContent.split(""), function (i, char) {
            $this.append($("<span>").text(char));
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

    // Icon box click activation
    $(document).on('click', '.icon-box', function () {
        $('.icon-box').removeClass('active');
        $(this).addClass('active');
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


$(document).ready(function () {
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
    $(".blob").each(function () {
        var $blob = $(this);
        var $parent = $blob.closest(".position-relative");
        var parentW = $parent.width();
        var parentH = $parent.height();
        var blobSize = $blob.outerWidth();

        function moveRandom() {
            var x = Math.random() * (parentW - blobSize);
            var y = Math.random() * (parentH - blobSize);
            $blob.css("transform", "translate(" + x + "px," + y + "px)");
        }

        // mulai di posisi random 
        moveRandom();

        // ulangi tiap 3–5 detik dengan delay berbeda 
        setInterval(moveRandom, 3000 + Math.random() * 2000);
    });
});

// Set the countdown end time (e.g., 1200 days from now)
const endDate = new Date();
endDate.setDate(endDate.getDate() + 10);

function updateCountdown() {
  const now = new Date();
  const timeLeft = endDate - now;

  const days = Math.floor(timeLeft / (1000 * 60 * 60 * 24));
  const hours = Math.floor((timeLeft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  const minutes = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60));
  const seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);

  document.getElementById("days").textContent = days;
  document.getElementById("hours").textContent = hours;
  document.getElementById("minutes").textContent = minutes;
  document.getElementById("seconds").textContent = seconds;
}

// Update countdown every second
setInterval(updateCountdown, 1000);

function filterEvents(day) {
    // Remove active class from all tabs
    document.querySelectorAll('.tab').forEach(tab => {
      tab.classList.remove('active');
    });
    
    // Add active class to clicked tab
    event.target.classList.add('active');
    
    // Hide all event cards
    document.querySelectorAll('.event-card').forEach(card => {
      card.classList.remove('active');
    });
    
    // Show only event cards matching the selected day
    document.querySelectorAll(`.event-card.${day}`).forEach(card => {
      card.classList.add('active');
    });
  }



