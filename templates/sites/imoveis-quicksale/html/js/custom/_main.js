// Javascript String constants for translation
var THEMEREX_MESSAGE_BOOKMARK_ADD   = "Add the bookmark";
var THEMEREX_MESSAGE_BOOKMARK_ADDED = "Current page has been successfully added to the bookmarks. You can see it in the right panel on the tab \'Bookmarks\'";
var THEMEREX_MESSAGE_BOOKMARK_TITLE = "Enter bookmark title";
var THEMEREX_MESSAGE_BOOKMARK_EXISTS= "Current page already exists in the bookmarks list";
var THEMEREX_MESSAGE_SEARCH_ERROR = "Error occurs in AJAX search! Please, type your query and press search icon for the traditional search way.";
var THEMEREX_MESSAGE_EMAIL_CONFIRM= "On the e-mail address <b>%s</b> we sent a confirmation email.<br>Please, open it and click on the link.";
var THEMEREX_MESSAGE_EMAIL_ADDED  = "Your address <b>%s</b> has been successfully added to the subscription list";
var THEMEREX_REVIEWS_VOTE  = "Thanks for your vote! New average rating is:";
var THEMEREX_REVIEWS_ERROR  = "Error saving your vote! Please, try again later.";
var THEMEREX_MAGNIFIC_LOADING     = "Loading image #%curr% ...";
var THEMEREX_MAGNIFIC_ERROR       = "<a href=\"%url%\">The image #%curr%</a> could not be loaded.";
var THEMEREX_MESSAGE_ERROR_LIKE   = "Error saving your like! Please, try again later.";
var THEMEREX_GLOBAL_ERROR_TEXT  = "Global error text";
var THEMEREX_NAME_EMPTY  = "The name can\'t be empty";
var THEMEREX_NAME_LONG   = "Too long name";
var THEMEREX_PHONE_EMPTY  = "The phone can\'t be empty";
var THEMEREX_PHONE_LONG   = "Too long phone";
var THEMEREX_DATE_EMPTY  = "The date can\'t be empty";
var THEMEREX_DATE_LONG   = "Too long date";
var THEMEREX_TIME_EMPTY  = "The time can\'t be empty";
var THEMEREX_TIME_LONG   = "Too long time";
var THEMEREX_EMAIL_EMPTY   = "Too short (or empty) email address";
var THEMEREX_EMAIL_LONG  = "Too long email address";
var THEMEREX_EMAIL_NOT_VALID   = "Invalid email address";
var THEMEREX_SUBJECT_EMPTY  = "The subject can\'t be empty";
var THEMEREX_SUBJECT_LONG   = "Too long subject";
var THEMEREX_MESSAGE_EMPTY   = "The message text can\'t be empty";
var THEMEREX_MESSAGE_LONG   = "Too long message text";
var THEMEREX_SEND_COMPLETE   = "Send message complete!";
var THEMEREX_SEND_ORDER_COMPLETE  = "Thank you! We\'ll be in touch.";
var THEMEREX_SEND_ERROR   = "Transmit failed!";
var THEMEREX_LOGIN_EMPTY  = "The Login field can\'t be empty";
var THEMEREX_LOGIN_LONG  = "Too long login field";
var THEMEREX_PASSWORD_EMPTY  = "The password can\'t be empty and shorter then 5 characters";
var THEMEREX_PASSWORD_LONG  = "Too long password";
var THEMEREX_PASSWORD_NOT_EQUAL   = "The passwords in both fields are not equal";
var THEMEREX_REGISTRATION_SUCCESS = "Registration success! Please log in!";
var THEMEREX_REGISTRATION_FAILED  = "Registration failed!";
var THEMEREX_REGISTRATION_AUTHOR  = "Your account is waiting for the site admin moderation!";
var THEMEREX_GEOCODE_ERROR   = "Geocode was not successful for the following reason:";
var THEMEREX_GOOGLE_MAP_NOT_AVAIL = "Google map API not available!";
var THEMEREX_HOVER_LINK           = "Enlarge";

// AJAX parameters
var THEMEREX_ajax_url = "#";
var THEMEREX_ajax_nonce = "38699fa705";

// Site base url
var THEMEREX_site_url = "index.html";

// Theme base font
var THEMEREX_theme_font = "";

// Theme skin
var THEMEREX_theme_skin = "general";
var THEMEREX_theme_skin_bg = "#ffffff";

