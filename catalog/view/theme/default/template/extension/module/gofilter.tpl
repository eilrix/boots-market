<?php if ($on_category) { ?>
<div class="options<?php if ($get_category_id) { ?> filter_category_page<?php } ?>" id="home_filter">
<div class="btn-white margin-bottom">
<div class="filter">
<form action="index.php?" method="get" id="filter_send">
<input type="hidden" name="route" value="product/category" />
<?php if ($category_id) { ?>
<input type="hidden" name="path" value="<?php echo $category_id; ?>" />
<input type="hidden" name="category_id" value="<?php echo $category_id; ?>" class="categ" />
<?php } ?>
<?php $seo_on = false; $popup_on = true;?>
<input type="hidden" name="keywords_filter" value="<?php if (isset($keywords_filter_text)) {echo $keywords_filter_text;} ?>" />
<?php if (isset($max_price_const) or $old_price) { ?><input type="hidden" name="op" value="<?php if (isset($max_price_const)) {echo $max_price_const;} else {echo $old_price;} ?>" class="filter_op" /><?php } ?>
<?php $drop_option = true; $drop_attributes = true; ?>
<?php
	if (isset($popup_view)) {$popup_on = false;}
	if (!isset($max_height)) {$max_height = '215';}
	if (!isset($count_show)) {$count_show = 3;}
?>
<?php foreach ($currencies as $currency) { ?>
	<?php if ($currency['symbol_left'] && $currency['code'] == $code) { ?>
		<?php $value_max_currency_left = $currency['symbol_left']; ?>
	<?php } elseif ($currency['symbol_right'] && $currency['code'] == $code) { ?>
		<?php $value_max_currency_right = $currency['symbol_right']; ?>
	<?php } ?>
<?php } ?>
<div id="option_filter">
	<?php if ($name_module and $name_module != "") { ?><h3 class="col-sm-12"><i class="fa fa-filter"></i>&nbsp;&nbsp;&nbsp;<?php echo $name_module; ?></h3><?php } ?>
	<div class="clearfix">
	<div class="options_container_filter col-sm-12">
	<div class="clearfix"></div>
	<div class="options_container filter_container">
		<?php if ($category_id) { ?><a class="btn btn-white category_filt" onclick="<?php if ($category_type=="radio" or $category_type=="link") { ?>live_option_product('category_filter', 'options', '', '');<?php } else { ?>live_home_clear_category_filter(<?php echo $category_id; ?>)<?php } ?>"><span class="pull-left"><?php echo $category_name; ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a><?php } ?>
		<?php if ($get_price_max and isset($max_price_const)) { ?>
			<?php if ($get_price_max > $max_price_const) {
				if (isset($max_price_const)) {$test_price = $max_price_const;}
			} else {
				if (isset($get_price_max)) {$test_price = $get_price_max;}
			} ?>
			<?php if ($test_price != $max_price_const or $get_price_min != 0) { ?>
				<?php foreach ($currencies as $currency) { ?>
					<?php if ($currency['symbol_left'] && $currency['code'] == $code) { ?>
						<?php $value_max_currency = $currency['symbol_left']; ?>
					<?php } elseif ($currency['symbol_right'] && $currency['code'] == $code) { ?>
						<?php $value_max_currency = $currency['symbol_right']; ?>
					<?php } ?>
				<?php } ?>
				<a class="btn btn-white option_cloud_price" onclick="slider_generation('0','<?php echo $max_price_const; ?>','clear'); clear_popup_filter();"><span class="pull-left"><?php echo $text_price; ?> <?php if (isset($min_price)) {echo $min_price;} ?> - <?php if ($get_price_max > $max_price_const) {if (isset($max_price_const)) {echo $max_price_const;}} else {if (isset($max_price)) {echo $max_price;}} ?> <?php if (isset($value_max_currency)) {echo $value_max_currency;} ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a>
			<?php } ?>
		<?php } ?>
		<?php if (isset($manufacturers)) { ?>
			<?php $n = 2000; ?>
			<?php foreach ($manufacturers as $manufacturer) { ?>
				<?php if ($manufacturer['manufacturer_value_required']) { ?>
					<a class="btn btn-white option_cloud<?php echo $n; ?><?php echo $manufacturer['manufacturer_id']; ?>" onclick="<?php if ($manufacturers_type == 'radio') { ?>live_option_product('manufacturers_filter', 'options', '', '');<?php } else { ?>live_home_clear_manufacturers_filter(<?php echo $manufacturer['manufacturer_id']; ?>);<?php } ?>"><span class="pull-left"><?php echo $manufacturer['name']; ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a>
				<?php } ?>
				<?php $n = $n + 1; ?>
			<?php } ?>
		<?php } ?>
		<?php $k = 1; ?>
		<?php if (isset($keywords_filter)) { ?>
			<?php foreach ($keywords_filter as $keywords_value => $value) { ?>
				<?php if ($value != "") { ?>
					<a class="btn btn-white option_cloud_keywords<?php echo $k ?>" onclick="live_home_clear_keywords_filter(<?php echo $value; ?>, <?php echo $k ?>);" data-value="<?php echo $value; ?>"><span class="pull-left"><?php echo $value; ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a>
				<?php } ?>
				<?php $k = $k + 1; ?>
			<?php } ?>
		<?php } ?>
		<?php if (isset($stock_statuses)) { ?>
			<?php foreach ($stock_statuses as $stock_status) { ?>
				<?php if ($stock_status['stock_status_value_required']) { ?>
					<a class="btn btn-white option_cloud<?php echo $stock_status['status_id']; ?>" onclick="<?php if ($status_stock_type == 'radio') { ?>live_option_product('stock_status_filter', 'options', '', '');<?php } else { ?>live_home_clear_stock_filter('<?php echo $stock_status['status_id']; ?>');<?php } ?>"><span class="pull-left"><?php echo $stock_status['name']; ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($options) { ?>
			<?php foreach ($options as $option) { ?>
				<?php foreach ($option['option_value'] as $option_value) { ?>
					<?php if ($option_value['option_value_required']) { ?>
						<a class="btn btn-white option_cloud<?php echo $option_value['option_value_id']; ?>" onclick="live_home_clear_option_filter(<?php echo $option_value['option_value_id']; ?>);"><span class="pull-left"><?php echo $option['name'] . ": " . $option_value['option_value_name']; ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($attributes) { ?>
			<?php $m = 1000; ?>
			<?php foreach ($attributes as $attribute) { ?>
				<?php foreach ($attribute['attribute'] as $attribute_text) { ?>
					<?php if ($attribute_text['attribute_value_required'] and $attribute_text['attribute_stock_required']) { ?>
						<a class="btn btn-white option_cloud<?php echo $m; ?><?php echo $attribute['attribute_id']; ?>" onclick="live_home_clear_attributes_filter(<?php echo $m; ?><?php echo $attribute['attribute_id']; ?>);"><span class="pull-left"><?php echo $attribute['name'] . ": " . $attribute_text['text']; ?></span>&nbsp;&nbsp;<i class="fa fa-times pull-right" aria-hidden="true"></i></a>
					<?php } ?>
					<?php $m = $m + 1; ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($options or $attributes or $prices_max_value) {} else { ?>
			<span class="clearfix">
				<?php if ($prices_max_value) { ?><?php echo $text_option_no_empty; ?><?php } ?>
			</span>
		<?php } ?>
		<?php if (isset($ratings)) { ?>
			<?php foreach ($ratings as $rating) { ?>
				<?php if ($rating['rating_value_required']) { ?>
					<a class="btn btn-white option_cloud<?php echo $rating['rating']; ?>" onclick="<?php if ($ratings_type == 'radio') { ?>live_option_product('rating_filter', 'options', '', '');<?php } else { ?>live_home_clear_rating_filter(<?php echo $rating['rating']; ?>);<?php } ?>">
					<span class="rating">
						<?php for ($i = 1; $i <= 5; $i++) { ?>
							<?php if ($rating['rating'] < $i) { ?>
								<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
							<?php } else { ?>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
							<?php } ?>
						<?php } ?>
					</span>
					&nbsp;&nbsp;<i class="fa fa-times pull-right"></i></a>
				<?php } ?>
			<?php } ?>
		<?php } ?>
	</div>
	</div>
	<?php
		$view_prices = false; $view_categories = false; $view_keywords_filter = false; $view_options = false; $view_attributes = false; $view_manufacturers = false; $view_stock_statuses = false; $view_ratings = false;
		if ($common_massiv['view']['categories'] == 1) {$view_categories = "column";} else {$view_categories = "content";}
		if ($common_massiv['view']['prices'] == 1) {$view_prices = "column";} else {$view_prices = "content";}
		if ($common_massiv['view']['keywords_filter'] == 1) {$view_keywords_filter = "column";} else {$view_keywords_filter = "content";}
		if ($common_massiv['view']['options'] == 1) {$view_options = "column";} else {$view_options = "content";}
		if ($common_massiv['view']['attributes'] == 1) {$view_attributes = "column";} else {$view_attributes = "content";}
		if ($common_massiv['view']['manufacturers'] == 1) {$view_manufacturers = "column";} else {$view_manufacturers = "content";}
		if ($common_massiv['view']['stock_statuses'] == 1) {$view_stock_statuses = "column";} else {$view_stock_statuses = "content";}
		if ($common_massiv['view']['ratings'] == 1) {$view_ratings = "column";} else {$view_ratings = "content";}
	?>
	<?php foreach($type_filters as $type_filter => $value) { ?>
		<?php if ($view_categories) { ?>
			<?php if ($value == "categories") { ?>
				<?php if ($status_category) { ?>
					<?php if (isset($categories)) { ?>
						<div class="checkbox-group btn-border col-sm-12<?php if ($view_categories == "column") { ?> column_filt<?php if ($go_mobile) { ?> column_mobile<?php } ?><?php } ?><?php if ($view_categories == "content") { ?> content_filt<?php } ?><?php if ($collapse_category == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_category == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_category == 0) { ?> hidden-sm<?php } ?>">
							<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.checkbox-group-overflow').slideToggle(300); $(this).parent().parent().find('.select-group').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $text_category; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
							<?php if ($category_type == 'link') { ?>
								<div class="checkbox-group-overflow">
									<?php if (isset($parent_category_id)) { ?>
										<div class="radio">
											<?php if ($old_category_id) { ?>
												<a class="category_filter">
													<i class="fa fa-reply-all pull-left"></i>
													<input type="hidden" name="category_id" value="<?php echo $category_id; ?>" checked />
													<input type="radio" name="category_id" value="<?php echo $old_category_id; ?>" id="option-value-category-<?php echo $old_category_id; ?>" />
													<label for="option-value-category-<?php echo $old_category_id; ?>">
														<?php echo $parent_category_id['name']; ?>
													</label>
												</a>
											<?php } else { ?>
												<input type="hidden" name="category_id" value="<?php echo $category_id; ?>" checked />
												<a class="category_filter" onclick="live_option_product('category_filter', 'options', '', '');">
													<i class="fa fa-reply-all pull-left"></i>
													<input type="hidden" name="old_category_id" value="<?php echo $parent_category_id['category_id']; ?>" id="" />
													<label for="option-value-category-<?php echo $parent_category_id['category_id']; ?>">
														<?php echo $parent_category_id['name']; ?>
													</label>
												</a>
											<?php } ?>
										</div>
									<?php } ?>
									<?php foreach ($categories as $category) { ?>
										<?php if ($category['category_stock_required'] or isset($parent_category_id)) { ?>
											<div class="radio">
												<a class="category_filter<?php if (!$category['total']) { ?> not-active-link<?php } ?>"><input type="radio"<?php if ($category['category_value_required']) { ?> checked<?php } ?> name="category_id" value="<?php echo $category['category_id']; ?>" data-category="category-<?php echo $category['category_id']; ?>" id="option-value-category-<?php echo $category['category_id']; ?>"<?php if (!$category['total']) { ?> disabled<?php } ?> /><?php if ($category['category_value_required']) { ?><i class="fa fa-check pull-left"></i><?php } ?>
													<label for="option-value-category-<?php echo $category['category_id']; ?>">
														<?php echo $category['name']; ?>
														<?php if ($category['category_value_required']) { ?>
															<i class="fa fa-close pull-right" onclick="live_home_filter();"></i>
														<?php } else { ?>
															<?php if ($category['total']) { ?><span class="filter_total"><?php echo $category['total']; ?></span><?php } else { ?><span class="filter_total gray">0</span><?php } ?>
														<?php } ?>
													</label>
												</a>
											</div>
										<?php } ?>
									<?php } ?>
									<div class="radio"><span id="popup_categories"></span></div>
								</div>
							<?php } ?>
							<?php if ($category_type == 'select') { ?>
								<div class="select-group">
									<select name="category_id" id="category-option" class="form-control">
										<option value="" id="common_category"><?php echo $text_select; ?></option>
										<?php foreach ($categories as $category) { ?>
											<?php if ($category['category_stock_required']) { ?>
												<option value="<?php echo $category['category_id']; ?>" <?php if ($category['category_value_required']) { ?> selected<?php } ?><?php if (!$category['total']) { ?> disabled<?php } ?>><?php echo $category['name']; ?><?php if ($category['total']) { ?> (<?php echo $category['total']; ?>)<?php } else { ?> (0)<?php } ?></option>
											<?php } ?>
										<?php } ?>
									</select>
									<div class="radio"><span id="popup_categories"></span></div>
								</div>
							<?php } ?>
							<?php if ($category_type == 'radio') { ?>
								<div class="checkbox-group-overflow">
									<?php if (isset($parent_category_id)) { ?>
										<div class="radio">
											<?php if ($old_category_id) { ?>
												<a class="category_filter">
													<i class="fa fa-reply-all pull-left"></i>
													<input type="hidden" name="category_id" value="<?php echo $category_id; ?>" checked />
													<input type="radio" name="category_id" value="<?php echo $old_category_id; ?>" id="option-value-category-<?php echo $old_category_id; ?>" />
													
													<label for="option-value-category-<?php echo $old_category_id; ?>">
														<?php echo $parent_category_id['name']; ?>
													</label>
												</a>
											<?php } else { ?>
												<input type="hidden" name="category_id" value="<?php echo $category_id; ?>" checked />
												<a class="category_filter" onclick="live_option_product('category_filter', 'options', '', '');">
													<i class="fa fa-reply-all pull-left"></i>
													<input type="hidden" name="old_category_id" value="<?php echo $parent_category_id['category_id']; ?>" id="" />
													<label for="option-value-category-<?php echo $parent_category_id['category_id']; ?>">
														<?php echo $parent_category_id['name']; ?>
													</label>
												</a>
											<?php } ?>
										</div>
									<?php } ?>
									<?php foreach ($categories as $category) { ?>
										<?php if ($category['category_stock_required'] or isset($parent_category_id)) { ?>
											<div class="radio">
											  <input type="radio"<?php if ($category['category_value_required']) { ?> checked<?php } ?> name="category_id" value="<?php echo $category['category_id']; ?>" data-category="category-<?php echo $category['category_id']; ?>" id="option-value-category-<?php echo $category['category_id']; ?>"<?php if (!$category['total']) { ?> disabled<?php } ?> />
											  <label for="option-value-category-<?php echo $category['category_id']; ?>">
												<?php echo $category['name']; ?>
												<?php if ($category['category_value_required']) { ?>
													<i class="fa fa-close" onclick="live_option_product('category_filter', 'options', '', '');"></i>
												<?php } else { ?>
													<?php if ($category['total']) { ?><span class="filter_total"><?php echo $category['total']; ?></span><?php } else { ?><span class="filter_total gray">0</span><?php } ?>
												<?php } ?>
											  </label>
											</div>
										<?php } ?>
									<?php } ?>
									<div class="radio"><span id="popup_categories"></span></div>
								</div>
							<?php } ?>
						</div>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if (isset($max_price_const) or $old_price) { ?>
			<?php if ($view_prices) { ?>
				<?php if ($value == "prices") { ?>
					<?php if ($status_price) { ?>
						<div class="checkbox-group-price btn-border col-sm-12<?php if ($view_prices == "column") { ?> column_filt<?php if ($go_mobile) { ?> column_mobile<?php } ?><?php } ?><?php if ($view_prices == "content") { ?> content_filt<?php } ?><?php if ($collapse_price == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_price == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_price == 0) { ?> hidden-sm<?php } ?>">
							<div class="checkbox-group-overflow-price<?php if ($view_prices == "column") { ?> column_filt<?php } ?><?php if ($view_prices == "content") { ?> content_filt<?php } ?>">
								<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.formCost.checkbox').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $text_range_price; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
								<div class="formCost checkbox">
									 <?php if (isset($value_max_currency_left)) { ?><label class="pull-left"><?php if (isset($value_max_currency_left)) {echo $value_max_currency_left;} ?></label><?php } ?><input type="text" name="prices_min_value" id="minCost" value="<?php if (isset($min_price)) {echo $min_price;} ?>" class="pull-left form-control" /><label class="pull-left"><?php if (isset($value_max_currency_right)) {echo $value_max_currency_right;} ?>&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;</label>
									 <?php if (isset($value_max_currency_left)) { ?><label class="pull-left"><?php if (isset($value_max_currency_left)) {echo $value_max_currency_left;} ?></label><?php } ?><input type="text" name="prices_max_value" id="maxCost" value="<?php if (isset($max_price_const)) {if ($get_price_max > $max_price_const) {if (isset($max_price_const)) {echo $max_price_const;}} else {if (isset($max_price)) {echo $max_price;}} } else {echo $prices_max_value;} ?>" class="pull-left form-control" /> <?php if (isset($value_max_currency_right)) { ?><label for="maxCost" class="pull-left"><?php echo $value_max_currency_right; ?></label><?php } ?>
									<div class="clearfix"><div id="formCost_popup"></div></div>
									<div class="clearfix"></div><br />
									<div class="col-sm-12"><div class="slider"></div></div>
								</div><div class="clearfix"></div>
							</div>
						</div>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($view_keywords_filter) { ?>
			<?php if ($value == "keywords_filter") { ?>
				<?php if ($status_keywords) { ?>
					<?php if (isset($max_price_const)) { ?>
						<div class="checkbox-group btn-border col-sm-12<?php if ($view_keywords_filter == "column") { ?> column_filt<?php } ?><?php if ($view_keywords_filter == "content") { ?> content_filt<?php } ?><?php if ($collapse_keywords == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_keywords == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_keywords == 0) { ?> hidden-sm<?php } ?>">
							<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.select-group').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $text_keywords; ?></strong><i class="fa fa-caret-down pull-right"></i></h4></div>
							<div class="select-group">
								<div id="keywords_filter" class="input-group select-group">
								  <input type="text" id="keywords_filter_input" name="keywords_filter" value="<?php if (isset($keywords_filter_text)) {echo $keywords_filter_text;} ?>" placeholder="<?php if ($delimitier == " ") {echo $text_keywords_placeholder;} ?><?php if ($delimitier == ",") {echo $text_keywords_placeholder_zap;} ?>" class="form-control" />
								  <span class="input-group-btn">
									<button type="button" class="btn"><i class="fa fa-search"></i></button>
								  </span>
								</div>
							</div>
						</div>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($view_manufacturers) { ?>
			<?php if ($value == "manufacturers") { ?>
				<?php if ($status_manufacturers) { ?>
					<?php if (isset($manufacturers)) { ?>
						<?php if ($view_manufacturers == "column") {$sort_manufacturers = array(); foreach ($manufacturers as $key => $value) {$sort_manufacturers[$key] = $value['manufacturers_stock_required'];} array_multisort($sort_manufacturers, SORT_DESC, $manufacturers);} ?>
						<div class="checkbox-group btn-border col-sm-12<?php if ($view_manufacturers == "column") { ?> column_filt<?php } ?><?php if ($view_manufacturers == "content") { ?> content_filt<?php } ?><?php if ($collapse_manufacturers == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_manufacturers == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_manufacturers == 0) { ?> hidden-sm<?php } ?>">
							<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.checkbox-group-overflow').slideToggle(300); $(this).parent().parent().find('.select-group').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $text_manufacturers; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
							<?php $count = 0; ?>
							<?php $coun_end = 0; ?>
							<?php $count_group = 100; ?>
							<?php if ($manufacturers_type == 'checkbox') { ?>
								<div class="checkbox-group-overflow">
								<?php $test_checked = 0; foreach ($manufacturers as $manufacturer) {if ($manufacturer['manufacturer_value_required']) {$test_checked = $test_checked + 1;}} ?>
									<?php foreach ($manufacturers as $manufacturer) { ?>
									<?php $count = $count + 1; ?>
										<div class="checkbox<?php if ($test_checked == 0) {if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php } } ?>">
										  <input type="checkbox"<?php if ($manufacturer['manufacturer_value_required']) { ?> checked<?php } ?> name="manufacturers_filter[]" value="<?php echo $manufacturer['manufacturer_id']; ?>" data-manufacturers="manufacturers-<?php echo $manufacturer['manufacturer_id']; ?>" id="option-value-manufacturers-<?php echo $manufacturer['manufacturer_id']; ?>"<?php if (!$manufacturer['manufacturers_stock_required'] and !$manufacturer['manufacturer_value_required']) { ?> disabled<?php } ?> />
										  <label for="option-value-manufacturers-<?php echo $manufacturer['manufacturer_id']; ?>">
											<?php if ($manufacturer['image'])  { ?><img src="<?php echo $manufacturer['image']; ?>" alt="" title="" /><?php } ?>
											<?php echo $manufacturer['name']; ?>
											<?php if ($manufacturer['manufacturer_value_required']) { ?>
												<?php if ($manufacturer['manufacturers_stock_required']) { ?>
													<i class="fa fa-close pull-right"></i>
												<?php } ?>
											<?php } else { ?>
												<?php if ($manufacturer['manufacturer_value_total']) { ?><span class="filter_total"><?php echo $manufacturer['manufacturer_value_total']; ?></span><?php } else { ?><span class="filter_total filter_gray">0</span><?php } ?>
											<?php } ?>
										  </label>
										</div>
										<?php $coun_end = $coun_end + 1; ?>
									<?php } ?>
								</div>
								<?php $coun_end = $coun_end - $count_show; ?>
								<?php if ($test_checked == 0) {if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
							<?php } ?>
							<?php if ($manufacturers_type == 'select') { ?>
								<div class="select-group">
								   <div class="checkbox">
										<select name="manufacturers_filter[]" id="manufacturers-option" class="form-control">
											<option value="" id="common_manufacturers"><?php echo $text_select; ?></option>
											<?php $test_checked = 0; foreach ($manufacturers as $manufacturer) {if ($manufacturer['manufacturer_value_required']) {$test_checked = $test_checked + 1;}} ?>
											<?php foreach ($manufacturers as $manufacturer) { ?>
												<option value="<?php echo $manufacturer['manufacturer_id']; ?>" <?php if ($manufacturer['manufacturer_value_required']) { ?> selected<?php } ?><?php if (!$manufacturer['manufacturers_stock_required']) { ?> disabled<?php } ?>><?php echo $manufacturer['name']; ?><?php if ($manufacturer['manufacturer_value_total']) { ?> (<?php echo $manufacturer['manufacturer_value_total']; ?>)<?php } ?></option>
											<?php } ?>
										</select>
									</div>
								</div>
							<?php } ?>
							<?php if ($manufacturers_type == 'radio') { ?>
								<div class="checkbox-group-overflow">
									<?php $test_checked = 0; foreach ($manufacturers as $manufacturer) {if ($manufacturer['manufacturer_value_required']) {$test_checked = $test_checked + 1;}} ?>
									<?php foreach ($manufacturers as $manufacturer) { ?>
										<?php $count = $count + 1; ?>
										<div class="radio<?php if ($test_checked == 0) {if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php } } ?>">
										  <input type="radio"<?php if ($manufacturer['manufacturer_value_required']) { ?> checked<?php } ?> name="manufacturers_filter[]" value="<?php echo $manufacturer['manufacturer_id']; ?>" data-manufacturer="manufacturer-<?php echo $manufacturer['manufacturer_id']; ?>" id="option-value-manufacturer-<?php echo $manufacturer['manufacturer_id']; ?>"<?php if (!$manufacturer['manufacturers_stock_required']) { ?> disabled<?php } ?> />
										  <label for="option-value-manufacturer-<?php echo $manufacturer['manufacturer_id']; ?>">
											<?php if ($manufacturer['image'])  { ?><img src="<?php echo $manufacturer['image']; ?>" alt="" title="" /><?php } ?>
											<?php echo $manufacturer['name']; ?>
											<?php if ($manufacturer['manufacturer_value_required']) { ?>
												<i class="fa fa-close pull-right" onclick="live_option_product('manufacturers_filter', 'options', '', '');"></i>
											<?php } else { ?>
												<?php if ($manufacturer['manufacturer_value_total']) { ?><span class="filter_total"><?php echo $manufacturer['manufacturer_value_total']; ?></span><?php } ?>
											<?php } ?>
										  </label>
										</div>
										<?php $coun_end = $coun_end + 1; ?>
									<?php } ?>
								</div>
								<?php $coun_end = $coun_end - $count_show; ?>
								<?php if ($test_checked == 0) {if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
							<?php } ?>
						</div>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($view_stock_statuses) { ?>
			<?php if ($value == "stock_statuses") { ?>
				<?php if ($status_stock) { ?>
					<?php if (isset($stock_statuses)) { ?>
						<div class="checkbox-group btn-border col-sm-12<?php if ($view_stock_statuses == "column") { ?> column_filt<?php } ?><?php if ($view_stock_statuses == "content") { ?> content_filt<?php } ?><?php if ($collapse_stock == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_stock == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_stock == 0) { ?> hidden-sm<?php } ?>">
							<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.checkbox-group-overflow').slideToggle(300); $(this).parent().parent().find('.select-group').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $text_stock_status; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
							<?php $count = 0; ?>
							<?php $coun_end = 0; ?>
							<?php $count_group = 200; ?>
							<?php if ($status_stock_type == 'checkbox') { ?>
								<div class="checkbox-group-overflow">
								<?php $test_checked = 0; foreach ($stock_statuses as $stock_status) {if ($stock_status['stock_status_value_required']) {$test_checked = $test_checked + 1;}} ?>
									<?php foreach ($stock_statuses as $stock_status) { ?>
										<?php $count = $count + 1; ?>
										<div class="checkbox<?php if ($test_checked == 0) {if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php } } ?>">
										  <input type="checkbox"<?php if ($stock_status['stock_status_value_required']) { ?> checked<?php } ?> name="stock_status_filter[]" value="<?php echo $stock_status['status_id']; ?>" data-stock="stock-<?php echo $stock_status['status_id']; ?>" id="option-value-stock-<?php echo $stock_status['status_id']; ?>" <?php if (!$stock_status['stock_status_stock_required']) { ?> disabled<?php } ?> />
										  <label for="option-value-stock-<?php echo $stock_status['status_id']; ?>">
											<?php echo $stock_status['name']; ?>
											<?php if ($stock_status['stock_status_value_required']) { ?>
												<?php if ($stock_status['stock_status_value_required']) { ?>
														<i class="fa fa-close pull-right" onclick="live_option_product('stock_status_filter', 'options', '', '');"></i>
													<?php } else { ?>
														<?php if ($stock_status['stock_status_value_total']) { ?><span class="filter_total gray">0</span><?php } ?>
													<?php } ?>
												<?php } else { ?>
													<?php if ($stock_status['stock_status_value_total']) { ?><span class="filter_total"><?php echo $stock_status['stock_status_value_total']; ?></span><?php } else { ?><span class="filter_total gray">0</span><?php } ?>
												<?php } ?>
										  </label>
										</div>
										<?php $coun_end = $coun_end + 1; ?>
									<?php } ?>
								</div>
								<?php $coun_end = $coun_end - $count_show; ?>
								<?php if ($test_checked == 0) {if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
							<?php } ?>
							<?php if ($status_stock_type == 'select') { ?>
								<div class="select-group">
								   <div class="checkbox">
										<select name="stock_status_filter[]" id="stock_status-option" class="form-control">
											<option value="" id="common_stock_status"><?php echo $text_select; ?></option>
											<?php foreach ($stock_statuses as $stock_status) { ?>
												<option value="<?php echo $stock_status['stock_status_id_array']; ?>" <?php if ($stock_status['stock_status_value_required']) { ?> selected<?php } ?><?php if (!$stock_status['stock_status_stock_required']) { ?> disabled<?php } ?>><?php echo $stock_status['name']; ?><?php if ($stock_status['stock_status_value_total']) { ?> (<?php echo $stock_status['stock_status_value_total']; ?>)<?php } ?></option>
											<?php } ?>
										</select>
									</div>
								</div>
							<?php } ?>
							<?php if ($status_stock_type == 'radio') { ?>
								<div class="checkbox-group-overflow">
									<?php foreach ($stock_statuses as $stock_status) { ?>
										<?php $count = $count + 1; ?>
										<div class="radio<?php if ($test_checked == 0) {if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php } } ?>">
										  <input type="radio"<?php if ($stock_status['stock_status_value_required']) { ?> checked<?php } ?> name="stock_status_filter[]" value="<?php echo $stock_status['stock_status_id_array']; ?>" data-stock_status="stock_status-<?php echo $stock_status['stock_status_id_array']; ?>" id="option-value-stock_status-<?php echo $stock_status['stock_status_id_array']; ?>"<?php if (!$stock_status['stock_status_stock_required']) { ?> disabled<?php } ?> />
										  <label for="option-value-stock_status-<?php echo $stock_status['stock_status_id_array']; ?>">
											<?php echo $stock_status['name']; ?>
											<?php if ($stock_status['stock_status_value_required']) { ?>
												<?php if ($stock_status['stock_status_value_required']) { ?>
													<i class="fa fa-close pull-right" onclick="live_option_product('stock_status_filter', 'options', '', '');"></i>
												<?php } else { ?>
													<?php if ($stock_status['stock_status_value_total']) { ?><span class="filter_total gray">0</span><?php } ?>
												<?php } ?>
											<?php } else { ?>
												<?php if ($stock_status['stock_status_value_total']) { ?><span class="filter_total"><?php echo $stock_status['stock_status_value_total']; ?></span><?php } else { ?><span class="filter_total gray">0</span><?php } ?>
											<?php } ?>
										  </label>
										</div>
										<?php $coun_end = $coun_end + 1; ?>
									<?php } ?>
								</div>
								<?php $coun_end = $coun_end - $count_show; ?>
								<?php if ($test_checked == 0) {if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
							<?php } ?>
						</div>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($view_ratings) { ?>
			<?php if ($value == "ratings") { ?>
				<?php if ($status_ratings) { ?>
					<?php if (isset($ratings)) { ?>
						<?php if ($view_ratings == "column") {$sort_ratings = array(); foreach ($ratings as $key => $value) {$sort_ratings[$key] = $value['ratings_stock_required'];} array_multisort($sort_ratings, SORT_DESC, $ratings);} ?>
						<div class="checkbox-group btn-border col-sm-12<?php if ($view_ratings == "column") { ?> column_filt<?php } ?><?php if ($view_ratings == "content") { ?> content_filt<?php } ?><?php if ($collapse_ratings == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_ratings == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_ratings == 0) { ?> hidden-sm<?php } ?>">
							<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.checkbox-group-overflow').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $text_rating; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
							<?php $count = 0; ?>
							<?php $coun_end = 0; ?>
							<?php $count_group = 300; ?>
							<?php if ($ratings_type == 'checkbox') { ?>
								<div class="checkbox-group-overflow">
								<?php $test_checked = 0; foreach ($ratings as $rating) {if ($rating['rating_value_required']) {$test_checked = $test_checked + 1;}} ?>
									<?php foreach ($ratings as $rating) { ?>
										<?php $count = $count + 1; ?>
										<div class="checkbox<?php if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php } ?>">
										  <input type="checkbox"<?php if ($rating['rating_value_required']) { ?> checked<?php } ?> name="rating_filter[]" value="<?php echo $rating['rating']; ?>" data-rating="<?php echo $rating['rating']; ?>" id="option-value-rating-<?php echo $rating['rating']; ?>"<?php if (!$rating['ratings_stock_required']) { ?> disabled<?php } ?> />
										  <label for="option-value-rating-<?php echo $rating['rating']; ?>">
											<span class="rating">
												<?php for ($i = 1; $i <= 5; $i++) { ?>
													<?php if ($rating['rating'] < $i) { ?>
														<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
													<?php } else { ?>
														<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
													<?php } ?>
												<?php } ?>
											</span>
											<?php if ($rating['rating_value_required']) { ?>
												<i class="fa fa-close pull-right"></i>
											<?php } else { ?>
												<?php if ($rating['rating_value_total']) { ?><span class="filter_total"><?php echo $rating['rating_value_total']; ?></span><?php } ?>
											<?php } ?>
										  </label>
										</div>
										<?php $coun_end = $coun_end + 1; ?>
									<?php } ?>
								</div>
								<?php $coun_end = $coun_end - $count_show; ?>
								<?php if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } ?>
							<?php } ?>
							<?php if ($ratings_type == 'radio') { ?>
								<div class="checkbox-group-overflow">
									<?php foreach ($ratings as $rating) { ?>
										<?php $count = $count + 1; ?>
										<div class="radio<?php if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php } ?>">
										  <input type="radio"<?php if ($rating['rating_value_required']) { ?> checked<?php } ?> name="rating_filter[]" value="<?php echo $rating['rating']; ?>" data-rating="<?php echo $rating['rating']; ?>" id="option-value-rating-<?php echo $rating['rating']; ?>"<?php if (!$rating['ratings_stock_required']) { ?> disabled<?php } ?> />
										  <label for="option-value-rating-<?php echo $rating['rating']; ?>">
											<span class="rating">
												<?php for ($i = 1; $i <= 5; $i++) { ?>
													<?php if ($rating['rating'] < $i) { ?>
														<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
													<?php } else { ?>
														<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
													<?php } ?>
												<?php } ?>
											</span>
											<?php if ($rating['rating_value_required']) { ?>
												<i class="fa fa-close pull-right" onclick="live_option_product('rating_filter', 'options', '', '');"></i>
											<?php } else { ?>
												<?php if ($rating['rating_value_total']) { ?><span class="filter_total"><?php echo $rating['rating_value_total']; ?></span><?php } ?>
											<?php } ?>
										  </label>
										</div>
										<?php $coun_end = $coun_end + 1; ?>
									<?php } ?>
								</div>
								<?php $coun_end = $coun_end - $count_show; ?>
								<?php if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } ?>
							<?php } ?>
						</div>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($view_options) { ?>
			<?php if ($value == "options") { ?>
				<?php if ($status_options) { ?>
					<?php if ($options) { ?>
						<?php $count_group = 400; ?>
						<?php foreach ($options as $option) { ?>
						<?php if ($option['type'] == 'checkbox' or $option['type'] == 'radio' or $option['type'] == 'select') { ?>
						<div class="checkbox-group btn-border col-sm-12<?php if ($view_options == "column") { ?> column_filt<?php } ?><?php if ($view_options == "content") { ?> content_filt<?php } ?><?php if ($collapse_options == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_options == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_options == 0) { ?> hidden-sm<?php } ?>">
							<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.checkbox-group-overflow').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $option['name']; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
								<div class="checkbox-group-overflow<?php if (!$drop_option) { ?> no_drop<?php } ?>">
									<?php $count = 0; ?>
									<?php $coun_end = 0; ?>
									<?php $test_checked = 0; foreach ($option['option_value'] as $option_value) {if ($option_value['option_value_required']) {$test_checked = $test_checked + 1;}} ?>
									<?php foreach ($option['option_value'] as $option_value) { ?>
										<?php $count = $count + 1; ?>
											<div class="checkbox<?php if ($test_checked == 0) {if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php }} ?>">
											  <input type="checkbox"<?php if ($option_value['option_value_required']) { ?> checked<?php } ?> name="option_filter[]" value="<?php echo $option_value['option_value_id']; ?>" id="option-value-<?php echo $option_value['option_value_id']; ?>" <?php if (!$option_value['option_stock_required']) { ?> disabled<?php } ?> data-options="<?php echo $option['option_id']; ?>" />
											  <label for="option-value-<?php echo $option_value['option_value_id']; ?>">
												<?php if ($option_value['image']) { ?><img src="<?php echo $option_value['image']; ?>" alt="" title="" /><?php } ?>
												<?php echo $option_value['option_value_name']; ?>
												<?php if ($option_value['option_value_required']) { ?>
													<?php if ($option_value['option_stock_required']) { ?>
														<i class="fa fa-close pull-right" onclick="live_home_clear_option_filter('<?php echo $m; ?><?php echo $option_value['option_value_id']; ?>');"></i>
													<?php } else { ?>
														<?php if ($option_value['option_value_total']) { ?><span class="filter_total filter_gray">0</span><?php } ?>
													<?php } ?>
												<?php } else { ?>
													<?php if ($option_value['option_value_total']) { ?><span class="filter_total"><?php echo $option_value['option_value_total']; ?></span><?php } ?>
												<?php } ?>
											  </label>
											</div>
											<?php $coun_end = $coun_end + 1; ?>
									<?php } ?>
								</div>
								<?php $coun_end = $coun_end - $count_show; ?>
								<?php if ($test_checked == 0) {if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
						</div>
						<?php } ?>
						<?php $count_group = $count_group + 1; ?>
						<?php } ?>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
		<?php if ($view_attributes) { ?>
			<?php if ($value == "attributes") { ?>
				<?php if ($status_attributes) { ?>
					<?php if ($attributes) { ?>
						<?php $m = 1000; ?>
						<?php $count_group = 500; ?>
						<?php foreach ($attributes as $attribute) { ?>
							<div class="checkbox-group btn-border col-sm-12<?php if ($view_attributes == "column") { ?> column_filt<?php } ?><?php if ($view_attributes == "content") { ?> content_filt<?php } ?><?php if ($collapse_attributes == '1') { ?> collapse_filter<?php } ?><?php if ($mobile_attributes == 0) { ?> hidden-xs<?php } ?><?php if ($desktop_attributes == 0) { ?> hidden-sm<?php } ?>">
								<div class="row"><h4 class="col-sm-12" onclick="$(this).parent().parent().find('.checkbox-group-overflow').slideToggle(300); $(this).parent().parent().find('.text_more_group').slideToggle(300);"><strong><?php echo $attribute['name']; ?></strong><i class="fa fa-caret-down pull-left"></i></h4></div>
								<div class="checkbox-group-overflow<?php if (!$drop_attributes) { ?> no_drop<?php } ?>">
									<?php $count = 0; ?>
									<?php $coun_end = 0; ?>
									<?php $test_checked = 0; foreach ($attribute['attribute'] as $attribute_text) {if ($attribute_text['attribute_value_required']) {$test_checked = $test_checked + 1;}} ?>
									<?php foreach ($attribute['attribute'] as $attribute_text) { ?>
										<?php $count = $count + 1; ?>
										<div class="checkbox<?php if ($test_checked == 0) {if ($count > $count_show) { ?> none none<?php echo $count_group; ?><?php }} ?>">
											<?php if ($attribute_text['attribute_value_required'] and !$attribute_text['attribute_stock_required']) { ?><input type="checkbox" name="attributes_filter[<?php echo $attribute_text['attribute_id']; ?>][]" value="<?php echo $attribute_text['text']; ?>" checked /><?php } ?>
											<input type="checkbox"<?php if ($attribute_text['attribute_value_required']) { ?> checked<?php } ?> name="attributes_filter[<?php echo $attribute_text['attribute_id']; ?>][]" value="<?php echo $attribute_text['text']; ?>" id="attribute-value-attribute-<?php echo $m; ?><?php echo $attribute['attribute_id']; ?>" data-attribute="<?php echo $attribute['attribute_id']; ?>" <?php if (!$attribute_text['attribute_stock_required']) { ?> disabled<?php } ?> />
											<label for="attribute-value-attribute-<?php echo $m; ?><?php echo $attribute['attribute_id']; ?>"><?php echo $attribute_text['text']; ?>
												<?php if ($attribute_text['attribute_value_required']) { ?>
													<?php if ($attribute_text['attribute_stock_required']) { ?>
														<i class="fa fa-close pull-right" onclick="live_home_clear_attributes_filter('<?php echo $m; ?><?php echo $attribute['attribute_id']; ?>');"></i>
													<?php } else { ?>
														<?php if ($attribute_text['attribute_text_total']) { ?><span class="filter_total filter_gray">0</span><?php } ?>
													<?php } ?>
												<?php } else { ?>
													<?php if ($attribute_text['attribute_text_total']) { ?><span class="filter_total"><?php echo $attribute_text['attribute_text_total']; ?></span><?php } ?>
												<?php } ?>
											</label>
										</div>
										<?php $m = $m + 1; ?>
										<?php $coun_end = $coun_end + 1; ?>
									<?php } ?>
								</div>
								<?php $coun_end = $coun_end - $count_show; ?>
								<?php if ($test_checked == 0) {if ($count > $count_show) { ?><div class="text_more_group"><a id="show_parent<?php echo $count_group; ?>" onclick="show_parent(<?php echo $count_group; ?>)"><strong class="text_more"><?php echo $text_more; ?> (<?php echo $coun_end; ?>)</strong><strong class="text_hide none"><?php echo $text_hide; ?> (<?php echo $coun_end; ?>)</strong></a></div><?php } } ?>
							</div>
							<?php $count_group = $count_group + 1; ?>
						<?php } ?>
					<?php } ?>
				<?php } ?>
			<?php } ?>
		<?php } ?>
	<?php } ?>
	<div class="clearfix"></div>
</div>
</form>
</div>
<div class="clearfix"></div>
</div>
</div>
</div>
<script id="module<?php echo $modul; ?>" type="text/javascript"><!--
$('#content #home_filter .column_filt').remove();
$('#column-left #home_filter .content_filt, #column-right #home_filter .content_filt').remove();
$('.go_filter_mobile_block #home_filter .content_filt, .go_filter_mobile_block #home_filter .content_filt').remove();

var col = $('input[name=\'op\'].filter_op').length;
if (col == 1) {
	$('input[name=\'op\'].filter_op').addClass('filter_op' + col);
} else {
	$('input[name=\'op\'].filter_op').addClass('filter_op' + col);
	$('input[name=\'op\'].filter_op' + parseInt(col - 1)).removeClass('filter_op' + col);
}
<?php if ($count_container) { ?>
	setTimeout(function () {
		live_checkout_product(<?php if (isset($category_id)) {echo $category_id;} ?>);
	}, 500);
	<?php if (isset($count_products)) { ?>
	
	function live_checkout_product(category_id) {
		var html = '';

			html += '<div class="pupop-filter animated bounceInLeft"><?php echo $text_products; ?> <?php echo $count_products; ?> ';
			
			<?php if ($count_products != 0) { ?>

				html += '<a class="btn btn-white btn-header pull-right" onclick="live_home_filter(' + category_id + ');"><?php echo $text_reset; ?></a> <button class="btn btn-primary btn-header pull-right text-uppercase" type="submit"><i class="fa fa-filter"></i> <?php echo $text_show; ?></button>';
				
			<?php } else { ?>
				
				html += '<a class="btn btn-white btn-header pull-right" onclick="live_home_filter(' + category_id + ');"><?php echo $text_reset; ?></a>';
				
			<?php } ?>

			html += '</div>';
		
		$('#<?php echo $count_container; ?>').parent().parent().parent().find('.row').append(html);
	}
	<?php } ?>
<?php } ?>
<?php if (isset($max_price_const) or $old_price) { ?>
slider_generation('<?php if (isset($min_price)) {echo $min_price;} ?>','<?php if (isset($max_price_const)) {if ($get_price_max > $max_price_const) {echo $max_price_const;} else {if (isset($max_price)) {echo $max_price;}} } else {echo $prices_max_value;} ?>','noclear');
function slider_generation(min_value_price, max_value_price, clear) {
	$(".slider").slider({
		min: 0,
		max: <?php if (isset($max_price_const)) {echo $max_price_const;} else {echo $old_price;} ?>,
		range: true,
		step: 1,
		values: [min_value_price, max_value_price],
		slide: function(event, ui){
			$("input#minCost").val($(".slider").slider("values",0));
			$("input#maxCost").val($(".slider").slider("values",1));
		},
		stop: function(event, ui){
			
			$("input#minCost").val($(".slider").slider("values",0));
			$("input#maxCost").val($(".slider").slider("values",1));

			if (clear != 'clear') {live_option_product('no', 'prices', '', 'maxCost');}
			
			var value_min = $(".slider").slider("values",0);
			var value_max = $(".slider").slider("values",1);
			
			<?php foreach ($currencies as $currency) { ?>
				<?php if ($currency['symbol_left'] && $currency['code'] == $code) { ?>
					var value_max_currency = $(".slider").slider("values",1) + '<?php echo $currency['symbol_left']; ?>';
				<?php } elseif ($currency['symbol_right'] && $currency['code'] == $code) { ?>
					var value_max_currency = $(".slider").slider("values",1) + '<?php echo $currency['symbol_right']; ?>';
				<?php } ?>
			<?php } ?>
		}
	});

	if (clear == 'clear') {
		$('.option_cloud_price').remove();
		$("input#minCost").val('0');
		$("input#maxCost").val(max_value_price);
		setTimeout(function() {
			live_option_product('no', 'options', '', 'maxCost');
		},200)
	}
	return clear = 'noclear';
}
<?php } ?>

var test_category = '';
$('select#category-option, #filter_send input[name^=category_id]').on('change', function(){
	if (test_category == '') {
		live_option_product('no', 'options', '', 'popup_categories');
		test_category = '1';
	}
});
var test_keywords = '';
$('input[name^=keywords_filter]').on('change', function(){
	if (test_keywords == '') {
		live_option_product('no', 'options', 'keywords', $(this));
		test_keywords = '1';
	}
});
var test_options = '';
$('input[name^=option_filter\\[]').on('change', function(){
	if (test_options == '') {
		live_option_product('no', 'options', 'options' + $(this).attr('data-options'), $(this));
		test_options = '1';
	}
});
var test_attributes = '';
$('input[name^=attributes_filter\\[]').on('change', function(){
	if (test_attributes == '') {
		live_option_product('no', 'options', 'attributes' + $(this).attr('data-attribute'), $(this));
		test_attributes = '1';
	}
});
var stock_call = '';
$('.checkbox input[name^=stock_status_filter\\[], select#stock_status-option, .radio input[name^=stock_status_filter\\[]').on('change', function(){
	if (stock_call == '') {
		live_option_product('no', 'options', 'stock', $(this));
		stock_call = '1';
	}
});
var manuf_call = '';
$('.checkbox input[name^=manufacturers_filter\\[], select#manufacturers-option, .radio input[name^=manufacturers_filter\\[]').on('change', function(){
	if (manuf_call == '') {
		live_option_product('no', 'options', 'manuf', $(this));
		manuf_call = '1';
	}
});
var rating_call = '';
$('.checkbox input[name^=rating_filter\\[], .radio input[name^=rating_filter\\[]').on('change', function(){
	if (rating_call == '') {
		live_option_product('no', 'options', 'rating', $(this));
		rating_call = '1';
	}
});
function live_option_product(clear_radio, click_options, selection, clac) {
	
	$('#content #home_filter').addClass('content_filter');
	
	var data_clear_radio = '';
	if (clear_radio == 'no') {data_clear_radio = ' #option_filter input[type=\'radio\'], input[name^=option_filter\\[], #filter_send input[name^=category_id], input.categ[name^=category_id],';} 
	
	if (clear_radio == 'stock_status_filter') {
		data_clear_radio = ' input[name^=manufacturers_filter\\[], input[name^=rating_filter\\[], input[name^=option_filter\\[], #filter_send input[name^=category_id], input.categ[name^=category_id],';
	}
	if (clear_radio == 'manufacturers_filter') {
		data_clear_radio = ' input[name^=stock_status_filter\\[], input[name^=rating_filter\\[], input[name^=option_filter\\[], #filter_send input[name^=category_id], input.categ[name^=category_id],';
	}
	
	if (clear_radio == 'rating_filter') {
		data_clear_radio = ' input[name^=stock_status_filter\\[], input[name^=manufacturers_filter\\[], input[name^=option_filter\\[], #filter_send input[name^=category_id], input.categ[name^=category_id],';
	}
	
	if (clear_radio == 'option_filter') {
		data_clear_radio = ' input[name^=stock_status_filter\\[], input[name^=manufacturers_filter\\[], input[name^=rating_filter\\[], #filter_send input[name^=category_id], input.categ[name^=category_id],';
	}
	
	if (clear_radio == 'category_filter') {
		data_clear_radio = ' input[name^=stock_status_filter\\[], input[name^=manufacturers_filter\\[], input[name^=rating_filter\\[], input[name^=option_filter\\[],';
	}

	var data_click = '';
	if (click_options != 'options') {
		data_click += ' .formCost input[type=\'text\'],';
		data_click += ' input[name=\'op\'].filter_op1,';
	}
	
	var sel = '';
	if (selection != '') {
		sel = '&select=' + selection;
		
	}
	
	if ($('#keywords_filter input[type=\'text\']').val() != '') {var keyword = '#keywords_filter input[type=\'text\'],';} else {var keyword = '';}
	data: data = $(data_clear_radio + ' #option_filter input[type=\'checkbox\']:checked, #filter_send input[name^=old_category_id],' + data_click + keyword + ' select#manufacturers-option, select#stock_status-option, select#category-option');
	var products = '';
	var options = data.serialize();
	
	var clas = '';
	var classing = '';
	if ($(clac).attr('id') != null) {
		clas = '&class=' + clac.attr('id');
		classing = clac.attr('id');
	} else {
		clas = '&class=' + clac;
		classing = clac;
	}
	
	$.ajax({
		url: 'index.php?route=extension/module/gofilter/live_option_product',
		type: 'post',
		data: options<?php if ($category_id) { ?> + '&path=<?php echo $category_id; ?>'<?php } ?> + sel <?php if ($route) { ?> + '&route_layout=<?php echo $route; ?>'<?php } ?><?php if (isset($url) && $url !="") { ?> + '<?php echo $url; ?>'<?php } ?> + clas<?php if ($go_mobile) { ?> + '&go_mobile=1'<?php } ?>,
		beforeSend: function() {
				$('#content #home_filter, #column-left #home_filter, #column-right #home_filter, .filter_cloud_mobile #home_filter').addClass('load');
				$('#home_filter').find('.pupop-filter').remove();
			<?php if (!$popup_on) { ?>
				$('#content').addClass('load');
			<?php } ?>
		},
		success: function(msg){
			get_data = this.data;

			setTimeout(function () {
				$('#content #home_filter, #column-left #home_filter, #column-right #home_filter, .filter_cloud_mobile #home_filter').removeClass('load');
				$('#column-left #home_filter, #column-right #home_filter').empty();
				$('#content #home_filter').empty();
				
				if ($('.go_filter_mobile_block').find('.icon_mobile_filter').hasClass('oneclick')) {
					$('.filter_cloud_mobile #home_filter').empty();
					$('.filter_cloud_mobile #home_filter').append(msg);
				} else {
					$('#column-left #home_filter, #column-right #home_filter').append(msg);
				}
				
				$('#content #home_filter').css('opacity','0');
				
				$('#content #home_filter').append(msg);
				
				generetion_content();
				$('#content #home_filter').css('opacity','1');
			}, 0);
			
			setTimeout(function () {
				<?php if (!$popup_on or $go_mobile) { ?>
					ajax_page_category(get_data, 'get');
				<?php } else { ?>
					generation_head_results('reset');
					var test_ajaxing = '';
					if ($('#' + classing).parent().parent().parent().parent().hasClass('content_filt')) {
						test_ajaxing = '1';
					}
					if ($('#' + classing).parent().parent().parent().parent().hasClass('column_mobile')) {
						test_ajaxing = '1';
					}
					if (test_ajaxing == '1') {
						ajax_page_category(get_data, 'get');
					}
				<?php } ?>
					
			}, 0);
			
			$('#content .option_cloud_price').remove();
			$('#content #home_filter.content_filter').show();
			$('#content #home_filter + #home_filter.content_filter').hide();
			$('#content #home_filter.content_filter').empty();
			
		}
	});
}
count_option_product('<?php echo $class; ?>', '<?php if (isset($products)) {echo $products;} ?>');
function count_option_product(clac, products) {
		
		var products_array = '';
		var count = '';
		if (products != "-1") {
			products_array = products.split(',');
			count = products_array.length;
		} else {
			count = 0;
		}
		
		if ($('#keywords_filter input[type=\'text\']').val() != '') {var keyword = '#keywords_filter input[type=\'text\'],';} else {var keyword = '';}
		var data = $(' .formCost input[type=\'text\'], #option_filter input[type=\'radio\'], input[name^=option_filter\\[], input[name^=attributes_filter\\[], #filter_send input[name^=category_id], #option_filter input[type=\'checkbox\']:checked, #filter_send input[name^=old_category_id],' + keyword + ' select#manufacturers-option, select#stock_status-option, select#category-option');
		
		var get_data = data.serialize();
		
		var html = '';

		html += '<div class="pupop-filter animated bounceInLeft hidden-xs"><span class="pull-left"><?php echo $text_products; ?>' + count + '</span>';
		
		if (count != '0') {
			html += '<a class="btn btn-white btn-header pull-right" onclick="reset_filter();"><?php echo $text_reset; ?></a><a class="btn btn-primary btn-header pull-right text-uppercase" onclick="ajax_page_category(\'' + get_data + '\',\'get\');"><i class="fa fa-filter"></i><?php echo $text_show; ?></a>';
		} else {
			html += '<a class="btn btn-white btn-header pull-right" onclick="reset_filter();"><?php echo $text_reset; ?></a>';
		} 

		html += '</div>';

		$('#' + clac).parent().parent().parent().find('.row').append(html);
}
function generation_head_results(reset) {
	
	if ($('#column-left #home_filter, #column-right #home_filter').html() != null) {
		$('#content').removeClass('load');
		
		var home_filter_content = $('#content #home_filter').html();

		var html_cloud = '<div class="options_container_filter">' + $('.options_container_filter').html() + '</div>';

		$('#home_filter .options_container_filter').remove();
		
		$('#content .options_container_filter').remove();

		if (home_filter_content != undefined) {
			$('#content .reset_filter').addClass('none_content_filter');
		}
		
		$('#content .none_content_filter').remove();

		$('#content').prepend(html_cloud);
		
		if ($('#home_filter').hasClass('filter_category_page')) {
			$('.category_filt').remove();
		}

		
	}
		
	show_reset();
}
function ajax_page_category(get_data, types) {
	var typ = '';
	if (types == 'post') {typ = 'post';} else {typ = 'get';}
	$.ajax({
		url: 'index.php?route=product/category&path=&gofilter=1',
		type: typ,
		data: get_data,
		success: function(data){
			
			generation_head_results('no_reset');

			$('#content').children().not('#home_filter').not('.options_container_filter').not('.breadcrumb').not('#home_filter').not('h1').remove();

			var data = $(data);

			$('#content').append(data.find('#content').html());

			$('#content').removeClass('load');
			
			if (localStorage.getItem('display') == 'list') {
				$('#list-view').click();
				$('#list-view').addClass('btn-default');
			} else {
				$('#grid-view').click();
				$('#grid-view').addClass('btn-default');
			}
			<?php if ($seo_on) { ?>
				var item_array = '';
				var browsers = 'gofilter/';
				var get_data_array = get_data.split('&');
				var lastItem = get_data_array[get_data_array.length - 1]
				get_data_array.forEach(function(item, i, get_data_array) {
					if (lastItem == item) {
						var separator = '';
					} else {
						var separator = '-and-';
					}
					var item_array = item.split('=');
					
					item_array.forEach(function(item, i, get_data_array) {
						if (i == 0) {
							browsers += item + '-';
						} else {
							browsers += item + separator;
						}
						
					});
				});
			<?php } else { ?>
				var browsers = 'index.php?route=product/category&path=&' + get_data + '&nofilter=1';
			<?php } ?>
			<?php if ($seo_on) { ?>
				history.pushState({}, '', browsers);
			<?php } ?>
			
			$('#option_filter .pupop-filter').remove();

		}

	});
}
function ajax_page_category_select(href) {
	$.ajax({
		url: href,
		type: 'get',
		success: function(data){
			
			generation_head_results('no_reset');

			$('#content').children().not('#home_filter').not('.options_container_filter').not('.breadcrumb').not('#home_filter').not('h1').remove();

			var data = $(data);

			$('#content').append(data.find('#content').html());

			$('#content').removeClass('load');
			
			if (localStorage.getItem('display') == 'list') {
				$('#list-view').click();
				$('#list-view').addClass('btn-default');
			} else {
				$('#grid-view').click();
				$('#grid-view').addClass('btn-default');
			}
			
			$('#option_filter .pupop-filter').remove();

		}

	});
}
var test_reset ='';
function show_reset() {
	if (test_reset == '') {
		if ($('#content').find('.options_container_filter .filter_container').find('*').length != 0) {
			$('#content .options_container_filter').prepend('<div class="reset_filter"><a onclick="reset_filter();"><i class="fa fa-close"></i>&nbsp;&nbsp;<?php echo $text_reset_all; ?></a></div>');
			if ($('#column-left #home_filter, #column-right #home_filter').html() == null) {
				$('#content .options_container_filter').addClass('row');
			}
		} else {
			$('#content').find('.options_container_filter .filter_container').empty();
		}
		test_reset = '1';
	}
}
function show_parent(count_group) {
	
	$('.none.none' + count_group).slideToggle(300);
	
	if ($('#show_parent' + count_group + ' .text_more').hasClass('none')) {
		$('#show_parent' + count_group + ' .text_more').removeClass("none");
	} else {
		$('#show_parent' + count_group + ' .text_more').addClass("none");
	}
	if ($('#show_parent' + count_group + ' .text_hide').hasClass("none")) {
		$('#show_parent' + count_group + ' .text_hide').removeClass("none");
	} else {
		$('#show_parent' + count_group + ' .text_hide').addClass("none");
	}
}
function clear_popup_filter() {
	$('#home_filter').find('.pupop-filter').remove();
}
function remove_popup() {
	$('#option_filter .pupop-filter').remove();
}
$("#keywords_filter .btn").click(function() {
	if ($('#keywords_filter input[type=\'text\']').val() != '') {
		live_option_product('no', 'options', '', $(this));
	} else {
		$('#keywords_filter input[type=\'text\']').attr('placeholder', '<?php echo $text_keywords_placeholder_empty; ?>');
		$('#keywords_filter input[type=\'text\']').addClass('red_filter');
	}
});
$(document).mouseup(function (e) {
	if ($('#keywords_filter input[type=\'text\']').attr('placeholder') == '<?php echo $text_keywords_placeholder_empty; ?>' && $('#keywords_filter').has(e.target).length === 0) {
		$('#keywords_filter input[type=\'text\']').attr('placeholder', '<?php echo $text_keywords_placeholder; ?>');
		$('#keywords_filter input[type=\'text\']').removeClass('red_filter');
	}
});
function live_home_filter(category_id) {
	if (category_id != null && category_id != 'mobile') {
		$.ajax({
			url: 'index.php?route=extension/module/gofilter/live_home_filter',
			type: 'post',
			data: '&category_id=' + category_id<?php if ($route) { ?> + '&route_layout=<?php echo $route; ?>'<?php } ?>,
			beforeSend: function() {
				$('#content #home_filter, #column-left #home_filter, #column-right #home_filter').addClass('load');
			},
			success: function(msg){
				setTimeout(function () {
					$('#content #home_filter, #column-left #home_filter, #column-right #home_filter').removeClass('load');
					$('#column-left #home_filter, #column-right #home_filter').empty();
					
					$('#column-left #home_filter, #column-right #home_filter').append(msg);
					
					$('#content #home_filter').empty();
					$('#content #home_filter').append(msg);
					generetion_content();
				}, 500);
				
			}
		});
	} else if (category_id != 'mobile') {
		var options = <?php if ($route) { ?>'&route_layout=<?php echo $route; ?>'<?php } else { ?>''<?php } ?>;
		$.ajax({
			url: 'index.php?route=extension/module/gofilter/live_home_filter',
			type: 'post',
			data: options,
			beforeSend: function() {
				$('#content #home_filter, #column-left #home_filter, #column-right #home_filter').addClass('load');
			},
			success: function(msg){
				get_data = this.data;
				setTimeout(function () {
					$('#content #home_filter, #column-left #home_filter, #column-right #home_filter').removeClass('load');
					$('#column-left #home_filter, #column-right #home_filter').empty();
					
					$('#column-left #home_filter, #column-right #home_filter').append(msg);
					
					$('#content #home_filter').empty();
					$('#content #home_filter').append(msg);
					generetion_content();
					
				}, 500);
				setTimeout(function () {
					ajax_page_category(get_data);
				}, 0);
			}
		});
	} else if ($('.go_filter_mobile_block').find('.icon_mobile_filter').hasClass('oneclick')) {
		$('.go_filter_mobile_block').animate({left: "-300px"}, 500);
		$('.icon_mobile_filter').removeClass('oneclick');
		$('.icon_mobile_filter').addClass('returnclick');
	} else if ($('.filter_cloud_mobile').text() == "") {
		generation_ajax('.filter_cloud_mobile');
	} else if ($('.go_filter_mobile_block').find('.icon_mobile_filter').hasClass('returnclick')) {
		$('.go_filter_mobile_block').animate({left: "0px"}, 500);
		$('.icon_mobile_filter').removeClass('returnclick');
	} else {
		$('.go_filter_mobile_block').animate({left: "-300px"}, 500);
		$('.icon_mobile_filter').addClass('returnclick');
	}
}
function generation_ajax(clas) {
	var categ = $('input.categ[name^=category_id]'); categ = categ.serialize();
	if (clas == '.filter_cloud_mobile') {
		$('#column-left #home_filter, #column-left #home_filter').empty();
	} else {
		setTimeout(function () {
			$('.filter_cloud_mobile').empty();
		}, 1000);
	}
	var options = '&go_mobile=1<?php if ($route) { ?>&route_layout=<?php echo $route; ?>'<?php } else { ?>'<?php } ?>;
	$.ajax({
		url: 'index.php?route=extension/module/gofilter/live_home_filter',
		type: 'post',
		data: categ + options,
		beforeSend: function() {
			if (clas == '.filter_cloud_mobile') {
				$('.icon_mobile_filter .fa').removeClass('fa-filter').addClass('fa-spinner').addClass('wheel');
			} else {
				$('.go_filter_mobile_block').animate({left: "-300px"}, 500);
			}
		},
		success: function(msg){
			get_data = this.data;
			setTimeout(function () {
				$(clas).empty();
				$(clas).append(msg);
				if (clas == '.filter_cloud_mobile') {
					$('.icon_mobile_filter .fa').removeClass('fa-spinner').removeClass('wheel').addClass('fa-filter');
					$('.go_filter_mobile_block').animate({left: "0px"}, 500);
					$('.icon_mobile_filter').addClass('oneclick');
				} else {
					setTimeout(function () {
						$('.icon_mobile_filter').removeClass('oneclick');
						$('.icon_mobile_filter').addClass('returnclick');
						$('.filter_cloud_mobile').empty();
					}, 500);
					
				}
				
				
			}, 500);
		}
	});
}

function reset_filter() {
	var category_id = '';
	if ($('#home_filter').hasClass('filter_category_page')) {
		category_id = $('input.categ[name^=category_id]');
		category_id = category_id.serialize();
	}
	$.ajax({
		url: 'index.php?route=extension/module/gofilter/live_home_filter',
		type: 'post',
		data: <?php if ($route) { ?>'&route_layout=<?php echo $route; ?><?php } ?>&' + category_id,
		beforeSend: function() {
			$('#content #home_filter, #column-left #home_filter, #column-right #home_filter').addClass('load');
		},
		success: function(msg){
			$('#content #home_filter').addClass('content_filter');
			setTimeout(function () {
				$('#content #home_filter, #column-left #home_filter, #column-right #home_filter').removeClass('load');
				$('#column-left #home_filter, #column-right #home_filter').empty();
				$('#content #home_filter').empty();
				$('#column-left #home_filter, #column-right #home_filter').append(msg);
				
				$('#content #home_filter').css('opacity','0');
				$('#content #home_filter').append(msg);
				generetion_content();
				$('#content #home_filter').css('opacity','1');
				
				$('#content .reset_filter').remove();
				$('#content .options_container').remove();
			}, 500);
			setTimeout(function () {
				ajax_page_category(category_id, 'get');
			}, 1000);
		}
	});
}
function getting() {
	if ($('#keywords_filter input[type=\'text\']').val() != '') {var keyword = '#keywords_filter input[type=\'text\'],';} else {var keyword = '';}
	var data = $(' .formCost input[type=\'text\'], #option_filter input[type=\'radio\'], input[name^=option_filter\\[], #filter_send input[name^=category_id], #option_filter input[type=\'checkbox\']:checked, #filter_send input[name^=old_category_id],' + keyword + ' select#manufacturers-option, select#stock_status-option, select#category-option');
		
	var get_data = data.serialize();
	return get_data;
}

function live_home_clear_option_filter(option_id) {
	$('#option_filter .checkbox label[for="option-value-' + option_id + '"]').trigger('click');
	ajax_page_category(getting(), 'get');
}
function live_home_clear_attributes_filter(attributes_id) {
	$('#option_filter .checkbox label[for="attribute-value-attribute-' + attributes_id + '"]').trigger('click');
	ajax_page_category(getting(), 'get');
}
function live_home_clear_stock_filter(stock_id) {
	$('#option_filter .checkbox label[for="option-value-stock-' + stock_id + '"]').trigger('click');
	$('select option#common_stock_status:eq(0)').prop('selected', 'selected').trigger('change');
	ajax_page_category(getting(), 'get');
}
function live_home_clear_rating_filter(rating) {
	$('#option_filter .checkbox label[for="option-value-rating-' + rating + '"]').trigger('click');
	ajax_page_category(getting(), 'get');
}
function live_home_clear_manufacturers_filter(manufacturer) {
	$('#option_filter .checkbox label[for="option-value-manufacturers-' + manufacturer + '"]').trigger('click');
	$('select option#common_manufacturers:eq(0)').prop('selected', 'selected').trigger('change');
	ajax_page_category(getting(), 'get');
}
function live_home_clear_category_filter(category) {
	$('#option_filter .checkbox label[for="option-value-category-' + category + '"]').trigger('click');
	$('select option#common_category:eq(0)').prop('selected', 'selected').trigger('change');
	ajax_page_category(getting(), 'get');
}
function live_home_clear_keywords_filter(text, key) {
	var isset_keywords = '';
	$('#keywords_filter input').attr("value", $('#keywords_filter input').attr("value") + '<?php echo $delimitier; ?>');
	$('#keywords_filter input').attr("value", $('#keywords_filter input').attr("value").replace(text + '<?php echo $delimitier; ?>',''));
	<?php if ($delimitier == ",") { ?>$('#keywords_filter input').attr("value", $('#keywords_filter input').attr("value").replace(', ',','));<?php } ?>
	$('#keywords_filter input').attr("value", $('#keywords_filter input').attr("value").replace(<?php if ($delimitier == " ") { ?>/\s+$/<?php } ?><?php if ($delimitier == ",") { ?>','<?php } ?>,''));
	$('.option_cloud_keywords' + key).remove();
	if ($('#keywords_filter input').attr("value") != '') {isset_keywords = 'yes';} else {isset_keywords = 'no';}
	if (isset_keywords == 'yes') {
		setTimeout(function () {
		
			$('#keywords_filter .input-group-btn > .btn').trigger('click');
		}, 500);
	}
}
<?php if ($modul > 0) { ?>
	$('#content .filter #option_filter h3').remove();
<?php } ?>
function clear_all_option_filter() {
	$('#option_filter .checkbox input:checked').trigger('click');
	setTimeout(function () {
		$('.pupop-filter').remove();
	}, 300);
}
function clear_all_option_filter_page_category() {
	$('#option_filter .checkbox input:checked').trigger('click');
	setTimeout(function () {
		$('.pupop-filter').remove();
	}, 300);
}
update_scrollbar();
function update_scrollbar() {
	$(document).ready(function(){
		$('#column-left .checkbox-group-overflow, #column-right .checkbox-group-overflow, .filter_cloud_mobile .checkbox-group-overflow').scrollbar();
	});
}
<?php if (!$go_mobile) { ?>
if ($('#content #home_filter').hasClass('content_filter')) {
	
} else {
	generetion_content();
}
<?php } ?>
function generetion_content() {
	$('#content #option_filter .checkbox-group .row, #content #option_filter .checkbox-group-overflow-price .row').wrap('<div class="input-group-addon"></div>').parent().parent().find('.select-group').addClass('col-xs-12 col-sm-12');
	$('#content #option_filter .checkbox-group .checkbox, #content #option_filter .checkbox-group .radio').removeClass('none');
	$('#content #option_filter .formCost label, #content #option_filter #minCost, #content #option_filter #maxCost').wrapAll('<div class="col-xs-12 col-sm-12 col-md-5"></div>');
	$('#content #option_filter .formCost .clearfix').addClass('visible-xs visible-sm');
	$('#content #option_filter .checkbox-group, #content #option_filter .checkbox-group-overflow-price').wrapInner('<div class="input-group row"></div>').find('.formCost').addClass('col-xs-12 col-sm-12').find('.col-sm-12').removeClass('col-xs-12 col-sm-12').addClass('col-xs-12 col-sm-12 col-md-7');
	$('#content #option_filter .filter_total').prepend('(').append(')');
	$('input[type=\'checkbox\']:checked').parent().addClass('reding');
}
if ($('.filter_cloud_mobile').length == false) {
	$('body').prepend('<div class="go_filter_mobile_block visible-xs"><div class="filter_cloud_mobile"></div><div class="icon_mobile_filter btn btn-primary" onclick="live_home_filter(\'mobile\'); "><i class="fa fa-filter"></i></div>');
}
//--></script>
<style type="text/css">
#option_filter .checkbox-group-overflow {
<?php if (isset($max_height)) { ?>	
    max-height: <?php echo $max_height; ?>px;
<?php } else { ?>
	max-height: 215px;
<?php } ?>	
}
#content #option_filter .checkbox-group-overflow {
	max-height: none;
}
<?php if (isset($color_caption)) { ?>
	#option_filter h3 {
		color: <?php echo $color_caption; ?>;
	}
<?php } ?>
<?php if (isset($color_group)) { ?>
	#column-left #option_filter .checkbox-group h4,
	#column-right #option_filter .checkbox-group h4,
	#column-left #option_filter .checkbox-group-price h4,
	#column-right #option_filter .checkbox-group-price h4	{
		color: <?php echo $color_group; ?>;
	}
<?php } ?>
<?php if (isset($bg_group)) { ?>
	#column-left #option_filter .checkbox-group h4,
	#column-right #option_filter .checkbox-group h4,
	#column-left #option_filter .checkbox-group-price h4,
	#column-right #option_filter .checkbox-group-price h4,
	#content #option_filter .input-group-addon	{
		background: <?php echo $bg_group; ?>;
	}
<?php } ?>
<?php if (isset($color_product)) { ?>
	.filter .filter_total {
		background: <?php echo $color_product; ?>;
	}
	.filter .filter_total::after {
		border-color: transparent <?php echo $color_product; ?> transparent transparent;
	}
<?php } ?>
<?php if (isset($color_product_no)) { ?>
	.filter .filter_total.gray {
		background: <?php echo $color_product_no; ?>;
	}
	.filter .filter_total.gray::after {
		border-color: transparent <?php echo $color_product_no; ?> transparent transparent;
	}
<?php } ?>
<?php if (isset($bg_price)) { ?>
	.filter .ui-widget-header {
		background: <?php echo $bg_price; ?>;
	}
<?php } ?>
</style>
<?php echo $gofilter_cloud; ?>
<?php } ?>