'use client';

import emailjs from '@emailjs/browser';
import { useMemo, useRef, useState } from 'react';

type SubmitStatus = 'idle' | 'sending' | 'success' | 'error';
const BOOKING_EMAILJS_SERVICE_ID = '';
const BOOKING_EMAILJS_TEMPLATE_ID = '';
const BOOKING_EMAILJS_PUBLIC_KEY = '';

export default function BookingForm() {
  const formRef = useRef<HTMLFormElement>(null);
  const [status, setStatus] = useState<SubmitStatus>('idle');
  const [errorMessage, setErrorMessage] = useState('');
  const today = useMemo(() => new Date().toISOString().split('T')[0], []);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setStatus('sending');
    setErrorMessage('');

    const serviceId = BOOKING_EMAILJS_SERVICE_ID.trim();
    const templateId = BOOKING_EMAILJS_TEMPLATE_ID.trim();
    const publicKey = BOOKING_EMAILJS_PUBLIC_KEY.trim();

    if (!formRef.current) {
      setStatus('error');
      setErrorMessage('Form tidak tersedia. Coba refresh halaman.');
      return;
    }

    if (!serviceId || !templateId || !publicKey) {
      const formData = new FormData(formRef.current);
      const mailto = `mailto:contact@dentiacare.com?subject=Booking Appointment - ${formData.get('service')}&body=Name: ${formData.get('name')}%0D%0AEmail: ${formData.get('email')}%0D%0APhone: ${formData.get('phone')}%0D%0AService: ${formData.get('service')}%0D%0ADate: ${formData.get('date')}%0D%0ATime: ${formData.get('time')}%0D%0AMessage: ${formData.get('message')}`;
      window.location.href = mailto;
      setStatus('success');
      return;
    }

    try {
      await emailjs.sendForm(serviceId, templateId, formRef.current, publicKey);
      setStatus('success');
      formRef.current.reset();
    } catch {
      setStatus('error');
      setErrorMessage('Gagal kirim booking. Coba lagi atau hubungi kami langsung.');
    }
  };

  return (
    <div className="relative">
      {status === 'success' ? (
        <div id="success_message_col" className="success p-40 h-100" style={{ display: 'block' }}>
          <h3>Thank You For Your Order</h3>
          <p>We have received your request and will be processing it shortly. Click button below if you want to make another order.</p>
          <button
            type="button"
            className="btn-main"
            onClick={() => setStatus('idle')}
          >
            Re-order
          </button>
        </div>
      ) : (
        <form ref={formRef} name="bookingForm" id="booking_form" onSubmit={handleSubmit}>
          <div className="row g-4">
            <div className="col-lg-12">
              <h3 className="mb-3"><i className="fa fa-envelope-o id-color me-2"></i> Book Your Appointment</h3>
              <p>Book your appointment today for expert dental care tailored to your needs. Healthy, beautiful smiles start with a simple step, schedule now!</p>
              <div className="relative">
                <select name="service" id="service" className="form-control" defaultValue="" required>
                  <option disabled value="">Select Service</option>
                  <option value="General Dentistry">General Dentistry</option>
                  <option value="Cosmetic Dentistry">Cosmetic Dentistry</option>
                  <option value="Pediatric Dentistry">Pediatric Dentistry</option>
                  <option value="Restorative Dentistry">Restorative Dentistry</option>
                  <option value="Preventive Dentistry">Preventive Dentistry</option>
                  <option value="Orthodontics">Orthodontics</option>
                </select>
                <i className="absolute top-0 end-0 id-color pt-3 pe-3 icofont-simple-down"></i>
              </div>
            </div>

            <div className="col-lg-6">
              <div id="date" className="relative input-group date" data-date-format="mm-dd-yyyy">
                <i className="absolute top-0 end-0 id-color pt-3 pe-3 icofont-calendar"></i>
                <input className="form-control" name="date" type="date" min={today} required />
                <span className="input-group-addon"><i className="glyphicon glyphicon-calendar"></i></span>
              </div>
            </div>

            <div className="col-lg-6">
              <div className="relative">
                <select name="time" id="time" className="form-control" defaultValue="" required>
                  <option disabled value="">Select Time</option>
                  <option value="10:00">10:00</option>
                  <option value="11:00">11:00</option>
                  <option value="12:00">12:00</option>
                  <option value="13:00">13:00</option>
                  <option value="14:00">14:00</option>
                  <option value="15:00">15:00</option>
                  <option value="16:00">16:00</option>
                  <option value="17:00">17:00</option>
                  <option value="18:00">18:00</option>
                  <option value="19:00">19:00</option>
                  <option value="20:00">20:00</option>
                </select>
                <i className="absolute top-0 end-0 id-color pt-3 pe-3 icofont-simple-down"></i>
              </div>
            </div>

            <div className="col-lg-4">
              <input type="text" name="name" id="name" placeholder="Name" className="form-control" required />
            </div>

            <div className="col-lg-4">
              <input type="email" name="email" id="email" placeholder="Email" className="form-control" required />
            </div>

            <div className="col-lg-4">
              <input type="text" name="phone" id="phone" placeholder="Phone" className="form-control" required />
            </div>

            <div className="col-lg-12">
              <textarea name="message" id="message" className="form-control" placeholder="Message"></textarea>
            </div>

            <div className="col-lg-12">
              <div id="submit">
                <input
                  type="submit"
                  id="send_message"
                  value={status === 'sending' ? 'Sending...' : 'Send Appointment'}
                  className="btn-main"
                  disabled={status === 'sending'}
                />
              </div>
            </div>
          </div>

          {status === 'error' && (
            <div id="error_message" className="error" style={{ display: 'block' }}>
              {errorMessage}
            </div>
          )}
        </form>
      )}
    </div>
  );
}
