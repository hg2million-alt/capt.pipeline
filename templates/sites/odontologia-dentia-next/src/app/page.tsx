import Link from 'next/link';

export default function Home() {
  return (
    <>
      <section id="section-intro" className="text-light no-top no-bottom relative overflow-hidden">
        <div className="relative">
          <div className="abs abs-centered w-100 z-2">
            <div className="container">
              <div className="row g-4 align-items-center justify-content-between">
                <div className="col-lg-6">
                  <div className="spacer-single sm-hide"></div>
                  <div className="subtitle">Family Dental Care</div>
                  <h1>Elevating Smiles with Expert Care and a Gentle Touch</h1>
                  <Link className="btn-main btn-line fx-slide" href="/booking"><span>Book Appointment</span></Link>
                </div>

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

          <div className="mh-800">
            <div className="swiper wow scaleIn">
              <div className="swiper-wrapper">
                <div className="swiper-slide">
                  <div className="swiper-inner" style={{ backgroundImage: 'url(/images/slider/1.jpg)', backgroundPosition: 'center', backgroundSize: 'cover', backgroundRepeat: 'no-repeat' }}>
                    <div className="sw-overlay op-5"></div>
                    <div className="gradient-edge-left z-2"></div>
                  </div>
                </div>
                <div className="swiper-slide">
                  <div className="swiper-inner" style={{ backgroundImage: 'url(/images/slider/2.jpg)', backgroundPosition: 'center', backgroundSize: 'cover', backgroundRepeat: 'no-repeat' }}>
                    <div className="sw-overlay op-5"></div>
                    <div className="gradient-edge-left z-2"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-dark text-light pt-50 pb-30">
        <div className="container relative">
          <div className="row g-4 grid-divider">
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
                        <img src="images/misc/p1.webp" className="w-100 wow scaleIn" alt="" />
                      </div>
                    </div>
                  </div>
                </div>
                <div className="col-6">
                  <div className="row g-4">
                    <div className="spacer-single sm-hide"></div>
                    <div className="col-lg-12">
                      <div className=" rounded-1 overflow-hidden wow zoomIn" data-wow-delay=".3s">
                        <img src="images/misc/p2.webp" className="w-100 wow scaleIn" alt="" data-wow-delay=".3s" />
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
                  <img src="images/icons/tooth-1.png" className="w-70px mb-3 wow scaleIn" alt="" />
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
                  <img src="images/icons/tooth-2.png" className="w-70px mb-3 wow scaleIn" alt="" />
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
                  <img src="images/icons/tooth-3.png" className="w-70px mb-3 wow scaleIn" alt="" />
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
                  <img src="images/icons/tooth-4.png" className="w-70px mb-3 wow scaleIn" alt="" />
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

      <section>
        <div className="container">
          <div className="row gy-4 gx-5 align-items-center">
            <div className="col-lg-6">
              <div className="subtitle id-color wow fadeInUp" data-wow-delay=".0s">Why Choose Our Dental Care</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Exceptional Service With a Personal Touch</h2>
              <p className="wow fadeInUp" data-wow-delay=".4s">Choosing the right dental provider matters. We combine expert care, advanced technology, and a warm atmosphere to ensure every visit is comfortable, efficient, and tailored to your unique needs.</p>

              <div className="border-bottom mb-4"></div>

              <div className="row g-4">
                <div className="col-sm-6">
                  <div className="h-100">
                    <div className="relative wow fadeInUp">
                      <h5>Experienced Dental</h5>
                      <p className="mb-0">Skilled care backed by years of trusted dental experience.</p>
                    </div>
                  </div>
                </div>

                <div className="col-sm-6">
                  <div className="h-100">
                    <div className="relative wow fadeInUp">
                      <h5>Advanced Technology</h5>
                      <p className="mb-0">Modern tools ensure accurate and efficient treatments.</p>
                    </div>
                  </div>
                </div>

                <div className="col-sm-6">
                  <div className="h-100">
                    <div className="relative wow fadeInUp">
                      <h5>Personalized Treatment</h5>
                      <p className="mb-0">Custom care plans made to fit your smile and lifestyle.</p>
                    </div>
                  </div>
                </div>

                <div className="col-sm-6">
                  <div className="h-100">
                    <div className="relative wow fadeInUp">
                      <h5>Family-Friendly</h5>
                      <p className="mb-0">Welcoming space for kids, teens, adults, and seniors.</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-6">
              <div className="row g-4 align-items-center">
                <div className="col-6 text-end">
                  <div className="w-80 rounded-1 overflow-hidden mb-25 wow zoomIn d-inline-block">
                    <img src="images/misc/s2.webp" className="w-100 wow scaleIn" alt="" />
                  </div>
                  <div className="w-100 rounded-1 overflow-hidden mb-25 wow zoomIn d-inline-block">
                    <img src="images/misc/s3.webp" className="w-100 wow scaleIn" alt="" />
                  </div>
                </div>

                <div className="col-6">
                  <div className="w-100 rounded-1 overflow-hidden mb-25 wow zoomIn d-inline-block">
                    <img src="images/misc/p3.webp" className="w-100 wow scaleIn" alt="" />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-color-op-1">
        <div className="container">
          <div className="row">
            <div className="col-lg-6 offset-lg-3 text-center">
              <div className="subtitle wow fadeInUp mb-3">Meet Our Dental Team</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Committed to Your Smile</h2>
              <p className="wow fadeInUp">Our experienced dental team is here to make every visit positive and personalized. With gentle hands and caring hearts.</p>
              <div className="spacer-single"></div>
            </div>
          </div>
          <div className="row g-4">
            <div className="col-lg-3 col-md-6">
              <div className="relative rounded-1 overflow-hidden">
                <div className="rounded-1 overflow-hidden wow fadeIn zoomIn">
                  <img src="images/team/1.webp" className="w-100 wow scaleIn" alt="" />
                </div>
                <div className="abs w-100 start-0 bottom-0 z-3">
                  <div className="p-2 rounded-10 m-3 text-center bg-white wow fadeInDown">
                    <h4 className="mb-0">Dr. Sarah Bennett</h4>
                    <p className="mb-2">Lead Dentist</p>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-3 col-md-6">
              <div className="relative rounded-1 overflow-hidden">
                <div className="rounded-1 overflow-hidden wow fadeIn zoomIn">
                  <img src="images/team/2.webp" className="w-100 wow scaleIn" alt="" />
                </div>
                <div className="abs w-100 start-0 bottom-0 z-3">
                  <div className="p-2 rounded-10 m-3 text-center bg-white wow fadeInDown">
                    <h4 className="mb-0">Dr. Maya Lin</h4>
                    <p className="mb-2">Cosmetic Dentist</p>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-3 col-md-6">
              <div className="relative rounded-1 overflow-hidden">
                <div className="rounded-1 overflow-hidden wow fadeIn zoomIn">
                  <img src="images/team/3.webp" className="w-100 wow scaleIn" alt="" />
                </div>
                <div className="abs w-100 start-0 bottom-0 z-3">
                  <div className="p-2 rounded-10 m-3 text-center bg-white wow fadeInDown">
                    <h4 className="mb-0">Dr. Michael Reyes</h4>
                    <p className="mb-2">Pediatric Specialist</p>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-3 col-md-6">
              <div className="relative rounded-1 overflow-hidden">
                <div className="rounded-1 overflow-hidden wow fadeIn zoomIn">
                  <img src="images/team/4.webp" className="w-100 wow scaleIn" alt="" />
                </div>
                <div className="abs w-100 start-0 bottom-0 z-3">
                  <div className="p-2 rounded-10 m-3 text-center bg-white wow fadeInDown">
                    <h4 className="mb-0">Dr. James Carter</h4>
                    <p className="mb-2">Dental Hygienist</p>
                  </div>
                </div>
              </div>
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
                      <img className="circle" alt="" src="images/testimonial/1.webp" /> <div>Michael S.<span>Customer</span></div>
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
                      <img className="circle" alt="" src="images/testimonial/2.webp" /> <div>Robert L.<span>Customer</span></div>
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
                      <img className="circle" alt="" src="images/testimonial/3.webp" /> <div>Jake M.<span>Customer</span></div>
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
                      <img className="circle" alt="" src="images/testimonial/4.webp" /> <div>Alex P.<span>Customer</span></div>
                    </div>
                    <p className="mt-4 mb-0 text-dark op-6">&quot;They’re professional, friendly, and genuinely care about your dental health. I trust them completely and recommend them to anyone looking for great care.&quot;</p>
                  </blockquote>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-color text-light pt-40 pb-40">
        <div className="container">
          <div className="row g-4">
            <div className="col-md-9">
              <h3 className="mb-0 fs-32">Ready to book your dental care session?</h3>
            </div>
            <div className="col-lg-3 text-lg-end">
              <Link className="btn-main btn-line fx-slide" href="/booking"><span>Book Appointment</span></Link>
            </div>
          </div>
        </div>
      </section>
    </>
  );
}
