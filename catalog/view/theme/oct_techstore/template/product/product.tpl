<?php echo $header; ?>
<div class="container">
  <?php echo $content_top; ?>
  <div class="col-sm-12  content-row product-content-row">
    <div class="breadcrumb-box">
      	 <ul class="breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
		    <?php foreach ($breadcrumbs as $count => $breadcrumb) { ?>
			    <?php if($count == 0) { ?>
				  <li>
					<a href="<?php echo $breadcrumb['href']; ?>" title="<?php echo $oct_home_text; ?>">
					  <?php echo $breadcrumb['text']; ?>
					</a>
				  </li>
		        <?php } elseif($count+1<count($breadcrumbs)) { ?>
		        	<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
					<a itemscope itemtype="https://schema.org/Thing" itemprop="item" href="<?php echo $breadcrumb['href']; ?>" itemid="<?php echo $breadcrumb['href']; ?>" title="<?php echo $breadcrumb['text']; ?>">
					  <span itemprop="name"><?php echo $breadcrumb['text']; ?></span>
					</a>
					<meta itemprop="position" content="<?php echo $count; ?>" />
					</li>
		        <?php } else { ?>
		        	<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
		        	<span itemscope itemtype="https://schema.org/Thing" itemprop="item" itemid="<?php echo $breadcrumb['href']; ?>">
					  <span itemprop="name"><?php echo $breadcrumb['text']; ?></span>
					</span>
					<meta itemprop="position" content="<?php echo $count; ?>" />
		        	</li>
		        <?php } ?>
			<?php } ?>
	  </ul>
    </div>
    <div class="row">
      <?php echo $column_left; ?>
      <?php if ($column_left && $column_right) { ?>
      <?php $class = 'col-sm-6'; ?>
      <?php } elseif ($column_left || $column_right) { ?>
      <?php $class = 'col-sm-9'; ?>
      <?php } else { ?>
      <?php $class = 'col-sm-12'; ?>
      <?php } ?>
      <div id="content" class="<?php echo $class; ?>"<?php if ($tech_pr_micro == "on") { ?> itemscope itemtype="https://schema.org/Product"<?php } ?>>
        <?php if ($tech_pr_micro == "on") { ?><span class="micro-name" itemprop="name"><?php echo $heading_title; ?></span><?php } ?>
        <div class="row">


          <?php if ($column_left || $column_right) { ?>
          <?php $class = 'col-sm-6'; ?>
          <?php } else { ?>
          <?php $class = 'col-sm-6'; ?>
          <?php } ?>
          <div class="<?php echo $class; ?> left-info">
            <?php if ($thumb || $images) { ?>
            <ul>
              <?php if ($special) { ?>
              <li id="main-product-you-save">-<?php echo $economy; ?>%</li>
              <?php } ?>

              <?php if ($oct_product_stickers) { ?>
              <li class="product-sticker-box">
                <?php foreach ($oct_product_stickers as $product_sticker) { ?>
                <div style="color: <?php echo $product_sticker['color']; ?>; background: <?php echo $product_sticker['background']; ?>;">
                  <?php echo $product_sticker['text']; ?>
                </div>
                <?php } ?>
              </li>
              <?php } ?>
              <?php if ($thumb) { ?>
              <li class="image thumbnails-one thumbnail">
                <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" <?php if ($check_zoom) { ?>data-fancybox="images" <?php } else { ?>onclick="funcyFirst(); return false;"<?php } ?> class='cloud-zoom' id='zoom1' data-index="0">
                <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" class="img-responsive" alt="<?php echo $heading_title; ?>" />
                </a>

                <a id="arrow-prev-img" class="cbutton--effect-nikola cbutton"><i class="fa fa-angle-left fa-5x" style="font-size: 60px;line-height: 48px;"></i></a>
                <a id="arrow-next-img" class="cbutton--effect-nikola cbutton"><i class="fa fa-angle-right fa-5x" style="font-size: 60px;line-height: 48px;"></i></a>
                <script type="text/javascript">

                </script>
              </li>
              <?php } ?>
            </ul>

			<?php if (count($images) > 1) { ?>
              <div class="image-additional" id="image-additional">
                <div class="thumbnails all-carousel">
                  <?php $data_index = 0; foreach ($images as $image) { ?>
                  <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" data-fancybox="images" data-index="<?php echo $data_index; ?>" data-main-img="<?php echo $image['main_img']; ?>" data-main-popup="<?php echo $image['main_popup']; ?>" class="cloud-zoom-gallery <?php if ($data_index == 0) { ?>selected-thumb<?php } ?>" data-rel="useZoom: 'zoom1', smallImage: '<?php echo $image['popup']; ?>'">
                  <img src="<?php echo $image['thumb']; ?>" <?php if ($tech_pr_micro == "on") { ?>itemprop="image" <?php } ?>title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="img-responsive" />
                  </a>
                  <?php $data_index++; } ?>
                </div>
              </div>
			<?php } ?>
            <script>
                $(function() {
                    $("#image-additional .all-carousel").owlCarousel({
        				items: 5,
        				itemsDesktop : [1921,4],
        				itemsDesktop : [1199,4],
        				itemsDesktopSmall : [979,4],
        				itemsTablet : [768,4],
        				itemsMobile : [479,4],
        				autoPlay: false,
        				navigation: true,
        				slideMargin: 10,
        				navigationText: ['<i class="fa fa-angle-left fa-5x" aria-hidden="true"></i>', '<i class="fa fa-angle-right fa-5x" aria-hidden="true"></i>'],
        				stopOnHover:true,
        				smartSpeed: 800,
        				loop: true,
        				pagination: false
        			});
                })
            </script>
            <?php } ?>
          </div>
          <?php if ($column_left || $column_right) { ?>
          <?php $class = 'col-sm-6'; ?>
          <?php } else { ?>
          <?php $class = 'col-sm-6'; ?>
          <?php } ?>
          <div id="product-info-right" class="<?php echo $class; ?>">
            <h1 class="product-header"><?php echo $heading_title; ?></h1>


            <div id="product">



              <div class="row">
                <div class="col-sm-12">
                  <hr class="product-hr">
                </div>
              </div>

              <?php if($special_date_start && $special_date_end > 0) { ?>
              <div class="row" id="product-info-counter">
              	<div class="product-info-counter-header col-lg-4 col-md-12 col-sm-12 col-xs-12"><?php echo $text_counter; ?></div>
	            <link href="catalog/view/javascript/octemplates/p_special_timer/flipclock.css" rel="stylesheet" media="screen" />
				<script src="catalog/view/javascript/octemplates/p_special_timer/flipclock.js"></script>
	            <div class="counter col-lg-8 col-md-12 col-sm-12 col-xs-12">
                  <div id="clock-<?php echo $product_id; ?>"></div>
                  <script>
                  $(document).ready(function() {
                    var futureDate  = new Date("<?php echo $special_date_end; ?> 00:00:00".replace(/-/g, "/"));
                    var currentDate = new Date("<?php echo date("Y-m-d H:i:s"); ?>".replace(/-/g, "/"));

                    var diff = futureDate.getTime() / 1000 - currentDate.getTime() / 1000;
                    function dayDiff(first, second) {
                      return (second-first)/(1000*60*60*24);
                    }
                    if (dayDiff(currentDate, futureDate) < 100) {
                      $('.clock').addClass('twoDayDigits');
                    } else {
                      $('.clock').addClass('threeDayDigits');
                    }
                    if(diff < 0) {
                      diff = 0;
                    }
                    clock = $('#clock-<?php echo $product_id; ?>').FlipClock(diff, {
                      clockFace: 'DailyCounter',
                      countdown: true,
                      language: '<?php echo $language_code; ?>'
                    });
                  });
                  </script>
                </div>
                </div>
	            <?php } ?>
              <?php if ($price) { ?>
              <div class="row">

                <div class="price-col"<?php if ($tech_pr_micro == "on") { ?> itemprop="offers" itemscope itemtype="https://schema.org/Offer"<?php } ?>>
                  <?php if ($tech_pr_micro == "on") {  ?>
                  <?php if ($disable_buy == 0) {
	                  $stockinfo = "InStock";
                    } elseif ($disable_buy == 2) {
                    $stockinfo = "OutOfStock";
                    } else {
                    $stockinfo = "PreOrder";
                   }  ?>
                  <span itemprop="availability" class="micro-availability" content="https://schema.org/<?php echo $stockinfo; ?>"><?php echo $stock."\r\n"; ?></span>
                  <meta itemprop="priceCurrency" content="<?php echo $oct_tech_currency_code_data; ?>" />
                  <span class="micro-price" itemprop="price" content="<?php if (!$special) { echo preg_replace('/[^0-9,.]+/','',rtrim($price, "."));}else{echo preg_replace('/[^0-9,.]+/','',rtrim($special, "."));} ?>"><?php if (!$special) { echo preg_replace('/[^0-9,.]+/','',rtrim($price, "."));}else{echo preg_replace('/[^0-9,.]+/','',rtrim($special, "."));} ?></span>
                  <?php } ?>
                  <div class="product-price" style="display: inline-block;">
                  <?php if ($reward) { ?>
		            <span class="oct-reward"><?php echo $text_reward; ?> <?php echo $reward; ?></span>
		           <?php } ?>
                  <?php if (!$special) { ?>
                    <h2 id="main-product-price" class="oct-price-normal"><?php echo $price; ?></h2>
                  <?php } else { ?>
                    <h3 id="main-product-price" class="oct-price-old"><?php echo $price; ?></h3>
                    <h2 id="main-product-special" class="oct-price-new"><?php echo $special; ?></h2>
                  <?php } ?>
                  </div>

                <div class="after-header-item" id="new-soc-buttons">

                  <script src="//yastatic.net/es5-shims/0.0.2/es5-shims.min.js"></script>
                  <script src="//yastatic.net/share2/share.js"></script>
                  <div class="ya-share2" data-services="vkontakte,facebook,odnoklassniki" data-counter=""></div>
                </div>

                  <?php if ($tax) { ?>
                  <p><?php echo $text_tax; ?> <span id="main-product-tax"><?php echo $tax; ?></span></p>
                  <?php } ?>
                  <?php if ($points) { ?>
                  <p><?php echo $text_points; ?> <?php echo $points; ?></p>
                  <?php } ?>
                  <?php if ($discounts) { ?>
                  <?php foreach ($discounts as $discount) { ?>
                  <p><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></p>
                  <?php } ?>
                  <?php } ?>
                </div>


              </div>
              <?php } ?>
              <?php if ($minimum > 1) { ?>
              <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
              <input type="hidden" id="minimumval" value="<?php echo $minimum; ?>">
              <?php } ?>

              <div class="product-buttons-row">
                  <div class="product-buttons-box<?php if ($disable_buy != 0) { ?> preorder-buttons-box<?php } ?>">
                    <?php if ($disable_buy == 0) { ?>
                    <a href="/go/product.php?id=<?php echo $partner_link; ?>" target="_blank" rel="nofollow" data-toggle="tooltip" id="button-cart" title="Купить в <?php echo $partner_store_name; ?>" data-loading-text="<?php echo $text_loading; ?>" class="oct-button"><i class="fa fa-shopping-basket" aria-hidden="true"></i> Купить сейчас</a>
                    <?php } elseif ($disable_buy == 2) { ?>
                    <a style="display:none;" href="javascript:void(0);" title="<?php echo $stockbutton; ?>" class="oct-button"><span class="hidden-sm hidden-xs"><?php echo $stockbutton; ?><span></a>
                    <?php } else { ?>
                    <a href="javascript:void(0);" title="<?php echo $stockbutton; ?>" class="oct-button oct-preorder-button" onclick="get_oct_product_preorder('<?php echo $product_id; ?>'); return false"><span><?php echo $stockbutton; ?></span></a>
                    <?php } ?>


                    <a href="javascript:void(0);" data-toggle="tooltip" class="oct-button button-wishlist cbutton cbutton--effect-nikola" style="width: 50%;float: right; color:#fff;" title="<?php echo $button_wishlist; ?>" onclick="get_oct_popup_add_to_wishlist('<?php echo $product_id; ?>');"><i class="fa fa-heart"></i><span style="margin-left: 4px;">Сохранить на потом</span></a>

                  </div>
              </div>

              <?php if ($oct_techstore_pr_social_button_script) { ?>
              <?php echo $oct_techstore_pr_social_button_script; ?>
              <?php } ?>

            <?php if ($options) { ?>
            <hr>
            <?php foreach ($options as $option) { ?>
            <?php if (isset($oct_advanced_options_settings_data['status']) && $oct_advanced_options_settings_data['status'] && $oct_advanced_options_settings_data['quantity_status'] && $option['type'] == 'oct_quantity') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li oct-quantity-div">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div class="table-responsive" id="input-option<?php echo $option['product_option_id']; ?>">
                <table class="table">
                  <thead>
                  <tr>
                    <?php if ($oct_advanced_options_settings_data['allow_column_q_image']) { ?>
                    <td class="oct-col-option-image"><?php echo $text_col_option_image; ?></td>
                    <?php } ?>
                    <td><?php echo $text_col_option_name; ?></td>
                    <?php if ($oct_advanced_options_settings_data['allow_column_q_sku']) { ?>
                    <td class="oct-col-sku"><?php echo $text_col_option_sku; ?></td>
                    <?php } ?>
                    <?php if ($oct_advanced_options_settings_data['allow_column_q_model']) { ?>
                    <td class="oct-col-model"><?php echo $text_col_option_model; ?></td>
                    <?php } ?>
                    <td><?php echo $text_col_option_price; ?></td>
                    <td><?php echo $text_col_option_quantity; ?></td>
                  </tr>
                  </thead>
                  <tbody>
                  <?php foreach ($option['product_option_value'] as $option_value) { ?>
                  <tr>
                    <?php if ($oct_advanced_options_settings_data['allow_column_q_image']) { ?>
                    <td class="text-left oct-col-option-image" style="vertical-align: middle;"><img src="<?php echo $option_value['o_v_image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /></td>
                    <?php } ?>
                    <td class="text-left" style="vertical-align: middle;"><?php echo $option_value['name']; ?></td>
                    <?php if ($oct_advanced_options_settings_data['allow_column_q_sku']) { ?>
                    <td class="text-left oct-col-sku" style="vertical-align: middle;"><?php echo $option_value['sku']; ?></td>
                    <?php } ?>
                    <?php if ($oct_advanced_options_settings_data['allow_column_q_model']) { ?>
                    <td class="text-left oct-col-model" style="vertical-align: middle;"><?php echo $option_value['model']; ?></td>
                    <?php } ?>
                    <td class="text-left" style="vertical-align: middle;"><?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?></td>
                    <td class="text-left oct-input-td" style="vertical-align: middle;">
                      <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" style="display: none !important; visibility: hidden !important;" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" />
                      <button class="oct-button opt-oct-button left-opt-button" type="button" onclick="oct_option_quantity_minus(this,'<?php echo $option_value['product_option_value_id']; ?>');"><i class="fa fa-minus" aria-hidden="true"></i></button>
                      <?php if (isset($oct_advanced_options_settings_data['status']) && $oct_advanced_options_settings_data['status']) { ?>
                      <input type="text" value="0" size="2" onchange="oct_option_quantity_manual(this,'<?php echo $option_value['product_option_value_id']; ?>'); return validate(this);" onkeyup="oct_option_quantity_manual(this,'<?php echo $option_value['product_option_value_id']; ?>'); return validate(this);" class="oct-quantity-text-input form-control"   />
                      <?php } else { ?>
                      <input type="text" value="0" size="2" onchange="oct_option_quantity_manual(this,'<?php echo $option_value['product_option_value_id']; ?>'); return validate(this);" onkeyup="oct_option_quantity_manual(this,'<?php echo $option_value['product_option_value_id']; ?>'); return validate(this);" class="oct-quantity-text-input"  />
                      <?php } ?>
                      <button class="oct-button opt-oct-button right-opt-button" type="button" onclick="oct_option_quantity_plus(this,'<?php echo $option_value['product_option_value_id']; ?>');"><i class="fa fa-plus" aria-hidden="true"></i></button>
                    </td>
                  </tr>
                  <?php } ?>
                  </tbody>
                </table>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'select') { ?>


            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">

              <span class="product-sizes-heading" style="font-weight: 900;">Размеры в наличии: </span>
              <?php foreach ($option['product_option_value'] as $option_value) { ?>
              <span class="product-sizes-span"><?php echo $option_value['name']; ?></span>
              <?php } ?>

            </div>


            <?php } ?>
            <?php if ($option['type'] == 'radio') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li list-li">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div class="options-box" id="input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <?php if ($option_value['image']) { ?>
                <div class="radio radio-img">
                  <?php if ($option_value['quantity_status']) { ?>
                  <label class="not-selected-img optid-<?php echo $option['option_id'];?>" data-toggle="tooltip" title="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>">
                    <?php } else { ?>
                    <label class="not-selected-img optid-<?php echo $option['option_id'];?>" data-toggle="tooltip" title="<?php echo $text_oct_option_disable; ?>" style="opacity:0.2;cursor:not-allowed;">
                      <?php } ?>
                      <?php if ($option_value['quantity_status']) { ?>
                      <?php if (isset($oct_advanced_options_settings_data['status']) && $oct_advanced_options_settings_data['status']) { ?>
                      <input onchange="oct_update_prices_opt();" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" class="none" />
                      <?php } else { ?>
                      <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" class="none" />
                      <?php } ?>
                      <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" />
                      <?php } else { ?>
                      <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="none" disabled="disabled" />
                      <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" />
                      <?php } ?>
                    </label>
                </div>
                <?php } else { ?>
                <div class="radio oct-product-radio">
                  <?php if ($option_value['quantity_status']) { ?>
                  <label class="optid-<?php echo $option['option_id'];?>" data-toggle="tooltip">
                    <?php } else { ?>
                    <label class="optid-<?php echo $option['option_id'];?>" data-toggle="tooltip" title="<?php echo $text_oct_option_disable; ?>" style="opacity:0.5;cursor:not-allowed;">
                      <?php } ?>
                      <?php if ($option_value['quantity_status']) { ?>
                      <?php if (isset($oct_advanced_options_settings_data['status']) && $oct_advanced_options_settings_data['status']) { ?>
                      <input onchange="oct_update_prices_opt();" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" class="product-input-radio none" />
                      <?php } else { ?>
                      <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" class="product-input-radio none" />
                      <?php } ?>
                      <?php } else { ?>
                      <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="product-input-radio none" disabled="disabled" />
                      <?php } ?>
                      <?php echo $option_value['name']; ?>
                    </label>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                </div>
                <?php } ?>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'checkbox') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li list-li">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div class="options-box" id="input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <div class="checkbox">
                  <label <?php if (!$option_value['quantity_status']) { ?>style="opacity:0.5;cursor:not-allowed;" title="<?php echo $text_oct_option_disable; ?>"<?php } ?>>
                  <?php if ($option_value['quantity_status']) { ?>
                  <?php if (isset($oct_advanced_options_settings_data['status']) && $oct_advanced_options_settings_data['status']) { ?>
                  <input onchange="oct_update_prices_opt();" type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" />
                  <?php } else { ?>
                  <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" />
                  <?php } ?>
                  <?php } else { ?>
                  <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" disabled="disabled" />
                  <?php } ?>
                  <?php if ($option_value['image']) { ?>
                  <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" />
                  <?php } ?>
                  <?php echo $option_value['name']; ?>
                  <?php if ($option_value['price']) { ?>
                  (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                  <?php } ?>
                  </label>
                </div>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'text') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'textarea') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'file') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
              <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'date') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group date">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                  <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                  </span>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'datetime') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group datetime">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'time') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group time">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span>
              </div>
            </div>
            <?php } ?>
            <?php } ?>
            <?php } ?>
            <div class="form-group required product-info-li">
              <span class="product-sizes-heading" style="font-weight: 900;">Магазин: </span><span class="product-sizes-span"> <?php echo $partner_store_name; ?></span>
            </div>

            <!-- <?php echo $viewed; ?> -->

            <div class="form-group required product-info-li">
              <span class="product-sizes-heading" style="font-weight: 900;">Артикул: </span><span class="product-sizes-span"> <?php echo $sku; ?></span>
            </div>

            <div class="form-group required product-info-li">
              <span id="backlinks-to-cat"><?php
              foreach ($categories_info as $categ) {
                if ($categ['name'] != 'Женские' && $categ['name'] != 'Мужские' && $categ['name'] != 'Бренды' && $categ['name'] != '') {
                  echo '<a class="backlink-to-categ" href="' . $categ['url'] . '">' . $categ['name'] . '</a>';
                }
              } ?></span>
            </div>


            <hr>

            <div class="row product-tabs-row">
              <div class="col-sm-12">
                <ul class="nav nav-tabs">
                  <li class="active"><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>

                </ul>
                <div class="tab-content">
                  <div class="tab-pane active" id="tab-description">
                    <?php if ($tech_pr_micro == "on") { ?>
                    <div itemprop="description"><?php } ?>
                      <?php echo $description; ?>
                      <?php if ($tech_pr_micro == "on") { ?>
                    </div>
                    <?php } ?>
                  </div>

                </div>
              </div>
            </div>

            </div>
          </div>
        </div>



        <?php if ($oct_rel_view === false) { ?>
            <div id="autoreleted"></div>
        <?php } ?>


        <?php if ($products && $oct_rel_view) { ?>
        <div class="oct-carousel-row oct-related-row">
          <div class="oct-carousel-box">
            <div class="oct-carousel-header"><?php echo $text_related; ?></div>
            <div id="oct-related" class="owl-carousel owl-theme">
              <?php foreach ($products as $product) { ?>
              <div class="item">
                <div class="image">
                  <?php if ($product['special']) { ?>
                  <div class="oct-discount-box">
                    <div class="oct-discount-item">-<?php echo $product['saving']; ?>%</div>
                  </div>
                  <?php } ?>
                  <?php if ($product['oct_product_stickers']) { ?>
                  <div class="oct-sticker-box">
                    <?php foreach ($product['oct_product_stickers'] as $product_sticker) { ?>
                    <div class="oct-sticker-item" style="color: <?php echo $product_sticker['color']; ?>; background: <?php echo $product_sticker['background']; ?>;"><?php echo $product_sticker['text']; ?></div>
                    <?php } ?>
                  </div>
                  <?php } ?>
                  <?php if (isset($oct_popup_view_data['status']) && $oct_popup_view_data['status'] && $product['quantity'] > 0) { ?>
                  <div class="quick-view"><a onclick="get_oct_popup_product_view('<?php echo $product['product_id']; ?>');"><?php echo $button_popup_view; ?></a></div>
                  <?php } ?>
                  <?php if ($product['thumb']) { ?>
					<?php if (isset($oct_lazyload) && $oct_lazyload) { ?>
						<a href="<?php echo $product['href']; ?>" class="lazy_link">
							<img data-original="<?php echo $product['thumb']; ?>" src="<?php echo $oct_lazyload_image; ?>" class="img-responsive lazy" alt="<?php echo $product['name'] ?>" />
						</a>
					<?php } else { ?>
						<a href="<?php echo $product['href']; ?>">
							<img src="<?php echo $product['thumb']; ?>" class="img-responsive" alt="<?php echo $product['name'] ?>" />
						</a>
					<?php } ?>
                  <?php } ?>
                </div>
                <div class="name">
                  <a href="<?php echo $product['href']; ?>"><?php echo $product['name'] ?></a>
                </div>

                <?php if ($product['price']) { ?>
                <div class="price">
                <?php if (!$product['special']) { ?>
                  <span class="price-new oct-price-normal"><?php echo $product['price']; ?></span>
                <?php } else { ?>
                  <span class="price-old oct-price-old"><?php echo $product['price']; ?></span><span class="price-new oct-price-new"><?php echo $product['special']; ?></span>
                <?php } ?>
              </div>
                <?php } ?>
                <div class="cart">
                  <?php if ($product['quantity'] > 0) { ?>
                  <a class="button-cart oct-button" title="<?php echo $button_cart; ?>" onclick="get_oct_popup_add_to_cart('<?php echo $product['product_id']; ?>', '1');"><i class="fa fa-shopping-basket" aria-hidden="true"></i> <?php echo $button_cart; ?></a>
                  <?php } else { ?>
                  <a class="out-of-stock-button oct-button" href="javascript: void(0);" <?php if (isset($product['product_preorder_status']) && $product['product_preorder_status'] == 1) { ?>onclick="get_oct_product_preorder('<?php echo $product['product_id']; ?>'); return false;"<?php } ?>><i class="fa fa-shopping-basket" aria-hidden="true"></i> <?php echo $product['product_preorder_text']; ?></a>
                  <?php } ?>
                  <a onclick="get_oct_popup_add_to_wishlist('<?php echo $product['product_id']; ?>');" title="<?php echo $button_wishlist; ?>" class="wishlist oct-button"><i class="fa fa-heart" aria-hidden="true"></i></a>
                  <a onclick="get_oct_popup_add_to_compare('<?php echo $product['product_id']; ?>');" title="<?php echo $button_compare; ?>" class="compare oct-button"><i class="fa fa-sliders" aria-hidden="true"></i></a>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>
        </div>
        <script>
		$(function() {
			<?php if (isset($oct_lazyload) && $oct_lazyload) { ?>
			setTimeout(function() {
				$("#oct-related img.lazy").lazyload({
					effect : "fadeIn"
				});
			}, 10);
			<?php } ?>

			$('#oct-related').owlCarousel({
				items: 4,
				itemsDesktop : [1921,4],
				itemsDesktop : [1199,4],
				itemsDesktopSmall : [979,3],
				itemsTablet : [768,2],
				itemsMobile : [479,1],
				autoPlay: false,
				navigation: true,
				slideMargin: 10,
				navigationText: ['<i class="fa fa-angle-left fa-5x" aria-hidden="true"></i>', '<i class="fa fa-angle-right fa-5x" aria-hidden="true"></i>'],
				stopOnHover:true,
				<?php if (isset($oct_lazyload) && $oct_lazyload) { ?>
				afterMove : function(){
					setTimeout(function() {
						$("#oct-related img.lazy").lazyload();
					}, 10);
				},
				<?php } ?>
				smartSpeed: 800,
				loop: true,
				pagination: false
			});
		});
        </script>
        <?php } ?>


        <?php if ($tags) { ?>
        <p><?php echo $text_tags; ?>
          <?php for ($i = 0; $i < count($tags); $i++) { ?>
          <?php if ($i < (count($tags) - 1)) { ?>
          <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
          <?php } else { ?>
          <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
          <?php } ?>
          <?php } ?>
        </p>
        <?php } ?>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
  <?php echo $content_bottom; ?>
</div>
<?php if ($options) { ?>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'radio') { ?>
<?php foreach ($option['product_option_value'] as $option_value) { ?>
<?php if ($option_value['image']) { ?>
<script>
  $(function() {
     $('label.optid-<?php echo $option['option_id'];?>').click(function(){
       if ($(this).find('input[type=radio]').is('input:disabled')) {
        //$('label.selected-img').removeClass('selected-img').addClass('not-selected-img');
       } else {
        $('label.optid-<?php echo $option['option_id'];?>').removeClass('selected-img').addClass('not-selected-img');
        $(this).removeClass('not-selected-img').addClass('selected-img');
       }
     });
  });
</script>
<?php } else { ?>
<script>
  $(function() {
     $('label.optid-<?php echo $option['option_id'];?>').click(function(){
       if ($(this).find('input[type=radio]').is('input:disabled')) {
        $('label.selected').removeClass('selected').addClass('not-selected');
        $(this).css({
          'opacity': 0.5,
          'cursor': 'not-allowed'
        });
       } else {
        $('label.optid-<?php echo $option['option_id'];?>').removeClass('selected').addClass('not-selected');
        $(this).removeClass('not-selected').addClass('selected');
       }
     });
  });
</script>
<?php } ?>
<?php } ?>
<?php } ?>
<?php } ?>
<?php if (isset($oct_advanced_options_settings_data['status']) && $oct_advanced_options_settings_data['status']) { ?>
<script>
  <?php if ($oct_advanced_options_settings_data['allow_autoselect_option']) { ?>
  $(function() {
    $.each($('div.product-info-li').not('.oct-quantity-div'), function(i, val) {
      setTimeout(function() {
        $(val).find('input[type=\'radio\']').eq(0).click();
        $(val).find('input[type=\'checkbox\']').eq(0).click();
        $(val).find('select option:nth-child(2)').attr("selected", "selected").trigger('change');
      }, i * 1000);
    });
  });
  <?php } ?>
  <?php if ($oct_advanced_options_settings_data['allow_sku']) { ?>
  $(document).on('change', '#product input[type=\'radio\']', function() {
    $('#main-product-sku').html($(this).attr('data-option-sku'));
  });
  $(document).on('change', '#product input[type=\'text\']', function() {
    $('#main-product-sku').html($(this).attr('data-option-sku'));
  });
  <?php } ?>
  <?php if ($oct_advanced_options_settings_data['allow_model']) { ?>
  $(document).on('change', '#product input[type=\'radio\']', function() {
    $('#main-product-model').html($(this).attr('data-option-model'));
  });
  $(document).on('change', '#product input[type=\'text\']', function() {
    $('#main-product-model').html($(this).attr('data-option-model'));
  });
  <?php } ?>
  <?php if ($oct_advanced_options_settings_data['allow_sku']) { ?>
  $(document).on('change', '#product input[type=\'checkbox\']', function() {
    if ($(this).is(':checked')) {
      $('#main-product-sku').html($(this).attr('data-option-sku'));
    } else {
      $('#main-product-sku').html('<?php echo $sku; ?>');
    }
  });
  <?php } ?>
  <?php if ($oct_advanced_options_settings_data['allow_model']) { ?>
  $(document).on('change', '#product input[type=\'checkbox\']', function() {
    if ($(this).is(':checked')) {
      $('#main-product-model').html($(this).attr('data-option-model'));
    } else {
      $('#main-product-model').html('<?php echo $model; ?>');
    }
  });
  <?php } ?>
  <?php if ($oct_advanced_options_settings_data['allow_sku']) { ?>
  $(document).on('change', '#product select', function() {
    $('#main-product-sku').html($(this).find(':selected').attr('data-option-sku'));
  });
  <?php } ?>
  <?php if ($oct_advanced_options_settings_data['allow_model']) { ?>
  $(document).on('change', '#product select', function() {
    $('#main-product-model').html($(this).find(':selected').attr('data-option-model'));
  });
  <?php } ?>
</script>
<script>
  function oct_option_quantity_minus(e,i) {
    if (~~$(e).next().val() > 0) {
      $(e).next().val(~~$(e).next().val()-1);
      $(e).prev().val(i+'|'+$(e).next().val());
      $(e).prev().prop('checked', true);
    }
    if (~~$(e).next().val() <= 0) {
      $(e).prev().removeAttr('checked');
    }
    <?php if ($oct_advanced_options_settings_data['allow_model']) { ?>
      if ($(e).prev().is(':checked')) {
        $('#main-product-model').html($(e).prev().attr('data-option-model'));
      } else {
        $('#main-product-model').html('<?php echo $model; ?>');
      }
    <?php } ?>
    <?php if ($oct_advanced_options_settings_data['allow_sku']) { ?>
      if ($(e).prev().is(':checked')) {
        $('#main-product-sku').html($(e).prev().attr('data-option-sku'));
      } else {
        $('#main-product-sku').html('<?php echo $sku; ?>');
      }
    <?php } ?>
    <?php if (isset($oct_advanced_options_settings_data['status']) && $oct_advanced_options_settings_data['status']) { ?>
      oct_update_prices_opt();
    <?php } ?>
  }

  function oct_option_quantity_manual(e,i) {
    $(e).prev().prev().val(i+'|'+$(e).val());
    $(e).prev().prev().prop('checked', true);
    if ($(e).val() <= 0) {
      $(e).prev().prev().removeAttr('checked');
    }
    <?php if ($oct_advanced_options_settings_data['allow_model']) { ?>
      if ($(e).prev().prev().is(':checked')) {
        $('#main-product-model').html($(e).prev().prev().attr('data-option-model'));
      } else {
        $('#main-product-model').html('<?php echo $model; ?>');
      }
    <?php } ?>
    <?php if ($oct_advanced_options_settings_data['allow_sku']) { ?>
      if ($(e).prev().prev().is(':checked')) {
        $('#main-product-sku').html($(e).prev().prev().attr('data-option-sku'));
      } else {
        $('#main-product-sku').html('<?php echo $sku; ?>');
      }
    <?php } ?>
    <?php if (isset($oct_advanced_options_settings_data['status']) && $oct_advanced_options_settings_data['status']) { ?>
      oct_update_prices_opt();
    <?php } ?>
  }

  function oct_option_quantity_plus(e,i) {
    $(e).prev().val(~~$(e).prev().val()+1);
    $(e).prev().prev().prev().val(i+'|'+$(e).prev().val());
    $(e).prev().prev().prev().prop('checked', true);

    <?php if ($oct_advanced_options_settings_data['allow_model']) { ?>
      if ($(e).prev().prev().prev().is(':checked')) {
        $('#main-product-model').html($(e).prev().prev().prev().attr('data-option-model'));
      } else {
        $('#main-product-model').html('<?php echo $model; ?>');
      }
    <?php } ?>
    <?php if ($oct_advanced_options_settings_data['allow_sku']) { ?>
      if ($(e).prev().prev().prev().is(':checked')) {
        $('#main-product-sku').html($(e).prev().prev().prev().attr('data-option-sku'));
      } else {
        $('#main-product-sku').html('<?php echo $sku; ?>');
      }
    <?php } ?>
    <?php if (isset($oct_advanced_options_settings_data['status']) && $oct_advanced_options_settings_data['status']) { ?>
      oct_update_prices_opt();
    <?php } ?>
  }
</script>
<script><!--
  $('#product .date').datetimepicker({
    pickTime: false
  });

  $('#product .datetime').datetimepicker({
    pickDate: true,
    pickTime: true
  });

  $('#product .time').datetimepicker({
    pickDate: false
  });

  $('#product button[id^=\'button-upload\']').on('click', function() {
    var node = this;

    $('#form-upload').remove();

    $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

    $('#form-upload input[name=\'file\']').trigger('click');

    if (typeof timer != 'undefined') {
        clearInterval(timer);
    }

    timer = setInterval(function() {
      if ($('#form-upload input[name=\'file\']').val() != '') {
        clearInterval(timer);

        $.ajax({
          url: 'index.php?route=tool/upload',
          type: 'post',
          dataType: 'json',
          data: new FormData($('#form-upload')[0]),
          cache: false,
          contentType: false,
          processData: false,
          beforeSend: function() {
            $(node).button('loading');
          },
          complete: function() {
            $(node).button('reset');
          },
          success: function(json) {
            $('.text-danger').remove();

            if (json['error']) {
              $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
            }

            if (json['success']) {
              alert(json['success']);

              $(node).parent().find('input').val(json['code']);
            }
          },
          error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
          }
        });
      }
    }, 500);
  });
  //-->
