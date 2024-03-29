<div id="quick-view" class="white-popup wide-popup mfp-with-anim">
  <script src="catalog/view/theme/oct_techstore/js/barrating.js"></script>
  <?php if ($stock_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $stock_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div id="content" class="col-sm-12">
    <div class="row">

      <!--
      <?php if (($oct_popup_view_data['image'] || $oct_popup_view_data['additional_image']) && ($thumb || $images)) { ?>
      <?php if ($thumb || $images) { ?>
      <div class="col-sm-6">
        <ul class="thumbnails product-images">
        <?php if ($special) { ?>
            <li id="main-product-you-save">-<?php echo $economy; ?>%</li>
            <?php } ?>
        <?php if ($oct_popup_view_data['image'] && $thumb) { ?>
        <li class="product-sticker-box">
          <?php if ($oct_product_stickers) { ?>
              <?php foreach ($oct_product_stickers as $product_sticker) { ?>
                <div style="color: <?php echo $product_sticker['color']; ?>; background: <?php echo $product_sticker['background']; ?>;">
                  <?php echo $product_sticker['text']; ?>
                </div>
              <?php } ?>
          <?php } ?>
            </li>
          <a class="thumbnail" href="<?php echo $view_product_link; ?>" title="<?php echo $product_name; ?>"><img src="<?php echo $thumb; ?>" title="<?php echo $product_name; ?>" alt="<?php echo $product_name; ?>" id="popup-main-image" /></a>
        <?php } ?>
        </ul>
		<?php if ($oct_popup_view_data['additional_image'] && $images) { ?>
		<div id="image-additional">
            <div class="thumbnails all-carousel">
    		  <?php $img_key = 0; foreach ($images as $image) { ?>
              <div class="image-additional">
                <input type="radio" name="sub_images" value="<?php echo $image['popup']; ?>" id="sub-image-<?php echo $img_key; ?>" style="display: none;" />
                <label class="thumbnail" title="<?php echo $product_name; ?>" for="sub-image-<?php echo $img_key; ?>"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $product_name; ?>" alt="<?php echo $product_name; ?>" /></label>
              </div>
              <?php $img_key++; } ?>
          </div>
		</div>

		<?php } ?>
		<script>
			  $(document).on('change', 'input[name=\'sub_images\']', function() {
				$('#popup-main-image').attr('src',$('input[name=sub_images]:checked').val());
			  });
			  $(document).on('click', '#image-additional .owl-wrapper .owl-item label', function() {
				  $('#image-additional .owl-wrapper .owl-item label').removeClass('label-active');
				  $(this).toggleClass('label-active');
			  });
			</script>
      </div>
      <?php } ?>
      <?php } ?>
      -->
      <div class="col-sm-6">
       <div class="left-info">
        <?php if ($thumb || $images) { ?>
        <ul style="padding: 0;">

          <?php if ($thumb) { ?>
          <li class="image thumbnails-one thumbnail">

            <?php if (count($images) == 1) { ?>
            <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" data-fancybox="images2" data-index="<?php echo $data_index; ?>" data-main-img="<?php echo $image['popup']; ?>" data-main-popup="<?php echo $image['popup']; ?>" class="cloud-zoom-gallery <?php if ($data_index == 0) { ?>selected-thumb<?php } ?>" data-rel="useZoom: 'zoom2', smallImage: '<?php echo $image['popup']; ?>'">
              <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" class="img-responsive" alt="<?php echo $heading_title; ?>" />
            </a>
            <?php } ?>
            <?php if (count($images) > 1) { ?>
            <a >
              <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" class="img-responsive" alt="<?php echo $heading_title; ?>" />
            </a>
            <?php } ?>
          </li>
          <?php } ?>
        </ul>

        <?php if (count($images) > 1) { ?>
        <div class="image-additional" id="image-additional">
          <div class="thumbnails all-carousel">
            <?php $data_index = 0; foreach ($images as $image) { ?>
            <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" data-fancybox="images2" data-index="<?php echo $data_index; ?>" data-main-img="<?php echo $image['popup']; ?>" data-main-popup="<?php echo $image['popup']; ?>" class="cloud-zoom-gallery <?php if ($data_index == 0) { ?>selected-thumb<?php } ?>" data-rel="useZoom: 'zoom2', smallImage: '<?php echo $image['popup']; ?>'">
              <img src="<?php echo $image['thumb']; ?>" <?php if ("on" == "on") { ?>itemprop="image" <?php } ?>title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="img-responsive" />
            </a>
            <?php $data_index++; } ?>
          </div>
        </div>
        <?php } ?>
        <script>
          $('#content > div > div:nth-child(1) > div > ul > li > a').on('click', ()=> {
              $('#image-additional > div > div.owl-wrapper-outer > div > div:nth-child(1) > a').click();
          });

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

      </div>


      <div class="col-sm-<?php if (($oct_popup_view_data['image'] || $oct_popup_view_data['additional_image']) && ($thumb || $images)) { ?>6<?php } else { ?>12<?php } ?>">
        <h1 class="product-header" style="margin-top: 20px;"><?php echo $product_name; ?></h1>


        <div class="row">
          <div class="col-sm-12"><hr class="product-hr"></div>
        </div>


        <div class="row">
          <?php if ($price) { ?>
          <div class="price-col">
            <div class="product-price" style="margin: 20px 20px 0px;">
              <?php if ($reward) { ?>
              <span class="oct-reward"><?php echo $text_reward; ?> <?php echo $reward; ?></span>
              <?php } ?>
              <?php if (!$special) { ?>
              <h2 id="main-product-price" class="oct-price-normal"><?php echo $price; ?></h2>
              <?php } else { ?>
              <h3 id="main-product-price" class="oct-price-old"><?php echo $price; ?></h3>
              <h2 id="main-product-special" class="oct-price-new"><?php echo $special; ?></h2>
              <?php } ?>
              <br/>
              <?php if ($tax) { ?>
              <span><?php echo $text_tax; ?> <span id="popup-main-tax"><?php echo $tax; ?></span></span>
              <br/>
              <?php } ?>
              <?php if ($points) { ?>
              <span><?php echo $text_points; ?> <?php echo $points; ?></span>
              <br/>
              <?php } ?>
              <?php if ($discounts) { ?>
              <?php foreach ($discounts as $discount) { ?>
              <span><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></span><br/>
              <?php } ?>
              <?php } ?>
            </div>
          </div>
          <?php } ?>

          <div class="col-sm-3">
            <?php if ($oct_popup_view_data['quantity']) { ?>
            <div class="number">
              <div class="frame-change-count">
                <div class="btn-minus">
                  <button type="button" id="superminus" onclick="$(this).parent().next().val(~~$(this).parent().next().val()-1); popup_update_prices('<?php echo $product_id; ?>');">
                    <span class="icon-minus"><i class="fa fa-minus"></i></span>
                  </button>
                </div>
                <input type="text" name="quantity" value="<?php echo $minimum; ?>" maxlength="5" size="8" class="plus-minus" id="input-quantity" onchange="popup_update_prices('<?php echo $product_id; ?>'); return validate(this);" keypress="popup_update_prices('<?php echo $product_id; ?>'); return validate(this);">
                <div class="btn-plus">
                  <button type="button" id="superplus" onclick="$(this).parent().prev().val(~~$(this).parent().prev().val()+1); popup_update_prices('<?php echo $product_id; ?>');">
                    <span class="icon-plus"><i class="fa fa-plus"></i></span>
                  </button>
                </div>
              </div>
            </div>
            <?php } else { ?>
            <input type="hidden" name="quantity" value="<?php echo $minimum; ?>" />
            <?php } ?>
            <?php if ($recurrings) { ?>
            <hr>
            <h3><?php echo $text_payment_recurring ?></h3>
            <div class="form-group required">
              <select name="recurring_id" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($recurrings as $recurring) { ?>
                <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
                <?php } ?>
              </select>
              <div class="help-block" id="popup-recurring-description"></div>
            </div>
            <?php } ?>
          </div>
        </div>


        <div class="row product-buttons-row">
          <div class="col-sm-12">
            <div class="product-buttons-box">

                <a href="/go/product.php?id=<?php echo $partner_link; ?>" rel="nofollow" target="_blank" data-toggle="tooltip" id="button-cart" title="Купить в <?php echo $partner_store_name; ?>" data-loading-text="<?php echo $text_loading; ?>" class="oct-button"><i class="fa fa-shopping-basket" aria-hidden="true"></i> Купить сейчас</a>

                <a href="javascript:void(0);" data-toggle="tooltip" class="oct-button button-wishlist cbutton cbutton--effect-nikola" style="display: inline-block; color:#fff; width: 50%;float: right;" title="<?php echo $button_wishlist; ?>" onclick="get_oct_popup_add_to_wishlist('<?php echo $product_id; ?>');"><i class="fa fa-heart"></i><span style="margin-left: 4px;">Сохранить на потом</span></a>

            </div>
          </div>
        </div>


        <div id="product">
          <form method="post" enctype="multipart/form-data" id="view-form">


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
              <div class="options-box" id="popup-input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                  <?php if ($option_value['image']) { ?>
                    <div class="radio radio-img">
                      <?php if ($option_value['quantity_status']) { ?>
                        <label class="not-selected-img optimid-<?php echo $option['option_id'];?>" data-toggle="tooltip" title="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>">
                      <?php } else { ?>
                        <label class="not-selected-img optimid-<?php echo $option['option_id'];?>" data-toggle="tooltip" title="<?php echo $text_option_disable; ?>" style="opacity:0.2;cursor:not-allowed;">
                      <?php } ?>
                      <?php if ($option_value['quantity_status']) { ?>
                        <?php if (isset($oct_advanced_options_settings_data['status']) && $oct_advanced_options_settings_data['status']) { ?>
                        <input onchange="oct_update_prices_opt();" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" class="none" />
                        <?php } else { ?>
                        <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" class="none" />
                        <?php } ?>
                        <img src="<?php echo $option_value['image']; ?>" title="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" />
                      <?php } else { ?>
                        <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="none" disabled="disabled" />
                        <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" />
                      <?php } ?>
                      </label>
                    </div>
                  <?php } else { ?>
                    <div class="radio oct-product-radio">
                      <?php if ($option_value['quantity_status']) { ?>
                        <label class="optimid-<?php echo $option['option_id'];?>" data-toggle="tooltip">
                      <?php } else { ?>
                        <label class="optimid-<?php echo $option['option_id'];?>" data-toggle="tooltip" title="<?php echo $text_option_disable; ?>" style="opacity:0.5;cursor:not-allowed;">
                      <?php } ?>
                        <?php if ($option_value['quantity_status']) { ?>
                          <?php if (isset($oct_advanced_options_settings_data['status']) && $oct_advanced_options_settings_data['status']) { ?>
                          <input onchange="oct_update_prices_opt();" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" class="product-input-radio" />
                          <?php } else { ?>
                          <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-option-sku="<?php echo $option_value['sku']; ?>" data-option-model="<?php echo $option_value['model']; ?>" class="product-input-radio" />
                          <?php } ?>
                        <?php } else { ?>
                          <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="product-input-radio" disabled="disabled" />
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
            <script>
              $(document).ready(function() {
                $('.radio-img label.optimid-<?php echo $option['option_id'];?>').click(function(){
                  if ($(this).find('input[type=radio]').is(':disabled')) {
                    //$('.radio-img label.optimid-<?php echo $option['option_id'];?>').removeClass('selected-img').addClass('not-selected-img');
                  } else {
                    $('.radio-img label.optimid-<?php echo $option['option_id'];?>').removeClass('selected-img').addClass('not-selected-img');
                    $(this).removeClass('not-selected-img').addClass('selected-img');
                  }
                });
              });
            </script>
            <?php } ?>
            <?php if ($option['type'] == 'checkbox') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li list-li">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div class="options-box" id="popup-input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <div class="checkbox">
                  <label <?php if (!$option_value['quantity_status']) { ?>style="opacity:0.5;cursor:default;" title="<?php echo $text_option_disable; ?>"<?php } ?>>
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
              <label class="control-label" for="popup-input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="popup-input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'textarea') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
              <label class="control-label" for="popup-input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="popup-input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'file') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
              <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="popup-input-option<?php echo $option['product_option_id']; ?>" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'date') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
              <label class="control-label" for="popup-input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group date">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="popup-input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'datetime') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
              <label class="control-label" for="popup-input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group datetime">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="popup-input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'time') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> product-info-li">
              <label class="control-label" for="popup-input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group time">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="popup-input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php } ?>
            <?php } ?>

            <div class="form-group required product-info-li">
              <span class="product-sizes-heading" style="font-weight: 900;">Магазин: </span><span class="product-sizes-span"> <?php echo $partner_store_name; ?></span>
            </div>

            <div class="form-group required product-info-li">
              <span class="product-sizes-heading" style="font-weight: 900;">Артикул: </span><span class="product-sizes-span"> <?php echo $sku; ?></span>
            </div>





          </form>


        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12"><hr class="product-hr"></div>
  </div>

  <div style="display: block; text-align: center"><a class="kedkros-btn" href="<?php echo $view_product_link; ?>">Подробнее о товаре</a></div>

  <div class="clearfix"></div>
