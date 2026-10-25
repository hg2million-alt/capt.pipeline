import Link from 'next/link';

export default function Header({
  className = "transparent scroll-light",
  useHeaderInner = false
}: {
  className?: string;
  useHeaderInner?: boolean;
}) {
  const isLightHeader = className.includes('header-light');
  const rowClassName = useHeaderInner ? "de-flex sm-pt10 header-inner" : "de-flex sm-pt10";

  return (
    <header className={className} data-base-class={className}>
      <div className="container">
        <div className="row">
          <div className="col-md-12">
            <div className={rowClassName}>
              <div className="de-flex-col">
                {/* logo begin */}
                <div id="logo">
                  <Link href="/">
                    <img className="logo-main logo" src="/images/logo-white.webp" alt="" />
                    <img className="logo-scroll logo-2" src="/images/logo-black.webp" alt="" />
                    <img className="logo-mobile" src={isLightHeader ? "/images/logo-black.webp" : "/images/logo-white.webp"} alt="" />
                  </Link>
                </div>
                {/* logo end */}
              </div>
              <div className="de-flex-col header-col-mid">
                {/* mainemenu begin */}
                <ul id="mainmenu">
                  <li>
                    <Link className="menu-item" href="/">Home</Link>
                    <ul>
                      <li><Link href="/">Homepage 1</Link></li>
                      <li><Link href="/homepage-2">Homepage 2</Link></li>
                      <li><Link href="/homepage-3">Homepage 3</Link></li>
                      <li><Link href="/homepage-4">Homepage 4</Link></li>
                      <li><Link href="/homepage-5">Homepage 5</Link></li>
                      <li><Link href="/homepage-6">Homepage 6</Link></li>
                      <li><Link href="/homepage-7">Homepage 7</Link></li>
                    </ul>
                  </li>
                  <li>
                    <Link className="menu-item" href="/services">Services</Link>
                    <ul>
                      <li><Link href="/services/general-dentistry">General Dentistry</Link></li>
                      <li><Link href="/services/cosmetic-dentistry">Cosmetic Dentistry</Link></li>
                      <li><Link href="/services/pediatric-dentistry">Pediatric Dentistry</Link></li>
                      <li><Link href="/services/restorative-dentistry">Restorative Dentistry</Link></li>
                      <li><Link href="/services/preventive-dentistry">Preventive Dentistry</Link></li>
                      <li><Link href="/services/orthodontics">Orthodontics</Link></li>
                      <li><Link href="/services">All Services</Link></li>
                    </ul>
                  </li>
                  <li><Link className="menu-item" href="/dentists">Dentists</Link></li>
                  <li>
                    <Link className="menu-item" href="#">Pages</Link>
                    <ul>
                      <li><Link href="/about">About Us</Link></li>
                      <li><Link href="/faq">FAQ</Link></li>
                      <li><Link href="/gallery">Gallery</Link></li>
                      <li><Link href="/testimonials">Testimonials</Link></li>
                    </ul>
                  </li>
                  <li><Link className="menu-item" href="/blog">Blog</Link></li>
                  <li><Link className="menu-item" href="/contact">Contact</Link></li>
                </ul>
                {/* mainmenu end */}
              </div>
              <div className="de-flex-col">
                <div className="menu_side_area">
                  <Link href="/booking" className="btn-main fx-slide"><span>Book Appointment</span></Link>
                  <span id="menu-btn"></span>
                </div>

                <div id="btn-extra">
                  <span></span>
                  <span></span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </header>
  );
}
