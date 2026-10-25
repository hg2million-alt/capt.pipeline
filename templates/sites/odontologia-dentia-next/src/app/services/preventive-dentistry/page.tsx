import Link from 'next/link';

export default function PreventiveDentistry() {
  return (
    <>
      <section id="subheader" className="bg-color-op-1 text-center">
        <div className="container relative z-2">
          <div className="row align-items-center">
            <div className="col-lg-12">
              <h1 className="wow fadeInUp">Preventive Dentistry</h1>
              <div className="border-bottom my-3"></div>
              <ul className="crumb wow fadeInDown">
                <li><Link href="/">Home</Link></li>
                <li><Link href="/services">Services</Link></li>
                <li className="active">Preventive Dentistry</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      <section>
        <div className="container">
          <div className="row g-4 gx-5 align-items-center">
            <div className="col-lg-6">
              <div className="row g-4">
                <div className="col-lg-6">
                  <div className="relative rounded-1 overflow-hidden wow zoomIn">
                    <img src="/images/misc/p1.webp" className="w-100 wow scaleIn" alt="" />
                    <div className="de-overlay-gradient-color h-50 top-50"></div>
                  </div>
                </div>
                <div className="col-lg-6" data-wow-delay=".3s">
                  <div className="relative rounded-1 overflow-hidden wow zoomIn">
                    <img src="/images/misc/p2.webp" className="w-100 wow scaleIn" alt="" />
                    <div className="de-overlay-gradient-color h-50 top-50"></div>
                  </div>
                </div>
              </div>
            </div>
            <div className="col-lg-6">
              <div className="ps-lg-3">
                <div className="subtitle id-color wow fadeInUp" data-wow-delay=".2s">Preventive Dentistry</div>
                <h2 className="wow fadeInUp" data-wow-delay=".4s">Building Healthy Smiles That Last a Lifetime</h2>
                <p className="mb-0 wow fadeInUp" data-wow-delay=".6s">We believe the best dental care begins with prevention. Preventive dentistry helps children avoid dental problems before they start, ensuring strong, healthy teeth and good habits that last into adulthood. Our goal is to make every visit positive, educational, and supportive for both kids and parents.</p>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-color-op-1">
        <div className="container">
          <div className="row g-4">
            <div className="col-lg-5">
              <div className="subtitle id-color wow fadeInUp" data-wow-delay=".0s">Why Choose Us</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Why Choose Our Preventive Dental Services?</h2>
            </div>

            <div className="col-lg-7">
              <div className="row g-4">
                <div className="col-md-6 wow fadeInUp" data-wow-delay=".3s">
                  <div className="relative">
                    <span className="abs w-70px p-3 circle bg-color d-block">
                      <img src="/images/ui/check-white.png" className="w-100" alt="" />
                    </span>
                    <div className="ps-90">
                      <h5>Kid-Friendly Environment</h5>
                      <p className="mb-0">Our space is fun, welcoming, and designed to keep children relaxed and happy during every visit.</p>
                    </div>
                  </div>
                </div>

                <div className="col-md-6 wow fadeInUp" data-wow-delay=".3s">
                  <div className="relative">
                    <span className="abs w-70px p-3 circle bg-color d-block">
                      <img src="/images/ui/check-white.png" className="w-100" alt="" />
                    </span>
                    <div className="ps-90">
                      <h5>Experienced Pediatric Dentists</h5>
                      <p className="mb-0">Our team has advanced training in caring for children, using gentle techniques.</p>
                    </div>
                  </div>
                </div>

                <div className="col-md-6 wow fadeInUp" data-wow-delay=".3s">
                  <div className="relative">
                    <span className="abs w-70px p-3 circle bg-color d-block">
                      <img src="/images/ui/check-white.png" className="w-100" alt="" />
                    </span>
                    <div className="ps-90">
                      <h5>Preventive Focus</h5>
                      <p className="mb-0">We emphasize early detection and education to help kids avoid problems before they start.</p>
                    </div>
                  </div>
                </div>

                <div className="col-md-6 wow fadeInUp" data-wow-delay=".3s">
                  <div className="relative">
                    <span className="abs w-70px p-3 circle bg-color d-block">
                      <img src="/images/ui/check-white.png" className="w-100" alt="" />
                    </span>
                    <div className="ps-90">
                      <h5>Modern Technology</h5>
                      <p className="mb-0">We use child-safe digital X-rays and advanced tools to ensure accuracy, safety, and comfort.</p>
                    </div>
                  </div>
                </div>

                <div className="col-md-6 wow fadeInUp" data-wow-delay=".3s">
                  <div className="relative">
                    <span className="abs w-70px p-3 circle bg-color d-block">
                      <img src="/images/ui/check-white.png" className="w-100" alt="" />
                    </span>
                    <div className="ps-90">
                      <h5>Parent &amp; Patient Education</h5>
                      <p className="mb-0">We take time to teach proper brushing, flossing, and nutrition to build long-term dental health.</p>
                    </div>
                  </div>
                </div>

                <div className="col-md-6 wow fadeInUp" data-wow-delay=".3s">
                  <div className="relative">
                    <span className="abs w-70px p-3 circle bg-color d-block">
                      <img src="/images/ui/check-white.png" className="w-100" alt="" />
                    </span>
                    <div className="ps-90">
                      <h5>Flexible Scheduling</h5>
                      <p className="mb-0">We offer after-school and weekend appointments to fit your family’s busy schedule.</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section>
        <div className="container">
          <div className="row g-4 justify-content-center">
            <div className="col-lg-8 text-center">
              <div className="subtitle wow fadeInUp mb-3">Preventive Dentistry</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Preventive Treatments We Offer</h2>
            </div>
          </div>

          <div className="row g-4">
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Routine Exams &amp; Cleanings</h4>
                  <p className="mb-0">Maintain a healthy smile with regular checkups and cleanings that remove plaque and detect early issues.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Fluoride Treatments</h4>
                  <p className="mb-0">Strengthen enamel and help prevent cavities with safe, quick fluoride applications tailored for kids.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Dental Sealants</h4>
                  <p className="mb-0">Protect your child’s molars from decay with a thin, invisible coating that lasts for years.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Digital X-Rays</h4>
                  <p className="mb-0">Safe, low-radiation imaging to catch cavities, monitor growth, and ensure accurate diagnosis.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Oral Health Education</h4>
                  <p className="mb-0">We teach kids and parents how to care for teeth at home—setting the foundation for lifelong habits.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Habit Counseling</h4>
                  <p className="mb-0">We offer guidance on habits like thumb-sucking and pacifier use to prevent future alignment issues.</p>
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
              <div className="col-lg-6 position-lg-absolute left-half h-100">
                <div className="image" style={{ backgroundImage: 'url(/images/misc/s2.webp)', backgroundPosition: 'center', backgroundSize: 'cover' }}></div>
              </div>
              <div className="col-lg-5 offset-lg-7">
                <div className="py-5 my-5">
                  <div className="owl-single-dots owl-carousel owl-theme">
                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">The staff is so patient and gentle with my daughter. She actually looks forward to going to the dentist now!</h3>
                      <span className="wow fadeInUp">Rachel T.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">We had an emergency and they saw us the same day. I’m so grateful for their quick response and kindness!</h3>
                      <span className="wow fadeInUp">Michael L.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">Clean, cheerful, and professional. The entire team makes dental visits a positive experience for my kids.</h3>
                      <span className="wow fadeInUp">Emily S.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">My son used to be terrified of dentists. Now he walks in with a smile. I can’t thank this team enough!</h3>
                      <span className="wow fadeInUp">Daniel K.</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-light">
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
