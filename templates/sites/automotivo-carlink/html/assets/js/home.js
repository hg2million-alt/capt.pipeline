var x, i, j, l, ll, selElmnt, a, b, c;
for ($((function () {
    
    
    
    //$('#tab-content div').hide();
//$('#tab-content div:first').show();

$('.brands-choose-item').click(function() {
    $('.brands-choose-item').removeClass("brands-choose-item--active");
    $(this).addClass("brands-choose-item--active");
    $('.brands__content').hide(); 

    var indexer = $(this).index(); //gets the current index of (this) which is #nav li
    $('.brands__content:eq(' + indexer + ')').fadeIn(); //uses whatever index the link has to open the corresponding box 
});
       
    

    
    
    })), new Swiper(".latest-swiper", {
        slidesPerView: 3
        , slidesPerGroup: 3
        , loop: !0
        , speed: 750
        , spaceBetween: 35
        , navigation: {
            prevEl: ".latest-swiper__prev"
            , nextEl: ".latest-swiper__next"
        }
        , pagination: {
            el: ".latest-swiper__pagination"
            , type: "fraction"
        }
        , breakpoints: {
            301: {
                slidesPerView: 1
                , slidesPerGroup: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 20
            }
            , 751: {
                slidesPerView: 2
                , slidesPerGroup: 2
                , loop: !0
                , speed: 750
                , spaceBetween: 35
            }
            , 1151: {
                slidesPerView: 3
                , slidesPerGroup: 3
                , loop: !0
                , speed: 750
                , spaceBetween: 35
            }
        }
    }), 
    
    
new Swiper(".rcslide-swiper[data-rcslide-col='1']", {
    
        slidesPerView: 1
        , loop: !0
        , speed: 750
        , spaceBetween: 30
            
    , pagination: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
            el: ".rcslide-swiper__pagination"
            , type: "bullets"
            , clickable: !0
        }, 
    navigation: {
     nextEl: ".swiper-button-next",
     prevEl: ".swiper-button-prev",
   },
    breakpoints: {
            301: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 15
            }
            , 551: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 15
            }
            , 951: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 30
            }
            , 1651: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 30
            }
        }
    }),

new Swiper(".rcslide-swiper[data-rcslide-col='2']", {
        slidesPerView: 2
        , loop: !0
        , speed: 750
        , spaceBetween: 30
        , pagination: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
            el: ".rcslide-swiper__pagination"
            , type: "bullets"
            , clickable: !0
        }
        , breakpoints: {
            301: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 15
            }
            , 551: {
                slidesPerView: 2
                , loop: !0
                , speed: 750
                , spaceBetween: 15
            }
            , 951: {
                slidesPerView: 3
                , loop: !0
                , speed: 750
                , spaceBetween: 30
            }
            , 1651: {
                slidesPerView: 2
                , loop: !0
                , speed: 750
                , spaceBetween: 30
            }
        }
    }),
         
new Swiper(".rcslide-swiper[data-rcslide-col='3']", {
        slidesPerView: 2
        , loop: !0
        , speed: 750
        , spaceBetween: 30
        , pagination: {
            el: ".rcslide-swiper__pagination"
            , type: "bullets"
            , clickable: !0,
            
        }
    
    
        , breakpoints: {
            301: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 15
            }
            , 551: {
                slidesPerView: 2
                , loop: !0
                , speed: 750
                , spaceBetween: 15
            }
            , 951: {
                slidesPerView: 3
                , loop: !0
                , speed: 750
                , spaceBetween: 30
            }
            , 1651: {
                slidesPerView: 3
                , loop: !0
                , speed: 750
                , spaceBetween: 30
            }
        }
    }),
               
new Swiper(".hero-swiper", {
        slidesPerView: 1 , 
    loop: !0 , 
    speed: 750, 
    spaceBetween: 0, 
    effect: 'fade',
  fadeEffect: {
    crossFade: true
  },
    
    autoplay: {
        delay: 3500,
        disableOnInteraction: true
      },
    
    pagination: {
        el: ".swiper-pagination",
        clickable: true,
      }
    
    
        , breakpoints: {
            301: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 0
            }
            , 551: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 0
            }
            , 951: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 0
            }
            , 1651: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 0
            }
        }
    }),
    
  new Swiper(".hero-slider", {
        slidesPerView: 1 , 
    loop: !0 , 
    speed: 750, 
    spaceBetween: 0, 
    effect: 'fade',
  fadeEffect: {
    crossFade: true
  },
    
    autoplay: {
        delay: 3500,
        disableOnInteraction: true
      },
    
    pagination: {
        el: ".swiper-pagination",
        clickable: true,
      }
    
    
        , breakpoints: {
            301: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 0
            }
            , 551: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 0
            }
            , 951: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 0
            }
            , 1651: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 0
            }
        }
    }),
    
      
    
    
         
