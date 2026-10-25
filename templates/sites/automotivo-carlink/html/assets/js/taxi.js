  function setSwiperHeight() {
      const e = document.querySelector(".km-rcslide-swiper").querySelectorAll(".swiper-slide");
      let s = 0;
      e.forEach(e => {
          const t = e.offsetHeight;
          t > s && (s = t)
      }), e.forEach(e => {
          e.style.height = s + "px"
      })
  }
  var x, i, j, l, ll, selElmnt, a, b, c;
  for (flatpickr("#datepicker", {
          dateFormat: "d/m/Y"
      }), $((function () {
          $(".km-burger").on("click", (function (e) {
              $("body").toggleClass("body--active")
          })), $(".selections-radio").on("click", (function (e) {
              for (let e of $(".selections-radio")) e.checked = !1;
              $(this)[0].checked = !0, $(".selections-form__radios-radio--acitve").removeClass("selections-form__radios-radio--acitve"), $(this)[0].parentNode.parentNode.classList.add("selections-form__radios-radio--acitve")
          }))
      })), window.addEventListener("load", setSwiperHeight), window.addEventListener("resize", setSwiperHeight), new Swiper(".km-cars-swiper", {
          slidesPerView: 3
          , loop: !0
          , speed: 750
          , spaceBetween: 30
          , pagination: {
              el: ".km-cars-swiper__pagination"
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
              , 601: {
                  slidesPerView: 2
                  , loop: !0
                  , speed: 750
                  , spaceBetween: 15
              }
              , 951: {
                  slidesPerView: 3
                  , loop: !0
                  , speed: 750
                  , spaceBetween: 15
              }
              , 1001: {
                  slidesPerView: 1.5
                  , loop: !0
                  , speed: 750
                  , spaceBetween: 30
              }
              , 1201: {
                  slidesPerView: 2
                  , loop: !0
                  , speed: 750
                  , spaceBetween: 30
              }
              , 1851: {
                  slidesPerView: 3
                  , loop: !0
                  , speed: 750
                  , spaceBetween: 30
              }
          }
      }), new Swiper(".km-rcslide-swiper", {
          slidesPerView: 2
          , loop: !0
          , speed: 750
          , spaceBetween: 30
          , pagination: {
              el: ".km-rcslide-swiper__pagination"
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
              , 751: {
                  slidesPerView: 2
                  , loop: !0
                  , speed: 750
                  , spaceBetween: 15
              }
          }
      }), l = (x = document.getElementsByClassName("custom-select2")).length, i = 0; i < l; i++) {
      for (ll = (selElmnt = x[i].getElementsByTagName("select")[0]).length, (a = document.createElement("DIV")).setAttribute("class", "select-selected"), a.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML, x[i].appendChild(a), (b = document.createElement("DIV")).setAttribute("class", "select-items select-hide"), j = 1; j < ll; j++)(c = document.createElement("DIV")).innerHTML = selElmnt.options[j].innerHTML, c.addEventListener("click", (function (e) {
          var s, t, i, l, n, c, o;
          for (c = (l = this.parentNode.parentNode.getElementsByTagName("select")[0]).length, n = this.parentNode.previousSibling, t = 0; t < c; t++)
              if (l.options[t].innerHTML == this.innerHTML) {
                  for (l.selectedIndex = t, n.innerHTML = this.innerHTML, o = (s = this.parentNode.getElementsByClassName("same-as-selected")).length, i = 0; i < o; i++) s[i].removeAttribute("class");
                  this.setAttribute("class", "same-as-selected");
                  break
              }
          n.click()
      })), b.appendChild(c);
      x[i].appendChild(b), a.addEventListener("click", (function (e) {
          e.stopPropagation(), closeAllSelect(this), this.nextSibling.classList.toggle("select-hide"), this.classList.toggle("select-arrow-active")
      }))
  }

  function closeAllSelect(e) {
      var s, t, i, l, n, c = [];
      for (s = document.getElementsByClassName("select-items"), t = document.getElementsByClassName("select-selected"), l = s.length, n = t.length, i = 0; i < n; i++) e == t[i] ? c.push(i) : t[i].classList.remove("select-arrow-active");
      for (i = 0; i < l; i++) c.indexOf(i) && s[i].classList.add("select-hide")
  }
  document.addEventListener("click", closeAllSelect);