// Slider height
var THEMEREX_slider_height = 100;

// System message
var THEMEREX_systemMessage = {message:"", status: "", header: ""};

// User logged in
var THEMEREX_userLoggedIn = false;

// Show table of content for the current page
var THEMEREX_menu_toc = 'no';
var THEMEREX_menu_toc_home = THEMEREX_menu_toc!='no' && false;
var THEMEREX_menu_toc_top = THEMEREX_menu_toc!='no' && false;

// Fix main menu
if (jQuery("body.fixed_menu").length > 0) {
	// Use fix main menu
	var THEMEREX_menuFixed = true;
	
}else{
	// Not use fix main menu
	var THEMEREX_menuFixed = false;
}

// Right panel demo timer
var THEMEREX_demo_time = 3000;

// Video and Audio tag wrapper
var THEMEREX_useMediaElement = true;

// Use AJAX search
var THEMEREX_useAJAXSearch = true;
var THEMEREX_AJAXSearch_min_length = 3;
var THEMEREX_AJAXSearch_delay = 200;

// Popup windows engine
var THEMEREX_popupEngine  = 'magnific';
var THEMEREX_popupGallery = true;

// E-mail mask
THEMEREX_EMAIL_MASK = '^([a-zA-Z0-9_\\-]+\\.)*[a-zA-Z0-9_\\-]+@[a-z0-9_\\-]+(\\.[a-z0-9_\\-]+)*\\.[a-z]{2,6}$';

// Messages max length
var THEMEREX_msg_maxlength_contacts = 1000;
var THEMEREX_msg_maxlength_comments = 1000;

// Remember visitors settings
var THEMEREX_remember_visitors_settings = false;

// Primary and secondary responsive main menu
if (jQuery("body.responsive_menu_show").length > 0) {
	// Use responsive version main menu as primary
	var THEMEREX_menuResponsive = 3000;
	
}else{
	// Use responsive version main menu as secondary
	var THEMEREX_menuResponsive = 1136;
}
var THEMEREX_responsive_menu_click = true;

// Global variables storage
if (typeof THEMEREX_GLOBALS == 'undefined') var THEMEREX_GLOBALS = {};

/* Booking Calendar Settings */
var WPBookingCalendarSettings = {"path":"js\/vendor\/booking-calendar\/public","day_white_bg":"#FFFFFF","day_white_bg_hover":"#567BD2","day_black_bg":"#333333","day_black_bg_hover":"#567BD2","day_white_line1_color":"#999999","day_white_line1_color_hover":"#FFFFFF","day_white_line2_color":"#00CC33","day_white_line2_color_hover":"#FFFFFF","day_black_line1_color":"#FFFFFF","day_black_line1_color_hover":"#FFFFFF","day_black_line2_color":"#FFFFFF","day_black_line2_color_hover":"#FFFFFF","recaptcha_style":"white"};

jQuery(window).load(function() {
    "use strict";
    preloader();
})

jQuery(document).ready(function() {
    "use strict";
	main_slider_init();
	isotope_filtr_inited();
	popup_block_inited();
	hover_mobile();
	simform_init();
});

function preloader(){
    "use strict";
    //preloader
    jQuery(".preloaderimg").fadeOut();
    jQuery(".preloader").delay(200).fadeOut("slow").delay(200, function(){
        jQuery(this).remove();
    });
}


