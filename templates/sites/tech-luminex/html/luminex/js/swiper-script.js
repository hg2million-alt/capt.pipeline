$(function () {
    var swiperTeam = new Swiper('.swiper.swiperTeam', {
        autoplay: {
            delay: 5000
        },
        speed: 2000,
        slidesPerView: 4,
        slidesPerGroup: 1,
        spaceBetween: 0,
        loop: false,
        grabCursor: true,
        breakpoints: {
            // when window width is >= 360px
            360: {
                slidesPerView: 1,
            },
            // when window width is >= 768px
            768: {
                slidesPerView: 4,
            },
            // when window width is >= 1024px
            1024: {
                slidesPerView: 4,
            }
        },
        // If we need pagination
        pagination: {
            enabled: true,
            el: '.swiper-pagination',
            type: 'bullets',
            clickable: true,
        },
    });

    var swiperTestimonials = new Swiper('.swiperTestimonials', {
        autoplay: {
            delay: 3000,
        },
        speed: 2000,
        slidesPerView: 2,
        spaceBetween: 10,
        loop: true,
        grabCursor: true,
        breakpoints: {
            // when window width is >= 360px
            360: {
                slidesPerView: 1,
            },
            // when window width is >= 768px
            768: {
                slidesPerView: 2,
            },
            // when window width is >= 1024px
            1024: {
                slidesPerView: 2,
            }
        },
        // If we need pagination
        pagination: {
            enabled: true,
            el: '.swiper-pagination',
            type: 'bullets',
            clickable: true,
        },
    });

    var swiperTestimonials2 = new Swiper('.swiperTestimonials2', {
        autoplay: {
            delay: 3000,
        },
        speed: 2000,
        slidesPerView: 2,
        spaceBetween: 10,
        centeredSlides: true,
        loop: true,
        grabCursor: true,
        initialSlide: 1,
        breakpoints: {
            // when window width is >= 360px
            360: {
                slidesPerView: 1,
            },
            // when window width is >= 768px
            768: {
                slidesPerView: 2,
            },
            // when window width is >= 1024px
            1024: {
                slidesPerView: 2,
            }
        },
        // If we need pagination
        pagination: {
            enabled: true,
            el: '.swiper-pagination',
            type: 'bullets',
            clickable: true,
        },
    });

    var swiperTestimonials3 = new Swiper('.swiperTestimonials3', {
        autoplay: {
            delay: 3000,
        },
        speed: 2000,
        slidesPerView: 2,
        spaceBetween: 10,
        loop: true,
        grabCursor: true,
        breakpoints: {
            // when window width is >= 360px
            360: {
                slidesPerView: 1,
            },
            // when window width is >= 768px
            768: {
                slidesPerView: 2,
            },
            // when window width is >= 1024px
            1024: {
                slidesPerView: 2,
            }
        },
        // If we need pagination
        pagination: {
            enabled: true,
            el: '.swiper-pagination',
            type: 'bullets',
            clickable: true,
        },
    });

    var swiperTestimonials4 = new Swiper('.swiperTestimonials4', {
        autoplay: {
            delay: 3000,
        },
        speed: 2000,
        slidesPerView: 3,
        spaceBetween: 10,
        loop: true,
        grabCursor: true,
        breakpoints: {
            // when window width is >= 360px
            360: {
                slidesPerView: 1,
            },
            // when window width is >= 768px
            768: {
                slidesPerView: 2,
            },
            // when window width is >= 1024px
            1024: {
                slidesPerView: 3,
            }
        },
        // If we need pagination
        pagination: {
            enabled: true,
            el: '.swiper-pagination',
            type: 'bullets',
            clickable: true,
        },
    });

});