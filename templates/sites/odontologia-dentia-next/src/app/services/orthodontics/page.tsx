import Link from 'next/link';

export default function Orthodontics() {
  return (
    <>
      <section id="subheader" className="bg-color-op-1 text-center">
        <div className="container relative z-2">
          <div className="row align-items-center">
            <div className="col-lg-12">
              <h1 className="wow fadeInUp">Orthodontics</h1>
              <div className="border-bottom my-3"></div>
              <ul className="crumb wow fadeInDown">
                <li><Link href="/">Home</Link></li>
                <li><Link href="/services">Services</Link></li>
                <li className="active">Orthodontics</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      <section>
        <div className="container">
          <div className="row g-4 gx-5 align-items-center">
            <div className="col-md-3 wow fadeInRight">
              <div className="relative rounded-1 overflow-hidden">
                <img src="/images/misc/p1.webp" className="w-100" alt="" />
                <div className="de-overlay-gradient-color h-50 top-50"></div>
              </div>
            </div>
            <div className="col-md-6">
              <div className="ps-lg-3 text-lg-center">
                <div className="subtitle id-color wow fadeInUp" data-wow-delay=".2s">Orthodontics</div>
                <h2 className="wow fadeInUp" data-wow-delay=".4s">Transform Your Smile with Expert Orthodontic Care</h2>
                <p className="mb-0 wow fadeInUp" data-wow-delay=".6s">We offer comprehensive orthodontic services designed to help you achieve a healthier, more beautiful smile. Whether you are considering braces, Invisalign, or other treatments, our experienced team is here to guide you every step of the way.</p>
              </div>
            </div>
            <div className="col-md-3 wow fadeInRight">
              <div className="relative rounded-1 overflow-hidden">
                <img src="/images/misc/p2.webp" className="w-100" alt="" />
                <div className="de-overlay-gradient-color h-50 top-50"></div>
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
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Orthodontic Treatments We Offer</h2>
            </div>
          </div>

          <div className="row g-4">
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Traditional Metal Braces</h4>
                  <p className="mb-0">The most common and reliable method for straightening teeth and correcting bite issues for all ages.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Ceramic Braces</h4>
                  <p className="mb-0">A more discreet alternative to metal braces, using clear or tooth-colored materials that blend with your smile.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Invisalign / Clear Aligners</h4>
                  <p className="mb-0">Virtually invisible aligners that offer a comfortable, removable, and discreet way to straighten teeth.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Early Orthodontic Treatment</h4>
                  <p className="mb-0">Interventions for children to guide proper jaw growth and prevent more serious issues later.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Retainers</h4>
                  <p className="mb-0">Essential appliances to maintain your new smile after braces or aligner treatment.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Surgical Orthodontics</h4>
                  <p className="mb-0">Orthodontic treatment combined with surgery to correct severe jaw misalignments and bite problems.</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-color-op-2">
        <div className="container">
          <div className="row g-4">
            <div className="col-lg-5">
              <div className="subtitle id-color wow fadeInUp" data-wow-delay=".0s">Why Choose Us</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Why Choose Our Orthodontic Services?</h2>
            </div>

            <div className="col-lg-7">
              <div className="row g-4">
                <div className="col-md-6 wow fadeInUp" data-wow-delay=".3s">
                  <div className="relative">
                    <span className="abs w-70px p-3 circle bg-color d-block">
                      <img src="/images/ui/check-white.png" className="w-100" alt="" />
                    </span>
                    <div className="ps-90">
                      <h5>Experienced Team</h5>
                      <p className="mb-0">Our board-certified orthodontists have years of experience providing top-quality care with the latest techniques and technology in orthodontics.</p>
                    </div>
                  </div>
                </div>

                <div className="col-md-6 wow fadeInUp" data-wow-delay=".4s">
                  <div className="relative">
                    <span className="abs w-70px p-3 circle bg-color d-block">
                      <img src="/images/ui/check-white.png" className="w-100" alt="" />
                    </span>
                    <div className="ps-90">
                      <h5>Personalized Treatment Plans</h5>
                      <p className="mb-0">We take the time to understand your unique needs and create a treatment plan tailored specifically to you.</p>
                    </div>
                  </div>
                </div>

                <div className="col-md-6 wow fadeInUp" data-wow-delay=".5s">
                  <div className="relative">
                    <span className="abs w-70px p-3 circle bg-color d-block">
                      <img src="/images/ui/check-white.png" className="w-100" alt="" />
                    </span>
                    <div className="ps-90">
                      <h5>Comfortable Environment</h5>
                      <p className="mb-0">We strive to create a welcoming, stress-free atmosphere for patients of all ages, making each visit enjoyable and relaxing.</p>
                    </div>
                  </div>
                </div>

                <div className="col-md-6 wow fadeInUp" data-wow-delay=".6s">
                  <div className="relative">
                    <span className="abs w-70px p-3 circle bg-color d-block">
                      <img src="/images/ui/check-white.png" className="w-100" alt="" />
                    </span>
                    <div className="ps-90">
                      <h5>Advanced Technology</h5>
                      <p className="mb-0">We use state-of-the-art tools, such as digital X-rays and 3D imaging, to ensure the most accurate diagnosis and treatment plan for you.</p>
                    </div>
                  </div>
                </div>

                <div className="col-md-6 wow fadeInUp" data-wow-delay=".7s">
                  <div className="relative">
                    <span className="abs w-70px p-3 circle bg-color d-block">
                      <img src="/images/ui/check-white.png" className="w-100" alt="" />
                    </span>
                    <div className="ps-90">
                      <h5>Flexible Payment Plans</h5>
                      <p className="mb-0">We offer various payment options to make orthodontic care accessible to everyone, including financing and insurance assistance.</p>
                    </div>
                  </div>
                </div>

                <div className="col-md-6 wow fadeInUp" data-wow-delay=".8s">
                  <div className="relative">
                    <span className="abs w-70px p-3 circle bg-color d-block">
                      <img src="/images/ui/check-white.png" className="w-100" alt="" />
                    </span>
                    <div className="ps-90">
                      <h5>Proven Results</h5>
                      <p className="mb-0">We have helped thousands of patients achieve their dream smiles, delivering beautiful, long-lasting results that boost both oral health and confidence.</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="no-top no-bottom overflow-hidden">
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
                      <h3 className="mb-4 wow fadeInUp fs-32">The staff is so patient and gentle with my daughter. She actually looks forward to going to the orthodontist now!</h3>
                      <span className="wow fadeInUp">Rachel T.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">I couldn't be happier with my Invisalign results. The process was smooth, and my smile looks amazing!</h3>
                      <span className="wow fadeInUp">James M.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">Dr. [Name] explained everything clearly and made me feel at ease about getting braces as an adult. So glad I went for it!</h3>
                      <span className="wow fadeInUp">Samantha L.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">My teen just got his braces off, and the results are fantastic. We’re so grateful for the care and attention he received throughout the process.</h3>
                      <span className="wow fadeInUp">Carlos D.</span>
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
