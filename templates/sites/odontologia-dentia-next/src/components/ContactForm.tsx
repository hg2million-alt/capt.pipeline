'use client';

import { useState, useRef } from 'react';
import emailjs from '@emailjs/browser';

export default function ContactForm() {
  const form = useRef<HTMLFormElement>(null);
  const [status, setStatus] = useState<'idle' | 'sending' | 'success' | 'error'>('idle');
  const [errorMessage, setErrorMessage] = useState('');

  const sendEmail = (e: React.FormEvent) => {
    e.preventDefault();
    setStatus('sending');

    // REPLACE THESE VALUES WITH YOUR EMAILJS CREDENTIALS
    // 1. Go to https://www.emailjs.com/
    // 2. Create a free account
    // 3. Add an "Email Service" (e.g., Gmail) -> get SERVICE_ID
    // 4. Create an "Email Template" -> get TEMPLATE_ID
    // 5. Go to Account > API Keys -> get PUBLIC_KEY
    
    const SERVICE_ID = 'YOUR_SERVICE_ID';
    const TEMPLATE_ID = 'YOUR_TEMPLATE_ID';
    const PUBLIC_KEY = 'YOUR_PUBLIC_KEY';

    if (SERVICE_ID === 'YOUR_SERVICE_ID') {
        // Fallback for demo purposes if keys aren't set
        setTimeout(() => {
            const formData = new FormData(form.current!);
            const mailtoLink = `mailto:contact@dentiacare.com?subject=New Contact from ${formData.get('name')}&body=${formData.get('message')}%0D%0A%0D%0AFrom: ${formData.get('name')} (${formData.get('email')}, ${formData.get('phone')})`;
            window.location.href = mailtoLink;
            setStatus('success');
        }, 1000);
        return;
    }

    if (form.current) {
      emailjs.sendForm(SERVICE_ID, TEMPLATE_ID, form.current, PUBLIC_KEY)
        .then((result) => {
            console.log(result.text);
            setStatus('success');
            if (form.current) form.current.reset();
        }, (error) => {
            console.log(error.text);
            setStatus('error');
            setErrorMessage('Failed to send message. Please try again later or contact us directly.');
        });
    }
  };

  return (
    <div className="p-40 bg-color-op-1 rounded-1">
      <h3>Get In Touch</h3>
      <form ref={form} onSubmit={sendEmail} name="contactForm" id="contact_form" className="form-border">
        <div className="mb-4">
          <input type="text" name="name" id="name" className="form-control" placeholder="Your Name" required />
        </div>

        <div className="mb-4">
          <input type="email" name="email" id="email" className="form-control" placeholder="Your Email" required />
        </div>

        <div className="mb-4">
          <input type="text" name="phone" id="phone" className="form-control" placeholder="Your Phone" required />
        </div>

        <div className="mb-4 mb20">
          <textarea name="message" id="message" className="form-control" placeholder="Your Message" required></textarea>
        </div>

        <div id='submit' className="mt20">
          <input 
            type='submit' 
            id='send_message' 
            value={status === 'sending' ? 'Sending...' : 'Send Message'} 
            className="btn-main" 
            disabled={status === 'sending'}
          />
        </div>

        {status === 'success' && (
          <div id="success_message" className='success' style={{ display: 'block' }}>
            Your message has been sent successfully.
          </div>
        )}
        
        {status === 'error' && (
          <div id="error_message" className='error' style={{ display: 'block' }}>
            {errorMessage}
          </div>
        )}
      </form>
    </div>
  );
}