new Swiper(".listing-swiper", {
    
        slidesPerView: 4
        , loop: !0
        , speed: 750
        , spaceBetween: 30
            
    ,  navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
      pagination: {
        el: ".swiper-pagination",
          type: "bullets" , 
          clickable: !0
          
      },
   
    breakpoints: {
            301: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 15
            }
            , 551: {
                slidesPerView: 2
                , loop: !0
                , speed: 750
                , spaceBetween: 15
            }
            , 951: {
                slidesPerView: 4
                , loop: !0
                , speed: 750
                , spaceBetween: 30
            }
            , 1651: {
                slidesPerView: 4
                , loop: !0
                , speed: 750
                , spaceBetween: 30
            }
        }
    }),
    
  new Swiper(".carousel-swiper", {
    
        slidesPerView: 1
        , loop: !0
        , speed: 750
        , spaceBetween: 30
            
    ,  navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
      pagination: {
        el: ".swiper-pagination",
          type: "bullets" , 
          clickable: !0
          
      }, 
   
    breakpoints: {
            301: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 15
            }
            , 551: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 15
            }
            , 951: {
                slidesPerView: 1
                , loop: !0
                , speed: 750
                , spaceBetween: 30
            }
            , 1240: {
                slidesPerView: 3
                , loop: !0 
                , speed: 750
                , spaceBetween: 30
            }
        }
    }),
    
   

        l = (x = document.getElementsByClassName("custom-select")).length, i = 0; i < l; i++) {
    for (ll = (selElmnt = x[i].getElementsByTagName("select")[0]).length, (a = document.createElement("DIV")).setAttribute("class", "select-selected"), a.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML, x[i].appendChild(a), (b = document.createElement("DIV")).setAttribute("class", "select-items select-hide"), j = 1; j < ll; j++)(c = document.createElement("DIV")).innerHTML = selElmnt.options[j].innerHTML, c.addEventListener("click", (function (e) {
        var t, s, l, n, i, a, o;
        for (a = (n = this.parentNode.parentNode.getElementsByTagName("select")[0]).length, i = this.parentNode.previousSibling, s = 0; s < a; s++)
            if (n.options[s].innerHTML == this.innerHTML) {
                for (n.selectedIndex = s, i.innerHTML = this.innerHTML, o = (t = this.parentNode.getElementsByClassName("same-as-selected")).length, l = 0; l < o; l++) t[l].removeAttribute("class");
                this.setAttribute("class", "same-as-selected");
                break
            }
        i.click()
    })), b.appendChild(c);
    x[i].appendChild(b), a.addEventListener("click", (function (e) {
        e.stopPropagation(), closeAllSelect(this), this.nextSibling.classList.toggle("select-hide"), this.classList.toggle("select-arrow-active")
    }))
}


function closeAllSelect(e) {
    var t, s, l, n, i, a = [];
    for (t = document.getElementsByClassName("select-items"), s = document.getElementsByClassName("select-selected"), n = t.length, i = s.length, l = 0; l < i; l++) e == s[l] ? a.push(l) : s[l].classList.remove("select-arrow-active");
    for (l = 0; l < n; l++) a.indexOf(l) && t[l].classList.add("select-hide")
}
if (document.addEventListener("click", closeAllSelect), document.getElementById("slider-second")) {
    var slider = document.getElementById("slider-second");
    noUiSlider.create(slider, {
        start: [0, 8250]
        , connect: !0
        , range: {
            min: 0
            , max: 13e3
        }
        , format: {
            to: function (e) {
                return e.toFixed(2).replace(".", ".") + " $"
            }
            , from: function (e) {
                return parseFloat(e.replace(" $", "").replace(".", "."))
            }
        }
    });
    var valueElement = document.getElementById("slider-values-second");
    slider.noUiSlider.on("update", (function (e, t) {
        valueElement.innerHTML = e.join(" - ")
    }))
}