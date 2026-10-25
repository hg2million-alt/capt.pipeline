<!DOCTYPE html>
<html lang="en">

<head>
    <title>Dentia — Dentist & Dental Clinic PHP Website Template</title>
    <link rel="icon" href="images/icon.webp" type="image/gif" sizes="16x16">
    <meta content="text/html;charset=utf-8" http-equiv="Content-Type">
    <meta content="width=device-width, initial-scale=1.0" name="viewport" >
    <meta content="Dentia — Dentist & Dental Clinic PHP Website Template" name="description" >
    <meta content="" name="keywords" >
    <meta content="" name="author" >
    <!-- CSS Files
    ================================================== -->
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" id="bootstrap">
    <link href="css/plugins.css" rel="stylesheet" type="text/css" >
    <?php
    if (!empty($page_css)) {
        foreach ($page_css as $css) {
            echo '<link rel="stylesheet" href="' . htmlspecialchars($css, ENT_QUOTES, 'UTF-8') . '">' . PHP_EOL;
        }
    }
    ?>
    <link href="css/style.css" rel="stylesheet" type="text/css" >
    <!-- color scheme -->
    <link id="colors" href="css/colors/scheme-01.css" rel="stylesheet" type="text/css" >

</head>

<body>
    <div id="wrapper">
        <a href="#" id="back-to-top"></a>

        <!-- preloader begin -->
        <div id="de-loader"></div>
        <!-- preloader end -->

        <!-- header begin -->
        <?php
        $has_light = isset($header_class) && strpos($header_class, 'header-light') !== false;
        ?>

        <header <?php echo isset($header_class) ? 'class="'.$header_class.'"' : ''; ?>>
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="de-flex sm-pt10">
                            <div class="de-flex-col">

                                <!-- logo header dark -->
                                <?php if(!$has_light): ?>
                                <div id="logo">
                                    <a href="index.php">
                                        <img class="logo-main" src="images/logo-white.webp" alt="">
                                        <img class="logo-scroll" src="images/logo-black.webp" alt="">
                                        <img class="logo-mobile" src="images/logo-white.webp" alt="">
                                    </a>
                                </div>
                                <?php endif; ?>

                                <!-- logo header light -->
                                <?php if($has_light): ?>
                                <div id="logo">
                                    <a href="index.php">
                                        <img class="logo-main" src="images/logo-black.webp" alt="">
                                        <img class="logo-scroll" src="images/logo-black.webp" alt="">
                                        <img class="logo-mobile" src="images/logo-black.webp" alt="">
                                    </a>
                                </div>
                                <?php endif; ?>

                            </div>

                            <!-- NAVIGATION MENU -->
                            <div class="de-flex-col header-col-mid">
                                <?php include 'menu.php'; ?>
                            </div>

                            <div class="de-flex-col">
                                <div class="menu_side_area">
                                    <a href="booking.php" class="btn-main fx-slide"><span>Book Appointment</span></a>
                                    <span id="menu-btn"></span>
                                </div>

                                <div id="btn-extra">
                                    <span></span>
                                    <span></span>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- header end -->
        <!-- content begin -->
        <div class="no-bottom no-top" id="content">

            <div id="top"></div>