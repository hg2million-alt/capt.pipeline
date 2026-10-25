import Link from 'next/link';

export default function Homepage6() {
  return (
    <>
      <section id="section-intro" className="pt-100 pt-sm-10 pb-0 p-xs-4 overflow-hidden">
        <div className="container">
          <div className="row g-4">
            <div className="col-lg-12 mb-4">
              <div className="rounded-1 p-lg-5 p-4 bg-color-op-1">
                <div className="row g-4 gx-5 align-items-center">
                  <div className="col-lg-6">
                    <div className="subtitle s2 mb-3 wow fadeInUp" data-wow-delay=".0s">Welcome to Dentia</div>
                    <h1 className="wow fadeInUp" data-wow-delay=".2s">Transforming Smiles With Precision And Gentle Touch</h1>
                    <p className="col-lg-10 wow fadeInUp" data-wow-delay=".4s">We offer high-quality dental care tailored for the whole family. From routine checkups to advanced treatments, our compassionate team ensures your smile stays healthy and confident.</p>

                    <Link className="btn-main mb10 mb-3 wow fadeInUp" data-wow-delay=".6s" href="/booking"><span>Book Appointment</span></Link>

                    <div className="border-bottom my-3"></div>

                    <div className="d-lg-flex align-items-center text-dark">
                      <div className="me-3">Google Rating</div>
                      <div className="me-3">5.0</div>
                      <div className="d-flex fs-14 d-rating me-3">
                        <i className="fa fa-solid fa-star m-1"></i>
                        <i className="fa fa-solid fa-star m-1"></i>
                        <i className="fa fa-solid fa-star m-1"></i>
                        <i className="fa fa-solid fa-star m-1"></i>
                        <i className="fa fa-solid fa-star m-1"></i>
                      </div>
                      <div className="me-3">Based on 23k Reviews</div>
                    </div>
                  </div>

                  <div className="col-lg-6">
                    <div className="relative">
                      <img src="/images/misc/c3.webp" className="w-100 wow fadeInUp" data-wow-delay=".3s" alt="" />
                    </div>
                  </div>

                </div>
              </div>
            </div>
          </div>

          <div className="row g-4">
            <div className="col-lg-3 col-sm-6">
              <div className="hover">
                <div className="bg-color-op-1 rounded-1 p-40 h-100">
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
                <div className="bg-color-op-1 rounded-1 p-40 h-100">
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
                <div className="bg-color-op-1 rounded-1 p-40 h-100">
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
                <div className="bg-color-op-1 rounded-1 p-40 h-100">
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
          </div>
        </div>
      </section>

      <section>
        <div className="container">
          <div className="row gy-4 gx-5 align-items-center">
            <div className="col-lg-6">
              <div className="row g-4 align-items-center">
                <div className="col-6 text-end">
                  <div className="w-80 rounded-1 overflow-hidden mb-25 wow zoomIn d-inline-block">
                    <img src="/images/misc/s2.webp" className="w-100 wow scaleIn" alt="" />
                  </div>
                  <div className="w-100 rounded-1 overflow-hidden mb-25 wow zoomIn d-inline-block">
                    <img src="/images/misc/s3.webp" className="w-100 wow scaleIn" alt="" />
                  </div>
                </div>

                <div className="col-6">
                  <div className="w-100 rounded-1 overflow-hidden mb-25 wow zoomIn d-inline-block">
                    <img src="/images/misc/p3.webp" className="w-100 wow scaleIn" alt="" />
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
          <div className="row">
            <div className="col-lg-6 offset-lg-3 text-center">
              <div className="subtitle wow fadeInUp mb-3">Meet Our Dental Team</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Committed to Your Smile</h2>
              <p className="wow fadeInUp">Our experienced dental team is here to make every visit positive and personalized. With gentle hands and caring hearts.</p>
              <div className="spacer-single"></div>
            </div>
          </div>
          <div className="row g-4">
            <div className="col-lg-3">
              <div className="relative rounded-1 overflow-hidden">
                <div className="rounded-1 overflow-hidden wow fadeIn zoomIn">
                  <img src="/images/team/1.webp" className="w-100 wow scaleIn" alt="" />
                </div>

                <div className="abs w-100 start-0 bottom-0 z-3">
                  <div className="p-2 rounded-10 m-3 text-center bg-white wow fadeInDown">
                    <h4 className="mb-0">Dr. Sarah Bennett</h4>
                    <p className="mb-2">Lead Dentist</p>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-3">
              <div className="relative rounded-1 overflow-hidden">
                <div className="rounded-1 overflow-hidden wow fadeIn zoomIn">
                  <img src="/images/team/2.webp" className="w-100 wow scaleIn" alt="" />
                </div>

                <div className="abs w-100 start-0 bottom-0 z-3">
                  <div className="p-2 rounded-10 m-3 text-center bg-white wow fadeInDown">
                    <h4 className="mb-0">Dr. Maya Lin</h4>
                    <p className="mb-2">Cosmetic Dentist</p>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-3">
              <div className="relative rounded-1 overflow-hidden">
                <div className="rounded-1 overflow-hidden wow fadeIn zoomIn">
                  <img src="/images/team/3.webp" className="w-100 wow scaleIn" alt="" />
                </div>

                <div className="abs w-100 start-0 bottom-0 z-3">
                  <div className="p-2 rounded-10 m-3 text-center bg-white wow fadeInDown">
                    <h4 className="mb-0">Dr. Michael Reyes</h4>
                    <p className="mb-2">Pediatric Specialist</p>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-3">
              <div className="relative rounded-1 overflow-hidden">
                <div className="rounded-1 overflow-hidden wow fadeIn zoomIn">
                  <img src="/images/team/4.webp" className="w-100 wow scaleIn" alt="" />
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