<?php if ($options) { ?>
<script src="catalog/view/javascript/jquery/datetimepicker/moment.js"></script>
<script src="catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<link href="catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet" />
<script><!--
  $('#quick-view .date').datetimepicker({
    pickTime: false,
  });

  $('#quick-view .datetime').datetimepicker({
    pickDate: true,
    pickTime: true
  });

  $('#quick-view .time').datetimepicker({
    pickDate: false,
  });

  $(document).on('click', '#quick-view button[id^=\'button-upload\']', function() {
    var node = this;
    $('#quick-view #form-upload').remove();
    $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');
    $('#quick-view #form-upload input[name=\'file\']').trigger('click');

    if (typeof timer != 'undefined') {
      clearInterval(timer);
    }

    timer = setInterval(function() {
      if ($('#quick-view #form-upload input[name=\'file\']').val() != '') {
        clearInterval(timer);
        $.ajax({
          url: 'index.php?route=tool/upload',
          type: 'post',
          dataType: 'json',
          data: new FormData($('#quick-view #form-upload')[0]),
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
            $('#quick-view .text-danger').remove();
            if (json['error']) {
              $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
            }
            if (json['success']) {
              alert(json['success']);
              $(node).parent().find('input').attr('value', json['code']);
            }
          },
          error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
          }
        });
      }
    }, 500);
  });
