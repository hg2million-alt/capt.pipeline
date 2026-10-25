import Link from 'next/link';

export default function Testimonials() {
  return (
    <>
      <section id="subheader" className="bg-color-op-1 text-center">
        <div className="container relative z-2">
          <div className="row align-items-center">
            <div className="col-lg-12">
              <h1 className="wow fadeInUp">Testimonials</h1>
              <div className="border-bottom my-3"></div>
              <ul className="crumb wow fadeInDown">
                <li><Link href="/">Home</Link></li>
                <li className="active">Testimonials</li>
              </ul>
            </div>
          </div>
        </div>
      </section>
      
      <section>
        <div className="container">
          <div id="gallery" className="row g-4 justify-content-center wow fadeInUp">
            <div className="col-md-4 item">
              <div className="p-40 bg-light rounded-1">
                <div className="de-rating-ext mb-2">
                  <span className="d-stars">
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                  </span>
                </div>
                <p>Dr. Patel did an amazing job with my teeth whitening. I’ve never felt so confident about my smile!</p>
                <div className="relative">
                  <img className="circle absolute w-40px" alt="" src="/images/testimonial/1.webp" />
                  <div className="ms-60px">
                    <h4 className="mb-0 fs-16 lh-1">Jessica M.</h4>
                    <span className="fs-14">Teeth Whitening</span>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-md-4 item">
              <div className="p-40 bg-light rounded-1">
                <div className="de-rating-ext mb-2">
                  <span className="d-stars">
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star off"></i>
                  </span>
                </div>
                <p>After my root canal with Dr. Lin, I had zero pain and quick recovery. Truly a top-notch experience.</p>
                <div className="relative">
                  <img className="circle absolute w-40px" alt="" src="/images/testimonial/2.webp" />
                  <div className="ms-60px">
                    <h4 className="mb-0 fs-16 lh-1">David R.</h4>
                    <span className="fs-14">Root Canal Therapy</span>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-md-4 item">
              <div className="p-40 bg-light rounded-1">
                <div className="de-rating-ext mb-2">
                  <span className="d-stars">
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                  </span>
                </div>
                <p>Dr. Kim’s gentle touch during my cleaning made the whole process so comfortable.</p>
                <div className="relative">
                  <img className="circle absolute w-40px" alt="" src="/images/testimonial/3.webp" />
                  <div className="ms-60px">
                    <h4 className="mb-0 fs-16 lh-1">Nina T.</h4>
                    <span className="fs-14">Dental Cleaning</span>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-md-4 item">
              <div className="p-40 bg-light rounded-1">
                <div className="de-rating-ext mb-2">
                  <span className="d-stars">
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                  </span>
                </div>
                <p>I was nervous about getting veneers, but Dr. Alvarez and her team walked me through everything. I love my new smile!</p>
                <div className="relative">
                  <img className="circle absolute w-40px" alt="" src="/images/testimonial/4.webp" />
                  <div className="ms-60px">
                    <h4 className="mb-0 fs-16 lh-1">Matthew L.</h4>
                    <span className="fs-14">Porcelain Veneers</span>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-md-4 item">
              <div className="p-40 bg-light rounded-1">
                <div className="de-rating-ext mb-2">
                  <span className="d-stars">
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star off"></i>
                  </span>
                </div>
                <p>Thanks to Dr. Chen, my dental implant looks and feels just like a real tooth.</p>
                <div className="relative">
                  <img className="circle absolute w-40px" alt="" src="/images/testimonial/5.webp" />
                  <div className="ms-60px">
                    <h4 className="mb-0 fs-16 lh-1">Olivia S.</h4>
                    <span className="fs-14">Dental Implant</span>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-md-4 item">
              <div className="p-40 bg-light rounded-1">
                <div className="de-rating-ext mb-2">
                  <span className="d-stars">
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                  </span>
                </div>
                <p>I chipped a tooth on vacation, but Dr. Nguyen fixed it the same day with bonding that looks perfect.</p>
                <div className="relative">
                  <img className="circle absolute w-40px" alt="" src="/images/testimonial/6.webp" />
                  <div className="ms-60px">
                    <h4 className="mb-0 fs-16 lh-1">Jake H.</h4>
                    <span className="fs-14">Tooth Bonding</span>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-md-4 item">
              <div className="p-40 bg-light rounded-1">
                <div className="de-rating-ext mb-2">
                  <span className="d-stars">
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                  </span>
                </div>
                <p>My daughter had her first cavity filled by Dr. Singh. He was so kind and patient with her.</p>
                <div className="relative">
                  <img className="circle absolute w-40px" alt="" src="/images/testimonial/7.webp" />
                  <div className="ms-60px">
                    <h4 className="mb-0 fs-16 lh-1">Melissa A.</h4>
                    <span className="fs-14">Pediatric Dentistry</span>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-md-4 item">
              <div className="p-40 bg-light rounded-1">
                <div className="de-rating-ext mb-2">
                  <span className="d-stars">
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                  </span>
                </div>
                <p>They’re professional, friendly, and genuinely care about your dental health. I trust them completely and recommend them to anyone looking for great care.</p>
                <div className="relative">
                    <img className="circle absolute w-40px" alt="" src="/images/testimonial/8.webp" />
                    <div className="ms-60px">
                        <h4 className="mb-0 fs-16 lh-1">Alex P.</h4>
                        <span className="fs-14">Customer</span>
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