</script>
<?php } ?>
<script>

    var firstThumb;
    var lastThumb;
    var nextThumb;
    var prevThumb;

function bindPhotoArrows() {
    $( document ).ready( ()=> {
        firstThumb = $('#image-additional .owl-wrapper .owl-item:first-child').children();
    lastThumb = $('#image-additional .owl-wrapper .owl-item:last-child').children();
    nextThumb = $('#image-additional .cloud-zoom-gallery.selected-thumb').parent().next().children();
    prevThumb = $('#image-additional .cloud-zoom-gallery.selected-thumb').parent().prev().children();
    if(lastThumb.length == 0 && firstThumb.length == 0) {
        $('#arrow-next-img').remove();
        $('#arrow-prev-img').remove();
        return;
    }


    if (nextThumb.length == 0) nextThumb = firstThumb;
    if (prevThumb.length == 0) prevThumb = lastThumb;

    $('#arrow-prev-img').on('click', ()=> {
        prevThumb.click();
    nextThumb = $('#image-additional .cloud-zoom-gallery.selected-thumb').parent().next().children();
    prevThumb = $('#image-additional .cloud-zoom-gallery.selected-thumb').parent().prev().children();
    if (nextThumb.length == 0) nextThumb = firstThumb;
    if (prevThumb.length == 0) prevThumb = lastThumb;
});

    $('#arrow-next-img').on('click', ()=> {
        nextThumb.click();
    nextThumb = $('#image-additional .cloud-zoom-gallery.selected-thumb').parent().next().children();
    prevThumb = $('#image-additional .cloud-zoom-gallery.selected-thumb').parent().prev().children();
    if (nextThumb.length == 0) nextThumb = firstThumb;
    if (prevThumb.length == 0) prevThumb = lastThumb;
});
})
}

