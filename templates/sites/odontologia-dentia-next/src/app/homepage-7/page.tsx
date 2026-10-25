import Link from 'next/link';

export default function Homepage7() {
  return (
    <>
      <section className="text-light bg-dark overflow-hidden jarallax v-center relative">
        <div className="absolute w-100 h-100 top-0 start-0 z-0" style={{ backgroundImage: 'url(/images/background/4.webp)', backgroundSize: 'cover', backgroundPosition: 'center', backgroundAttachment: 'fixed' }}></div>
        <div className="sw-overlay op-4"></div>
        <div className="abs w-100 bottom-0">
          <div className="container relative z-2">
            <div className="row g-4 align-items-end">

              <div className="col-md-8">
                <div className="d-flex align-items-center wow fadeInUp" data-wow-delay=".2s">
                  <div className="relative me-4">
                    <img src="/images/testimonial/1.webp" className="w-50px circle" alt="" />
                    <img src="/images/testimonial/2.webp" className="w-50px circle ms-min-20" alt="" />
                    <img src="/images/testimonial/3.webp" className="w-50px circle ms-min-20" alt="" />
                    <img src="/images/testimonial/4.webp" className="w-50px circle ms-min-20" alt="" />
                  </div>
                  <div className="fw-600 fs-14 lh-1-5">Trusted by 23k customers</div>
                </div>
                <div className="spacer-double"></div>
                <h1 className="fs-72 fs-xs-12vw wow fadeInUp" data-wow-delay=".4s">Unforgettable Dental With Expert And Caring</h1>
                <p className="wow fadeInUp" data-wow-delay=".6s">Ullamco in eiusmod sint sint irure esse in aliquip consequat officia.</p>
                <Link className="btn-main me-4 wow fadeInUp" data-wow-delay=".8s" href="/booking">Book Appointment</Link>
              </div>

              <div className="col-lg-4">
                <div className="relative">
                  <div className="text-end">
                    <div className="d-inline-block p-40 bg-light rounded-1 xs-hide text-center wow fadeInUp" data-wow-delay=".0s">
                      <h1 className="fs-72 text-dark mb-1">98%</h1>
                      <div className="fs-16 text-dark lh-1-5">Trusted Score</div>
                    </div>
                  </div>
                </div>
              </div>

              <div className="spacer-double"></div>
            </div>
          </div>
        </div>
      </section>

      <section className="pt-5 pb-0 text-center relative">
        <p className="text-dark mb-4 wow fadeInUp">Connected by 100+ Companies</p>
        <div className="d-flex">
          <div className="de-marquee-list wow fadeInUp" data-wow-delay=".3s">
            <img src="/images/logo/1.png" className="w-200px mx-5" alt="" />
            <img src="/images/logo/2.png" className="w-200px mx-5" alt="" />
            <img src="/images/logo/3.png" className="w-200px mx-5" alt="" />
            <img src="/images/logo/4.png" className="w-200px mx-5" alt="" />
            <img src="/images/logo/5.png" className="w-200px mx-5" alt="" />
            <img src="/images/logo/6.png" className="w-200px mx-5" alt="" />
            <img src="/images/logo/7.png" className="w-200px mx-5" alt="" />
            <img src="/images/logo/8.png" className="w-200px mx-5" alt="" />
            <img src="/images/logo/9.png" className="w-200px mx-5" alt="" />
            <img src="/images/logo/10.png" className="w-200px mx-5" alt="" />
          </div>
        </div>
      </section>

      <section>
        <div className="container">
          <div className="row g-4 gx-5 align-items-center">
            <div className="col-md-3">
              <div className=" rounded-1 overflow-hidden wow zoomIn">
                <img src="/images/misc/p1.webp" className="w-100 wow scaleIn" alt="" />
              </div>
            </div>

            <div className="col-lg-6">
              <div className="text-center">
                <div className="subtitle s2 mb-3 wow fadeInUp" data-wow-delay=".0s">About Us</div>
                <h2 className="wow fadeInUp" data-wow-delay=".2s">Dedicated Professionals Delivering Personalized Dental Excellence With Gentle Precision And Attentive Care</h2>
                <Link className="btn-main fx-slide wow fadeInUp" data-wow-delay=".4s" href="/contact"><span>Book Appointment</span></Link>
              </div>
            </div>

            <div className="col-lg-3">
              <div className=" rounded-1 overflow-hidden wow zoomIn" data-wow-delay=".3s">
                <img src="/images/misc/p2.webp" className="w-100 wow scaleIn" alt="" data-wow-delay=".3s" />
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="pt-0">
        <div className="container">
          <div className="row g-4 justify-content-center">
            <div className="col-lg-8 text-center">
              <div className="subtitle wow fadeInUp mb-3">Our Services</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Complete Care for Every Smile</h2>
              <p className="col-lg-8 offset-lg-2 mb-0 wow fadeInUp">From routine cleanings to advanced restorations, we provide personalized dental solutions for patients of all ages.</p>
              <div className="spacer-single"></div>
            </div>
          </div>

          <div className="row g-4">
            <div className="col-lg-3 col-sm-6">
              <div className="hover bg-white h-100 rounded-1 shadow-soft">
                <div className="p-40">
                  <img src="/images/icons/tooth-1.png" className="w-70px mb-3 wow scaleIn" alt="" />
                  <div className="relative mt-4 wow fadeInUp">
                    <h4>General Dentistry</h4>
                    <p>Complete oral care for every smile with cleanings, exams, and more.</p>
                    <Link className="btn-plus" href="/services/general-dentistry">
                      <i className="fa fa-plus"></i>
                      <span>Read more</span>
                    </Link>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-3 col-sm-6">
              <div className="hover bg-white h-100 rounded-1 shadow-soft">
                <div className="p-40">
                  <img src="/images/icons/tooth-2.png" className="w-70px mb-3 wow scaleIn" alt="" />
                  <div className="relative mt-4 wow fadeInUp">
                    <h4>Cosmetic Dentistry</h4>
                    <p>Enhance your smile’s beauty with whitening, veneers, and more.</p>
                    <Link className="btn-plus" href="/services/cosmetic-dentistry">
                      <i className="fa fa-plus"></i>
                      <span>Read more</span>
                    </Link>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-3 col-sm-6">
              <div className="hover bg-white h-100 rounded-1 shadow-soft">
                <div className="p-40">
                  <img src="/images/icons/tooth-3.png" className="w-70px mb-3 wow scaleIn" alt="" />
                  <div className="relative mt-4 wow fadeInUp">
                    <h4>Pediatric Dentistry</h4>
                    <p>Gentle and fun dental care for kids to grow healthy, happy smiles.</p>
                    <Link className="btn-plus" href="/services/pediatric-dentistry">
                      <i className="fa fa-plus"></i>
                      <span>Read more</span>
                    </Link>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-3 col-sm-6">
              <div className="hover bg-white h-100 rounded-1 shadow-soft">
                <div className="p-40">
                  <img src="/images/icons/tooth-4.png" className="w-70px mb-3 wow scaleIn" alt="" />
                  <div className="relative mt-4 wow fadeInUp">
                    <h4>Restorative Dentistry</h4>
                    <p>Repair and restore your teeth for lasting comfort and function.</p>
                    <Link className="btn-plus" href="/services/restorative-dentistry">
                      <i className="fa fa-plus"></i>
                      <span>Read more</span>
                    </Link>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-12 mt-5 text-center">
              <Link className="btn-main fx-slide" href="/services"><span>View All Services</span></Link>
            </div>


          </div>
        </div>
      </section>

      <section className="bg-dark text-light pt-60 pb-60">
        <div className="container">

          <div className="row g-4">
            <div className="col-md-3 col-sm-6 text-center">
              <div className="de_count wow fadeInRight" data-wow-delay=".0s">
                <h3 className="fs-40 mb-0"><span className="timer" data-to="10000" data-speed="3000">0</span>+</h3>
                Happy Patients
              </div>
            </div>
            <div className="col-md-3 col-sm-6 text-center">
              <div className="de_count wow fadeInRight" data-wow-delay=".2s">
                <h3 className="fs-40 mb-0"><span className="timer" data-to="2500" data-speed="3500">0</span>+</h3>
                Teeth Whitened
              </div>
            </div>
            <div className="col-md-3 col-sm-6 text-center">
              <div className="de_count wow fadeInRight" data-wow-delay=".4s">
                <h3 className="fs-40 mb-0"><span className="timer" data-to="800" data-speed="3000">0</span>+</h3>
                Dental Implants
              </div>
            </div>
            <div className="col-md-3 col-sm-6 text-center">
              <div className="de_count wow fadeInRight" data-wow-delay=".6s">
                <h3 className="fs-40 mb-0"><span className="timer" data-to="15" data-speed="3000">0</span>+</h3>
                Years of Exeperience
              </div>
            </div>
          </div>
        </div>
      </section>

      <section aria-label="section" className="p-0">
        <div className="container-fluid">
          <div className="row">
            <div className="col-lg-12">
              <a className="d-block hover popup-youtube" href="https://www.youtube.com/watch?v=C6rf51uHWJg">
                <div className="relative overflow-hidden">
                  <div className="absolute start-0 w-100 abs-middle fs-36 text-white text-center z-2">
                    <div className="player circle wow scaleIn"><span></span></div>
                  </div>
                  <div className="absolute w-100 h-100 top-0 bg-dark hover-op-05"></div>
                  <img src="/images/background/1.webp" className="w-100 hover-scale-1-1" alt="" />
                </div>
              </a>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-light">
        <div className="container">
          <div className="row">
            <div className="col-lg-6 offset-lg-3 text-center">
              <div className="subtitle wow fadeInUp mb-3">Testimonials</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Our Happy Customers</h2>
              <p className="wow fadeInUp">Join thousands of happy patients who trust us for gentle, expert care and beautiful smiles. Your perfect dental experience starts here!</p>
              <div className="spacer-single"></div>
            </div>
          </div>
        </div>
        <div className="container-fluid">
          <div className="row">
            <div className="owl-carousel owl-theme wow fadeInUp four-cols-center-dots text-center">
              <div className="item">
                <div className="gradient-white-top p-40 py-4 rounded-1">
                  <blockquote>
                    <i className="fs-32 icofont-quote-left absolute start-0 mt-2 p-0 id-color"></i>
                    <div className="de_testi_by">
                      <img className="circle" alt="" src="/images/testimonial/1.webp" /> <div>Michael S.<span>Customer</span></div>
                    </div>
                    <p className="mt-4 mb-0 text-dark op-6">&quot;I’ve always been nervous about dental visits, but the staff made me feel completely comfortable. Their gentle care and attention to detail truly stand out.&quot;
                    </p>
                  </blockquote>
                </div>
              </div>
              <div className="item">
                <div className="gradient-white-top p-40 py-4 rounded-1">
                  <blockquote>
                    <i className="fs-32 icofont-quote-left absolute start-0 mt-2 p-0 id-color"></i>
                    <div className="de_testi_by">
                      <img className="circle" alt="" src="/images/testimonial/2.webp" /> <div>Robert L.<span>Customer</span></div>
                    </div>
                    <p className="mt-4 mb-0 text-dark op-6">&quot;My family and I have been coming here for years. The service is exceptional, and the team always goes the extra mile to make sure we’re happy and well taken care of.&quot;</p>
                  </blockquote>
                </div>
              </div>
              <div className="item">
                <div className="gradient-white-top p-40 py-4 rounded-1">
                  <blockquote>
                    <i className="fs-32 icofont-quote-left absolute start-0 mt-2 p-0 id-color"></i>
                    <div className="de_testi_by">
                      <img className="circle" alt="" src="/images/testimonial/3.webp" /> <div>Jake M.<span>Customer</span></div>
                    </div>
                    <p className="mt-4 mb-0 text-dark op-6">&quot;I came in for a whitening treatment and left with a brand new level of confidence. The results were amazing, and the staff made it such a relaxing experience.&quot;</p>
                  </blockquote>
                </div>
              </div>
              <div className="item">
                <div className="gradient-white-top p-40 py-4 rounded-1">
                  <blockquote>
                    <i className="fs-32 icofont-quote-left absolute start-0 mt-2 p-0 id-color"></i>
                    <div className="de_testi_by">
                      <img className="circle" alt="" src="/images/testimonial/4.webp" /> <div>Alex P.<span>Customer</span></div>
                    </div>
                    <p className="mt-4 mb-0 text-dark op-6">&quot;&quot;They’re professional, friendly, and genuinely care about your dental health. I trust them completely and recommend them to anyone looking for great care.&quot;</p>
                  </blockquote>
                </div>
              </div>
              <div className="item">
                <div className="gradient-white-top p-40 py-4 rounded-1">
                  <blockquote>
                    <i className="fs-32 icofont-quote-left absolute start-0 mt-2 p-0 id-color"></i>
                    <div className="de_testi_by">
                      <img className="circle" alt="" src="/images/testimonial/5.webp" /> <div>Carlos R.<span>Customer</span></div>
                    </div>
                    <p className="mt-4 mb-0 text-dark op-6">&quot;Hands down the best dental experience I’ve ever had. Everything from scheduling to treatment was smooth, comfortable, and handled with a personal touch.&quot;</p>
                  </blockquote>
                </div>
              </div>
              <div className="item">
                <div className="gradient-white-top p-40 py-4 rounded-1">
                  <blockquote>
                    <i className="fs-32 icofont-quote-left absolute start-0 mt-2 p-0 id-color"></i>
                    <div className="de_testi_by">
                      <img className="circle" alt="" src="/images/testimonial/6.webp" /> <div>Edward B.<span>Customer</span></div>
                    </div>
                    <p className="mt-4 mb-0 text-dark op-6">&quot;I’ve never felt more comfortable at a dentist’s office. The team is so kind, professional, and thorough. They always explain everything in detail, and I leave with a smile every time!&quot;</p>
                  </blockquote>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
}
