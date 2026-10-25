</div>
        <!-- content end -->

        <!-- footer begin -->
        <footer class="section-dark">
            <div class="container">
                <div class="row gx-5">
                    <div class="col-lg-4 col-sm-6">
                        <img src="images/logo-white.webp" class="logo-footer" alt="" >
                        <div class="spacer-20"></div>
                        <p>At Dentia, we’re dedicated to providing high-quality, personalized dental care for patients of all ages. Our skilled team uses the latest technology to ensure comfortable, efficient treatments and beautiful, healthy smiles for life.</p>

                        <div class="social-icons mb-sm-30">
                            <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                            <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
                            <a href="#"><i class="fa-brands fa-whatsapp"></i></a>
                            <a href="#"><i class="fa-brands fa-instagram"></i></a>
                            <a href="#"><i class="fa-brands fa-youtube"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-12 order-lg-1 order-sm-2">
                        <div class="row">
                            <div class="col-lg-6 col-sm-6">
                                <div class="widget">
                                    <h5>Company</h5>
                                    <ul>                                        
                                        <li><a href="index.php">Home</a></li>
                                        <li><a href="services.php">Our Services</a></li>
                                        <li><a href="gallery.php">Gallery</a></li>
                                        <li><a href="about.php">About Us</a></li>
                                        <li><a href="blog.php">Blog</a></li>
                                        <li><a href="contact.php">Contact</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-lg-6 col-sm-6">
                                <div class="widget">
                                    <h5>Our Services</h5>
                                    <ul>
                                        <li><a href="service-general-dentistry.php">General Dentistry</a></li>
                                        <li><a href="service-cosmetic-dentistry.php">Cosmetic Dentistry</a></li>
                                        <li><a href="service-pediatric-dentistry.php">Pediatric Dentistry</a></li>
                                        <li><a href="service-restorative-dentistry.php">Restorative Dentistry</a></li>
                                        <li><a href="service-preventive-dentistry.php">Preventive Dentistry</a></li>
                                        <li><a href="service-orthodontics.php">Orthodontics</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 order-lg-2 order-sm-1">
                        <div class="widget">
                            <h5>Contact Us</h5>
                            <div class="fw-bold text-white"><i class="icofont-location-pin me-2 id-color"></i>Clinic Location</div>
                            100 S Main St, New York, NY

                            <div class="spacer-20"></div>

                            <div class="fw-bold text-white"><i class="icofont-phone me-2 id-color"></i>Call Us</div>
                            +1 123 456 789

                            <div class="spacer-20"></div>

                            <div class="fw-bold text-white"><i class="icofont-envelope me-2 id-color"></i>Send a Message</div>
                            contact@dentiacare.com                            
                        </div>
                    </div>
                </div>
            </div>
            <div class="subfooter">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="de-flex">
                                <div class="de-flex-col">
                                    Copyright [ANO] - [NOME DO CLIENTE]
                                </div>
                                <ul class="menu-simple">
                                    <li><a href="#">Terms &amp; Conditions</a></li>
                                    <li><a href="#">Privacy Policy</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- footer end -->
    </div>

    <!-- overlay content begin -->
    <div id="extra-wrap" class="text-light">
        <div id="btn-close">
            <span></span>
            <span></span>
        </div>

        <div id="extra-content">
            <img src="images/logo-white.webp" class="w-150px" alt="">

            <div class="spacer-30-line"></div>

            <h5>Our Services</h5>
            <ul class="ul-check">
                <li><a href="service-general-dentistry.php">General Dentistry</a></li>
                <li><a href="service-cosmetic-dentistry.php">Cosmetic Dentistry</a></li>
                <li><a href="service-pediatric-dentistry.php">Pediatric Dentistry</a></li>
                <li><a href="service-restorative-dentistry.php">Restorative Dentistry</a></li>
                <li><a href="service-preventive-dentistry.php">Preventive Dentistry</a></li>
                <li><a href="service-orthodontics.php">Orthodontics</a></li>
            </ul>

            <div class="spacer-30-line"></div>

            <h5>Contact Us</h5>
            <div><i class="icofont-clock-time me-2 op-5"></i>Monday - Friday 08.00 - 18.00</div>
            <div><i class="icofont-location-pin me-2 op-5"></i>100 S Main St, New York, </div>
            <div><i class="icofont-envelope me-2 op-5"></i>contact@dentiacare.com </div>

            <div class="spacer-30-line"></div>

            <h5>About Us</h5>
            <p>At Dentia, we’re dedicated to providing high-quality, personalized dental care for patients of all ages. Our skilled team uses the latest technology to ensure comfortable, efficient treatments and beautiful, healthy smiles for life.</p>

            <div class="social-icons">
                <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
                <a href="#"><i class="fa-brands fa-youtube"></i></a>
                <a href="#"><i class="fa-brands fa-whatsapp"></i></a>
            </div>
        </div>
    </div>
    
    <!-- Javascript Files
    ================================================== -->
    <script src="js/plugins.js"></script>
    <script src="js/theme.js"></script>
    <script src="js/custom-marquee.js"></script>
    <?php
    if (!empty($page_js)) {
        foreach ($page_js as $js) {
            echo '<script src="' . htmlspecialchars($js, ENT_QUOTES, 'UTF-8') . '"></script>' . PHP_EOL;
        }
    }
    ?>

</body>

</html>