bindPhotoArrows();



  $(document).on('change', '#product .radio-img', function() {
    $.ajax({
      url: 'index.php?route=product/product/getPImages&product_id=<?php echo $product_id; ?>',
      type: 'post',
      data: $('#product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select'),
      dataType: 'json',
      success: function(json) {
        var items2 = [];

        if (json['images']) {
          var patterns  = '<div class="thumbnails all-carousel">';
          $.each(json['images'], function(i,val) {
            patterns += '   <a href="'+val['popup']+'" data-fancybox="images" data-index="'+i+'" data-main-img="'+val['main_img']+'" data-main-popup="'+val['main_popup']+'" class="cloud-zoom-gallery" data-rel="useZoom: \'zoom1\', smallImage: \''+val['popup']+'\'">';
            patterns += '     <img class="img-responsive" src="'+val['thumb']+'" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />';
            patterns += '   </a>';
          });

          patterns += '</div>';
        }

        $('.left-info #image-additional').html(patterns);

        $("#image-additional .all-carousel").owlCarousel({
            items: 5,
            itemsDesktop : [1921,4],
            itemsDesktop : [1199,4],
            itemsDesktopSmall : [979,4],
            itemsTablet : [768,4],
            itemsMobile : [479,4],
            autoPlay: false,
            navigation: true,
            slideMargin: 10,
            navigationText: ['<i class="fa fa-angle-left fa-5x" aria-hidden="true"></i>', '<i class="fa fa-angle-right fa-5x" aria-hidden="true"></i>'],
            stopOnHover:true,
            smartSpeed: 800,
            loop: true,
            pagination: false
        });

        <?php if ($check_zoom) { ?>
		   $('.cloud-zoom, .cloud-zoom-gallery').CloudZoom({position: 'inside'});
		   if ($('.cloud-zoom-gallery').eq(0).length) {
			   $('.cloud-zoom-gallery').eq(0).click();
			   $('.cloud-zoom-gallery').eq(0).addClass('selected-thumb');
		   }
		<?php } else { ?>
		  if ($('.cloud-zoom-gallery').eq(0).length) {
			$('.left-info .thumbnails-one').find('a').attr('href', $('.cloud-zoom-gallery').eq(0).attr('data-main-popup'));
			$('.left-info .thumbnails-one a').find('img').attr('src', $('.cloud-zoom-gallery').eq(0).attr('data-main-img'));
		  }
		<?php } ?>

        $('.thumbnails a').on('click', function(e) {
          $(".thumbnails a").removeClass("selected-thumb");
          $(this).addClass("selected-thumb");
        });
      }
    });
  });
