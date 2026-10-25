import Link from 'next/link';

export default function GeneralDentistry() {
  return (
    <>
      <section id="subheader" className="bg-color-op-1 text-center">
        <div className="container relative z-2">
          <div className="row align-items-center">
            <div className="col-lg-12">
              <h1 className="wow fadeInUp">General Dentistry</h1>
              <div className="border-bottom my-3"></div>
              <ul className="crumb wow fadeInDown">
                <li><Link href="/">Home</Link></li>
                <li><Link href="/services">Services</Link></li>
                <li className="active">General Dentistry</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      <section>
        <div className="container">
          <div className="row g-4 align-items-center">
            <div className="col-lg-6">
              <div className="relative">
                <div className="w-100 pe-5 pb-5 wow scaleIn">
                  <img src="/images/misc/l1.webp" className="w-100 rounded-1" alt="" />
                </div>
                <img src="/images/misc/s1.webp" className="w-40 rounded-1 abs end-0 bottom-0 z-2 soft-shadow wow scaleIn" data-wow-delay=".2s" alt="" />
              </div>
            </div>
            <div className="col-lg-6">
              <div className="ps-lg-3">
                <div className="subtitle id-color wow fadeInUp" data-wow-delay=".2s">General Dentistry</div>
                <h2 className="wow fadeInUp" data-wow-delay=".4s">Comprehensive Oral Care for Every Stage of Life</h2>
                <p className="mb-0 wow fadeInUp" data-wow-delay=".6s">Our general dentistry services focus on the prevention, diagnosis, and treatment of a wide range of oral health issues. Whether you&apos;re coming in for a routine check-up or seeking relief from dental pain, our experienced team is here to help you maintain a healthy, confident smile.</p>
              </div>
            </div>
          </div>

          <div className="spacer-double"></div>

          <div className="row g-4">
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Routine Exams & Cleanings</h4>
                  <p className="mb-0">Keep your teeth and gums healthy with regular check-ups and cleanings.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Digital X-rays & Diagnostics</h4>
                  <p className="mb-0">Quick, safe imaging to detect hidden dental issues early.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Tooth-Colored Fillings</h4>
                  <p className="mb-0">Natural-looking solutions to treat cavities and restore strength to your teeth.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Tooth Extractions</h4>
                  <p className="mb-0">Comfortable, gentle removal of damaged or problematic teeth.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Root Canal Therapy</h4>
                  <p className="mb-0">Save infected teeth with this pain-relieving, tooth-saving procedure.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Gum Disease Treatment</h4>
                  <p className="mb-0">Non-surgical and deep-cleaning options to treat gingivitis and periodontitis.</p>
                </div>
              </div>
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
                <div className="image" style={{ backgroundImage: 'url(/images/misc/s5.webp)', backgroundPosition: 'center', backgroundSize: 'cover' }}></div>
              </div>
              {/* Text */}
              <div className="col-lg-6">
                <div className="me-lg-3">
                  <div className="py-5 my-5 me-lg-3">
                    <div className="subtitle s2 mb-3 wow fadeInUp" data-wow-delay=".0s">Top Reasons</div>
                    <h2 className="wow fadeInUp" data-wow-delay=".2s">Why Choose Us</h2>

                    <div className="row g-4">
                      <div className="col-lg-8 col-md-8 col-sm-6">
                        <ul className="ul-check fw-600 text-white mb-4 wow fadeInUp" data-wow-delay=".6s">
                          <li>Experienced & Gentle Dentists</li>
                          <li>Modern Technology</li>
                          <li>Flexible Appointments</li>
                          <li>Transparent Pricing</li>
                          <li>Personalized Treatment Plans</li>
                          <li>Sterile & Safe Facility</li>
                        </ul>
                      </div>
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
