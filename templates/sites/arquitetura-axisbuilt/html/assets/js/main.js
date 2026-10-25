(function ($) {
  "use strict";

  /*
  |=====================================================================
  | Template Name: Axisbuilt
  | Author: Laralink
  | Version: 1.0.0
  |=====================================================================
  |=====================================================================
  | TABLE OF CONTENTS:
  |=====================================================================
  |
  | 01. Preloader
  | 02. Mobile Menu
  | 03. Sticky Header
  | 04. Dynamic Background
  | 05. Swiper Slider
  | 06. Search Modal Toggle
  | 07. Smooth Page Scroll(Lenis)
  | 08. Counter Animation
  | 09. Modal Video
  | 10. Review
  | 11. Tabs
  | 12. Progress Bar
  | 13. Accordian
  | 14. Service Steps Animation
  | 15. Card Hover
  | 16. Scroll Up
  | 17. Hobble Animation With Mouse Move
  | 18. Animation With GSAP
  | 19. Dynamic contact form
  |
  */

  /*====================================================================
    Scripts initialization
  ======================================================================*/
  $.exists = function (selector) {
    return $(selector).length > 0;
  };

  $(window).on("load", function () {
    preloader();
  });

  $(function () {
    mainNav();
    stickyHeader();
    dynamicBackground();
    swiperInit();
    modalToggle();
    smoothScroll();
    counterInit();
    modalVideo();
    review();
    tabs();
    accordian();
    serviceSteps();
    scrollUp();
    animationOnHover();
    progressBar();
    cardHoverActive();
    gsapAnimation();
    dynamicContactForm();
    if ($.exists(".cs_getting_year")) {
      const date = new Date();
      $(".cs_getting_year").text(date.getFullYear());
    }
  });
  $(window).on("scroll", function () {
    stickyHeader();
    showScrollUp();
  });
  /*=============================================================
   Run on window resize
  ===============================================================*/
  $(window).on("resize", function () {
    const mobileWidth = 1199;
    if ($(window).width() >= mobileWidth) {
    }
    ScrollTrigger.refresh();
  });
  /*=============================================================
    01. Preloader
  ===============================================================*/
  function preloader() {
    const $preloader = $(".cs_preloader");
    const $progressBar = $(".cs_progressbar");
    const $percentageText = $(".cs_loading_percentage");

    let progress = 0;
    const startTime = Date.now();
    const estimatedDuration = 300;

    const interval = setInterval(() => {
      const elapsed = Date.now() - startTime;
      progress = Math.min((elapsed / estimatedDuration) * 100, 100);
      updateProgress(progress);

      if (progress >= 100) {
        clearInterval(interval);
        setTimeout(() => {
          $preloader.fadeOut(300);
        }, 50);
      }
    }, 50);

    window.addEventListener("load", () => {
      progress = 100;
      updateProgress(progress);
      clearInterval(interval);
      setTimeout(() => {
        $preloader.fadeOut(300);
      }, 100);
    });

    function updateProgress(value) {
      const rounded = Math.floor(value);
      $progressBar.css("width", rounded + "%");
      $percentageText.text(rounded + "%");
    }

    const $text = $(".cs_loading_text");
    const text = $text.text();
    $text.empty();

    // Split text into characters
    const characters = text.split("");
    characters.forEach((char) => {
      $text.append(
        `<span class="char">${char === " " ? "&nbsp;" : char}</span>`,
      );
    });

    // Animate each character
    gsap.from(".cs_loading_text .char", {
      opacity: 0,
      y: 100,
      duration: 0.6,
      stagger: 0.1,
    });
  }
  /*=============================================================
    02. Mobile Menu
  ===============================================================*/
  function mainNav() {
    $(".cs_nav").append('<span class="cs_menu_toggle"><span></span></span>');
    $(".menu-item-has-children").append(
      '<span class="cs_menu_dropdown_toggle"><span></span></span>',
    );
    $(".cs_menu_toggle").on("click", function () {
      $(this)
        .toggleClass("active")
        .siblings(".cs_nav_list_wrapper")
        .toggleClass("active");
      $(".cs_close_nav").toggleClass("active");
    });

    $(".cs_menu_dropdown_toggle").on("click", function () {
      $(this).toggleClass("active").siblings("ul").slideToggle();
      $(this).parent().toggleClass("active");
    });
    $(".cs_search_btn").on("click", function () {
      $(".cs_header_search").addClass("active");
      $(".cs_user_content").slideUp();
    });
    $(".cs_close, .cs_sidenav_overlay").on("click", function () {
      $(".cs_sidenav, .cs_header_search").removeClass("active");
    });
    $(".cs_close_nav").on("click", function () {
      $(this)
        .toggleClass("active")
        .parent(".cs_nav_list_wrapper")
        .toggleClass("active");
      $(".cs_menu_toggle").toggleClass("active");
    });
  }
  /*=============================================================
    03. Sticky Header
  ===============================================================*/
  function stickyHeader() {
    var scroll = $(window).scrollTop();
    if (scroll >= 10) {
      $(".cs_sticky_header").addClass("cs_sticky_active");
    } else {
      $(".cs_sticky_header").removeClass("cs_sticky_active");
    }
  }
  /*=============================================================
    04. Dynamic Background
  ===============================================================*/
  function dynamicBackground() {
    $("[data-src]").each(function () {
      var src = $(this).attr("data-src");
      $(this).css({
        "background-image": "url(" + src + ")",
      });
    });
  }
  /*============================================================
    05. Swiper Slider
  ==============================================================*/
  function swiperInit() {
    // Loop through each Swiper container
    $(".swiper").each(function () {
      var $swiperEl = $(this);
      var $wrapper = $swiperEl.find(".swiper-wrapper");

      // Skip if no wrapper found
      if (!$wrapper.length) return;

      // ========== BASIC OPTIONS ==========
      var autoplayVal = Boolean(parseInt($swiperEl.attr("data-autoplay"), 10));
      var loopVal = Boolean(parseInt($swiperEl.attr("data-loop"), 10));
      var centerVal = Boolean(parseInt($swiperEl.attr("data-center"), 10));
      var variableVal = Boolean(
        parseInt($swiperEl.attr("data-variable-width"), 10),
      );
      var speedVal = parseInt($swiperEl.data("speed")) || 600;
      var slidesType = $swiperEl.data("slides-per-view");
      var slidesVal = 1;

      if (slidesType !== "responsive") {
        slidesVal = parseInt(slidesType) || 1;
      }

      // ========== SLIDES PER VIEW ==========
      var mobileSm = parseInt($swiperEl.data("mobile-sm")) || 1;
      var mobile = parseInt($swiperEl.data("mobile")) || mobileSm;
      var tabletSm = parseInt($swiperEl.data("tablet-sm")) || 2;
      var tablet = parseInt($swiperEl.data("tablet")) || tabletSm;
      var laptop = parseInt($swiperEl.data("laptop")) || 3;
      var desktop = parseInt($swiperEl.data("desktop")) || 4;
      var desktopLg = parseInt($swiperEl.data("desktop-lg")) || desktop;

      // ========== GAP LOGIC ==========
      var defaultGap = parseInt($swiperEl.data("gap"));
      if (isNaN(defaultGap)) defaultGap = 24;

      var gapMobileSm = parseInt($swiperEl.data("gap-mobile-sm"));
      var gapMobile = parseInt($swiperEl.data("gap-mobile"));
      var gapTabletSm = parseInt($swiperEl.data("gap-tablet-sm"));
      var gapTablet = parseInt($swiperEl.data("gap-tablet"));
      var gapLaptop = parseInt($swiperEl.data("gap-laptop"));
      var gapDesk = parseInt($swiperEl.data("gap-desktop"));
      var gapDeskLg = parseInt($swiperEl.data("gap-desktop-lg"));

      // Set fallback values
      gapMobileSm = !isNaN(gapMobileSm)
        ? gapMobileSm
        : !isNaN(gapMobile)
          ? gapMobile
          : defaultGap;
      gapMobile = !isNaN(gapMobile) ? gapMobile : gapMobileSm;
      gapTabletSm = !isNaN(gapTabletSm)
        ? gapTabletSm
        : !isNaN(gapTablet)
          ? gapTablet
          : defaultGap;
      gapTablet = !isNaN(gapTablet) ? gapTablet : gapTabletSm;
      gapLaptop = !isNaN(gapLaptop) ? gapLaptop : defaultGap;
      gapDesk = !isNaN(gapDesk) ? gapDesk : defaultGap;
      gapDeskLg = !isNaN(gapDeskLg) ? gapDeskLg : gapDesk;

      // ========== BASE OPTIONS ==========
      var swiperOptions = {
        slidesPerView: variableVal ? "auto" : mobile,
        spaceBetween: gapMobileSm,
        speed: speedVal,
        loop: loopVal,
        autoHeight: true,
        centeredSlides: centerVal,
        grabCursor: true,
        watchOverflow: true,
        autoplay: autoplayVal
          ? {
              delay: speedVal * 5,
              disableOnInteraction: false,
              pauseOnMouseEnter: true,
            }
          : false,
        breakpoints: {
          // Small mobile (portrait phones)
          576: {
            slidesPerView: variableVal ? "auto" : tabletSm,
            spaceBetween: gapTabletSm,
          },
          // Tablet (portrait)
          768: {
            slidesPerView: variableVal ? "auto" : tablet,
            spaceBetween: gapTablet,
          },
          // Laptop / Small desktop
          992: {
            slidesPerView: variableVal ? "auto" : laptop,
            spaceBetween: gapLaptop,
          },
          // Desktop
          1200: {
            slidesPerView: variableVal ? "auto" : desktop,
            spaceBetween: gapDesk,
          },
          // Large desktop
          1400: {
            slidesPerView: variableVal ? "auto" : desktopLg,
            spaceBetween: gapDeskLg,
          },
        },
      };

      // ========== NAVIGATION ==========
      var $prevBtn = $swiperEl.find(".slider-prev");
      var $nextBtn = $swiperEl.find(".slider-next");

      if (!$prevBtn.length) {
        $prevBtn = $swiperEl.siblings(".slider-prev");
      }
      if (!$nextBtn.length) {
        $nextBtn = $swiperEl.siblings(".slider-next");
      }

      if (!$prevBtn.length || !$nextBtn.length) {
        var $container = $swiperEl.closest(
          ".swiper-container, .slider-section, .carousel",
        );
        if ($container.length) {
          if (!$prevBtn.length) $prevBtn = $container.find(".slider-prev");
          if (!$nextBtn.length) $nextBtn = $container.find(".slider-next");
        }
      }

      if ($prevBtn.length && $nextBtn.length) {
        swiperOptions.navigation = {
          nextEl: $nextBtn[0],
          prevEl: $prevBtn[0],
        };
      }

      // ========== PAGINATION ==========
      var $pagination = $swiperEl.find(".swiper-pagination");

      if (!$pagination.length) {
        $pagination = $swiperEl.siblings(".swiper-pagination");
      }

      if ($pagination.length) {
        swiperOptions.pagination = {
          el: $pagination[0],
          clickable: true,
          //dynamicBullets: true,
          renderBullet: function (index, className) {
            return '<span class="' + className + '">' + (index + 1) + "</span>";
          },
        };
      }
      // ========== SCROLLBAR ==========
      var $scrollbar = $swiperEl.find(".swiper-scrollbar");
      if ($scrollbar.length) {
        swiperOptions.scrollbar = {
          el: $scrollbar[0],
          draggable: true,
        };
      }

      // ========== ADDITIONAL OPTIONS ==========
      if ($swiperEl.data("mousewheel") === true) {
        swiperOptions.mousewheel = {
          sensitivity: 1,
          eventsTarget: ".swiper-slide",
        };
      }

      if ($swiperEl.data("auto-height") === true) {
        swiperOptions.autoHeight = true;
      }

      // ========== EFFECT ==========
      var effect = $swiperEl.data("effect");

      // Check if effect exists and is valid
      if (effect) {
        var validEffects = [
          "slide",
          "fade",
          "cube",
          "coverflow",
          "flip",
          "creative",
          "cards",
        ];

        if (validEffects.includes(effect)) {
          swiperOptions.effect = effect;

          // Configure effect parameters based on effect type
          switch (effect) {
            case "fade":
              swiperOptions.fadeEffect = {
                crossFade: $swiperEl.data("fade-cross") !== false,
              };
              break;

            case "cube":
              swiperOptions.cubeEffect = {
                slideShadows: $swiperEl.data("cube-shadows") !== false,
                shadow: $swiperEl.data("cube-shadow") !== false,
                shadowOffset:
                  parseInt($swiperEl.data("cube-shadow-offset")) || 20,
                shadowScale:
                  parseFloat($swiperEl.data("cube-shadow-scale")) || 0.94,
              };
              break;

            case "coverflow":
              swiperOptions.coverflowEffect = {
                rotate: parseInt($swiperEl.data("coverflow-rotate")) || 50,
                stretch: parseInt($swiperEl.data("coverflow-stretch")) || 0,
                depth: parseInt($swiperEl.data("coverflow-depth")) || 100,
                modifier: parseFloat($swiperEl.data("coverflow-modifier")) || 1,
                slideShadows: $swiperEl.data("coverflow-shadows") !== false,
              };
              break;

            case "flip":
              swiperOptions.flipEffect = {
                slideShadows: $swiperEl.data("flip-shadows") !== false,
                limitRotation: $swiperEl.data("flip-limit") !== false,
              };
              break;
          }

          // For 'slide' effect, no additional parameters needed
          console.log("Swiper effect set to:", effect);
        } else {
          console.warn("Invalid effect specified:", effect);
        }
      }

      // ========== DESTROY EXISTING INSTANCE ==========
      if ($swiperEl[0].swiper) {
        $swiperEl[0].swiper.destroy(true, true);
      }

      // ========== INIT ==========
      new Swiper($swiperEl[0], swiperOptions);
    });
  }
  /*============================================================
    06. Search Modal Toggle
  ==============================================================*/
  function modalToggle() {
    $(".cs_open_modal").on("click", function () {
      $(".cs_advanced_search_modal").addClass("active");
      $("body").addClass("scroll_off");
    });
    $(".cs_close_modal").on("click", function () {
      $(".cs_advanced_search_modal").removeClass("active");
      $("body").removeClass("scroll_off");
    });
  }
  /*============================================================
    07. Smooth Page Scroll
  ==============================================================*/
  function smoothScroll() {
    if (typeof Lenis === "undefined") return;

    // Reduced motion respect
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;

    // Prevent multiple init
    if (window.lenisInstance) return;

    const lenis = new Lenis({
      duration: 1.2,
      smooth: true,
      smoothTouch: false,
      easing: (t) => 1 - Math.pow(1 - t, 3),
    });

    window.lenisInstance = lenis;

    // GSAP + ScrollTrigger integration

    if (typeof gsap !== "undefined" && typeof ScrollTrigger !== "undefined") {
      lenis.on("scroll", ScrollTrigger.update);

      gsap.ticker.add((time) => {
        lenis.raf(time * 1000);
      });

      gsap.ticker.lagSmoothing(0);
    } else {
      function raf(time) {
        lenis.raf(time);
        requestAnimationFrame(raf);
      }
      requestAnimationFrame(raf);
    }
  }
  /*============================================================
    08. Counter Animation
  ==============================================================*/
  function counterInit() {
    if (!$.exists(".odometer")) return;

    const observer = new IntersectionObserver(
      function (entries, observer) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            const el = $(entry.target);
            el.html(el.data("count-to"));
            observer.unobserve(entry.target);
          }
        });
      },
      {
        threshold: 0.3,
      },
    );

    $(".odometer").each(function () {
      observer.observe(this);
    });
  }
  /*============================================================
    09. Modal Video
  ==============================================================*/
  function modalVideo() {
    if ($.exists(".cs_video_open")) {
      $("body").append(`
        <div class="cs_video_popup">
          <div class="cs_video_popup-overlay"></div>
          <div class="cs_video_popup-content">
            <div class="cs_video_popup-layer"></div>
            <div class="cs_video_popup_container">
              <div class="cs_video_popup-align">
                <div class="embed-responsive embed-responsive-16by9">
                  <iframe class="embed-responsive-item" src="about:blank"></iframe>
                </div>
              </div>
              <div class="cs_video_popup_close"></div>
            </div>
          </div>
        </div>
      `);
      $(document).on("click", ".cs_video_open", function (e) {
        e.preventDefault();
        var video = $(this).attr("href");

        $(".cs_video_popup_container iframe").attr("src", `${video}`);

        $(".cs_video_popup").addClass("active");
      });
      $(".cs_video_popup_close, .cs_video_popup-layer").on(
        "click",
        function (e) {
          $(".cs_video_popup").removeClass("active");
          $("html").removeClass("overflow-hidden");
          $(".cs_video_popup_container iframe").attr("src", "about:blank");
          e.preventDefault();
        },
      );
    }
  }
  /*============================================================
    10. Review
  ==============================================================*/
  function review() {
    $(".cs_rating").each(function () {
      var review = $(this).data("rating");
      var reviewVal = review * 20 + "%";
      $(this).find(".cs_rating_percentage").css("width", reviewVal);
    });
  }
  /*============================================================
    11. Tabs
  ===============================================================*/
  function tabs() {
    $(".cs_tab_links a").on("click", function (e) {
      var currentAttrValue = $(this).attr("href");
      //Tab and slider both activation code
      $(".cs_tabs " + currentAttrValue)
        .addClass("active")
        .siblings()
        .removeClass("active");
      $(this).parents("li").addClass("active").siblings().removeClass("active");
      e.preventDefault();
    });
  }
  /*--------------------------------------------------------------
    12. Progress Bar
  --------------------------------------------------------------*/
  function progressBar() {
    $(".cs_progress").each(function () {
      var progressPercentage = $(this).data("progress") + "%";
      $(this).find(".cs_progress_in").css("width", progressPercentage);
    });
  }
  /*=============================================================
    13. Accordian
  ===============================================================*/
  function accordian() {
    $(".cs_accordian").children(".cs_accordian_body").hide();
    $(".cs_accordian.active").children(".cs_accordian_body").show();
    $(".cs_accordian_head").on("click", function () {
      $(this)
        .parent(".cs_accordian")
        .siblings()
        .children(".cs_accordian_body")
        .slideUp(250);
      $(this).siblings().slideDown(250);
      $(this)
        .parent()
        .parent()
        .siblings()
        .find(".cs_accordian_body")
        .slideUp(250);
      /* Accordian Active Class */
      $(this).parents(".cs_accordian").addClass("active");
      $(this).parent(".cs_accordian").siblings().removeClass("active");
    });
  }
  /*===========================================================
    14. Service Steps Animation
  =============================================================*/
  function serviceSteps() {
    let tabInterval;
    let currentIndex = 0;

    const $tabs = $(".cs_service_menu_list li");
    const $tabContents = $(".cs_service_thumbnails_wrapper");
    const intervalTime = 5000;

    if ($tabs.length > 0 && $tabContents.length > 0) {
      function activateTab(index) {
        $tabs.eq(index).addClass("active").siblings().removeClass("active");
        $tabContents.eq(index).fadeIn(600).siblings().hide();
      }

      function startAutoplay() {
        stopAutoplay();
        tabInterval = setInterval(function () {
          currentIndex = (currentIndex + 1) % $tabs.length;
          activateTab(currentIndex);
        }, intervalTime);
      }

      function stopAutoplay() {
        if (tabInterval) clearInterval(tabInterval);
      }

      $tabs.on("click", function (e) {
        e.preventDefault();
        stopAutoplay();
        currentIndex = $(this).index();
        activateTab(currentIndex);
        startAutoplay();
      });

      // Init
      $tabContents.hide();
      activateTab(currentIndex);
      startAutoplay();
    }
  }
  /*==============================================================
   15. Card Hover
  ================================================================*/
  function cardHoverActive() {
    $(".cs_card_style_6").on("mouseenter", function () {
      $(this)
        .addClass("active")
        .siblings(".cs_card_style_6")
        .removeClass("active");
    });
  }
  /*==============================================================
    16. Scroll Up
  ================================================================*/
  function scrollUp() {
    $(".cs_scrollup_btn").on("click", function (e) {
      e.preventDefault();
      $("html,body").animate(
        {
          scrollTop: 0,
        },
        0,
      );
    });
  }
  /* For Scroll Up */
  function showScrollUp() {
    let scroll = $(window).scrollTop();
    if (scroll >= 350) {
      $(".cs_scrollup_btn").addClass("show");
    } else {
      $(".cs_scrollup_btn").removeClass("show");
    }
  }
  /*==============================================================
    17. Hobble Animation With Mouse Move
  ================================================================*/
  function animationOnHover() {
    let cards = document.querySelectorAll(".animationonhover");

    cards.forEach((tmpOnHover) => {
      // Set initial value
      tmpOnHover.style.setProperty("--x", "-1px");
      tmpOnHover.style.setProperty("--y", "-1px");

      tmpOnHover.onmousemove = function (e) {
        let rect = tmpOnHover.getBoundingClientRect();
        let x = e.clientX - rect.left;
        let y = e.clientY - rect.top;

        tmpOnHover.style.setProperty("--x", `${x}px`);
        tmpOnHover.style.setProperty("--y", `${y}px`);
      };
    });
  }
  /*==============================================================
    18. Animation With GSAP
  ================================================================*/
  function gsapAnimation() {
    //Check if GSAP is loaded FIRST
    if (typeof gsap === "undefined") {
      console.warn("GSAP not loaded - animations disabled");
      return;
    }

    //Safely register plugins
    try {
      if (typeof ScrollTrigger !== "undefined") {
        gsap.registerPlugin(ScrollTrigger);
      } else {
        console.warn("ScrollTrigger not loaded");
      }

      if (typeof SplitText !== "undefined") {
        gsap.registerPlugin(SplitText);
      } else {
        console.warn(
          "SplitText not loaded - title animations will use fallback",
        );
      }
    } catch (e) {
      console.warn("Plugin registration failed:", e);
    }

    //Team Card Social Buttons Animation (Fixed)
    const $teamCards = $(".cs_team_style_1");
    if ($teamCards.length) {
      $teamCards.each(function () {
        const $card = $(this);
        const $buttons = $card.find(".cs_social_btns_style_1 a");

        if ($buttons.length === 0) return;

        // Prevent duplicate initialization
        if ($card.data("socialAnimated")) return;

        // Set initial state
        gsap.set($buttons, {
          y: 15,
          autoAlpha: 0,
          scale: 0.8,
        });

        // Create timeline with better easing
        const tl = gsap.timeline({
          paused: true,
          defaults: {
            duration: 0.25,
            ease: "back.out(0.6)",
          },
        });

        tl.to($buttons, {
          y: 0,
          autoAlpha: 1,
          scale: 1,
          stagger: 0.08,
        });

        // Store timeline and mark as initialized
        $card.data("socialTimeline", tl);
        $card.data("socialAnimated", true);

        // Event handlers
        $card.on("mouseenter.socialAnimation", function () {
          tl.play();
        });

        $card.on("mouseleave.socialAnimation", function () {
          tl.reverse();
        });
      });
    }

    //Slide Up Text Animation
    const $shadowText = $(".cs_shadow_text");
    if ($shadowText.length && typeof ScrollTrigger !== "undefined") {
      gsap.from($shadowText, {
        y: 100,
        opacity: 0,
        rotationX: 15,
        duration: 0.8,
        ease: "power3.out",
        scrollTrigger: {
          trigger: $shadowText,
          start: "top 85%",
          end: "bottom 65%",
          toggleActions: "play none reverse none",
          scrub: 0.3,
        },
      });
    } else if ($shadowText.length) {
      //Fallback without ScrollTrigger
      gsap.from($shadowText, {
        y: 100,
        opacity: 0,
        duration: 0.8,
        ease: "power3.out",
        delay: 0.2,
      });
    }

    //Button Animation
    const $buttons = $(".cs_text_btn_style_2");
    if ($buttons.length) {
      $buttons.each(function () {
        const $btn = $(this);
        const $textEl = $btn.find(".cs_btn_text");

        if (!$textEl.length) return;

        const text = $textEl.text().trim();

        // Prevent duplicate init
        if ($textEl.find(".cs_letter").length || $btn.data("buttonAnimated"))
          return;

        $textEl.empty();

        //Split letters with proper styling
        const letters = text.split("");
        letters.forEach((char, index) => {
          const $span = $("<span/>", {
            class: "cs_letter",
            html: char === " " ? "&nbsp;" : char,
            css: {
              display: "inline-block",
              transformStyle: "preserve-3d",
              transformOrigin: "center center",
            },
          });
          $textEl.append($span);
        });

        const $letters = $textEl.find(".cs_letter");

        const tl = gsap.timeline({
          paused: true,
          defaults: {
            duration: 0.6,
            ease: "back.out(0.8)",
          },
        });

        tl.to($letters, {
          rotationX: 360,
          rotationY: 10,
          scale: 1.05,
          stagger: 0.04,
          ease: "power2.out",
        });

        $btn.data("buttonTimeline", tl);
        $btn.data("buttonAnimated", true);

        $btn.on("mouseenter.buttonAnimation", function () {
          tl.play();
        });

        $btn.on("mouseleave.buttonAnimation", function () {
          tl.reverse();
        });
      });
    }

    //Sticky Cards Animation
    const $stickyCards = $(".cs_sticky_card");
    if ($stickyCards.length && typeof ScrollTrigger !== "undefined") {
      // Kill existing triggers to prevent conflicts
      ScrollTrigger.getAll().forEach((trigger) => {
        if (
          trigger.vars.trigger &&
          $(trigger.vars.trigger).hasClass("cs_sticky_card")
        ) {
          trigger.kill();
        }
      });

      $stickyCards.each(function (index) {
        const $card = $(this);
        const isLast = index === $stickyCards.length - 1;
        const topOffset = 100 + index * 40;

        $card.css({
          "z-index": 100 + index,
          position: "relative",
        });

        ScrollTrigger.create({
          trigger: $card[0],
          start: "top top",
          pin: !isLast,
          pinSpacing: false,
          pinOffset: topOffset,
          anticipatePin: 1,
          invalidateOnRefresh: true,
        });
      });
    }

    //Section Title Animation
    const $sectionTitles = $(".cs_section_title");

    if ($sectionTitles.length) {
      //Check if SplitText is available
      const hasSplitText = typeof SplitText !== "undefined";

      $sectionTitles.each(function (index) {
        const el = this;
        const $el = $(el);

        //Prevent duplicate initialization
        if ($el.data("titleAnimated")) return;

        if (hasSplitText) {
          try {
            //Split into words
            const split = new SplitText(el, {
              type: "words",
              wordsClass: "word",
            });

            if (split.words && split.words.length) {
              //Wrap words with inner span
              split.words.forEach((word) => {
                const inner = document.createElement("span");
                inner.classList.add("word_inner");
                inner.innerHTML = word.innerHTML;
                word.innerHTML = "";
                word.appendChild(inner);
              });

              const wordsInner = el.querySelectorAll(".word_inner");

              //Set initial state
              gsap.set(wordsInner, {
                y: "100%",
                opacity: 0,
                filter: "blur(8px)",
                transformOrigin: "center bottom",
              });

              //Animate words
              gsap.to(wordsInner, {
                y: 0,
                opacity: 1,
                filter: "blur(0px)",
                duration: 1,
                ease: "power4.out",
                stagger: 0.08,
                scrollTrigger: {
                  trigger: el,
                  start: "top 85%",
                  end: "top 65%",
                  once: true,
                  onEnter: () => {
                    $el.addClass("title-animated");
                  },
                },
              });

              //Store split instance for potential cleanup
              $el.data("splitText", split);
            } else {
              //Fallback if no words
              useFallbackTitleAnimation(el);
            }
          } catch (e) {
            console.warn("SplitText error for element", index, e);
            useFallbackTitleAnimation(el);
          }
        } else {
          //Fallback without SplitText
          useFallbackTitleAnimation(el);
        }

        $el.data("titleAnimated", true);
      });
    }

    //Fallback title animation function
    function useFallbackTitleAnimation(element) {
      gsap.fromTo(
        element,
        {
          opacity: 0,
          y: 50,
          filter: "blur(8px)",
        },
        {
          opacity: 1,
          y: 0,
          filter: "blur(0px)",
          duration: 0.8,
          ease: "power3.out",
          scrollTrigger: {
            trigger: element,
            start: "top 85%",
            once: true,
          },
        },
      );
    }

    //Resize Handler to Refresh ScrollTrigger
    if (typeof ScrollTrigger !== "undefined") {
      let resizeTimer;

      $(window).on("resize", function () {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(() => {
          ScrollTrigger.refresh();
        }, 250);
      });

      //Initial refresh after all animations are set
      setTimeout(() => {
        ScrollTrigger.refresh();
      }, 100);
    }

    //Cleanup function
    function cleanupAnimations() {
      //Remove event handlers
      $(".cs_team_style_1").off(".socialAnimation");
      $(".cs_text_btn_style_2").off(".buttonAnimation");

      //Kill all ScrollTriggers
      if (typeof ScrollTrigger !== "undefined") {
        ScrollTrigger.getAll().forEach((trigger) => trigger.kill());
      }
      console.log("GSAP animations cleaned up");
    }
    //Store cleanup function for potential use
    window.gsapAnimationCleanup = cleanupAnimations;
    console.log("GSAP animations initialized successfully");
  }
  /*===============================================================
    19. Dynamic contact form
  =================================================================*/
  function dynamicContactForm() {
    if ($.exists("#cs_form")) {
      const form = document.getElementById("cs_form");
      const result = document.getElementById("cs_result");

      form.addEventListener("submit", function (e) {
        const formData = new FormData(form);
        e.preventDefault();
        var object = {};
        formData.forEach((value, key) => {
          object[key] = value;
        });
        var json = JSON.stringify(object);
        result.innerHTML = "Please wait...";

        fetch("https://api.web3forms.com/submit", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
          body: json,
        })
          .then(async (response) => {
            let json = await response.json();
            if (response.status == 200) {
              result.innerHTML = json.message;
            } else {
              console.log(response);
              result.innerHTML = json.message;
            }
          })
          .catch((error) => {
            console.log(error);
            result.innerHTML = "Something went wrong!";
          })
          .then(function () {
            form.reset();
            setTimeout(() => {
              result.style.display = "none";
            }, 5000);
          });
      });
    }
  }
})(jQuery); // End of use strict
