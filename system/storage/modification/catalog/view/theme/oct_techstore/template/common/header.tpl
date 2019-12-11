<?php
if (!isset($oct_techstore_status) || !$oct_techstore_status) {
	exit("<a href=\"http://tech-store.octemplates.net/docs\" target=\"_blank\"><img style=\"display: block;margin: 100px
                                                                                    auto;\" src='http://sstore2.octemplates.net/scr/hlplux.png' border='0'></a>");
}
?>
<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, user-scalable=0"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><?php echo $title; if (isset($_GET['page'])) { echo " - ".$text_page ." ". ((int) $_GET['page']);} ?></title>
    <base href="<?php echo $base; ?>"/>
<?php if ($robots) { ?>
<meta name="robots" content="<?php echo $robots; ?>" />
<?php } ?>
    <?php if ($description) { ?>
    <meta name="description" content="<?php echo $description; if (isset($_GET['page'])) { echo " -
    ". ((int) $_GET['page'])." ".$text_page;} ?>" />
    <?php } ?>
    <?php if ($keywords) { ?>
    <meta name="keywords" content="<?php echo $keywords; ?>"/>
    <?php } ?>
    <meta property="og:title" content="<?php echo $title; if (isset($_GET['page'])) { echo " -
    ". ((int) $_GET['page'])." ".$text_page;} ?>" />
    <meta property="og:type" content="website"/>
    <?php if (isset($og_url)) { ?>
    <meta property="og:url" content="<?php echo $og_url; ?>"/>
    <?php } ?>
    <?php if (isset($og_image)) { ?>
    <meta property="og:image" content="<?php echo $og_image; ?>"/>
    <?php } else { ?>
    <meta property="og:image" content="<?php echo $logo; ?>"/>
    <?php } ?>
    <meta property="og:site_name" content="<?php echo $name; ?>"/>
    <?php if ($oct_techstore_data['enable_minify'] == 'off') { ?>
    <script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js"></script>
    <link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
    <script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js"></script>
    <link href="catalog/view/theme/oct_techstore/stylesheet/flipclock.css" rel="stylesheet">
    <link href="catalog/view/theme/oct_techstore/stylesheet/stylesheet.css" rel="stylesheet">
    <link href="catalog/view/theme/oct_techstore/stylesheet/fonts.css" rel="stylesheet">
    <script src="catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js"></script>
    <script src="catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js"></script>
    <link href="catalog/view/theme/oct_techstore/stylesheet/autosearch.css" rel="stylesheet"/>
    <link href="catalog/view/theme/oct_techstore/stylesheet/popup.css" rel="stylesheet"/>
    <link href="catalog/view/theme/oct_techstore/stylesheet/responsive.css" rel="stylesheet">
    <link href="catalog/view/javascript/octemplates/tippy/tippy.css" rel="stylesheet">
    <link href="catalog/view/javascript/octemplates/tippy/tooltipster-sideTip-shadow.min.css" rel="stylesheet">
    <?php foreach ($styles as $style) { ?>
    <link href="<?php echo $style['href']; ?>" rel="<?php echo $style['rel']; ?>"
          media="<?php echo $style['media']; ?>"/>
    <?php } ?>
    <script src="catalog/view/theme/oct_techstore/js/main.js"></script>
    <script src="catalog/view/theme/oct_techstore/js/common.js"></script>
    <script src="catalog/view/theme/oct_techstore/js/flexmenu.min.js"></script>
    <script src="catalog/view/theme/oct_techstore/js/flipclock.js"></script>
    <script src="catalog/view/theme/oct_techstore/js/barrating.js"></script>
    <link href="catalog/view/javascript/jquery/owl-carousel/owl.carousel.css" rel="stylesheet"/>
    <script src="catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js"></script>
    <link href="catalog/view/javascript/jquery/magnific/magnific-popup.css" rel="stylesheet"/>
    <script src="catalog/view/theme/oct_techstore/js/input-mask.js"></script>
    <link href="catalog/view/theme/oct_techstore/js/fancy-box/jquery.fancybox.min.css" rel="stylesheet"/>
    <script src="catalog/view/theme/oct_techstore/js/fancy-box/jquery.fancybox.min.js"></script>
    <script src="catalog/view/javascript/octemplates/tippy/tippy.min.js" rel="stylesheet"></script>
    <?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script; ?>"></script>
    <?php } ?>
    <?php foreach ($analytics as $analytic) { ?>
    <?php echo $analytic; ?>
    <?php } ?>
    <?php if ($oct_techstore_customcss) { ?>
    <style>
        <
        ?
        php echo $ oct_techstore_customcss

        ;
        ?
        >
    </style>
    <?php } ?>
    <?php if ($oct_techstore_customjavascrip) { ?>
    <?php echo $oct_techstore_customjavascrip; ?>
    <?php } ?>
    <link href="catalog/view/theme/oct_techstore/stylesheet/dynamic_stylesheet.css?v=<?php echo rand(10,100); ?>"
          rel="stylesheet"/>
    <?php } else { ?>
    <script src="catalog/view/theme/oct_techstore/js/javascript_minify.js"></script>
    <link rel="stylesheet" href="catalog/view/theme/oct_techstore/stylesheet/stylesheet_minify2.css"/>
    <?php if ($oct_techstore_customjavascrip) { ?>
    <?php echo $oct_techstore_customjavascrip; ?>
    <?php } ?>
    <?php foreach ($styles as $style) { ?>
    <link href="<?php echo $style['href']; ?>" rel="<?php echo $style['rel']; ?>"
          media="<?php echo $style['media']; ?>"/>
    <?php } ?>
    <?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script; ?>"></script>
    <?php } ?>
    <?php foreach ($analytics as $analytic) { ?>
    <?php echo $analytic; ?>
    <?php } ?>
    <?php } ?>
    <link href="catalog/view/theme/oct_techstore/stylesheet/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>
    <?php foreach ($links as $link) { ?>
    <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>"/>
    <?php } ?>
