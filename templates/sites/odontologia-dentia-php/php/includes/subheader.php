<section id="subheader" class="section-dark bg-dark text-light relative jarallax">
    <div class="gradient-edge-top"></div>
    <img 
            src="<?php echo isset($subheader_image) ? $subheader_image : 'images/background/1.webp'; ?>" 
            class="jarallax-img" 
            alt="<?php echo isset($page_heading) ? $page_heading : 'Subheader Image'; ?>"
        >
    <div class="container relative z-2">
        <div class="row gy-4 gx-5 align-items-center">
            <div class="spacer-double sm-hide"></div>

            <div class="col-lg-6">
                <h1 class="mb-0 wow fadeInUp" data-wow-delay=".2s">
                    <?php echo isset($page_heading) ? $page_heading : ""; ?>
                </h1>

                <ul class="crumb wow fadeInUp">
                    <li><a href="index.php">Home</a></li>
                    <li class="active"><?php echo isset($page_heading) ? $page_heading : ""; ?></li>
                </ul>   
            </div>

            <div class="col-lg-6 text-lg-end sm-hide">
                <h3>
                    <?php echo isset($page_tagline) ? $page_tagline : '"Prevention is cheaper than a breach"'; ?>
                </h3>
            </div>
        </div>
    </div>
</section>