//--></script>
	<?php if (isset($oct_advanced_options_settings_data['status']) && $oct_advanced_options_settings_data['status']) { ?>
	<script><!--
    function oct_update_prices_opt() {
      masked('#quick-view', true);
      $.ajax({
        type: 'post',
        url:  'index.php?route=product/product/update_prices',
        data: $('#quick-view #product input[type=\'text\']:not(\'.oct-quantity-text-input\'), #quick-view #product input[type=\'hidden\'], #quick-view #product input[type=\'radio\']:checked, #quick-view #product input[type=\'checkbox\']:checked, #quick-view #product select'),
        dataType: 'json',
        success: function(json) {
          <?php if (!$special) { ?>
          $('#main-product-price').html(json['price']);
          <?php } ?>
          $('#main-product-special').html(json['special']);
          $('#popup-main-tax').html(json['tax']);
          $('#main-product-you-save').html(json['you_save']);
          masked('#quick-view', false);
        }
      });
    }
	  <?php if ($oct_advanced_options_settings_data['allow_autoselect_option']) { ?>
	  $(function() {
	    $('#quick-view div.product-info-li').not('.oct-quantity-div').each(function(i, val) {
        setTimeout(function() {
          $(val).find('input[type=\'radio\']').eq(0).click();
  	      $(val).find('input[type=\'checkbox\']').eq(0).click();
  	      $(val).find('select option:nth-child(2)').attr("selected", "selected").trigger('change');
        }, i * 1000);
	    });
	  });
	  <?php } ?>
	  <?php if ($oct_advanced_options_settings_data['allow_sku']) { ?>
	  $(document).on('change', '#quick-view #product input[type=\'radio\']', function() {
	    $('#quick-view #main-product-sku').html($(this).attr('data-option-sku'));
	  });
	  <?php } ?>
	  <?php if ($oct_advanced_options_settings_data['allow_model']) { ?>
	  $(document).on('change', '#quick-view #product input[type=\'radio\']', function() {
	    $('#quick-view #main-product-model').html($(this).attr('data-option-model'));
	  });
	  <?php } ?>
	  <?php if ($oct_advanced_options_settings_data['allow_sku']) { ?>
	  $(document).on('change', '#quick-view #product input[type=\'checkbox\']', function() {
	    if ($(this).is(':checked')) {
	      $('#quick-view #main-product-sku').html($(this).attr('data-option-sku'));
	    } else {
	      $('#quick-view #main-product-sku').html('<?php echo $sku; ?>');
	    }
	  });
	  <?php } ?>
	  <?php if ($oct_advanced_options_settings_data['allow_model']) { ?>
	  $(document).on('change', '#quick-view #product input[type=\'checkbox\']', function() {
	    if ($(this).is(':checked')) {
	      $('#quick-view #main-product-model').html($(this).attr('data-option-model'));
	    } else {
	      $('#quick-view #main-product-model').html('<?php echo $model; ?>');
	    }
	  });
	  <?php } ?>
	  <?php if ($oct_advanced_options_settings_data['allow_sku']) { ?>
	  $(document).on('change', '#quick-view #product select', function() {
	    $('#quick-view #main-product-sku').html($(this).find(':selected').attr('data-option-sku'));
	  });
	  <?php } ?>
	  <?php if ($oct_advanced_options_settings_data['allow_model']) { ?>
	  $(document).on('change', '#quick-view #product select', function() {
	    $('#quick-view #main-product-model').html($(this).find(':selected').attr('data-option-model'));
	  });
	  <?php } ?>

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
	        $('#quick-view #main-product-model').html($(e).prev().attr('data-option-model'));
	      } else {
	        $('#quick-view #main-product-model').html('<?php echo $model; ?>');
	      }
	    <?php } ?>
	    <?php if ($oct_advanced_options_settings_data['allow_sku']) { ?>
	      if ($(e).prev().is(':checked')) {
	        $('#quick-view #main-product-sku').html($(e).prev().attr('data-option-sku'));
	      } else {
	        $('#quick-view #main-product-sku').html('<?php echo $sku; ?>');
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
	        $('#quick-view #main-product-model').html($(e).prev().prev().attr('data-option-model'));
	      } else {
	        $('#quick-view #main-product-model').html('<?php echo $model; ?>');
	      }
	    <?php } ?>
	    <?php if ($oct_advanced_options_settings_data['allow_sku']) { ?>
	      if ($(e).prev().prev().is(':checked')) {
	        $('#quick-view #main-product-sku').html($(e).prev().prev().attr('data-option-sku'));
	      } else {
	        $('#quick-view #main-product-sku').html('<?php echo $sku; ?>');
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
	        $('#quick-view #main-product-model').html($(e).prev().prev().prev().attr('data-option-model'));
	      } else {
	        $('#quick-view #main-product-model').html('<?php echo $model; ?>');
	      }
	    <?php } ?>
	    <?php if ($oct_advanced_options_settings_data['allow_sku']) { ?>
	      if ($(e).prev().prev().prev().is(':checked')) {
	        $('#quick-view #main-product-sku').html($(e).prev().prev().prev().attr('data-option-sku'));
	      } else {
	        $('#quick-view #main-product-sku').html('<?php echo $sku; ?>');
	      }
	    <?php } ?>
	    <?php if (isset($oct_advanced_options_settings_data['status']) && $oct_advanced_options_settings_data['status']) { ?>
	      oct_update_prices_opt();
	    <?php } ?>
	  }
