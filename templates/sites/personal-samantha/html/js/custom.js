/*-----------------------------------------------------------------------------------

    Template Name: Samantha - Crowdfunding & Charity HTML Template



    Note: This is Custom Js file

-----------------------------------------------------------------------------------

    Js INDEX

    ===================



    ## counter 
    ## count-number
    ## menu-btn 
    ## loop-slider
    ## progress-bar
    ## photo
    ## nonloop
    ## ProgressBar
    ## weekdays
    ## beforeAfter
    ## loader
    ## aos
    ## mobile-nav
    ## Location Map Pin

-----------------------------------------------------------------------------------*/

/*Counter Init 1*/
(function($) {
  $.fn.countTo = function(options) {
    options = options || {};

    return $(this).each(function() {
      // set options for current element
      var settings = $.extend(
        {},
        $.fn.countTo.defaults,
        {
          from: $(this).data("from"),
          to: $(this).data("to"),
          speed: $(this).data("speed"),
          refreshInterval: $(this).data("refresh-interval"),
          decimals: $(this).data("decimals")
        },
        options
      );

      // how many times to update the value, and how much to increment the value on each update
      var loops = Math.ceil(settings.speed / settings.refreshInterval),
        increment = (settings.to - settings.from) / loops;

      // references & variables that will change with each update
      var self = this,
        $self = $(this),
        loopCount = 0,
        value = settings.from,
        data = $self.data("countTo") || {};

      $self.data("countTo", data);

      // if an existing interval can be found, clear it first
      if (data.interval) {
        clearInterval(data.interval);
      }
      data.interval = setInterval(updateTimer, settings.refreshInterval);

      // initialize the element with the starting value
      render(value);

      function updateTimer() {
        value += increment;
        loopCount++;

        render(value);

        if (typeof settings.onUpdate == "function") {
          settings.onUpdate.call(self, value);
        }

        if (loopCount >= loops) {
          // remove the interval
          $self.removeData("countTo");
          clearInterval(data.interval);
          value = settings.to;

          if (typeof settings.onComplete == "function") {
            settings.onComplete.call(self, value);
          }
        }
      }

      function render(value) {
        var formattedValue = settings.formatter.call(self, value, settings);
        $self.html(formattedValue);
      }
    });
  };

  $.fn.countTo.defaults = {
    from: 0, // the number the element should start at
    to: 0, // the number the element should end at
    speed: 1000, // how long it should take to count between the target numbers
    refreshInterval: 100, // how often the element should be updated
    decimals: 0, // the number of decimal places to show
    formatter: formatter, // handler for formatting the value before rendering
    onUpdate: null, // callback method for every time the element is updated
    onComplete: null // callback method for when the element finishes updating
  };

  function formatter(value, settings) {
    return value.toFixed(settings.decimals);
  }
})(jQuery);


// count-number 2
jQuery(function($) {
  // custom formatting example
  $(".count-number").data("countToOptions", {
    formatter: function(value, options) {
      return value
        .toFixed(options.decimals)
        .replace(/\B(?=(?:\d{3})+(?!\d))/g, ",");
    }
  });

  // start all the timers
  $(".timer").each(count);

  function count(options) {
    var $this = $(this);
    options = $.extend({}, options || {}, $this.data("countToOptions") || {});
    $this.countTo(options);
  }
});



// menu-btn 3
$('.menu-btn').on('click', function () {
    $('body.menu-layer').addClass('active');
    return false;
  });
  $('.menu-cls-btn').on('click', function () {
    $('body.menu-layer').removeClass('active');
    return false;
  });
// loop-slider 4
$(document).ready(function(){
if ( $.isFunction($.fn.owlCarousel) ) {
$('.loop-slider').owlCarousel({
    center: true,
    nav:true,
    margin:30,
    dot:true,
    loop:true,
    mouseDrag : false,
    responsiveClass:true,
    responsive:{
        300:{
            items:1,
            nav:false,
            margin:0,
            center: false,
        },
        800:{
            items:2,
        }
      }

  })
}



// photo 5
if ( $.isFunction($.fn.owlCarousel) ) {
$('.photo').owlCarousel({
     items: 1,
    loop: false,
    margin: 10,
     callbacks: true,
    URLhashListener: true,
    autoplayHoverPause: true,
    mouseDrag : false,
    startPosition: 'URLHash'
  });
}


// nonloop 6
if ( $.isFunction($.fn.owlCarousel) ) {
$('.nonloop').owlCarousel({
    items:2,
    dots:false,
    loop: true,
    margin:0,
    autoplay:true,
    autoplayTimeout:3000,
    responsiveClass:true,
    responsive:{
        300:{
            items:1,
            nav:false,
            margin:0,
            center: false,
        },
        800:{
            items:2,
        }
      }
});
}
});


