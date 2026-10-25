<?php 
$header_class = 'transparent header-light'; 
include 'includes/header.php'; 

$page_js = [
    'js/validation-contact.js',
];

?>
<!-- Main Content Begin -->

            <section id="subheader" class="bg-color-op-1 text-center">
                <div class="container relative z-2">
                    <div class="row align-items-center">
                        <div class="col-lg-12">
                            <h1 class="wow fadeInUp">Contact Us</h1>
                            <div class="border-bottom my-3"></div>
                            <ul class="crumb wow fadeInDown">
                                <li><a href="index.php">Home</a></li>
                                <li class="active">Contact</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </section>


            <section>
                <div class="container">
                    <div class="row g-4">
                        <div class="col-lg-6">
                            <div class="subtitle">Get In Touch</div>
                            <h2 class="wow fadeInUp">We are always ready to help you and answer your questions</h2>

                            <p>Whether you have a question, a suggestion, or just want to say hello, this is the place to do it. Please fill out the form below with your details and message, and we'll get back to you as soon as possible.</p>

                            <div class="row g-4 gx-5">
                                <div class="col-lg-6">
                                    <div class="fw-bold text-dark"><i class="icofont-clock-time me-2 id-color-2"></i>We're Open</div>
                                    Monday - Friday 08.00 - 18.00
                                </div>

                                <div class="col-lg-6">
                                    <div class="fw-bold text-dark"><i class="icofont-location-pin me-2 id-color-2"></i>Clinic Location</div>
                                    100 S Main St, New York, NY
                                </div>

                                <div class="col-lg-6">
                                    <div class="fw-bold text-dark"><i class="icofont-phone me-2 id-color-2"></i>Call Us Directly</div>
                                    +1 123 456 789
                                </div>

                                <div class="col-lg-6">
                                    <div class="fw-bold text-dark"><i class="icofont-envelope me-2 id-color-2"></i>Send a Message</div>
                                    contact@dentiacare.com       
                                </div>
                            </div>



                        </div>

                        <div class="col-lg-6">
                            <div class="p-40 bg-color-op-1 rounded-1">
                                <h3>Get In Touch</h3>
                                <form name="contactForm" id="contact_form" method="post" action="action-contact.php">

                                    <div class="mb-4">
                                        <input type="text" name="name" id="name" class="form-control" placeholder="Your Name" required>
                                    </div>

                                    <div class="mb-4">
                                        <input type="text" name="email" id="email" class="form-control" placeholder="Your Email" required>
                                    </div>

                                    <div class="mb-4">
                                        <input type="text" name="phone" id="phone" class="form-control" placeholder="Your Phone" required>
                                    </div>

                                    <div class="mb-4 mb20">
                                        <textarea name="message" id="message" class="form-control" placeholder="Your Message" required></textarea>
                                    </div>


                                    <div id='submit' class="mt20">
                                        <input type='submit' id='send_message' value='Send Message' class="btn-main">
                                    </div>

                                    <div id="success_message" class='success'>
                                        Your message has been sent successfully. Refresh this page if you want to send more messages.
                                    </div>
                                    <div id="error_message" class='error'>
                                        Sorry there was an error sending your form.
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>
                </div>
            </section>

<!-- Main Content End -->

<?php include 'includes/footer.php'; ?>