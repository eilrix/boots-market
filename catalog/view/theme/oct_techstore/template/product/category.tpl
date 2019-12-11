<?php echo $header; ?>
<div class="container">
  <?php echo $content_top; ?>
  <div class="col-sm-12  content-row">
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
      <div class="col-sm-12">
        <h1 class="cat-header"><?php echo $heading_title; ?></h1>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-12">
        <div class="mobile-category-header"></div>
      </div>
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


      <div id="content" class="<?php echo $class; ?>">
        <?php if ($categories && $oct_techstore_data['cat_show_subcat'] == 'on') { ?>


        <div class="subcats-row">
          <div id="subcats">

            <div class="row oct-carousel-row">
              <div class="col-sm-12">
                <div class="oct-carousel-box">
                  <h3 class="subcat-header"><?php echo $oct_choose_subcategory; ?></h3>
                  <div id="oct-products-from-category-0" class="owl-carousel owl-theme">

                    <?php foreach ($categories as $category) { ?>

                    <div class="item subcat-box col-md-2 col-sm-3 col-xs-6">
                      <a href="<?php echo $category['href']; ?>" title="<?php echo $category['name']; ?>">
                        <img class="img-responsive" src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" />
                        <span><?php echo $category['name']; ?></span>
                      </a>
                    </div>

                    <?php } ?>

                  </div>
                  <div class="clearfix"></div>
                </div>

              </div></div></div></div>
        <script>
            $('#oct-products-from-category-0').owlCarousel({
                items: 7,
                itemsDesktop : [1921,9],
                itemsDesktop : [1199,7],
                itemsDesktopSmall : [979,6],
                itemsTablet : [768,6],
                itemsMobile : [479,3],
                autoPlay: false,
                navigation: true,
                slideMargin: 10,
                navigationText: ['<i class="fa fa-angle-left fa-5x" aria-hidden="true"></i>', '<i class="fa fa-angle-right fa-5x" aria-hidden="true"></i>'],
                stopOnHover:true,
                smartSpeed: 800,
                loop: true,
                pagination: false
            });
        </script>
        <?php } ?>


        <div id="oct-filter-tag"></div>
        <?php if ($products) { ?>
        <div class="row sort-row-wrapper">
        <div class="row sort-row" <?php if ($oct_techstore_data['cat_sorttype'] != 'on') { ?>style="display:none !important;"<?php } ?>>
          <div class="text-left left-sort-row">
            <div class="form-group input-group input-group-sm input-sort-div">
              <label class="input-group-addon" for="input-sort"><?php echo $text_sort; ?></label>
              <select id="input-sort" onchange="location = this.value;">
                <?php foreach ($sorts as $sorts) { ?>
                <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
              <div class="clearfix"></div>
            </div>
            <div class="form-group input-group input-group-sm input-limit-div">
              <select id="input-limit" onchange="location = this.value;">
                <?php foreach ($limits as $limits) { ?>
                <?php if ($limits['value'] == $limit) { ?>
                <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="text-right right-sort-row">
            <div class="hidden-xs text-right appearance">
              <div class="btn-group btn-group-sm">
                <span class="oct-product-view-text"></span>
                <button type="button" id="list-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="fa fa-th-list"></i></button>
                <button type="button" id="grid-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="fa fa-th"></i></button>
              </div>
            </div>
          </div>
        </div>
        </div>
        <div id="res-products">
          <div class="row">
            <?php foreach ($products as $product) { ?>
            <div class="product-layout product-grid <?php if (!$column_left && !$column_right) { ?> <?php echo 'col-lg-3'; ?> <?php } ?> col-md-4 col-sm-6 col-xs-6">
              <div class="product-thumb<?php echo (isset($product['product_preorder_status']) && $product['product_preorder_status'] != 1 && $product['quantity'] <= 0) ? ' no_quantity' : ''?>">
                <div class="image">
                  <?php if (isset($oct_popup_view_data['status']) && $oct_popup_view_data['status'] && $product['quantity'] > 0) { ?>
                  <div class="quick-view"><a onclick="get_oct_popup_product_view('<?php echo $product['product_id']; ?>');"><?php echo $button_popup_view; ?></a></div>
                  <?php } ?>
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
					<?php if (isset($oct_lazyload) && $oct_lazyload) { ?>
						<a href="<?php echo $product['href']; ?>" class="lazy_link">
							<img data-original="<?php echo $product['thumb']; ?>" src="<?php echo $oct_lazyload_image; ?>" class="img-responsive lazy" alt="<?php echo $product['name'] ?>" />
						</a>
					<?php } else { ?>
						<a href="<?php echo $product['href']; ?>">
							<img src="<?php echo $product['thumb']; ?>" class="img-responsive" alt="<?php echo $product['name'] ?>" />
						</a>
					<?php } ?>
                  <a class="loupPlusBlackFa popupViewBtn" onclick="get_oct_popup_product_view('<?php echo $product['product_id']; ?>');"></a>
                </div>
                <div>
                  <div class="caption">
                    <p class="cat-model"><?php echo $text_model; ?> <span><?php echo $product['model']; ?></span></p>
                    <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>

                    <hr>
                    <div class="cat-box-effect">
                      <div class="cat-box-effect-inner">
                        <?php if ($product['price']) { ?>
                        <p class="price">
                          <?php if (!$product['special']) { ?>
                          <span class="common-price"><?php echo $product['price']; ?></span>
                          <?php } else { ?>
                          <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
                          <?php } ?>

                        </p>
                        <a onclick="get_oct_popup_add_to_wishlist('<?php echo $product['product_id']; ?>');" title="<?php echo $button_wishlist; ?>" class="wishlist oct-button"><i class="fa fa-heart" aria-hidden="true"></i></a>
                        <?php } ?>

                      </div>
                    </div>
                    <p class="oct-product-stock"><span class="hidden-xs"><?php echo $text_stock; ?></span> <span><?php echo $product['stock']; ?></span></p>
                    <div class="oct-additional-info">
                      <p class="oct-product-desc"><?php echo $product['description']; ?></p>
                      <?php if (isset($product['oct_options']) && $product['oct_options']) { ?>
                      <div class="cat-options">
                        <?php foreach ($product['oct_options'] as $option) { ?>
                        <?php if ($option['type'] == 'radio') { ?>
                        <div class="form-group">
                          <label class="control-label"><?php echo $option['name']; ?></label>
                          <br/>
                          <?php if ($option['product_option_value']) { ?>
                          <?php foreach ($option['product_option_value'] as $product_option_value) { ?>
                          <?php if ($product_option_value['image']) { ?>
                          <div class="radio">
                            <img src="<?php echo $product_option_value['image']; ?>" alt="<?php echo $product_option_value['name']; ?>" class="img-thumbnail" title="<?php echo $product_option_value['name']; ?>" />
                          </div>
                          <?php } else { ?>
                          <div class="radio">
                            <label class="not-selected"><?php echo $product_option_value['name']; ?></label>
                          </div>
                          <?php } ?>
                          <?php } ?>
                          <?php } ?>
                        </div>
                        <?php } else { ?>
                        <div class="form-group size-box">
                          <label class="control-label"><?php echo $option['name']; ?></label>
                          <br/>
                          <?php if ($option['product_option_value']) { ?>
                          <?php foreach ($option['product_option_value'] as $product_option_value) { ?>
                          <div class="radio">
                            <label class="not-selected"><?php echo $product_option_value['name']; ?></label>
                          </div>
                          <?php } ?>
                          <?php } ?>
                        </div>
                        <?php } ?>
                        <?php } ?>
                      </div>
                      <?php } ?>
	                    <?php if (isset($product['oct_attributes']) && $product['oct_attributes']) { ?>
	                      <div class="cat-options">
	                        <?php foreach ($product['oct_attributes'] as $attribute) { ?>
		                        <div class="form-group size-box">
		                          <label class="control-label"><?php echo $attribute['name']; ?></label>
		                          <br/>
			                        <span><?php echo $attribute['text']; ?></span>
		                        </div>
	                        <?php } ?>
	                      </div>
                      <?php } ?>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <?php } ?>
          </div>
          <div class="row pagination-row">
            <div class="col-sm-12 text-center"><?php echo $pagination; ?></div>
          </div>
        </div>
        <?php } ?>
        <?php if ($thumb || $description) { ?>
        <div class="row">
          <div class="col-sm-12 cat-desc-box">
            <?php if ($thumb) { ?>
            <img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail" />
            <?php } ?>
            <?php if ($description) { ?>
            <?php echo $description; ?>
            <?php } ?>
          </div>
        </div>
        <?php } ?>
        <?php if (!$categories && !$products) { ?>
        <p class="text-left empty-text"><?php echo $text_empty; ?></p>
        <div class="buttons">
          <div class="text-left"><a href="<?php echo $continue; ?>" class="oct-button"><?php echo $button_continue; ?></a></div>
        </div>
        <?php } ?>
      </div>
      <?php echo $column_right; ?>
    </div>
    <div class="clearfix"></div>
    <div id="LoadMoreHere"></div>
  </div>
</div>
<div class="container">
 <?php echo $content_bottom; ?>
</div>
<?php if (isset($oct_lazyload) && $oct_lazyload) { ?>
<script>
	$(function() {
		setTimeout(function() {
			$("img.lazy").lazyload({
				effect : "fadeIn"
			});
		}, 10);
	});
</script>
<?php } ?>
<?php echo $footer; ?>