</script>
<?php } ?>
<script>
  $(function() {
    <?php if ($minimum > 1) { ?>
      oct_update_prices_opt();
    <?php } ?>
  });

  function oct_update_prices_opt() {
    var input_val = $('#product').find('input[name=quantity]').val();
    var quantity = parseInt(input_val);
    var minimumval = $('#minimumval').val();

    if (quantity < minimumval) {
      $('.plus-minus').val(minimumval);
    }

    $.ajax({
      type: 'post',
      url:  'index.php?route=product/product/update_prices',
      data: $('#product input[type=\'text\']:not(\'.oct-quantity-text-input\'), #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select'),
      dataType: 'json',
      success: function(json) {
        <?php if (!$special) { ?>
          $('#main-product-price').html(json['price']);
        <?php } ?>
        $('#main-product-special').html(json['special']);
        $('#main-product-tax').html(json['tax']);
        $('#main-product-you-save').html(json['you_save']);
      }
    });
  }
  function oct_update_product_quantity(product_id) {
    var input_val = $('#product').find('input[name=quantity]').val();
    var quantity = parseInt(input_val);

    <?php if ($minimum > 1) { ?>
      if (quantity < <?php echo $minimum; ?>) {
        quantity = $('#product').find('input[name=quantity]').val(<?php echo $minimum; ?>);
        return;
      }
    <?php } else { ?>
      if (quantity == 0) {
        quantity = $('#product').find('input[name=quantity]').val(1);
        return;
      }
    <?php } ?>

    $.ajax({
      url: 'index.php?route=product/product/update_prices&product_id=' + product_id + '&quantity=' + quantity,
      type: 'post',
      dataType: 'json',
      data: $('#product input[type=\'text\']:not(\'.oct-quantity-text-input\'), #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
      success: function(json) {
        <?php if (!$special) { ?>
          $('#main-product-price').html(json['price']);
        <?php } ?>
        $('#main-product-special').html(json['special']);
        $('#main-product-tax').html(json['tax']);
        $('#main-product-you-save').html(json['you_save']);
      }
    });
  }
</script>
	<?php if ($check_zoom) { ?>
        <script>
            jQuery.browser = {};
            (function () {
                jQuery.browser.msie = false;
                jQuery.browser.version = 0;
                if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
                    jQuery.browser.msie = true;
                    jQuery.browser.version = RegExp.$1;
                }
            })();
        </script>
        <script>
          $('.cloud-zoom, .cloud-zoom-gallery').CloudZoom({position: 'inside'});
          $(function() {
        	var getWidth = viewport().width;

        	if($('[data-fancybox]').length){
        	$.fancybox.defaults.hash = false;
        	}

            if(getWidth > 480) {
                var class_in = ".mousetrap";
            } else {
                var class_in = ".cloud-zoom";
            }

            $('body').delegate(class_in, 'click', function() {
        	  var iar = [];
        	  var ind = '';

        	  if($('[data-fancybox]').length > 1){
        		  $('.thumbnails a.cloud-zoom-gallery').each(function(index) {
        				iar.push({src: $(this).attr('href')});

        				if ($(this).attr('href') == $("#zoom1").attr('href')) {
        			  		ind = index;
        				}
        		  });
          	  } else {
        		  iar.push({src: $("#zoom1").attr('href')});
        		  ind = 0;
        	  }

        	  $.fancybox.open(iar, {padding : 0, index: ind});
        	  return false;
        	});
          });
        </script>
        <?php } else { ?>
        <script>
          $(function() {
            if($('[data-fancybox]').length){
              $.fancybox.defaults.hash = false;
            }
          });

          function funcyFirst() {
        	  if($('[data-fancybox]').length > 1){
        		  $('.cloud-zoom-gallery').eq(0).click(); return false;
        	  } else {
        		  var iar = [];
        		  var ind = '';

        		  iar.push({src: $("#zoom1").attr('href')});
        		  ind = 0;

        		  $.fancybox.open(iar, {padding : 0, index: ind});
        	  }
          }
        </script>
	<?php } ?>
