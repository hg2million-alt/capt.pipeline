import Link from 'next/link';

export default function Services() {
  return (
    <>
      <section id="subheader" className="bg-color-op-1 text-center">
        <div className="container relative z-2">
          <div className="row align-items-center">
            <div className="col-lg-12">
              <h1 className="wow fadeInUp">Our Services</h1>
              <div className="border-bottom my-3"></div>
              <ul className="crumb wow fadeInDown">
                <li><Link href="/">Home</Link></li>
                <li className="active">Our Services</li>
              </ul>
            </div>
          </div>
        </div>
      </section>
      
      <section>
        <div className="container">
          <div className="row g-4">
            <div className="col-lg-3 col-md-6">
              <div className="hover">
                <div className="bg-color-op-1 h-100 p-40 rounded-1">
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

            <div className="col-lg-3 col-md-6">
              <div className="hover">
                <div className="bg-color-op-1 h-100 p-40 rounded-1">
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

            <div className="col-lg-3 col-md-6">
              <div className="h-100 rounded-1" data-bgimage="url(/images/misc/s3.webp) center">
              </div>
            </div>

            <div className="col-lg-3 col-md-6">
              <div className="hover">
                <div className="bg-color-op-1 h-100 p-40 rounded-1">
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
            
            <div className="col-lg-3 col-md-6">
              <div className="hover">
                <div className="bg-color-op-1 h-100 p-40 rounded-1">
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

            <div className="col-lg-3 col-md-6">
              <div className="h-100 rounded-1" data-bgimage="url(/images/misc/s2.webp) center">
              </div>
            </div>
            
            {/* Added extra items to complete the grid based on pattern */}
            <div className="col-lg-3 col-md-6">
                <div className="hover">
                    <div className="bg-color-op-1 h-100 p-40 rounded-1">
                        <img src="/images/icons/tooth-1.png" className="w-70px mb-3 wow scaleIn" alt="" />
                        <div className="relative mt-4 wow fadeInUp">
                            <h4>Preventive Dentistry</h4>
                            <p>Prevent problems before they start with our comprehensive care.</p>
                            <Link className="btn-plus" href="/services/preventive-dentistry">
                                <i className="fa fa-plus"></i>
                                <span>Read more</span>
                            </Link>
                        </div>
                    </div>
                </div>
            </div>

            <div className="col-lg-3 col-md-6">
                <div className="hover">
                    <div className="bg-color-op-1 h-100 p-40 rounded-1">
                        <img src="/images/icons/tooth-2.png" className="w-70px mb-3 wow scaleIn" alt="" />
                        <div className="relative mt-4 wow fadeInUp">
                            <h4>Orthodontics</h4>
                            <p>Straighten your teeth and correct your bite with modern solutions.</p>
                            <Link className="btn-plus" href="/services/orthodontics">
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
    </>
  );
}