/*Main slider*/
function main_slider_init() {
    "use strict";
    if (jQuery("#mainslider_1").length > 0) {
		var setREVStartSize = function() {
			var	tpopt = new Object();
				tpopt.startwidth = 1280;
				tpopt.startheight = 690;
				tpopt.container = jQuery('#rev_slider');
				tpopt.fullScreen = "off";
				tpopt.forceFullWidth="off";

			tpopt.container.closest(".rev_slider_wrapper").css({height:tpopt.container.height()});tpopt.width=parseInt(tpopt.container.width(),0);tpopt.height=parseInt(tpopt.container.height(),0);tpopt.bw=tpopt.width/tpopt.startwidth;tpopt.bh=tpopt.height/tpopt.startheight;if(tpopt.bh>tpopt.bw)tpopt.bh=tpopt.bw;if(tpopt.bh<tpopt.bw)tpopt.bw=tpopt.bh;if(tpopt.bw<tpopt.bh)tpopt.bh=tpopt.bw;if(tpopt.bh>1){tpopt.bw=1;tpopt.bh=1}if(tpopt.bw>1){tpopt.bw=1;tpopt.bh=1}tpopt.height=Math.round(tpopt.startheight*(tpopt.width/tpopt.startwidth));if(tpopt.height>tpopt.startheight&&tpopt.autoHeight!="on")tpopt.height=tpopt.startheight;if(tpopt.fullScreen=="on"){tpopt.height=tpopt.bw*tpopt.startheight;var cow=tpopt.container.parent().width();var coh=jQuery(window).height();if(tpopt.fullScreenOffsetContainer!=undefined){try{var offcontainers=tpopt.fullScreenOffsetContainer.split(",");jQuery.each(offcontainers,function(e,t){coh=coh-jQuery(t).outerHeight(true);if(coh<tpopt.minFullScreenHeight)coh=tpopt.minFullScreenHeight})}catch(e){}}tpopt.container.parent().height(coh);tpopt.container.height(coh);tpopt.container.closest(".rev_slider_wrapper").height(coh);tpopt.container.closest(".forcefullwidth_wrapper_tp_banner").find(".tp-fullwidth-forcer").height(coh);tpopt.container.css({height:"100%"});tpopt.height=coh;}else{tpopt.container.height(tpopt.height);tpopt.container.closest(".rev_slider_wrapper").height(tpopt.height);tpopt.container.closest(".forcefullwidth_wrapper_tp_banner").find(".tp-fullwidth-forcer").height(tpopt.height);}
		};

		/* CALL PLACEHOLDER */
		setREVStartSize();

		var tpj=jQuery;
		tpj.noConflict();
		var revapi8;

		tpj(document).ready(function() {

		if(tpj('#rev_slider').revolution == undefined){
			revslider_showDoubleJqueryError('#rev_slider');
		}else{
		   revapi8 = tpj('#rev_slider').show().revolution(
			{	
				dottedOverlay:"none",
				delay:8000,
				startwidth:1280,
				startheight:690,
				hideThumbs:200,
				thumbWidth:200,
				thumbHeight:200,
				thumbAmount:4,
				simplifyAll:"off",
				navigationType:"none",
				navigationArrows:"solo",
				navigationStyle:"preview1",
				touchenabled:"on",
				onHoverStop:"on",
				nextSlideOnWindowFocus:"off",
				swipe_threshold: 75,
				swipe_min_touches: 1,
				drag_block_vertical: false,
				keyboardNavigation:"off",
				navigationHAlign:"center",
				navigationVAlign:"bottom",
				navigationHOffset:0,
				navigationVOffset:20,
				soloArrowLeftHalign:"left",
				soloArrowLeftValign:"center",
				soloArrowLeftHOffset:20,
				soloArrowLeftVOffset:0,
				soloArrowRightHalign:"right",
				soloArrowRightValign:"center",
				soloArrowRightHOffset:20,
				soloArrowRightVOffset:0,
				shadow:0,
				fullWidth:"on",
				fullScreen:"off",
				spinner:"spinner0",
				stopLoop:"off",
				stopAfterLoops:-1,
				stopAtSlide:-1,
				shuffle:"off",
				autoHeight:"off",
				forceFullWidth:"off",
				hideThumbsOnMobile:"off",
				hideNavDelayOnMobile:1500,
				hideBulletsOnMobile:"off",
				hideArrowsOnMobile:"off",
				hideThumbsUnderResolution:0,
				hideSliderAtLimit:0,
				hideCaptionAtLimit:0,
				hideAllCaptionAtLilmit:0,
				startWithSlide:0					
				});

			}
		});
    }

    if (jQuery("#mainslider_2").length > 0) {
		var setREVStartSize = function() {
			var tpopt = new Object();
			tpopt.startwidth = 1280;
			tpopt.startheight = 750;
			tpopt.container = jQuery('#rev_slider');
			tpopt.fullScreen = "on";
			tpopt.forceFullWidth="off";

			tpopt.container.closest(".rev_slider_wrapper").css({height:tpopt.container.height()});tpopt.width=parseInt(tpopt.container.width(),0);tpopt.height=parseInt(tpopt.container.height(),0);tpopt.bw=tpopt.width/tpopt.startwidth;tpopt.bh=tpopt.height/tpopt.startheight;if(tpopt.bh>tpopt.bw)tpopt.bh=tpopt.bw;if(tpopt.bh<tpopt.bw)tpopt.bw=tpopt.bh;if(tpopt.bw<tpopt.bh)tpopt.bh=tpopt.bw;if(tpopt.bh>1){tpopt.bw=1;tpopt.bh=1}if(tpopt.bw>1){tpopt.bw=1;tpopt.bh=1}tpopt.height=Math.round(tpopt.startheight*(tpopt.width/tpopt.startwidth));if(tpopt.height>tpopt.startheight&&tpopt.autoHeight!="on")tpopt.height=tpopt.startheight;if(tpopt.fullScreen=="on"){tpopt.height=tpopt.bw*tpopt.startheight;var cow=tpopt.container.parent().width();var coh=jQuery(window).height();if(tpopt.fullScreenOffsetContainer!=undefined){try{var offcontainers=tpopt.fullScreenOffsetContainer.split(",");jQuery.each(offcontainers,function(e,t){coh=coh-jQuery(t).outerHeight(true);if(coh<tpopt.minFullScreenHeight)coh=tpopt.minFullScreenHeight})}catch(e){}}tpopt.container.parent().height(coh);tpopt.container.height(coh);tpopt.container.closest(".rev_slider_wrapper").height(coh);tpopt.container.closest(".forcefullwidth_wrapper_tp_banner").find(".tp-fullwidth-forcer").height(coh);tpopt.container.css({height:"100%"});tpopt.height=coh;}else{tpopt.container.height(tpopt.height);tpopt.container.closest(".rev_slider_wrapper").height(tpopt.height);tpopt.container.closest(".forcefullwidth_wrapper_tp_banner").find(".tp-fullwidth-forcer").height(tpopt.height);}
		};

		setREVStartSize();
		var tpj=jQuery;
		tpj.noConflict();
		var revapi2;

		tpj(document).ready(function() {
			if(tpj('#rev_slider').revolution == undefined){
				revslider_showDoubleJqueryError('#rev_slider');
			}else{
				revapi2 = tpj('#rev_slider').show().revolution(
				{
				dottedOverlay:"none",
				delay:8000,
				startwidth:1280,
				startheight:750,
				hideThumbs:0,thumbWidth:180,
				thumbHeight:80,
				thumbAmount:3,
				simplifyAll:"off",
				navigationType:"thumb",
				navigationArrows:"none",
				navigationStyle:"round",
				touchenabled:"on",
				onHoverStop:"on",
				nextSlideOnWindowFocus:"off",
				swipe_threshold: 75,
				swipe_min_touches: 1,
				drag_block_vertical: false,
				keyboardNavigation:"off",
				navigationHAlign:"center",
				navigationVAlign:"bottom",
				navigationHOffset:0,
				navigationVOffset:0,
				soloArrowLeftHalign:"left",
				soloArrowLeftValign:"center",
				soloArrowLeftHOffset:20,
				soloArrowLeftVOffset:0,
				soloArrowRightHalign:"right",
				soloArrowRightValign:"center",
				soloArrowRightHOffset:20,
				soloArrowRightVOffset:0,shadow:0,
				fullWidth:"off",
				fullScreen:"on",
				spinner:"spinner0",
				stopLoop:"off",
				stopAfterLoops:-1,
				stopAtSlide:-1,shuffle:"off",
				forceFullWidth:"off",
				fullScreenAlignForce:"off",
				minFullScreenHeight:"",
				hideThumbsOnMobile:"off",
				hideNavDelayOnMobile:1500,
				hideBulletsOnMobile:"off",
				hideArrowsOnMobile:"off",
				hideThumbsUnderResolution:0,
				fullScreenOffsetContainer: "",
				fullScreenOffset: "",
				hideSliderAtLimit:0,
				hideCaptionAtLimit:0,
				hideAllCaptionAtLilmit:0,
				startWithSlide:0});
			}
		});    	
    }

    if (jQuery("#mainslider_3").length > 0) {
		var setREVStartSize = function() {
			var	tpopt = new Object();
				tpopt.startwidth = 1280;
				tpopt.startheight = 750;
				tpopt.container = jQuery('#rev_slider');
				tpopt.fullScreen = "on";
				tpopt.forceFullWidth="off";

			tpopt.container.closest(".rev_slider_wrapper").css({height:tpopt.container.height()});tpopt.width=parseInt(tpopt.container.width(),0);tpopt.height=parseInt(tpopt.container.height(),0);tpopt.bw=tpopt.width/tpopt.startwidth;tpopt.bh=tpopt.height/tpopt.startheight;if(tpopt.bh>tpopt.bw)tpopt.bh=tpopt.bw;if(tpopt.bh<tpopt.bw)tpopt.bw=tpopt.bh;if(tpopt.bw<tpopt.bh)tpopt.bh=tpopt.bw;if(tpopt.bh>1){tpopt.bw=1;tpopt.bh=1}if(tpopt.bw>1){tpopt.bw=1;tpopt.bh=1}tpopt.height=Math.round(tpopt.startheight*(tpopt.width/tpopt.startwidth));if(tpopt.height>tpopt.startheight&&tpopt.autoHeight!="on")tpopt.height=tpopt.startheight;if(tpopt.fullScreen=="on"){tpopt.height=tpopt.bw*tpopt.startheight;var cow=tpopt.container.parent().width();var coh=jQuery(window).height();if(tpopt.fullScreenOffsetContainer!=undefined){try{var offcontainers=tpopt.fullScreenOffsetContainer.split(",");jQuery.each(offcontainers,function(e,t){coh=coh-jQuery(t).outerHeight(true);if(coh<tpopt.minFullScreenHeight)coh=tpopt.minFullScreenHeight})}catch(e){}}tpopt.container.parent().height(coh);tpopt.container.height(coh);tpopt.container.closest(".rev_slider_wrapper").height(coh);tpopt.container.closest(".forcefullwidth_wrapper_tp_banner").find(".tp-fullwidth-forcer").height(coh);tpopt.container.css({height:"100%"});tpopt.height=coh;}else{tpopt.container.height(tpopt.height);tpopt.container.closest(".rev_slider_wrapper").height(tpopt.height);tpopt.container.closest(".forcefullwidth_wrapper_tp_banner").find(".tp-fullwidth-forcer").height(tpopt.height);}
		};

		setREVStartSize();


		var tpj=jQuery;
		tpj.noConflict();
		var revapi7;

		tpj(document).ready(function() {
			if(tpj('#rev_slider').revolution == undefined){
				revslider_showDoubleJqueryError('#rev_slider');
			}else{
			   	revapi7 = tpj('#rev_slider').show().revolution({	
					dottedOverlay:"none",
					delay:8000,
					startwidth:1280,
					startheight:750,
					hideThumbs:200,
					thumbWidth:100,
					thumbHeight:50,
					thumbAmount:3,
					simplifyAll:"off",
					navigationType:"none",
					navigationArrows:"solo",
					navigationStyle:"preview1",
					touchenabled:"on",
					onHoverStop:"on",
					nextSlideOnWindowFocus:"off",
					swipe_threshold: 75,
					swipe_min_touches: 1,
					drag_block_vertical: false,
					keyboardNavigation:"off",
					navigationHAlign:"center",
					navigationVAlign:"bottom",
					navigationHOffset:0,
					navigationVOffset:20,
					soloArrowLeftHalign:"left",
					soloArrowLeftValign:"center",
					soloArrowLeftHOffset:20,
					soloArrowLeftVOffset:0,
					soloArrowRightHalign:"right",
					soloArrowRightValign:"center",
					soloArrowRightHOffset:20,
					soloArrowRightVOffset:0,
					shadow:0,
					fullWidth:"off",
					fullScreen:"on",
					spinner:"spinner0",
					stopLoop:"off",
					stopAfterLoops:-1,
					stopAtSlide:-1,
					shuffle:"off",
					forceFullWidth:"off",
					fullScreenAlignForce:"off",
					minFullScreenHeight:"",
					hideThumbsOnMobile:"off",
					hideNavDelayOnMobile:1500,
					hideBulletsOnMobile:"off",
					hideArrowsOnMobile:"off",
					hideThumbsUnderResolution:0,
					fullScreenOffsetContainer: "",
					fullScreenOffset: "",
					hideSliderAtLimit:0,
					hideCaptionAtLimit:0,
					hideAllCaptionAtLilmit:737,
					startWithSlide:0					
				});

			}
		});
	}

	if (jQuery("#mainslider_4").length > 0) {
		var setREVStartSize = function() {
			var	tpopt = new Object();
				tpopt.startwidth = 1280;
				tpopt.startheight = 750;
				tpopt.container = jQuery('#rev_slider');
				tpopt.fullScreen = "on";
				tpopt.forceFullWidth="off";

			tpopt.container.closest(".rev_slider_wrapper").css({height:tpopt.container.height()});tpopt.width=parseInt(tpopt.container.width(),0);tpopt.height=parseInt(tpopt.container.height(),0);tpopt.bw=tpopt.width/tpopt.startwidth;tpopt.bh=tpopt.height/tpopt.startheight;if(tpopt.bh>tpopt.bw)tpopt.bh=tpopt.bw;if(tpopt.bh<tpopt.bw)tpopt.bw=tpopt.bh;if(tpopt.bw<tpopt.bh)tpopt.bh=tpopt.bw;if(tpopt.bh>1){tpopt.bw=1;tpopt.bh=1}if(tpopt.bw>1){tpopt.bw=1;tpopt.bh=1}tpopt.height=Math.round(tpopt.startheight*(tpopt.width/tpopt.startwidth));if(tpopt.height>tpopt.startheight&&tpopt.autoHeight!="on")tpopt.height=tpopt.startheight;if(tpopt.fullScreen=="on"){tpopt.height=tpopt.bw*tpopt.startheight;var cow=tpopt.container.parent().width();var coh=jQuery(window).height();if(tpopt.fullScreenOffsetContainer!=undefined){try{var offcontainers=tpopt.fullScreenOffsetContainer.split(",");jQuery.each(offcontainers,function(e,t){coh=coh-jQuery(t).outerHeight(true);if(coh<tpopt.minFullScreenHeight)coh=tpopt.minFullScreenHeight})}catch(e){}}tpopt.container.parent().height(coh);tpopt.container.height(coh);tpopt.container.closest(".rev_slider_wrapper").height(coh);tpopt.container.closest(".forcefullwidth_wrapper_tp_banner").find(".tp-fullwidth-forcer").height(coh);tpopt.container.css({height:"100%"});tpopt.height=coh;}else{tpopt.container.height(tpopt.height);tpopt.container.closest(".rev_slider_wrapper").height(tpopt.height);tpopt.container.closest(".forcefullwidth_wrapper_tp_banner").find(".tp-fullwidth-forcer").height(tpopt.height);}
		};

		/* CALL PLACEHOLDER */
		setREVStartSize();


		var tpj=jQuery;
		tpj.noConflict();
		var revapi9;

		tpj(document).ready(function() {

		if(tpj('#rev_slider').revolution == undefined){
			revslider_showDoubleJqueryError('#rev_slider');
		}else{
		   	revapi9 = tpj('#rev_slider').show().revolution({	
				dottedOverlay:"none",
				delay:8000,
				startwidth:1280,
				startheight:750,
				hideThumbs:0,
				thumbWidth:180,
				thumbHeight:80,
				thumbAmount:4,
				simplifyAll:"off",
				navigationType:"thumb",
				navigationArrows:"none",
				navigationStyle:"round",
				touchenabled:"on",
				onHoverStop:"on",
				nextSlideOnWindowFocus:"off",
				swipe_threshold: 75,
				swipe_min_touches: 1,
				drag_block_vertical: false,
				keyboardNavigation:"off",
				navigationHAlign:"center",
				navigationVAlign:"bottom",
				navigationHOffset:0,
				navigationVOffset:0,
				soloArrowLeftHalign:"left",
				soloArrowLeftValign:"center",
				soloArrowLeftHOffset:20,
				soloArrowLeftVOffset:0,
				soloArrowRightHalign:"right",
				soloArrowRightValign:"center",
				soloArrowRightHOffset:20,
				soloArrowRightVOffset:0,
				shadow:0,
				fullWidth:"off",
				fullScreen:"on",
				spinner:"spinner0",
				stopLoop:"off",
				stopAfterLoops:-1,
				stopAtSlide:-1,
				shuffle:"off",
				forceFullWidth:"off",
				fullScreenAlignForce:"off",
				minFullScreenHeight:"",
				hideThumbsOnMobile:"off",
				hideNavDelayOnMobile:1500,
				hideBulletsOnMobile:"off",
				hideArrowsOnMobile:"off",
				hideThumbsUnderResolution:0,
				fullScreenOffsetContainer: "",
				fullScreenOffset: "",
				hideSliderAtLimit:0,
				hideCaptionAtLimit:0,
				hideAllCaptionAtLilmit:0,
				startWithSlide:0					
				});

			}
		});		
	}


}

