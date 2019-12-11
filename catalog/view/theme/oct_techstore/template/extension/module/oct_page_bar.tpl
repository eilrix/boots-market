<div id="oct-slide-panel">
	<div class="oct-slide-panel-heading">
		<div id="hide-slide-panel"><!--<i class="fa fa-times" aria-hidden="true"></i>-->×</div>
		<div class="container">
			<?php if ($oct_page_bar_data['show_viewed_bar']) { ?>
			<div id="oct-last-seen-link" class="col-sm-3 col-xs-3">
				<a href="javascript:void(0);" class="oct-panel-link">
					<i class="fa fa-eye" aria-hidden="true"></i>
                    <!--<span class="hidden-xs hidden-sm"><?php echo $text_viewed; ?></span>-->
                    <span id="oct-last-seen-quantity" class="oct-slide-panel-quantity"><?php echo $total_viewed; ?></span>
                </a>
            </div>
            <?php } ?>
            <?php if ($oct_page_bar_data['show_wishlist_bar']) { ?>
            <div id="oct-favorite-link" class="col-sm-3 col-xs-3">
                <a href="javascript:void(0);" class="oct-panel-link">
                    <i class="fa fa-heart-o" aria-hidden="true"></i>
                    <!--<span class="hidden-xs hidden-sm"><?php echo $text_wishlist; ?></span>-->
                    <span id="oct-favorite-quantity" class="oct-slide-panel-quantity"><?php echo $total_wishlist; ?></span>
                </a>
            </div>
            <?php } ?>


		</div>	
	</div>
	<div class="oct-slide-panel-content">
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<?php if ($oct_page_bar_data['show_viewed_bar']) { ?>
					<div id="oct-last-seen-content" class="oct-slide-panel-item-content"></div>
					<?php } ?>
					<?php if ($oct_page_bar_data['show_wishlist_bar']) { ?>
					<div id="oct-favorite-content" class="oct-slide-panel-item-content"></div>
					<?php } ?>


				</div>
			</div>
		</div>			
	</div>

	<script type="text/javascript">
/*
        $('.oct-panel-link').on('click', function () {
            if ($(this).parent().hasClass('oct-panel-link-active')) {
                $(this).parent().removeClass('oct-panel-link-active');
                hidePanel();
            } else {
                $('#hide-slide-panel').fadeIn();
                $("#oct-bluring-box").addClass('oct-bluring');
                $("#oct-slide-panel .oct-slide-panel-content").addClass('oct-slide-panel-content-opened');
                $('.oct-slide-panel-heading > .container > div').removeClass('oct-panel-link-active');
                $(this).parent().addClass('oct-panel-link-active');
                $('.oct-slide-panel-item-content').removeClass('oct-panel-active');
                var linkId = $(this).parent()[0].id;
                if (linkId === 'oct-last-seen-link') {
                    $('#oct-last-seen-content').toggleClass('oct-panel-active').load('index.php?route=extension/module/oct_page_bar/block_viewed');
                } else if (linkId === 'oct-favorite-link' || linkId === 'oct-favorite-link-top') {
                    $('#oct-favorite-content').toggleClass("oct-panel-active").load('index.php?route=extension/module/oct_page_bar/block_wishlist');
                } else if (linkId === 'oct-compare-link') {
                    $('#oct-compare-content').toggleClass("oct-panel-active").load('index.php?route=extension/module/oct_page_bar/block_compare');
                } else if (linkId === 'oct-bottom-cart-link') {
                    $('#oct-bottom-cart-content').toggleClass("oct-panel-active").load('index.php?route=extension/module/oct_page_bar/block_cart');
                }
            }
        });
        $('#oct-bluring-box, #hide-slide-panel').click(function () {
            hidePanel();
        });*/
	</script>
</div>