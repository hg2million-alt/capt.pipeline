import Link from 'next/link';

export default function Footer() {
  return (
    <footer className="section-dark">
      <div className="container">
        <div className="row gx-5">
          <div className="col-lg-4 col-sm-6">
            <img src="/images/logo-white.webp" className="logo-footer" alt="" />
            <div className="spacer-20"></div>
            <p>At Dentia, we’re dedicated to providing high-quality, personalized dental care for patients of all ages. Our skilled team uses the latest technology to ensure comfortable, efficient treatments and beautiful, healthy smiles for life.</p>

            <div className="social-icons mb-sm-30">
              <Link href="#"><i className="fa-brands fa-facebook-f"></i></Link>
              <Link href="#"><i className="fa-brands fa-x-twitter"></i></Link>
              <Link href="#"><i className="fa-brands fa-whatsapp"></i></Link>
              <Link href="#"><i className="fa-brands fa-instagram"></i></Link>
              <Link href="#"><i className="fa-brands fa-youtube"></i></Link>
            </div>
          </div>
          <div className="col-lg-4 col-sm-12 order-lg-1 order-sm-2">
            <div className="row">
              <div className="col-lg-6 col-sm-6">
                <div className="widget">
                  <h5>Company</h5>
                  <ul>
                    <li><Link href="/">Home</Link></li>
                    <li><Link href="/services">Our Services</Link></li>
                    <li><Link href="/gallery">Gallery</Link></li>
                    <li><Link href="/about">About Us</Link></li>
                    <li><Link href="/blog">Blog</Link></li>
                    <li><Link href="/contact">Contact</Link></li>
                  </ul>
                </div>
              </div>
              <div className="col-lg-6 col-sm-6">
                <div className="widget">
                  <h5>Our Services</h5>
                  <ul>
                    <li><Link href="/services/general-dentistry">General Dentistry</Link></li>
                    <li><Link href="/services/cosmetic-dentistry">Cosmetic Dentistry</Link></li>
                    <li><Link href="/services/pediatric-dentistry">Pediatric Dentistry</Link></li>
                    <li><Link href="/services/restorative-dentistry">Restorative Dentistry</Link></li>
                    <li><Link href="/services/preventive-dentistry">Preventive Dentistry</Link></li>
                    <li><Link href="/services/orthodontics">Orthodontics</Link></li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          <div className="col-lg-4 col-sm-6 order-lg-2 order-sm-1">
            <div className="widget">
              <h5>Contact Us</h5>
              <div className="fw-bold text-white"><i className="icofont-location-pin me-2 id-color"></i>Clinic Location</div>
              100 S Main St, New York, NY

              <div className="spacer-20"></div>

              <div className="fw-bold text-white"><i className="icofont-phone me-2 id-color"></i>Call Us</div>
              +1 123 456 789

              <div className="spacer-20"></div>

              <div className="fw-bold text-white"><i className="icofont-envelope me-2 id-color"></i>Send a Message</div>
              contact@dentiacare.com
            </div>
          </div>
        </div>
      </div>
      <div className="subfooter">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <div className="de-flex">
                <div className="de-flex-col">
                  Copyright {new Date().getFullYear()} - Dentia
                </div>
                <ul className="menu-simple">
                  <li><Link href="#">Terms &amp; Conditions</Link></li>
                  <li><Link href="#">Privacy Policy</Link></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </footer>
  );
}
