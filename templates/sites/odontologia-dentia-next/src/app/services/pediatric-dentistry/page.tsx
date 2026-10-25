import Link from 'next/link';

export default function PediatricDentistry() {
  return (
    <>
      <section id="subheader" className="bg-color-op-1 text-center">
        <div className="container relative z-2">
          <div className="row align-items-center">
            <div className="col-lg-12">
              <h1 className="wow fadeInUp">Pediatric Dentistry</h1>
              <div className="border-bottom my-3"></div>
              <ul className="crumb wow fadeInDown">
                <li><Link href="/">Home</Link></li>
                <li><Link href="/services">Services</Link></li>
                <li className="active">Pediatric Dentistry</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      <section className="text-light bg-dark no-top no-bottom overflow-hidden">
        <div className="container-fluid position-relative half-fluid">
          <div className="container">
            <div className="row">
              {/* Image */}
              <div className="col-lg-6 position-lg-absolute right-half h-100">
                <div className="triangle-bottomright-dark"></div>
                <div className="image" style={{ backgroundImage: 'url(/images/misc/l4.webp)', backgroundPosition: 'center', backgroundSize: 'cover' }}></div>
              </div>
              {/* Text */}
              <div className="col-lg-5">
                <div className="me-lg-3">
                  <div className="py-5 my-5 me-lg-3">
                    <div className="subtitle id-color wow fadeInUp" data-wow-delay=".2s">Pediatric Dentistry</div>
                    <h2 className="wow fadeInUp" data-wow-delay=".4s">Comprehensive Oral Care for Every Stage of Life</h2>
                    <p className="mb-0 wow fadeInUp" data-wow-delay=".6s">We specialize in gentle, personalized dental care for infants, children, and teens. From a child’s first tooth to their teenage years, our goal is to create a comfortable, fun, and educational environment for every visit.</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-color-op-1">
        <div className="container">
          <div className="row g-4">
            <div className="col-lg-4">
              <div className="subtitle id-color wow fadeInUp" data-wow-delay=".0s">Top Reasons</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Why Choose Us?</h2>
            </div>

            <div className="col-lg-8">
              <ul className="ul-check text-dark fs-24">
                <li>Kid-friendly and calming environment designed just for children</li>
                <li>Experienced, board-certified pediatric dentists</li>
                <li>Comfortable treatment rooms with fun themes</li>
                <li>Parents welcome during exams and treatments</li>
                <li>Focus on education to build lifelong healthy habits</li>
                <li>Flexible scheduling and emergency care available</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      <section>
        <div className="container">
          <div className="row g-4">
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Infant Oral Health Exams</h4>
                  <p className="mb-0">Gentle exams for babies to monitor development and guide parents on early dental care.</p>
                </div>
              </div>
            </div>
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Preventive Care</h4>
                  <p className="mb-0">Protect young teeth with cleanings, fluoride treatments, and dental sealants.</p>
                </div>
              </div>
            </div>
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Digital X-rays</h4>
                  <p className="mb-0">Safe, low-radiation imaging to detect dental issues early and accurately.</p>
                </div>
              </div>
            </div>
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Tooth-Colored Fillings</h4>
                  <p className="mb-0">Natural-looking fillings to repair cavities while keeping your child’s smile bright.</p>
                </div>
              </div>
            </div>
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Emergency Dental Care</h4>
                  <p className="mb-0">Quick, compassionate care for dental injuries, toothaches, and accidents.</p>
                </div>
              </div>
            </div>
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Sedation Dentistry</h4>
                  <p className="mb-0">Safe sedation options to help anxious children feel calm and comfortable.</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-color-op-2 no-top no-bottom overflow-hidden">
        <div className="container-fluid position-relative half-fluid">
          <div className="container">
            <div className="row">
              {/* Image */}
              <div className="col-lg-6 position-lg-absolute left-half h-100">
                <div className="image" style={{ backgroundImage: 'url(/images/misc/l5.webp)', backgroundPosition: 'center', backgroundSize: 'cover' }}></div>
              </div>
              {/* Text */}
              <div className="col-lg-5 offset-lg-7">
                <div className="py-5 my-5">
                  <div className="owl-single-dots owl-carousel owl-theme">
                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">Dr. Sarah and her team are amazing with kids! My son used to be afraid of the dentist, but now he actually looks forward to his check-ups.</h3>
                      <span className="wow fadeInUp">Jessica M.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">The entire office is kid-friendly and welcoming. They explained every step clearly and made my daughter feel comfortable throughout.</h3>
                      <span className="wow fadeInUp">David K.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">My kids love going here! The staff is kind, patient, and always has a smile. You can tell they really care about children.</h3>
                      <span className="wow fadeInUp">Linda W.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">From the moment we walked in, we felt at ease. The waiting area was fun for the kids, and the staff made sure we were all comfortable.</h3>
                      <span className="wow fadeInUp">Amanda L.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">My child needed a filling and was so nervous, but the dentist explained everything so kindly. They made it a positive experience from start to finish.</h3>
                      <span className="wow fadeInUp">Eric T.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">I appreciate how they involve parents in the process. They answered all my questions and gave great tips for dental care at home.</h3>
                      <span className="wow fadeInUp">Nina R.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">Our family loves this dental office! They’re always on time, so friendly, and my twins leave with big smiles and new toothbrushes.</h3>
                      <span className="wow fadeInUp">Rebecca S.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">Even during a dental emergency, they handled everything calmly and quickly. We felt cared for every step of the way.</h3>
                      <span className="wow fadeInUp">Carlos M.</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-color-op-1">
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
                    When should I take my child to the dentist for the first time?
                  </div>
                  <div className="accordion-section-content" id="accordion-a1">
                    The American Academy of Pediatric Dentistry recommends scheduling the first visit by your child’s first birthday or within 6 months of their first tooth erupting.
                  </div>
                  <div className="accordion-section-title" data-tab="#accordion-a2">
                    How can I prepare my child for their dental visit?
                  </div>
                  <div className="accordion-section-content" id="accordion-a2">
                    Talk about the dentist positively, read books about dental visits, and avoid using words like &quot;pain&quot; or &quot;hurt.&quot; Our team is also trained to help children feel at ease.
                  </div>
                  <div className="accordion-section-title" data-tab="#accordion-a3">
                    Are dental X-rays safe for children?
                  </div>
                  <div className="accordion-section-content" id="accordion-a3">
                    Yes, dental X-rays are safe. We use digital X-rays, which emit significantly less radiation than traditional ones, and we only take them when necessary.
                  </div>
                  <div className="accordion-section-title" data-tab="#accordion-a4">
                    What if my child has a toothache or dental emergency?
                  </div>
                  <div className="accordion-section-content" id="accordion-a4">
                    Call our office immediately. We prioritize emergencies and will guide you on what to do until you can reach the clinic.
                  </div>
                  <div className="accordion-section-title" data-tab="#accordion-a5">
                    How do dental sealants work?
                  </div>
                  <div className="accordion-section-content" id="accordion-a5">
                    Sealants are a thin protective coating applied to the chewing surfaces of back teeth (molars) to prevent cavities by blocking out food and bacteria.
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-color text-light pt-50 pb-50">
        <div className="container">
          <div className="row g-4 align-items-center">
            <div className="col-md-9">
              <h3 className="mb-0 fs-32">Ready to Book Your Appointment?</h3>
              <p className="mb-0">Contact us today to schedule your visit and take the first step toward a healthier smile.</p>
            </div>
            <div className="col-lg-3 text-lg-end">
              <Link className="btn-main fx-slide btn-line" href="/booking"><span>Book Appointment</span></Link>
            </div>
          </div>
        </div>
      </section>
    </>
  );
}