// ProgressBar 7
var ProgressBar = function(ele) {
  this.$ele = $(ele);
  this.progressValue = this.$ele.data('progress-value');
  this.tooltipValue = this.$ele.data('tooltip-value');
  this.progressBar = this.$ele.find('.progress-status');
  this.tooltipWrapper = this.$ele.find('.tooltip');
  
  this.init();
}

ProgressBar.prototype = {
  
  init: function(){
    this.setBarValue();
    this.setTooltip();
  },
  
  setBarValue: function(){
    $(this.progressBar).css('width', this.progressValue+'%');
  },
  
  setTooltip: function(){
    
    if(this.tooltipValue === undefined || this.tooltipValue === ''){
      return;   
    }
        
    $(this.tooltipWrapper)
      .addClass('show')
      .append('<p>' + this.tooltipValue + '</p>');
  }
}

ProgressBar.plugin = function() {
  $('[data-plugin="progress-bar"]').each(function(index, item) {
    item.module = new ProgressBar($(item));
  });
}

$(function() {  
  ProgressBar.plugin();
});


//weekdays 8 
if ($("#weekdays")[0]){
$(function(){
  $('#weekdays').weekdays({
    singleSelect: true
  });
});
}



// beforeAfter 9
if ( $.isFunction($.fn.beforeAfter) ) {
jQuery('.beforeAfter').beforeAfter({

  // is draggable/swipeable
  movable: true,

  // click image to move the slider
  clickMove: true,

  // always show the slider
  alwaysShow: true,

  // intial position of the slider
  position: 100,

  // opacity between 0 and 1
  opacity: 0.4,
  activeOpacity: 1,
  hoverOpacity: 0.8,

  // slider colors
  separatorColor: '#bed800',
  bulletColor: '#bed800',
  arrowColor: '#ffffff',
  
});
}


// loader 10
$(window).on('load',function(){
  setTimeout(function(){ // allowing 3 secs to fade out loader
  $('.page-loader').fadeOut('slow');
  });
});



// Responsive header menu
$(document).ready(function(){
 

          jQuery('.mobile-nav .menu-item-has-children').on('click', function($) {

          jQuery(this).toggleClass('active');

        }); 



        jQuery('#nav-icon4').click(function($){

           // jQuery(this).toggleClass('open');

            jQuery('#mobile-nav').toggleClass('open');

        });



        jQuery('.res-cross').click(function($){

           jQuery('#mobile-nav').removeClass('open');

            //jQuery('#nav-icon4').removeClass('open')

        });


        jQuery('.bar-menu').click(function($){

           // jQuery(this).toggleClass('open');

            jQuery('#mobile-nav').toggleClass('open');
            jQuery('#mobile-nav').toggleClass('hmburger-menu');
            jQuery('#mobile-nav').show();

        });



        jQuery('.res-cross').click(function($){

           jQuery('#mobile-nav').removeClass('open');

            //jQuery('#nav-icon4').removeClass('open')

        });
});


// Location Map Pin
    if ($(".map-pin")[0]){
       $('.map-pin span').on('click', function() {
          $(this).parent().addClass('active');
       });
       $('.map-pin .close-icon').on('click', function() {
          $(this).parent().removeClass('active');
       });
    }


// .scroll-top
const d = document,
  w = window;

d.addEventListener("DOMContentLoaded", (e) =>{
    scrollToTop(".scroll-top-btn");
});


function scrollToTop(btnScroll) {
  const $scrollBtn = d.querySelector(btnScroll);

  d.addEventListener("scroll", (e) => {
    let scrollTop = w.pageYOffset || d.documentElement.scrollTop;

    if (scrollTop > 100) {
      $scrollBtn.classList.remove("hidden");
    } else {
      $scrollBtn.classList.add("hidden");
    }
    /* console.log(w.pageYOffset, d.documentElement.scrollTop); */
  });
  d.addEventListener("click", (e) => {
    if (e.target.matches(btnScroll)) {
      w.scrollTo({
        behavior: "smooth",
        top: 0,
      });
    }
  });
}


//AOS animation 11
    AOS.init({
      once:true
  });