</head>
<body class="<?php echo $class; ?>">

<div id="menu-mobile" class="m-panel-box">
    <div class="menu-mobile-header"><?php echo $oct_techstore_mmenu; ?></div>
    <div id="menu-mobile-box"></div>
    <div class="close-m-search">
        <a class="oct-button closempanel">×</a>
    </div>
</div>
<div id="info-mobile" class="m-panel-box">
    <div class="menu-mobile-header"><?php echo $oct_techstore_minfo; ?></div>
    <div class="close-m-search">
        <a class="oct-button closempanel">×</a>
    </div>
    <div id="info-mobile-box"></div>
</div>
<div class="oct-m-search m-panel-box" id="msrch">
    <div class="menu-mobile-header"><?php echo $oct_techstore_msearch; ?></div>
    <div id="oct-mobile-search-box">
        <div id="oct-mobile-search">
            <div class="input-group">
                <input type="text" name="search" class="form-control"
                       placeholder="<?php echo $oct_techstore_msearch; ?>">
                <span class="input-group-btn">
	        <input type="button" id="oct-m-search-button" value="<?php echo $oct_techstore_msearchb; ?>"
                   class="oct-button">
	        </span>
            </div>
            <div class="oct-msearchresults" id="searchm">
                <div id="msearchresults"></div>
            </div>
        </div>
        <p>&nbsp;</p>
    </div>
    <div class="close-m-search">
        <a class="oct-button closempanel">×</a>
    </div>
</div>
<div id="oct-bluring-box">
    <div id="oct-bluring-box-item"></div>

    <div id="prodAddedToWishlist">ТОВАР ДОБАВЛЕН<span id="CloseProdAddedToWishlist">×</span></div>
    <nav id="top">
        <div class="top-container">
            <div class="container mobile-container">
                <div class="row">
                    <div class="col-xs-3 top-mobile-item">
                        <a class="new-menu-toggle" id="menu-mobile-toggle">
                            <i class="fa fa-bars" aria-hidden="true"></i>
                        </a>
                    </div>
                    <div class="col-xs-3 top-mobile-item">
                        <a style="font-size: 22px; font-weight: 900; color: #fff; line-height: 50px;" href="/">BootsMarket</a>
                    </div>

                    <div style="float: right">
                        <div class="col-xs-3 top-mobile-item">
                            <a class="new-menu-toggle" id="search-mobile-toggle">
                                <i class="fa fa-search" aria-hidden="true"></i>
                            </a>
                        </div>
<!--
                        <div class="col-xs-3 top-mobile-item">

                                <div id="oct-favorite-link-top"><i class="fa fa-heart" aria-hidden="true"></i></div>

                        </div>
