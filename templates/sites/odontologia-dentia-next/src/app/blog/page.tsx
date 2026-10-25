import Link from 'next/link';

export default function Blog() {
  return (
    <>
      <section id="subheader" className="bg-color-op-1 text-center">
        <div className="container relative z-2">
          <div className="row align-items-center">
            <div className="col-lg-12">
              <h1 className="wow fadeInUp">Our Blog</h1>
              <div className="border-bottom my-3"></div>
              <ul className="crumb wow fadeInDown">
                <li><Link href="/">Home</Link></li>
                <li className="active">Blog</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      <section>
        <div className="container">
          <div className="row g-4 gy-5">
            <div className="col-lg-4">
              <div className="overflow-hidden">
                <div className="relative">
                  <div className="abs z-2 bg-color rounded-2 text-white p-3 pb-2 m-4 text-center fw-600">
                    <h4 className="fs-36 mb-0 lh-1">20</h4>
                    <span>Jun</span>
                  </div>
                  <img src="/images/blog/l1.webp" className="rounded-1 w-100" alt="" />
                </div>

                <div className="pt-4">
                  <Link href="/blog/single">
                    <h4 className="mb-3">Discover 10 Easy Tips to Maintain a Healthier and Brighter Smile Today</h4>
                  </Link>
                  <div>
                    <img src="/images/testimonial/1.webp" className="w-20px me-2 circle" alt="" />
                    <div className="d-inline fs-14 me-3">Brunilda Doniger</div>
                    <div className="d-inline fs-14"><i className="icofont-tags id-color me-2"></i>Health Care</div>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-4">
              <div className="overflow-hidden">
                <div className="relative">
                  <div className="abs z-2 bg-color rounded-2 text-white p-3 pb-2 m-4 text-center fw-600">
                    <h4 className="fs-36 mb-0 lh-1">20</h4>
                    <span>Jun</span>
                  </div>
                  <img src="/images/blog/l2.webp" className="rounded-1 w-100" alt="" />
                </div>

                <div className="pt-4">
                  <Link href="/blog/single">
                    <h4 className="mb-3">Is Teeth Whitening Safe and Effective? Here’s What You Need to Know</h4>
                  </Link>
                  <div>
                    <img src="/images/testimonial/1.webp" className="w-20px me-2 circle" alt="" />
                    <div className="d-inline fs-14 me-3">Brunilda Doniger</div>
                    <div className="d-inline fs-14"><i className="icofont-tags id-color me-2"></i>Health Care</div>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-4">
              <div className="overflow-hidden">
                <div className="relative">
                  <div className="abs z-2 bg-color rounded-2 text-white p-3 pb-2 m-4 text-center fw-600">
                    <h4 className="fs-36 mb-0 lh-1">20</h4>
                    <span>Jun</span>
                  </div>
                  <img src="/images/blog/l3.webp" className="rounded-1 w-100" alt="" />
                </div>

                <div className="pt-4">
                  <Link href="/blog/single">
                    <h4 className="mb-3">Braces vs. Clear Aligners: Which Orthodontic Option Fits You Best?</h4>
                  </Link>
                  <div>
                    <img src="/images/testimonial/1.webp" className="w-20px me-2 circle" alt="" />
                    <div className="d-inline fs-14 me-3">Brunilda Doniger</div>
                    <div className="d-inline fs-14"><i className="icofont-tags id-color me-2"></i>Health Care</div>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-4">
              <div className="overflow-hidden">
                <div className="relative">
                  <div className="abs z-2 bg-color rounded-2 text-white p-3 pb-2 m-4 text-center fw-600">
                    <h4 className="fs-36 mb-0 lh-1">20</h4>
                    <span>Jun</span>
                  </div>
                  <img src="/images/blog/l4.webp" className="rounded-1 w-100" alt="" />
                </div>

                <div className="pt-4">
                  <Link href="/blog/single">
                    <h4 className="mb-3">What to Expect During Your First Visit to the Dentist’s Office</h4>
                  </Link>
                  <div>
                    <img src="/images/testimonial/1.webp" className="w-20px me-2 circle" alt="" />
                    <div className="d-inline fs-14 me-3">Brunilda Doniger</div>
                    <div className="d-inline fs-14"><i className="icofont-tags id-color me-2"></i>Health Care</div>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-4">
              <div className="overflow-hidden">
                <div className="relative">
                  <div className="abs z-2 bg-color rounded-2 text-white p-3 pb-2 m-4 text-center fw-600">
                    <h4 className="fs-36 mb-0 lh-1">20</h4>
                    <span>Jun</span>
                  </div>
                  <img src="/images/blog/l5.webp" className="rounded-1 w-100" alt="" />
                </div>

                <div className="pt-4">
                  <Link href="/blog/single">
                    <h4 className="mb-3">5 Warning Signs You May Need a Root Canal and Why It&apos;s Not So Bad</h4>
                  </Link>
                  <div>
                    <img src="/images/testimonial/1.webp" className="w-20px me-2 circle" alt="" />
                    <div className="d-inline fs-14 me-3">Brunilda Doniger</div>
                    <div className="d-inline fs-14"><i className="icofont-tags id-color me-2"></i>Health Care</div>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-lg-4">
              <div className="overflow-hidden">
                <div className="relative">
                  <div className="abs z-2 bg-color rounded-2 text-white p-3 pb-2 m-4 text-center fw-600">
                    <h4 className="fs-36 mb-0 lh-1">20</h4>
                    <span>Jun</span>
                  </div>
                  <img src="/images/blog/l6.webp" className="rounded-1 w-100" alt="" />
                </div>

                <div className="pt-4">
                  <Link href="/blog/single">
                    <h4 className="mb-3">How to Protect Your Child’s Teeth and Prevent Cavities Early On</h4>
                  </Link>
                  <div>
                    <img src="/images/testimonial/1.webp" className="w-20px me-2 circle" alt="" />
                    <div className="d-inline fs-14 me-3">Brunilda Doniger</div>
                    <div className="d-inline fs-14"><i className="icofont-tags id-color me-2"></i>Health Care</div>
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
