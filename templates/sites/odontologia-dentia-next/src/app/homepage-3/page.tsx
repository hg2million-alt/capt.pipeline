import Link from 'next/link';

export default function Homepage3() {
  return (
    <>
      <section className="text-light bg-dark no-top no-bottom overflow-hidden">
        <div className="container-fluid position-relative half-fluid">
          <div className="container">
            <div className="row">
              {/* Image */}
              <div className="col-lg-6 position-lg-absolute right-half h-100">
                <div className="image" style={{ backgroundImage: 'url(/images/misc/s1.webp)', backgroundPosition: 'center', backgroundSize: 'cover' }}></div>
              </div>
              {/* Text */}
              <div className="col-lg-6">
                <div className="pt-lg-5 mt-lg-5 me-lg-3">
                  <div className="py-5 mt-5 mb-3 me-lg-3">
                    <div className="subtitle id-color wow fadeInUp" data-wow-delay=".0s">Welcome to Dentia</div>
                    <h1 className="wow fadeInUp" data-wow-delay=".2s">Transforming Smiles With Precision And Gentle Touch</h1>
                    <p className="col-lg-10 wow fadeInUp" data-wow-delay=".4s">We offer high-quality dental care tailored for the whole family. From routine checkups to advanced treatments, our compassionate team ensures your smile stays healthy and confident.</p>

                    <Link className="btn-main mb10 mb-3 wow fadeInUp" data-wow-delay=".6s" href="/contact"><span>Book Appointment</span></Link>

                    <div className="border-bottom my-3"></div>

                    <div className="d-lg-flex align-items-center">
                      <div className="me-3">Google Rating</div>
                      <div className="de-flex justify-content-start align-items-center">
                        <div className="me-3">5.0</div>
                        <div className="d-flex fs-14 d-rating me-3">
                          <i className="fa fa-solid fa-star m-1"></i>
                          <i className="fa fa-solid fa-star m-1"></i>
                          <i className="fa fa-solid fa-star m-1"></i>
                          <i className="fa fa-solid fa-star m-1"></i>
                          <i className="fa fa-solid fa-star m-1"></i>
                        </div>
                      </div>
                      <div className="me-3">Based on 23k Reviews</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-dark text-light pt-50 pb-30">
        <div className="container relative">
          <div className="row g-4 grid-divider slider-extra sm-hide">
            <div className="col-lg-4 col-md-6 mb-sm-30">
              <div className="d-flex justify-content-center">
                <i className="fs-60 id-color icon_phone"></i>
                <div className="ms-3">
                  <h4 className="mb-0">Need Dental Services?</h4>
                  <p>Call: +1 123 456 789</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6 mb-sm-30">
              <div className="d-flex justify-content-center">
                <i className="fs-60 id-color icon_clock"></i>
                <div className="ms-3">
                  <h4 className="mb-0">Opening Hours</h4>
                  <p>Mon to Sat 08:00 - 20:00</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6 mb-sm-30">
              <div className="d-flex justify-content-center">
                <i className="fs-60 id-color icon_mail"></i>
                <div className="ms-3">
                  <h4 className="mb-0">Email Us</h4>
                  <p>contact@dentiaclinic.com</p>
                </div>
              </div>
            </div>

          </div>
        </div>
      </section>

      <section>
        <div className="container">
          <div className="row g-4 gx-5 align-items-center">
            <div className="col-lg-6">
              <div className="row g-4">
                <div className="col-6">
                  <div className="row g-4">
                    <div className="col-lg-12">
                      <div className=" rounded-1 overflow-hidden wow zoomIn">
                        <img src="/images/misc/p1.webp" className="w-100 wow scaleIn" alt="" />
                      </div>
                    </div>

                  </div>
                </div>
                <div className="col-6">
                  <div className="row g-4">
                    <div className="spacer-single sm-hide"></div>

                    <div className="col-lg-12">
                      <div className=" rounded-1 overflow-hidden wow zoomIn" data-wow-delay=".3s">
                        <img src="/images/misc/p2.webp" className="w-100 wow scaleIn" alt="" data-wow-delay=".3s" />
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-6">
              <div className="me-lg-3">
                <div className="subtitle s2 mb-3 wow fadeInUp" data-wow-delay=".0s">About Us</div>
                <h2 className="wow fadeInUp" data-wow-delay=".2s">Professionals and Personalized Dental Excellence</h2>
                <p className="wow fadeInUp" data-wow-delay=".4s">We offer high-quality dental care tailored for the whole family. From routine checkups to advanced treatments, our compassionate team ensures your smile stays healthy and confident.</p>
                <ul className="ul-check text-dark cols-2 fw-600 mb-4 wow fadeInUp" data-wow-delay=".6s">
                  <li>Personalized Treatment Plans</li>
                  <li>Gentle Care for Kids and Adults</li>
                  <li>State-of-the-Art Technology</li>
                  <li>Flexible Appointment Scheduling</li>
                </ul>

                <Link className="btn-main fx-slide wow fadeInUp" data-wow-delay=".8s" href="/contact"><span>Book Appointment</span></Link>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-color-op-1">
        <div className="container">
          <div className="row g-4 justify-content-center">
            <div className="col-lg-8 text-center">
              <div className="subtitle wow fadeInUp mb-3">Our Services</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Complete Care for Every Smile</h2>
              <p className="col-lg-8 offset-lg-2 mb-0 wow fadeInUp">From routine cleanings to advanced restorations, we provide personalized dental solutions for patients of all ages.</p>
              <div className="spacer-single"></div>
              <div className="spacer-half"></div>
            </div>
          </div>

          <div className="row g-4">
            <div className="col-lg-3 col-sm-6">
              <div className="hover">
                <div className="bg-white h-100 p-40 rounded-1">
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
              <div className="hover">
                <div className="bg-white h-100 p-40 rounded-1">
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
              <div className="hover">
                <div className="bg-white h-100 p-40 rounded-1">
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
              <div className="hover">
                <div className="bg-white h-100 p-40 rounded-1">
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

      <section>
        <div className="container">
          <div className="row g-4">
            <div className="col-lg-5">
              <div className="subtitle id-color wow fadeInUp" data-wow-delay=".0s">Everything You Need to Know</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Frequently Asked Questions</h2>
            </div>

            <div className="col-lg-7">
              <div className="accordion s2 wow fadeInUp">
                <div className="accordion-section">
                  <div className="accordion-section-title" data-tab="#accordion-a1">
                    How often should I visit the dentist?
                  </div>
                  <div className="accordion-section-content" id="accordion-a1">It’s recommended to see your dentist every 6 months for a routine check-up and cleaning, unless advised otherwise.
                  </div>
                  <div className="accordion-section-title" data-tab="#accordion-a2">
                    What should I do in a dental emergency?
                  </div>
                  <div className="accordion-section-content" id="accordion-a2">
                    Call our office immediately. We offer same-day emergency care for issues like severe pain, broken teeth, or swelling.
                  </div>
                  <div className="accordion-section-title" data-tab="#accordion-a3">
                    Do you offer services for kids?
                  </div>
                  <div className="accordion-section-content" id="accordion-a3">
                    Absolutely! We provide gentle, friendly pediatric dental care for children of all ages.
                  </div>
                  <div className="accordion-section-title" data-tab="#accordion-a4">
                    What are my options for replacing missing teeth?
                  </div>
                  <div className="accordion-section-content" id="accordion-a4">
                    We offer dental implants, bridges, and dentures depending on your needs and preferences.
                  </div>
                  <div className="accordion-section-title" data-tab="#accordion-a5">
                    Is teeth whitening safe?
                  </div>
                  <div className="accordion-section-content" id="accordion-a5">
                    Yes, when performed by a dental professional, teeth whitening is safe and effective with long-lasting results.
                  </div>
                </div>
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

      <section className="bg-color-op-1">
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
                    <p className="mt-4 mb-0 text-dark op-6">&quot;They’re professional, friendly, and genuinely care about your dental health. I trust them completely and recommend them to anyone looking for great care.&quot;</p>
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
              <div className="item">
                <div className="gradient-white-top p-40 py-4 rounded-1">
                  <blockquote>
                    <i className="fs-32 icofont-quote-left absolute start-0 mt-2 p-0 id-color"></i>
                    <div className="de_testi_by">
                      <img className="circle" alt="" src="/images/testimonial/7.webp" /> <div>Daniel H.<span>Customer</span></div>
                    </div>
                    <p className="mt-4 mb-0 text-dark op-6">&quot;My experience here has been wonderful! The staff is friendly, the office is spotless, and the care is top-notch. I always feel relaxed, and my teeth have never looked better!&quot;</p>
                  </blockquote>
                </div>
              </div>
              <div className="item">
                <div className="gradient-white-top p-40 py-4 rounded-1">
                  <blockquote>
                    <i className="fs-32 icofont-quote-left absolute start-0 mt-2 p-0 id-color"></i>
                    <div className="de_testi_by">
                      <img className="circle" alt="" src="/images/testimonial/8.webp" /> <div>Bryan G.<span>Customer</span></div>
                    </div>
                    <p className="mt-4 mb-0 text-dark op-6">&quot;From the moment I walked in, I felt at ease. The staff made me feel like family, and the care I received was exceptional. I’m so happy with my smile—thank you for everything!&quot;</p>
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
