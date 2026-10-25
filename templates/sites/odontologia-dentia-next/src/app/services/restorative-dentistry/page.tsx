import Link from 'next/link';

export default function RestorativeDentistry() {
  return (
    <>
      <section id="subheader" className="bg-color-op-1 text-center">
        <div className="container relative z-2">
          <div className="row align-items-center">
            <div className="col-lg-12">
              <h1 className="wow fadeInUp">Restorative Dentistry</h1>
              <div className="border-bottom my-3"></div>
              <ul className="crumb wow fadeInDown">
                <li><Link href="/">Home</Link></li>
                <li><Link href="/services">Services</Link></li>
                <li className="active">Restorative Dentistry</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      <section>
        <div className="container">
          <div className="row g-4 align-items-center">
            <div className="col-lg-6">
              <div className="pe-lg-3">
                <div className="subtitle id-color wow fadeInUp" data-wow-delay=".2s">Restorative Dentistry</div>
                <h2 className="wow fadeInUp" data-wow-delay=".4s">Restore Your Smile with Confidence</h2>
                <p className="mb-0 wow fadeInUp" data-wow-delay=".6s">Our restorative dentistry services focus on repairing damaged or missing teeth to restore function, health, and aesthetics. Whether you need a simple filling or a complex reconstruction, our experienced team is here to help you regain a healthy, confident smile.</p>
              </div>
            </div>

            <div className="col-lg-6">
              <div className="row align-items-center">
                <div className="col-6">
                  <img src="/images/misc/l3.webp" className="w-100 rounded-1 mb-4" alt="" />
                  <img src="/images/misc/l2.webp" className="w-100 rounded-1" alt="" />
                </div>
                <div className="col-6">
                  <img src="/images/misc/l5.webp" className="w-100 rounded-1" alt="" />
                </div>
              </div>
            </div>
          </div>

          <div className="spacer-double"></div>

          <div className="row g-4">
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Fillings</h4>
                  <p className="mb-0">Restore cavities with durable, tooth-colored fillings that blend seamlessly with your natural smile.</p>
                </div>
              </div>
            </div>
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Crowns</h4>
                  <p className="mb-0">Cap a damaged or decayed tooth with a custom-made crown for strength and aesthetic appeal.</p>
                </div>
              </div>
            </div>
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Bridges</h4>
                  <p className="mb-0">Replace missing teeth by securing a prosthetic tooth between two healthy teeth with a dental bridge.</p>
                </div>
              </div>
            </div>
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Dental Implants</h4>
                  <p className="mb-0">A permanent solution for missing teeth, providing a stable foundation for crowns, bridges, or dentures.</p>
                </div>
              </div>
            </div>
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Dentures</h4>
                  <p className="mb-0">Restore missing teeth with custom-made dentures that help you chew, speak, and smile with confidence.</p>
                </div>
              </div>
            </div>
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Inlays &amp; Onlays</h4>
                  <p className="mb-0">Custom restorations that fit inside or on top of a damaged tooth for a more conservative solution than crowns.</p>
                </div>
              </div>
            </div>
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Root Canals</h4>
                  <p className="mb-0">Save a damaged or infected tooth by removing the affected tissue and restoring the tooth to full function.</p>
                </div>
              </div>
            </div>
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Tooth Extractions</h4>
                  <p className="mb-0">When a tooth is beyond repair, we offer gentle extractions and follow-up options like implants or bridges.</p>
                </div>
              </div>
            </div>
            <div className="col-lg-4 col-md-6">
              <div className="border-gray p-40 h-100 rounded-1">
                <div className="relative wow fadeInUp">
                  <h4>Veneers</h4>
                  <p className="mb-0">Enhance the appearance of your smile with custom-made porcelain veneers that cover imperfections and create a flawless smile.</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-color-op-1">
        <div className="container">
          <div className="row g-4 mb-2 justify-content-center">
            <div className="col-lg-5 text-center">
              <div className="subtitle s2 wow fadeInUp mb-2">Top Reasons</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Why Choose Us</h2>
            </div>
          </div>
          <div className="row g-4">
            <div className="col-lg-4 col-md-6 wow fadeInUp">
              <div className="relative">
                <i className="abs fs-40 p-4 bg-color text-light icon_check rounded-1"></i>
                <div className="ps-100 ms-4">
                  <h4>Patient-Centered Care</h4>
                  <p>We prioritize your comfort and goals, ensuring every treatment plan is tailored specifically to your needs.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6 wow fadeInUp">
              <div className="relative">
                <i className="abs fs-40 p-4 bg-color text-light icon_check rounded-1"></i>
                <div className="ps-100 ms-4">
                  <h4>Experienced Specialists</h4>
                  <p>Our team includes highly skilled restorative dentists dedicated to delivering long-lasting, natural-looking results.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6 wow fadeInUp">
              <div className="relative">
                <i className="abs fs-40 p-4 bg-color text-light icon_check rounded-1"></i>
                <div className="ps-100 ms-4">
                  <h4>Comprehensive Services</h4>
                  <p>We offer a full range of restorative treatments, from simple fillings to complex full-mouth reconstructions.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6 wow fadeInUp">
              <div className="relative">
                <i className="abs fs-40 p-4 bg-color text-light icon_check rounded-1"></i>
                <div className="ps-100 ms-4">
                  <h4>Modern Technology</h4>
                  <p>We utilize the latest dental technology, ensuring accurate diagnoses, efficient treatments, and optimal outcomes.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6 wow fadeInUp">
              <div className="relative">
                <i className="abs fs-40 p-4 bg-color text-light icon_check rounded-1"></i>
                <div className="ps-100 ms-4">
                  <h4>Emergency Care</h4>
                  <p>We provide emergency dental care for unexpected issues, ensuring you receive prompt treatment when needed most.</p>
                </div>
              </div>
            </div>

            <div className="col-lg-4 col-md-6 wow fadeInUp">
              <div className="relative">
                <i className="abs fs-40 p-4 bg-color text-light icon_check rounded-1"></i>
                <div className="ps-100 ms-4">
                  <h4>Convenient Scheduling</h4>
                  <p>We offer flexible hours to fit your busy schedule, including early morning and evening appointments.</p>
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
