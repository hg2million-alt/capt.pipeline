'use client';

import { usePathname } from 'next/navigation';
import { useEffect } from 'react';

export default function ScriptHandler() {
  const pathname = usePathname();

  useEffect(() => {
    const initCustomBackgrounds = () => {
      const colorElements = document.querySelectorAll<HTMLElement>('[data-bgcolor]');
      colorElements.forEach((el) => {
        const bgColor = el.dataset.bgcolor;
        if (!bgColor) return;
        el.classList.add('bgcustom');
        el.style.backgroundColor = bgColor;
      });

      const imageElements = document.querySelectorAll<HTMLElement>('[data-bgimage]');
      imageElements.forEach((el) => {
        const bgImage = el.dataset.bgimage;
        if (!bgImage) return;
        el.classList.add('bgcustom');
        el.style.background = bgImage;
        el.style.backgroundSize = 'cover';
        el.style.backgroundRepeat = 'no-repeat';
      });
    };

    const initMagnificPopup = () => {
      const $ = (window as any).jQuery;
      if (!$ || !$.fn || !$.fn.magnificPopup) return;

      $('.popup-youtube, .popup-vimeo, .popup-gmaps, .image-popup, .image-popup-vertical-fit, .image-popup-fit-width, .image-popup-no-margins, .image-popup-gallery').off('click.magnificPopup');
      $('.zoom-gallery, .images-group, .images-popup').off('click.magnificPopup');

      $('.zoom-gallery').magnificPopup({
        delegate: 'a',
        type: 'image',
        closeOnContentClick: false,
        closeBtnInside: false,
        mainClass: 'mfp-with-zoom mfp-img-mobile',
        image: {
          verticalFit: true,
          titleSrc: (item: any) => item.el.attr('title'),
        },
        gallery: {
          enabled: true,
        },
        zoom: {
          enabled: true,
          duration: 300,
          opener: (element: any) => element.find('img'),
        },
      });

      $('.popup-youtube, .popup-vimeo, .popup-gmaps').magnificPopup({
        disableOn: 700,
        type: 'iframe',
        mainClass: 'mfp-fade',
        removalDelay: 160,
        preloader: false,
        fixedContentPos: false,
      });

      $('.image-popup').magnificPopup({
        type: 'image',
        mainClass: 'mfp-with-zoom',
        zoom: {
          enabled: true,
          duration: 300,
          easing: 'ease-in-out',
          opener: (openerElement: any) => (openerElement.is('img') ? openerElement : openerElement.find('img')),
        },
      });

      $('.image-popup-vertical-fit').magnificPopup({
        type: 'image',
        closeOnContentClick: true,
        mainClass: 'mfp-img-mobile',
        image: {
          verticalFit: true,
        },
      });

      $('.image-popup-fit-width').magnificPopup({
        type: 'image',
        closeOnContentClick: true,
        image: {
          verticalFit: false,
        },
      });

      $('.image-popup-no-margins').magnificPopup({
        type: 'image',
        closeOnContentClick: true,
        closeBtnInside: false,
        fixedContentPos: true,
        mainClass: 'mfp-no-margins mfp-with-zoom',
        image: {
          verticalFit: true,
        },
        zoom: {
          enabled: true,
          duration: 300,
        },
      });

      $('.image-popup-gallery').magnificPopup({
        type: 'image',
        closeOnContentClick: false,
        closeBtnInside: false,
        mainClass: 'mfp-with-zoom mfp-img-mobile',
        image: {
          verticalFit: true,
          titleSrc: (item: any) => item.el.attr('title'),
        },
        gallery: {
          enabled: true,
        },
      });

      $('.images-group').each((_: any, el: any) => {
        $(el).magnificPopup({
          delegate: 'a',
          type: 'image',
          gallery: {
            enabled: true,
          },
        });
      });

      $('.images-popup').magnificPopup({
        delegate: 'a',
        type: 'image',
      });
    };

    const initOwlCarousel = () => {
      const $ = (window as any).jQuery;
      if (!$ || !$.fn || !$.fn.owlCarousel) return false;

      const reset = (selector: string) => {
        $(selector).each((_: any, el: any) => {
          const $el = $(el);
          if ($el.hasClass('owl-loaded')) {
            $el.trigger('destroy.owl.carousel');
            $el.removeClass('owl-loaded owl-hidden');
            $el.find('.owl-stage-outer').children().unwrap();
          }
        });
      };

      reset('.owl-single-dots');
      reset('.four-cols-center-dots');

      $('.owl-single-dots').owlCarousel({
        loop: true,
        items: 1,
        nav: false,
        dots: true,
      });

      $('.four-cols-center-dots').owlCarousel({
        center: true,
        loop: true,
        margin: 25,
        responsive: {
          1200: {
            items: 4,
          },
          1000: {
            items: 3,
          },
          600: {
            items: 2,
          },
          0: {
            items: 1,
          },
        },
      });

      return true;
    };

    const initAccordion = () => {
      const $ = (window as any).jQuery;
      if (!$ || !$.fn) return;

      $(document).off('click.accordionDentia', '.accordion-section-title');
      $(document).on('click.accordionDentia', '.accordion-section-title', function (this: any, e: any) {
        const currentAttrvalue = $(this).data('tab');
        if ($(e.target).is('.active')) {
          $(this).removeClass('active');
          $('.accordion-section-content:visible').slideUp(300);
          return;
        }

        $('.accordion-section-title').removeClass('active');
        $(this).addClass('active');
        $('.accordion-section-content').slideUp(300);
        $(currentAttrvalue).slideDown(300);
      });
    };

    const resetMobileHeaderState = () => {
      const header = document.querySelector('header');
      const isMenuOpen = header?.classList.contains('menu-open');

      if (header) {
        const baseClasses = (header.getAttribute('data-base-class') || '')
          .split(' ')
          .map((className) => className.trim())
          .filter(Boolean);
        const keepMobileClass = window.innerWidth <= 992 ? ['header-mobile'] : [];
        const keepOpenClass = isMenuOpen ? ['menu-open'] : [];
        
        let finalClasses = [...baseClasses, ...keepMobileClass, ...keepOpenClass];
        // If menu is open, remove autoshow to prevent interference
        if (isMenuOpen) {
          finalClasses = finalClasses.filter(c => c !== 'autoshow');
        }

        header.className = finalClasses.join(' ');
        
        if (isMenuOpen) {
           (header as HTMLElement).style.height = `${window.innerHeight}px`;
        } else {
           (header as HTMLElement).style.height = 'auto';
           (header as HTMLElement).style.top = '0px';
           (header as HTMLElement).style.marginTop = '0px';
        }
      }

      const menuButton = document.getElementById('menu-btn');
      if (menuButton && !isMenuOpen) {
        menuButton.classList.remove('menu-open');
      }

      if (!isMenuOpen) {
        document.body.classList.remove('no-scroll');
      }

      const $ = (window as any).jQuery;
      if (!$ || !$.fn) return;

      if (!isMenuOpen) {
        $('#mainmenu li ul').removeAttr('style');
        $('#mainmenu li span').removeClass('active');
        $('#mainmenu li').removeAttr('style');
        $('#mainmenu').removeAttr('style');
      }
    };

    const stabilizeMobileMenu = () => {
      const $ = (window as any).jQuery;
      if (!$ || !$.fn) return;

      $('#mainmenu li > span').remove();
      $('#mainmenu li').removeClass('has-child menu-item-has-children');
      $('#mainmenu li').has('ul').addClass('has-child menu-item-has-children');
      $('#mainmenu li').has('ul').each((_: any, el: any) => {
        const $li = $(el);
        const $anchor = $li.children('a').first();
        if ($anchor.length) {
          $('<span></span>').insertAfter($anchor);
        }
      });

      $(document).off('click.mobileDentiaMenu', '#mainmenu a');
      $(document).off('click.mobileDentiaMenuArrow', '#mainmenu li > span');

      const closeMenu = () => {
        if (window.innerWidth > 992) return;
        $('header').removeClass('menu-open');
        resetMobileHeaderState();
      };

      const bindMenuButton = () => {
        // Remove existing handlers to prevent conflicts (fix "3 actions")
        $('#menu-btn').off('click');
        $(document).off('click', '#menu-btn');
        $(document).off('click.mobileDentiaMenuBtn', '#menu-btn');

        // Attach new handler via delegation (robust to re-renders)
        $(document).on('click.mobileDentiaMenuBtn', '#menu-btn', function (this: any, e: any) {
          if (window.innerWidth > 992) return;
          e.preventDefault();
          e.stopPropagation();
          e.stopImmediatePropagation();
          
          const isOpen = $('header').hasClass('menu-open');
          if (isOpen) {
            closeMenu();
          } else {
            // Open menu
            $('header').addClass('menu-open');
            $('body').addClass('no-scroll');
            $('#menu-btn').addClass('menu-open');
            resetMobileHeaderState();
          }
        });
      };

      bindMenuButton();

      $(document).on('click.mobileDentiaMenu', '#mainmenu a', () => {
        closeMenu();
      });

      $(document).on('click.mobileDentiaMenuArrow', '#mainmenu li > span', function (this: any, e: any) {
        if (window.innerWidth > 992) return;
        e.preventDefault();
        e.stopPropagation();
        const $span = $(this);
        const $submenu = $span.parent().children('ul').first();
        if (!$submenu.length) return;

        if ($span.hasClass('active')) {
          // Close menu
          $span.removeClass('active');
          $submenu.stop(true, true).animate({ height: '0' }, 300);
        } else {
          // Open menu
          $span.addClass('active');
          // Manual height animation (because CSS sets height: 0, not display: none)
          $submenu.css('height', 'auto');
          const targetHeight = $submenu.height();
          $submenu.css('height', '0');
          $submenu.stop(true, true).animate({ height: targetHeight }, 300);
        }
      });

      return () => {
        $(document).off('click.mobileDentiaMenuBtn');
        $(document).off('click.mobileDentiaMenu');
        $(document).off('click.mobileDentiaMenuArrow');
      };
    };

    let cleanupMobileMenu: (() => void) | undefined;
    let initialized = false;
    const initScripts = () => {
      if (initialized) return;
      if (typeof window === 'undefined') return;
      const $ = (window as any).jQuery;
      if (!$ || !$.fn) return;

      if ((window as any).de_init) {
        (window as any).de_init();
      }

      if (cleanupMobileMenu) cleanupMobileMenu();
      cleanupMobileMenu = stabilizeMobileMenu();

      initCustomBackgrounds();
      initMagnificPopup();
      const owlReady = initOwlCarousel();
      initAccordion();

      if ((window as any).WOW) {
        new (window as any).WOW().init();
      }

      if ((window as any).Swiper) {
        const swiperElements = document.querySelectorAll('.swiper');
        swiperElements.forEach((el) => {
          const swiperElement = el as any;
          if (swiperElement.swiper) {
            swiperElement.swiper.destroy(true, true);
          }
          if (swiperElement.querySelectorAll('.swiper-slide').length > 0) {
            new (window as any).Swiper(swiperElement, {
              loop: true,
              autoplay: {
                delay: 3000,
                disableOnInteraction: false,
              },
              spaceBetween: 30,
              effect: 'fade',
              navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
              },
              pagination: {
                el: false,
                clickable: false,
              },
            });
          }
        });
      }

      initialized = owlReady || !!(window as any).Swiper;
    };

    const timerA = setTimeout(initScripts, 100);
    const timerB = setTimeout(initScripts, 1000);
    const timerC = setTimeout(resetMobileHeaderState, 250);

    resetMobileHeaderState();
    window.addEventListener('resize', resetMobileHeaderState);

    const handleMenuClick = () => {
      document.body.classList.add('no-scroll');
    };
    const handleCloseClick = () => {
      document.body.classList.remove('no-scroll');
    };

    const btnExtra = document.getElementById('btn-extra');
    const btnClose = document.getElementById('btn-close');

    if (btnExtra) btnExtra.addEventListener('click', handleMenuClick);
    if (btnClose) btnClose.addEventListener('click', handleCloseClick);

    return () => {
      clearTimeout(timerA);
      clearTimeout(timerB);
      clearTimeout(timerC);
      window.removeEventListener('resize', resetMobileHeaderState);
      if (btnExtra) btnExtra.removeEventListener('click', handleMenuClick);
      if (btnClose) btnClose.removeEventListener('click', handleCloseClick);
      if (cleanupMobileMenu) cleanupMobileMenu();
    };
  }, [pathname]);

  return null;
}