/* Add isotope filtr button*/
function isotope_filtr_inited() {
    "use strict";
	if (jQuery(".isotopeFiltr").length > 0) {
		jQuery(".isotopeFiltr").append("<ul><li class=\"squareButton active\"><a href=\"#\" data-filter=\"*\">All</a></li><li class=\"squareButton\"><a href=\"#\" data-filter=\".flt_64\">Living room</a></li><li class=\"squareButton\"><a href=\"#\" data-filter=\".flt_65\">Driveway</a></li><li class=\"squareButton\"><a href=\"#\" data-filter=\".flt_46\">Basement</a></li><li class=\"squareButton\"><a href=\"#\" data-filter=\".flt_11\">Bedroom</a></li><li class=\"squareButton\"><a href=\"#\" data-filter=\".flt_8\">Garage</a></li><li class=\"squareButton\"><a href=\"#\" data-filter=\".flt_10\">Kitchen</a></li></ul>");
	}
}

/* Add login popup block */
function popup_block_inited() {
    "use strict";
	if (jQuery(".usermenu_show").length > 0) {

		var usermenu  ='<div id="form_popup_top" class="sc_popup sc_popup_light mfp-with-anim mfp-hide">';
		usermenu  +=	'<div class="dark sc_contact_form sc_call_form sc_contact_form_contact">';
		usermenu  +=		'<h4 class="title">Request call back</h4>';
		usermenu  +=		'<div class="description">Enter your details below request a call back.</div>';
		usermenu  +=		'<form data-formtype="call" method="post" action="#">';
		usermenu  +=			'<input placeholder="Name" class="sc_contact_form_username" type="text" name="username">';
		usermenu  +=			'<input placeholder="Phone" class="sc_contact_form_phone" type="text" name="phone">';
		usermenu  +=			'<div class="message">';
		usermenu  +=				'<textarea placeholder="Message" class="sc_contact_form_message" name="message"></textarea>';
		usermenu  +=			'</div>';
		usermenu  +=			'<div class="sc_contact_form_button">';
		usermenu  +=				'<div class="squareButton sc_button_style_accent_2 sc_button_size_big global big">';
		usermenu  +=					'<a href="#" class="sc_contact_form_submit">Submit</a>';
		usermenu  +=				'</div>';
		usermenu  +=			'</div>';
		usermenu  +=			'<div class="result sc_infobox"></div>';
		usermenu  +=		'</form>';
		usermenu  +=	'</div>';
		usermenu  +='</div>';
		usermenu  +='<div id="user-popUp" class="user-popUp mfp-with-anim mfp-hide">';
		usermenu  +=	'<div class="sc_tabs">';
		usermenu  +=		'<ul class="loginHeadTab" role="tablist">';
		usermenu  +=			'<li role="tab" tabindex="0" aria-controls="loginForm" aria-labelledby="user_popup_1" aria-selected="true" aria-expanded="true">';
		usermenu  +=				'<a href="#loginForm" class="loginFormTab icon" role="presentation" id="user_popup_1">Log In</a>';
		usermenu  +=			'</li>';
		usermenu  +=			'<li role="tab" aria-controls="registerForm" aria-labelledby="user_popup_2" aria-selected="false" aria-expanded="false">';
		usermenu  +=				'<a href="#registerForm" class="registerFormTab icon" role="presentation" id="user_popup_2">Create an Account</a>';
		usermenu  +=			'</li>';
		usermenu  +=		'</ul>';
		usermenu  +=		'<div id="loginForm" class="formItems loginFormBody" aria-labelledby="user_popup_1" role="tabpanel" aria-hidden="false">';
		usermenu  +=			'<div class="itemformLeft">';
		usermenu  +=				'<form action="#" method="post" name="login_form" class="formValid">';
		usermenu  +=					'<input type="hidden" name="redirect_to" value="#">';
		usermenu  +=					'<ul class="formList">';
		usermenu  +=						'<li class="icon formLogin">';
		usermenu  +=							'<input type="text" id="login" name="log" value="" placeholder="Login">';
		usermenu  +=						'</li>';
		usermenu  +=						'<li class="icon formPass">';
		usermenu  +=							'<input type="password" id="password" name="pwd" value="" placeholder="Password">';
		usermenu  +=						'</li>';
		usermenu  +=						'<li class="remember">';
		usermenu  +=							'<a href="#" class="forgotPwd">Forgot password?</a>';
		usermenu  +=							'<input type="checkbox" value="forever" id="rememberme" name="rememberme">';
		usermenu  +=							'<label for="rememberme">Remember me</label>';
		usermenu  +=						'</li>';
		usermenu  +=						'<li class="sc_button sc_button_style_global sc_button_size_big squareButton global big">';
		usermenu  +=							'<a href="#" class="sendEnter enter">Login</a>';
		usermenu  +=						'</li>';
		usermenu  +=					'</ul>';
		usermenu  +=				'</form>';
		usermenu  +=			'</div>';
		usermenu  +=			'<div class="itemformRight">';
		usermenu  +=				'<ul class="formList">';
		usermenu  +=					'<li>You can login using your social profile</li>';
		usermenu  +=					'<li class="loginSoc">';
		usermenu  +=						'<a href="#" class="iconLogin fb"></a>';
		usermenu  +=						'<a href="#" class="iconLogin tw"></a>';
		usermenu  +=						'<a href="#" class="iconLogin gg"></a>';
		usermenu  +=					'</li>';
		usermenu  +=					'<li>';
		usermenu  +=						'<a href="#" class="loginProblem">Problem with login?</a>';
		usermenu  +=					'</li>';
		usermenu  +=				'</ul>';
		usermenu  +=			'</div>';
		usermenu  +=			'<div class="result messageBlock"></div>';
		usermenu  +=		'</div>';
		usermenu  +=		'<div id="registerForm" class="formItems registerFormBody" aria-labelledby="user_popup_2" role="tabpanel" aria-hidden="true">';
		usermenu  +=			'<form name="register_form" method="post" class="formValid">';
		usermenu  +=				'<input type="hidden" name="redirect_to" value="#">';
		usermenu  +=				'<div class="itemformLeft">';
		usermenu  +=					'<ul class="formList">';
		usermenu  +=						'<li class="icon formUser">';
		usermenu  +=							'<input type="text" id="registration_username" name="registration_username" value="" placeholder="User name (login)">';
		usermenu  +=						'</li>';
		usermenu  +=						'<li class="icon formLogin">';
		usermenu  +=							'<input type="text" id="registration_email" name="registration_email" value="" placeholder="E-mail">';
		usermenu  +=						'</li>';
		usermenu  +=						'<li class="i-agree">';
		usermenu  +=							'<input type="checkbox" value="forever" id="i-agree" name="i-agree">';
		usermenu  +=							'<label for="i-agree">I agree with</label> <a href="#">Terms &amp; Conditions</a>';
		usermenu  +=						'</li>';
		usermenu  +=						'<li class="sc_button sc_button_style_global sc_button_size_big squareButton global big">';
		usermenu  +=							'<a href="#" class="sendEnter enter">Sign Up</a>';
		usermenu  +=						'</li>';
		usermenu  +=					'</ul>';
		usermenu  +=				'</div>';
		usermenu  +=				'<div class="itemformRight">';
		usermenu  +=					'<ul class="formList">';
		usermenu  +=						'<li class="icon formPass">';
		usermenu  +=							'<input type="password" id="registration_pwd" name="registration_pwd" value="" placeholder="Password">';
		usermenu  +=						'</li>';
		usermenu  +=						'<li class="icon formPass">';
		usermenu  +=							'<input type="password" id="registration_pwd2" name="registration_pwd2" value="" placeholder="Confirm Password">';
		usermenu  +=						'</li>';
		usermenu  +=					'</ul>';
		usermenu  +=				'</div>';
		usermenu  +=			'</form>';
		usermenu  +=			'<div class="result messageBlock"></div>';
		usermenu  +=		'</div>';
		usermenu  +=	'</div>';
		usermenu  +='</div>';

		jQuery('body').append(usermenu);

	}
}

/* Simform init*/
function simform_init() {
    "use strict";
	if (jQuery("#sc_contact_simform").length > 0) {
		var theForm = document.getElementById( "sc_contact_simform" );
		var orderForm = jQuery("#sc_contact_simform");
		new stepsForm( theForm, {
			onSubmit : function( form ) {
				// hide form
				var action = orderForm.attr("action");
				orderSubmitForm(theForm, orderForm, action!=undefined ? action : THEMEREX_ajax_url, THEMEREX_ajax_nonce);
			}
		});
	}
};
