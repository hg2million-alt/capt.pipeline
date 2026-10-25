import Link from 'next/link';

export default function About() {
  return (
    <>
      <section id="subheader" className="bg-color-op-1 text-center">
        <div className="container relative z-2">
          <div className="row align-items-center">
            <div className="col-lg-12">
              <h1 className="wow fadeInUp">About Us</h1>
              <div className="border-bottom my-3"></div>
              <ul className="crumb wow fadeInDown">
                <li><Link href="/">Home</Link></li>
                <li className="active">About Us</li>
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

      <section>
        <div className="container">
          <div className="row gy-4 gx-5 align-items-center">
            <div className="col-lg-6">
              <div className="subtitle id-color wow fadeInUp" data-wow-delay=".0s">Why Choose Our Dental Care</div>
              <h2 className="wow fadeInUp" data-wow-delay=".2s">Exceptional Service With a Personal Touch</h2>
              <p className="wow fadeInUp" data-wow-delay=".4s">Choosing the right dental provider matters. We combine expert care, advanced technology, and a warm atmosphere to ensure every visit is comfortable, efficient, and tailored to your unique needs.</p>

              <div className="border-bottom mb-4"></div>

              <div className="row g-4">
                <div className="col-lg-6">
                  <div className="h-100">
                    <div className="relative wow fadeInUp">
                      <h5>Experienced Dental</h5>
                      <p className="mb-0">Skilled care backed by years of trusted dental experience.</p>
                    </div>
                  </div>
                </div>

                <div className="col-lg-6">
                  <div className="h-100">
                    <div className="relative wow fadeInUp">
                      <h5>Advanced Technology</h5>
                      <p className="mb-0">Modern tools ensure accurate and efficient treatments.</p>
                    </div>
                  </div>
                </div>

                <div className="col-lg-6">
                  <div className="h-100">
                    <div className="relative wow fadeInUp">
                      <h5>Personalized Treatment</h5>
                      <p className="mb-0">Custom care plans made to fit your smile and lifestyle.</p>
                    </div>
                  </div>
                </div>

                <div className="col-lg-6">
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

          </div>

        </div>
      </section>
    </>
  );
}
