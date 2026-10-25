import type { Metadata } from "next";
import Script from "next/script";
import Link from "next/link";
import "./globals.css";
import HeaderWrapper from "@/components/HeaderWrapper";
import Preloader from "@/components/Preloader";
import Footer from "@/components/Footer";
import ScriptHandler from "@/components/ScriptHandler";

export const metadata: Metadata = {
  title: "Dentia — Dentist & Dental Clinic Website Template",
  description: "Dentia — Dentist & Dental Clinic Website Template",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <head>
        <link href="/css/bootstrap.min.css" rel="stylesheet" type="text/css" id="bootstrap" />
        <link href="/css/plugins.css" rel="stylesheet" type="text/css" />
        <link href="/css/swiper.css" rel="stylesheet" type="text/css" />
        <link href="/css/style.css" rel="stylesheet" type="text/css" />
        <link id="colors" href="/css/colors/scheme-01.css" rel="stylesheet" type="text/css" />
      </head>
      <body>
        <ScriptHandler />
        <div id="wrapper">
          <a href="#" id="back-to-top"></a>

          {/* preloader begin */}
          <Preloader />
          {/* preloader end */}

          <HeaderWrapper />
          
          {/* content begin */}
          <div className="no-bottom no-top" id="content">
            <div id="top"></div>
            {children}
          </div>
          {/* content end */}

          <Footer />
        </div>
        
        {/* overlay content begin */}
        <div id="extra-wrap" className="text-light">
            <div id="btn-close">
                <span></span>
                <span></span>
            </div>

            <div id="extra-content">
                <img src="/images/logo-white.webp" className="w-150px" alt="" />

                <div className="spacer-30-line"></div>

                <h5>Our Services</h5>
                <ul className="ul-check">
                    <li><Link href="/services/general-dentistry">General Dentistry</Link></li>
                    <li><Link href="/services/cosmetic-dentistry">Cosmetic Dentistry</Link></li>
                    <li><Link href="/services/pediatric-dentistry">Pediatric Dentistry</Link></li>
                    <li><Link href="/services/restorative-dentistry">Restorative Dentistry</Link></li>
                    <li><Link href="/services/preventive-dentistry">Preventive Dentistry</Link></li>
                    <li><Link href="/services/orthodontics">Orthodontics</Link></li>
                </ul>

                <div className="spacer-30-line"></div>

                <h5>Contact Us</h5>
                <div><i className="icofont-clock-time me-2 op-5"></i>Monday - Friday 08.00 - 18.00</div>
                <div><i className="icofont-location-pin me-2 op-5"></i>100 S Main St, New York, </div>
                <div><i className="icofont-envelope me-2 op-5"></i>contact@dentiacare.com </div>

                <div className="spacer-30-line"></div>

                <h5>About Us</h5>
                <p>At Dentia, we’re dedicated to providing high-quality, personalized dental care for patients of all ages. Our skilled team uses the latest technology to ensure comfortable, efficient treatments and beautiful, healthy smiles for life.</p>

                <div className="social-icons">
                    <Link href="#"><i className="fa-brands fa-facebook-f"></i></Link>
                    <Link href="#"><i className="fa-brands fa-x-twitter"></i></Link>
                    <Link href="#"><i className="fa-brands fa-instagram"></i></Link>
                    <Link href="#"><i className="fa-brands fa-youtube"></i></Link>
                    <Link href="#"><i className="fa-brands fa-whatsapp"></i></Link>
                </div>
            </div>
        </div>
        
        <Script src="/js/plugins.js" strategy="beforeInteractive" />
        <Script src="/js/on3step.js" strategy="lazyOnload" />
        <Script src="/js/swiper.js" strategy="lazyOnload" />
        <Script src="/js/custom-marquee.js" strategy="lazyOnload" />
      </body>
    </html>
  );
}