<script><!--
  $('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
    $.ajax({
      url: 'index.php?route=product/product/getRecurringDescription',
      type: 'post',
      data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
      dataType: 'json',
      beforeSend: function() {
        $('#recurring-description').html('');
      },
      success: function(json) {
        $('.alert, .text-danger').remove();

        if (json['success']) {
          $('#recurring-description').html(json['success']);
        }
      }
    });
  });
  //-->
</script>
<script><!--
  $('#button-cart').on('click', function() {
    $.ajax({
      url: 'index.php?route=checkout/cart/add&oct_dirrect_add=1',
      type: 'post',
      data: $('#product input[type=\'text\']:not(\'.oct-quantity-text-input\'), #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
      dataType: 'json',
      success: function(json) {
        $('.alert, .text-danger').remove();
        $('.form-group').removeClass('has-error');

        if (json['error']) {
          if (json['error']['option']) {
            for (i in json['error']['option']) {
              var element = $('#input-option' + i.replace('_', '-'));

              if (element.parent().hasClass('input-group')) {
                element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
              } else {
                element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
              }
            }
          }

          if (json['error']['recurring']) {
            $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
          }

          // Highlight any found errors
          $('.text-danger').parent().addClass('has-error');
        }

        if (json['success']) {
          // $.magnificPopup.open({
          //   tLoading: '<img src="catalog/view/theme/oct_techstore/image/ring-alt.svg" />',
          //   items: {
          //     src: "index.php?route=extension/module/oct_popup_add_to_cart&product_id=" + <?php echo $product_id; ?>,
          //     type: "ajax"
          //   },
          //   midClick: true,
          //   removalDelay: 200
          // });
	        get_oct_popup_cart();

          $("#cart-total").html(json['total']);
          $('#cart > ul').load('index.php?route=common/cart/info ul li');

          $.ajax({
            url:  'index.php?route=extension/module/oct_page_bar/update_html',
            type: 'get',
            dataType: 'json',
            success: function(json) {
              $("#oct-bottom-cart-quantity").html(json['total_cart']);
            }
          });
        }
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  });
  //-->
</script>
<script><!--
  $('#review').delegate('.pagination a', 'click', function(e) {
      e.preventDefault();

      $('#review').fadeOut('slow');

      $('#review').load(this.href);

      $('#review').fadeIn('slow');
  });

  $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

  $('#button-review').on('click', function() {
    $.ajax({
      url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
      type: 'post',
      dataType: 'json',
      data: $("#form-review").serialize(),
      beforeSend: function() {
        $('#button-review').button('loading');
      },
      complete: function() {
        $('#button-review').button('reset');
      },
      success: function(json) {
        $('.alert-success, .alert-danger').remove();

        if (json['error']) {
            setTimeout(function(){$.toast(json['error']);}, 0);
        }

        if (json['success']) {
            setTimeout(function(){$.toast({text: json['success'], heading: "", icon: 'success'});}, 0);

          $('input[name=\'name\']').val('');
          $('textarea[name=\'text\']').val('');
          <?php if (isset($oct_product_reviews_data['status']) && $oct_product_reviews_data['status']) { ?>
              $('textarea[name=\'positive_text\']').val('');
              $('textarea[name=\'negative_text\']').val('');
          <?php } ?>
          $('input[name=\'rating\']:checked').prop('checked', false);
          <?php if ($text_terms) { ?>
              $('input[name=\'terms\']:checked').prop('checked', false);
          <?php } ?>
        }
      }
    });
    <?php if ($captcha) { ?>
    grecaptcha.reset();
    <?php } ?>
  });

  $(function() {
    var hash = window.location.hash;
    if (hash) {
      var hashpart = hash.split('#');
      var  vals = hashpart[1].split('-');
      for (i=0; i<vals.length; i++) {
        $('div.options').find('select option[value="'+vals[i]+'"]').attr('selected', true).trigger('select');
        $('div.options').find('input[type="radio"][value="'+vals[i]+'"]').attr('checked', true).trigger('click');
      }
    }
  })
  //-->
</script>
<?php if (isset($oct_product_reviews_data['status']) && $oct_product_reviews_data['status']) { ?>
<script>
  function review_reputation(review_id, reputation_type) {
    $.ajax({
      url: 'index.php?route=product/product/oct_review_reputation&review_id=' + review_id + '&reputation_type=' + reputation_type,
      dataType: 'json',
      success: function(json) {
        $('#form-review .alert-success, #form-review .alert-danger').remove();

        if (json['error']) {
          alert(json['error']);
        }
        if (json['success']) {
          alert(json['success']);
          $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');
        }
      }
    });
  }
</script>
<?php } ?>
<?php if ($oct_rel_view === false) { ?>
<script>
$.ajax({
  url: 'index.php?route=product/product/getAutoRels&product_id=<?php echo $product_id; ?>',
  dataType: 'html',
  success: function(json) {
    $("#autoreleted").html(json);
  }
});
</script>
<?php } ?>
<?php echo $footer; ?>
