jQuery(document).ready(function ($) {
    
    "use strict";
    
    
	$.migrateMute = true;
	$.migrateTrace = false;
    
 
    
     $(window).scroll(function () {
            //if you hard code, then use console
            //.log to determine when you want the
            //nav bar to stick.
           //console.log($(window).scrollTop());
            if ($(window).scrollTop() > 180) {
                $('.fl-header-sticky').addClass('navbar-sticky');
            }
            if ($(window).scrollTop() < 180) {
                $('.fl-header-sticky').removeClass('navbar-sticky');
            }
        });
    
    
    
    
       splt({});  
    
    
 SlideAnime()  
	
    

      $('.hero-slide').slick({
          
          
          
          

    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    centerMode: true,
    autoplaySpeed:4000,
    pauseOnHover:false,
    fade: true,
    autoplay:true, 
   cssEase: 'linear',
    infinite: true,
    responsive: [{
      breakpoint: 959,
      settings: {
        arrows: false,
        centerMode: true,
        centerPadding: '120px',
        slidesToShow: 1
      }
    }, {
      breakpoint: 767,
      settings: {
        arrows: false,
        centerMode: true,
        centerPadding: '80px',
        slidesToShow: 1
      }
    }, {
      breakpoint: 639,
      settings: {
        arrows: false,
        centerMode: true,
        centerPadding: '40px',
        slidesToShow: 1
      }
    }]
  });
    
    
    

   $('.hero-slide').on('beforeChange', function(event, slick, currentSlide, nextSlide){
      SlideAnime()           
});
    

       function SlideAnime() {

 anime({
  reveal:false,
  targets: '.char',
  opacity: [0,1],
  scale: [1, 1.5],
  delay: anime.stagger(10),
  easing: 'cubicBezier(.71,-0.77,.43,1.67)',
     

});
       }
    
   


    
    
  $('.gallery-slider-nav').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    asNavFor: '.gallery-slider',
    dots: true,
    centerMode: true,
    focusOnSelect: true,
    cssEase: 'linear',
    centerPadding: '0px'
  });
  
    
   $("#cataloge-tabs").tabs({ 
                    active: 0 
                }) ;
    
    

    
  $( '#dl-menu' ).dlmenu();
    
  $('.gallery-slider').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    centerMode: true,
    centerPadding: '150px',
    infinite: true,
    asNavFor: '.gallery-slider-nav',
    cssEase: 'linear',
    responsive: [{
      breakpoint: 959,
      settings: {
        arrows: false,
        centerMode: true,
        centerPadding: '120px',
        slidesToShow: 1
      }
    }, {
      breakpoint: 767,
      settings: {
        arrows: false,
        centerMode: true,
        centerPadding: '80px',
        slidesToShow: 1
      }
    }, {
      breakpoint: 639,
      settings: {
        arrows: false,
        centerMode: true,
        centerPadding: '40px',
        slidesToShow: 1
      }
    }]
  });
  $('.gallery-slider-nav').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    asNavFor: '.gallery-slider',
    dots: true,
    centerMode: true,
    focusOnSelect: true,
    cssEase: 'linear',
    centerPadding: '0px'
  });
    
    
    


    
  const mediaQueryDesktop = window.matchMedia('(max-width: 959px)');

  function handleDesktopChange(e) {
    if (e.matches) {
      $('.js-filter-content').hide();
    } else {
      $('.js-filter-content').show();
    }
  }

  mediaQueryDesktop.addListener(handleDesktopChange);
  handleDesktopChange(mediaQueryDesktop);
  $('.js-filter-more').on('click', function () {
    $(this).next('.js-filter-content').slideToggle();
  });

  function rargePrice() {
    var $range = $("#range-price");
    var $inputFrom = $("#range-price-from");
    var $inputTo = $("#range-price-to");
    var instance;
    var min = 0;
    var max = 150000;
    var from = 3500;
    var to = 120000;
    $range.ionRangeSlider({
      skin: "round",
      type: "double",
      min: min,
      max: max,
      from: from,
      to: to,
      hide_min_max: true,
      hide_from_to: true,
      onStart: updateInputs,
      onChange: updateInputs,
      onFinish: updateInputs
    });
    instance = $range.data("ionRangeSlider");

    function updateInputs(data) {
      from = data.from;
      to = data.to;
      $inputFrom.prop("value", from);
      $inputTo.prop("value", to);
    }

    $inputFrom.on("change", function () {
      var val = $(this).prop("value"); // validate

      if (val < min) {
        val = min;
      } else if (val > to) {
        val = to;
      }

      instance.update({
        from: val
      });
      $(this).prop("value", val);
    });
    $inputTo.on("change", function () {
      var val = $(this).prop("value"); // validate

      if (val < from) {
        val = from;
      } else if (val > max) {
        val = max;
      }

      instance.update({
        to: val
      });
      $(this).prop("value", val);
    });
  }

  rargePrice();

  function rargeMileage() {
    var $range = $("#range-mileage");
    var $inputFrom = $("#range-mileage-from");
    var $inputTo = $("#range-mileage-to");
    var instance;
    var min = 0;
    var max = 8000;
    var from = 1000;
    var to = 5000;
    $range.ionRangeSlider({
      skin: "round",
      type: "double",
      min: min,
      max: max,
      from: from,
      to: to,
      hide_min_max: true,
      hide_from_to: true,
      onStart: updateInputs,
      onChange: updateInputs,
      onFinish: updateInputs
    });
    instance = $range.data("ionRangeSlider");

    function updateInputs(data) {
      from = data.from;
      to = data.to;
      $inputFrom.prop("value", from);
      $inputTo.prop("value", to);
    }

    $inputFrom.on("change", function () {
      var val = $(this).prop("value"); // validate

      if (val < min) {
        val = min;
      } else if (val > to) {
        val = to;
      }

      instance.update({
        from: val
      });
      $(this).prop("value", val);
    });
    $inputTo.on("change", function () {
      var val = $(this).prop("value"); // validate

      if (val < from) {
        val = from;
      } else if (val > max) {
        val = max;
      }

      instance.update({
        to: val
      });
      $(this).prop("value", val);
    });
  }

  rargeMileage();
}); 

const mediaQueryTablet = window.matchMedia('(max-width: 768px)');

function handleTabletChange(e) {
  if (e.matches) {
    //console.log('Media Query 768!');
  }
}


    
    /////////////////////////////////////////////////////////////////
// Preloader
/////////////////////////////////////////////////////////////////


    var $preloader = $('#page-preloader'),
    $spinner   = $preloader.find('.spinner-loader');
    $spinner.fadeOut();
    $preloader.delay(50).fadeOut('slow');

mediaQueryTablet.addListener(handleTabletChange);
handleTabletChange(mediaQueryTablet);