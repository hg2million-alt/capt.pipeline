import Link from 'next/link';

export default function Dentists() {
  return (
    <>
      <section id="subheader" className="bg-color-op-1 text-center">
        <div className="container relative z-2">
          <div className="row align-items-center">
            <div className="col-lg-12">
              <h1 className="wow fadeInUp">Our Dentists</h1>
              <div className="border-bottom my-3"></div>
              <ul className="crumb wow fadeInDown">
                <li><Link href="/">Home</Link></li>
                <li className="active">Our Dentists</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      <section>
        <div className="container">
          <div className="row g-4 gy-5">
            <div className="col-md-12">
              <div className="bg-light rounded-1 relative overflow-hidden">
                <div className="abs end-0 bottom-0 p-5 fs-150 fw-bold op-1 lh-1 id-color">1
                </div>
                <div className="row g-0 align-items-center">
                  <div className="col-md-4">
                    <img src="/images/team/1.webp" className="w-100 rounded" alt="" />
                  </div>
                  <div className="col-md-8">
                    <div className="h-100 p-40">
                      <h3 className="mb-0">Dr. Sarah Bennett</h3>
                      <p className="id-color">Lead Dentist</p>

                      <h4>Qualification</h4>
                      <p>Doctor of Dental Surgery (DDS), New York University College of Dentistry</p>

                      <h4>Certifications</h4>
                      <ul className="ul-check">
                        <li>Certified in Invisalign Provider</li>
                        <li>Advanced Cardiac Life Support (ACLS)</li>
                      </ul>

                      <h4>Awards</h4>
                      <ul className="ul-check">
                        <li>“Top Dentist in Manhattan” – New York Dental Journal (2022)</li>
                        <li>American Academy of Cosmetic Dentistry Excellence Award (2021)</li>
                      </ul>

                      <div className="sc-icons mt-4">
                        <Link href="#"><i className="fa-brands fa-facebook-f"></i></Link>
                        <Link href="#"><i className="fa-brands fa-x-twitter"></i></Link>
                        <Link href="#"><i className="fa-brands fa-youtube"></i></Link>
                      </div>

                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-md-12">
              <div className="bg-light rounded-1 relative overflow-hidden">
                <div className="abs end-0 bottom-0 p-5 fs-150 fw-bold op-1 lh-1 id-color">2
                </div>
                <div className="row g-0 align-items-center">
                  <div className="col-md-4">
                    <img src="/images/team/2.webp" className="w-100 rounded" alt="" />
                  </div>
                  <div className="col-md-8">
                    <div className="h-100 p-40">
                      <h3 className="mb-0">Dr. Maya Lin</h3>
                      <p className="id-color">Cosmetic Dentist</p>

                      <h4>Qualification</h4>
                      <p>Doctor of Medicine in Dentistry (DMD), University of Pennsylvania School of Dental Medicine</p>

                      <h4>Certifications</h4>
                      <ul className="ul-check">
                        <li>Board Certified by the American Board of Periodontology</li>
                        <li>Sedation Dentistry Certified</li>
                      </ul>

                      <h4>Awards</h4>
                      <ul className="ul-check">
                        <li>Best Periodontist – Pennsylvania Dental Association (2023)</li>
                        <li>Clinical Research Award – American Dental Association (2020)</li>
                      </ul>

                      <div className="sc-icons mt-4">
                        <Link href="#"><i className="fa-brands fa-facebook-f"></i></Link>
                        <Link href="#"><i className="fa-brands fa-x-twitter"></i></Link>
                        <Link href="#"><i className="fa-brands fa-youtube"></i></Link>
                      </div>

                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-md-12">
              <div className="bg-light rounded-1 relative overflow-hidden">
                <div className="abs end-0 bottom-0 p-5 fs-150 fw-bold op-1 lh-1 id-color">3
                </div>
                <div className="row g-0 align-items-center">
                  <div className="col-md-4">
                    <img src="/images/team/3.webp" className="w-100 rounded" alt="" />
                  </div>
                  <div className="col-md-8">
                    <div className="h-100 p-40">
                      <h3 className="mb-0">Dr. Michael Reyes</h3>
                      <p className="id-color">Pediatric Specialist</p>

                      <h4>Qualification</h4>
                      <p>Bachelor of Dental Surgery (BDS), University of Mumbai; Master of Dental Surgery (MDS) in Orthodontics</p>

                      <h4>Certifications</h4>
                      <ul className="ul-check">
                        <li>Invisalign Platinum Provider</li>
                        <li>Certified in Digital Smile Design</li>
                      </ul>

                      <h4>Awards</h4>
                      <ul className="ul-check">
                        <li>National Orthodontics Innovation Award (India, 2021)</li>
                        <li>Excellence in Dental Practice – Indian Dental Association (2022)</li>
                      </ul>

                      <div className="sc-icons mt-4">
                        <Link href="#"><i className="fa-brands fa-facebook-f"></i></Link>
                        <Link href="#"><i className="fa-brands fa-x-twitter"></i></Link>
                        <Link href="#"><i className="fa-brands fa-youtube"></i></Link>
                      </div>

                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-md-12">
              <div className="bg-light rounded-1 relative overflow-hidden">
                <div className="abs end-0 bottom-0 p-5 fs-150 fw-bold op-1 lh-1 id-color">4
                </div>
                <div className="row g-0 align-items-center">
                  <div className="col-md-4">
                    <img src="/images/team/4.webp" className="w-100 rounded" alt="" />
                  </div>
                  <div className="col-md-8">
                    <div className="h-100 p-40">
                      <h3 className="mb-0">Dr. James Carter</h3>
                      <p className="id-color">Dental Hygienist</p>

                      <h4>Qualification</h4>
                      <p>DDS, University of Michigan; MS in Prosthodontics</p>

                      <h4>Certifications</h4>
                      <ul className="ul-check">
                        <li>Board Certified Prosthodontist</li>
                        <li>Laser Dentistry Certified (ALD)</li>
                      </ul>

                      <h4>Awards</h4>
                      <ul className="ul-check">
                        <li>American College of Prosthodontists Educator of the Year (2020)</li>
                        <li>International Smile Makeover Award (2023)</li>
                      </ul>

                      <div className="sc-icons mt-4">
                        <Link href="#"><i className="fa-brands fa-facebook-f"></i></Link>
                        <Link href="#"><i className="fa-brands fa-x-twitter"></i></Link>
                        <Link href="#"><i className="fa-brands fa-youtube"></i></Link>
                      </div>

                    </div>
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
