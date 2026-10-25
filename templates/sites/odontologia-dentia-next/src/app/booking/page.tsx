import Link from 'next/link';
import BookingForm from '@/components/BookingForm';

export default function Booking() {
  return (
    <>
      <section id="subheader" className="bg-color-op-1 text-center">
        <div className="container relative z-2">
          <div className="row align-items-center">
            <div className="col-lg-12">
              <h1 className="wow fadeInUp">Book Appointment</h1>
              <div className="border-bottom my-3"></div>
              <ul className="crumb wow fadeInDown">
                <li><Link href="/">Home</Link></li>
                <li className="active">Book Appointment</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      <section>
        <div className="container relative z-2">
          <div className="row g-4 gx-5 justify-content-between">

            <div className="col-lg-6">
              <BookingForm />
            </div>

            <div className="col-lg-6">
              <div className="h-100 rounded-1 relative" data-bgimage="url(images/misc/s4.webp) center" style={{ backgroundImage: 'url(/images/misc/s4.webp)', backgroundPosition: 'center', backgroundSize: 'cover' }}>
                <div className="bg-blur text-light shadow-1 abs start-10 bottom-10 p-4 rounded-1 overflow-hidden z-2" data-wow-delay=".5s">
                  <div className="d-flex justify-content-center">
                    <i className="fs-60 text-white icon_clock"></i>
                    <div className="ms-3">
                      <h4 className="mb-0">Opening Hours</h4>
                      Mon to Sat 08:00 - 20:00
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