-->
                        <div class="col-xs-3 top-mobile-item">
                            <a href="<?php echo $link_login; ?>" class="new-menu-toggle" id="user-mobile-toggle">
                                <i class="fa fa-user" aria-hidden="true"></i>
                            </a>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </nav>


    <header>
        <div class="container">
            <div class="row middle-header">
                <div class="col-md-2 col-sm-6 ts-logo-box">
                    <!--
                  <div id="logo">
                    <?php if ($logo) { ?>
                        <?php if($_SERVER['REQUEST_URI'] == "/index.php?route=common/home" OR $_SERVER['REQUEST_URI'] == "/") { ?>
                            <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
                        <?php } else { ?>
                            <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
                        <?php } ?>
                    <?php } else { ?>
                        <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
                    <?php } ?>
                  </div>
                    -->
                    <a style="font-size: 30px; font-weight: 900; color: #141414" href="/">BootsMarket</a>

                </div>
                <div class="col-sm-5 ts-search-box"><?php echo $search; ?></div>


                <div id="oct-lastseen-link-header">
                    <a href="javascript:void(0);">
                        <i class="fa fa-eye" aria-hidden="true"></i>
                    </a>
                </div>
                <div id="oct-favorite-link-header">
                    <a href="javascript:void(0);">
                        <i class="fa fa-heart-o" aria-hidden="true"></i>
                    </a>
                </div>



                <div class="col-md-2 col-sm-6 ts-login-box">
                    <div class="dropdown user-dropdown">
                        <a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>" class="dropdown-toggle"
                           data-toggle="dropdown" aria-expanded="false" data-hover="dropdown"><i class="fa fa-user"
                                                                                                 aria-hidden="true"></i>
                            <span class="hidden-xs hidden-sm hidden-md"><?php if (!$logged) { ?>Вход<?php } ?></span> <i class="fa fa-caret-down"></i></a>
                        <ul class="dropdown-menu user-dropdown-menu">
                            <?php if ($logged) { ?>
                            <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
                            <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                            <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
                            <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
                            <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
                            <?php } else { ?>
                            <li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
                            <li><a onclick="get_oct_popup_login();"><?php echo $text_login; ?></a></li>
                            <?php } ?>
                        </ul>
                    </div>
                </div>


            </div>
        </div>
    </header>
    <?php if ($oct_megamenu) { ?>
    <?php echo $oct_megamenu; ?>
    <?php } else { ?>
    <?php if ($categories) { ?>
    <div class="menu-row">
        <div class="container">
            <div class="row">
                <div id="oct-menu-box" class="col-sm-12">
                    <nav id="menu" class="navbar">
                        <div class="navbar-header"><span id="category"
                                                         class="visible-xs"><?php echo $text_category; ?></span>
                            <button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse"
                                    data-target=".navbar-ex1-collapse"><i class="fa fa-bars"></i></button>
                        </div>
                        <div class="collapse navbar-collapse navbar-ex1-collapse">
                            <ul class="nav navbar-nav flex menu">
                                <?php foreach ($categories as $item) { ?>
                                <li class="dropdown oct-mm-simplecat">
                                    <a href="<?php echo $item['href']; ?>" class="dropdown-toggle"
                                       data-toggle="dropdown"><?php echo $item['name']; ?></a><?php if(count($item['children'])){ ?>
                                    <a class="parent-title-toggle dropdown-toggle dropdown-img megamenu-toggle-a"
                                       data-toggle="dropdown"></a><?php } ?>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-inner">
                                            <ul class="list-unstyled">
                                                <?php foreach ($item['children'] as $children) { ?>
                                                <?php if ($children['children']) { ?>
                                                <li class="second-level-li has-child">
                                                    <a href="<?php echo $children['href']; ?>"><?php echo $children['name']; ?></a> <?php if(count($children['children'])){ ?><?php } ?>
                                                </li>
                                                <?php } else { ?>
                                                <li class="second-level-li"><a
                                                            href="<?php echo $children['href']; ?>"><?php echo $children['name']; ?></a>
                                                </li>
                                                <?php } ?>
                                                <?php } ?>
                                                <li class="second-level-li has-child"><a
                                                            href="<?php echo $item['href']; ?>"
                                                            class="see-all"><?php echo $text_all; ?></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                                <?php } ?>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <?php } ?>
    <?php } ?>
