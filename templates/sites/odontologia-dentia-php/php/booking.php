<?php 
$header_class = 'transparent header-light'; 
include 'includes/header.php';

$page_js = [
    'js/validation-booking.js',
];

?>
<!-- Main Content Begin -->

            <section id="subheader" class="bg-color-op-1 text-center">
                <div class="container relative z-2">
                    <div class="row align-items-center">
                        <div class="col-lg-12">
                            <h1 class="wow fadeInUp">Book Appointment</h1>
                            <div class="border-bottom my-3"></div>
                            <ul class="crumb wow fadeInDown">
                                <li><a href="index.php">Home</a></li>
                                <li class="active">Book Appointment</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </section>


            <section>
                <div class="container relative z-2">
                    <div class="row g-4 gx-5 justify-content-between">

                        <div class="col-lg-6">
                            <div class="relative">
                                <div id="success_message_col" class='success p-40 h-100'>
                                    <h3>Thank You For Your Order</h3>
                                    <p>We have received your request and will be processing it shortly. Click button below if you want to make another order.</p>
                                    <a class="btn-main" href="booking.html">Re-order</a>
                                </div>

                                <form name="bookingForm" id="booking_form" class="relative" method="post" action="action-booking.php">

                                    <h3 class="mb-3"><i class="fa fa-envelope-o id-color me-2"></i> Book Your Appointment</h3>
                                    <p>Book your appointment today for expert dental care tailored to your needs. Healthy, beautiful smiles start with a simple step, schedule now!</p>


                                    <div class="row g-3">

                                        <div class="col-lg-12">
                                            <label for="service" class="form-label text-dark fw-500">Service</label>
                                            <div class="relative">
                                                <select name="service" id="service" class="form-control">
                                                    <option disabled selected value>Select Service</option>
                                                    <option value="General Dentistry">General Dentistry</option>
                                                    <option value="Cosmetic Dentistry">Cosmetic Dentistry</option>
                                                    <option value="Pediatric Dentistry">Pediatric Dentistry</option>
                                                    <option value="Restorative Dentistry">Restorative Dentistry</option>
                                                    <option value="Preventive Dentistry">Preventive Dentistry</option>
                                                    <option value="Orthodontics">Orthodontics</option>
                                                </select>
                                                <i class="absolute top-0 end-0 id-color pt-3 pe-3 icofont-simple-down"></i>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <label for="date" class="form-label text-dark fw-500">Date</label>
                                            <div class="field-set">
                                                <input type="date" name="date" id="date" class="form-control" required>
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <label for="time" class="form-label text-dark fw-500">Time</label>
                                            <div class="relative">
                                                <select name="time" id="time" class="form-control" required>
                                                    <option disabled selected value="">Select Time</option>
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
                                                <i class="absolute top-0 end-0 id-color pt-3 pe-3 icofont-simple-down"></i>
                                            </div>
                                        </div>

                                        <div class="col-lg-4">
                                            <label for="name" class="form-label text-dark fw-500">Name</label>
                                            <input type="text" name="name" id="name" class="form-control" placeholder="Your Name" required>
                                        </div>

                                        <div class="col-lg-4">
                                            <label for="email" class="form-label text-dark fw-500">Email</label>
                                            <input type="email" name="email" id="email" class="form-control" placeholder="Your Email" required>
                                        </div>

                                        <div class="col-lg-4">
                                            <label for="phone" class="form-label text-dark fw-500">Phone</label>
                                            <input type="tel" name="phone" id="phone" class="form-control" placeholder="Your Phone" required>
                                        </div>

                                        <div class="col-lg-12">
                                            <label for="message" class="form-label text-dark fw-500">Message</label>
                                            <textarea name="message" id="message" class="form-control" placeholder="Tell us about your appointment or service request" rows="5"></textarea>
                                        </div>

                                        <div class="col-lg-12">
                                            <div id="submit">
                                                <input type="submit" id="send_message" value="Send Appointment" class="btn-main">
                                            </div>
                                        </div>

                                    </div>

                                    <div id="error_message" class="error">
                                        Sorry there was an error sending your form.
                                    </div>

                                </form>

                                <div id="booking_success" class="d-none mt-4">

                                    <div class="alert alert-success mb-4">
                                        <h4 class="mb-2">Appointment Request Sent!</h4>
                                        <p class="mb-0">
                                            Thank you. We have received your appointment request and will contact you shortly.
                                        </p>
                                    </div>

                                    <div id="booking_summary"></div>

                                </div>

                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="h-100 rounded-1 relative" data-bgimage="url(images/misc/s4.webp) center">
                                <div class="bg-blur text-light shadow-1 abs start-10 bottom-10 p-4 rounded-1 overflow-hidden z-2" data-wow-delay=".5s">
                                    <div class="d-flex justify-content-center">
                                        <i class="fs-60 text-white icon_clock"></i>
                                        <div class="ms-3">
                                            <h4 class="mb-0">Opening Hours</h4>
                                            Mon to Sat 08:00 - 20:00
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>                        

                    </div>
                </div>
            </section>

        </div>
        <!-- content end -->

<?php include 'includes/footer.php'; ?>