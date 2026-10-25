import Link from 'next/link';

export default function CosmeticDentistry() {
  return (
    <>
      <section id="subheader" className="bg-color-op-1 text-center">
        <div className="container relative z-2">
          <div className="row align-items-center">
            <div className="col-lg-12">
              <h1 className="wow fadeInUp">Cosmetic Dentistry</h1>
              <div className="border-bottom my-3"></div>
              <ul className="crumb wow fadeInDown">
                <li><Link href="/">Home</Link></li>
                <li><Link href="/services">Services</Link></li>
                <li className="active">Cosmetic Dentistry</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      <section>
        <div className="container">
          <div className="row g-4 align-items-center">
            <div className="col-lg-7">
              <div className="relative">
                <div className="w-100 pe-5 pb-5 wow scaleIn">
                  <img src="/images/misc/l2.webp" className="w-100 rounded-1" alt="" />
                </div>
                <div className="bg-color rounded-1 text-light w-50 p-4 abs end-0 bottom-0 z-2 soft-shadow wow scaleIn" data-wow-delay=".2s">
                  <i className="fa fa-quote-left fs-32 abs"></i>
                  <h4 className="ps-50">Your natural beauty begins with a confident smile</h4>
                </div>
              </div>
            </div>
            <div className="col-lg-5">
              <div className="ps-lg-3">
                <div className="subtitle id-color wow fadeInUp" data-wow-delay=".2s">Cosmetic Dentistry</div>
                <h2 className="wow fadeInUp" data-wow-delay=".4s">Enhancing Your Smile with Art and Precision</h2>
                <p className="mb-0 wow fadeInUp" data-wow-delay=".6s">We believe your smile is your best accessory. Our cosmetic dentistry services are designed to improve the appearance of your teeth, gums, and overall smile—boosting your confidence and helping you look your best.</p>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-dark text-light">
        <div className="container">
          <div className="row g-4">
            <div className="col-lg-5">
              <div className="subtitle id-color wow fadeInUp" data-wow-delay=".0s">Why Choose Us</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Why Choose Our Cosmetic Dental Services?</h2>
            </div>

            <div className="col-lg-7">
              <ul className="ul-check fs-500">
                <li>Experienced cosmetic dentists with an eye for detail and artistry</li>
                <li>Advanced technology, including digital smile design and mock-up previews</li>
                <li>Customized treatment plans tailored to your aesthetic goals and lifestyle</li>
                <li>Gentle techniques with a focus on patient comfort and minimal discomfort</li>
                <li>Natural-looking results that enhance your facial features and confidence</li>
                <li>Comprehensive smile solutions—from simple touch-ups to full makeovers</li>
                <li>Clean, modern clinic environment with a warm and welcoming team</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      <section>
        <div className="container">
          <div className="row g-4 justify-content-center">
            <div className="col-lg-8 text-center">
              <div className="subtitle wow fadeInUp mb-3">Cosmetic Dentistry</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Cosmetic Treatments We Offer</h2>
            </div>
          </div>

          <div className="row g-4">
            <div className="col-lg-3 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Teeth Whitening</h4>
                  <p className="mb-0">Brighten your smile safely with professional whitening that works in just one visit.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-3 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Dental Veneers</h4>
                  <p className="mb-0">Ultra-thin porcelain shells that cover imperfections and create a flawless smile.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-3 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Cosmetic Bonding</h4>
                  <p className="mb-0">An affordable way to repair chips, cracks, and small gaps using tooth-colored resin.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-3 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Smile Makeovers</h4>
                  <p className="mb-0">A customized combination of treatments to fully transform and enhance your smile.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-3 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Tooth Contouring</h4>
                  <p className="mb-0">Refine tooth shape and smooth rough edges for a more symmetrical, balanced smile.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-3 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Gum Contouring</h4>
                  <p className="mb-0">Reshape your gum line to correct a gummy smile and improve symmetry.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-3 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Invisalign &amp; Clear Aligners</h4>
                  <p className="mb-0">Straighten teeth discreetly with clear aligners—no brackets or wires needed.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-3 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Metal-Free Crowns</h4>
                  <p className="mb-0">Restore damaged teeth with all-ceramic crowns that blend seamlessly with your smile.</p>
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
                <div className="image" style={{ backgroundImage: 'url(/images/misc/l3.webp)', backgroundPosition: 'center', backgroundSize: 'cover' }}></div>
              </div>
              {/* Text */}
              <div className="col-lg-5 offset-lg-7">
                <div className="py-5 my-5">
                  <div className="owl-single-dots owl-carousel owl-theme">
                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">I never thought I’d love my smile this much. The veneers look so natural, and the process was surprisingly comfortable. I finally feel confident in every photo!</h3>
                      <span className="wow fadeInUp">Jessica M.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">The team took the time to listen to what I wanted and made it happen. My whitening results were incredible, and I get compliments all the time. I actually enjoy going to the dentist now!</h3>
                      <span className="wow fadeInUp">Darren K.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">From start to finish, I felt completely taken care of. My smile makeover was life-changing. I can’t stop smiling—literally!</h3>
                      <span className="wow fadeInUp">Elena R.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">I was always self-conscious about my teeth. After my bonding and reshaping, it’s like I have a brand-new smile. Quick, painless, and totally worth it.</h3>
                      <span className="wow fadeInUp">Carlos F.</span>
                    </div>

                    <div className="item">
                      <i className="icofont-quote-left id-color fs-40 mb-4 wow fadeInUp"></i>
                      <h3 className="mb-4 wow fadeInUp fs-32">The results exceeded my expectations. The cosmetic work looks so natural, and the staff was supportive every step of the way.</h3>
                      <span className="wow fadeInUp">Aisha B.</span>
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