//--></script>
	<?php } ?>
<?php } ?>
<script><!--
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

    <?php if ($minimum > 1) { ?>
      oct_update_prices_opt();
    <?php } ?>
  });

  function masked(element, status) {
    if (status == true) {
      $('<div/>')
      .attr({ 'class':'masked' })
      .prependTo(element);
      $('<div class="masked_loading" />').insertAfter($('.masked'));
    } else {
      $('.masked').remove();
      $('.masked_loading').remove();
    }
  }

  <?php if ($oct_popup_view_data['quantity']) { ?>
    function validate(input) {
      input.value = input.value.replace(/[^\d,]/g, '');
    }

    function popup_update_prices(product_id) {
      masked('#quick-view', true);
      var input_val = $('#quick-view').find('input[name=quantity]').val();
      var quantity = parseInt(input_val);

      <?php if ($minimum > 1) { ?>
        if (quantity < <?php echo $minimum; ?>) {
          quantity = $('#quick-view').find('input[name=quantity]').val(<?php echo $minimum; ?>);
          masked('#quick-view', false);
          return;
        }
      <?php } else { ?>
        if (quantity == 0) {
          quantity = $('#quick-view').find('input[name=quantity]').val(1);
          masked('#quick-view', false);
          return;
        }
      <?php } ?>

      $.ajax({
        url: 'index.php?route=extension/module/oct_popup_view/update_prices&product_id=' + product_id + '&quantity=' + quantity,
        type: 'post',
        dataType: 'json',
        data: $('#view-form').serialize(),
        success: function(json) {
          <?php if (!$special) { ?>
          $('#main-product-price').html(json['price']);
          <?php } ?>
          $('#main-product-special').html(json['special']);
          $('#popup-main-tax').html(json['tax']);
          $('#main-product-you-save').html(json['you_save']);

          masked('#quick-view', false);
        }
      });
    }
  <?php } else { ?>
    function popup_update_prices(product_id) {}
    function validate(input) {}
  <?php } ?>

  $('#product .radio-img').on('change', function() {
    $.ajax({
      url: 'index.php?route=product/product/getPImages&product_id=<?php echo $product_id; ?>' + '&image_width=<?php echo $image_width;?>&image_height=<?php echo $image_height;?>&image_additional_width=<?php echo $image_additional_width;?>&image_additional_height=<?php echo $image_additional_height;?>',
      type: 'post',
      data: $('#product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select'),
      dataType: 'json',
      success: function(json) {
        var items2 = [];
        var img_key = 0;
        if (json['images']) {
          var patterns  = '<div class="thumbnails all-carousel">';
          $.each(json['images'], function(i,val) {
            patterns += '<div class="image-additional">';
            patterns += '<input type="radio" name="sub_images" value="'+val['popup']+'" id="sub-image-'+ img_key +'" style="display: none;" />';
            patterns += '<label class="thumbnail" title="<?php echo $product_name; ?>" for="sub-image-'+ img_key +'"><img src="'+val['thumb']+'" title="<?php echo $product_name; ?>" alt="<?php echo $product_name; ?>" /></label>';
            patterns += '</div>';

            img_key++;
          });

          patterns += '</div>';
        }

        $('#image-additional').html(patterns);

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

        $('#image-additional .owl-wrapper .owl-item label:first').click();
      }
    });
  });

  $('#quick-view #button-cart').on('click', function() {
    $.ajax({
      url: 'index.php?route=checkout/cart/add',
      type: 'post',
      data: $('#quick-view #product input[type=\'text\']:not(\'.oct-quantity-text-input\'), #quick-view #product input[type=\'hidden\'], #quick-view #product input[type=\'radio\']:checked, #quick-view #product input[type=\'checkbox\']:checked, #quick-view #product select, #quick-view #product textarea'),
      dataType: 'json',
      beforeSend: function() {
        $('#quick-view #button-cart').button('loading');
      },
      complete: function() {
        $('#quick-view #button-cart').button('reset');
      },
      success: function(json) {
        $('#quick-view .alert, #quick-view .text-danger').remove();
        $('#quick-view .form-group').removeClass('has-error');
        $('#quick-view .success, #quick-view .warning, #quick-view .attention, #quick-view .information, #quick-view .error').remove();

        if (json['error']) {
          if (json['error']['option']) {
            for (i in json['error']['option']) {
              $('#quick-view #option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
            }
          }

          if (json['error']['recurring']) {
            $('#quick-view select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
          }

          // Highlight any found errors
          $('#quick-view .text-danger').parent().addClass('has-error');
        }

        if (json['success']) {
          // $.magnificPopup.open({
          //   tLoading: '<img src="catalog/view/theme/oct_techstore/image/ring-alt.svg" />',
          //   items: {
          //     src: 'index.php?route=extension/module/oct_popup_add_to_cart&product_id=<?php echo $product_id; ?>',
          //     type: 'ajax'
          //   },
          //   midClick: true,
          //   removalDelay: 200
          // });
	        get_oct_popup_cart();

          $('#cart-total').html(json['total']);
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
      }
    });
  });

  <?php if ($oct_popup_view_data['review']) { ?>
    $('#quick-view #review').delegate('.pagination a', 'click', function(e) {
      e.preventDefault();
      $('#quick-view #review').fadeOut('slow');
      $('#quick-view #review').load(this.href);
      $('#quick-view #review').fadeIn('slow');
    });

    $('#quick-view #review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

    $('#quick-view #button-review').on('click', function() {
      $.ajax({
        url: 'index.php?route=extension/module/oct_popup_view/write&product_id=<?php echo $product_id; ?>',
        type: 'post',
        dataType: 'json',
        data: $("#quick-view #form-review").serialize(),
        beforeSend: function() {
          $('#quick-view #button-review').button('loading');
        },
        complete: function() {
          $('#quick-view #button-review').button('reset');
        },
        success: function(json) {
          $('#quick-view .alert-success, #quick-view .alert-danger').remove();
          if (json['error']) {
            $('#quick-view #review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
          }
          if (json['success']) {
            $('#quick-view #review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
            $('#quick-view input[name=\'name\']').val('');
            $('#quick-view textarea[name=\'text\']').val('');
            <?php if (isset($oct_product_reviews_data['status']) && $oct_product_reviews_data['status']) { ?>
            $('#quick-view textarea[name=\'positive_text\']').val('');
            $('#quick-view textarea[name=\'negative_text\']').val('');
            <?php } ?>
            <?php if ($text_terms) { ?>
            $('#quick-view input[name=\'terms\']:checked').prop('checked', false);
            <?php } ?>
            $('#quick-view input[name=\'rating\']:checked').prop('checked', false);
          }
        }
      });
    });
  <?php } ?>
  //--></script>
  <script><!--
    $('#quick-view select[name=\'recurring_id\'], #quick-view input[name="quantity"]').change(function(){
      $.ajax({
        url: 'index.php?route=product/product/getRecurringDescription',
        type: 'post',
        data: $('#quick-view input[name=\'product_id\'], #quick-view input[name=\'quantity\'], #quick-view select[name=\'recurring_id\']'),
        dataType: 'json',
        beforeSend: function() {
          $('#popup-recurring-description').html('');
        },
        success: function(json) {
          $('.alert, .text-danger').remove();
          if (json['success']) {
            $('#popup-recurring-description').html(json['success']);
          }
        }
      });
    });
  //--></script>
  <?php if (isset($oct_product_reviews_data['status']) && $oct_product_reviews_data['status']) { ?>
  <script>
  function review_reputation(review_id, reputation_type) {
    $.ajax({
      url: 'index.php?route=product/product/oct_review_reputation&review_id=' + review_id + '&reputation_type=' + reputation_type,
      dataType: 'json',
      success: function(json) {
        $('#quick-view #form-review .alert-success, #quick-view #form-review .alert-danger').remove();

        if (json['error']) {
          alert(json['error']);
        }

        if (json['success']) {
          alert(json['success']);
          $('#quick-view #review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');
        }
      }
    });
  }
  </script>
  <?php } ?>
</div>
