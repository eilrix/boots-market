<div class="sc-jetcache-bottom-heading">


<div class="sc-flex-container">
  <div class="sc-flex-block sc-jetcache-heading">
  	<a href="<?php echo $language->get('url_jetcache_buy'); ?>" target="_blank"><img src="<?php echo $icon; ?>">&nbsp;&nbsp;<?php echo $language->get('entry_jetcache'); ?></a>
	&nbsp;&nbsp;&nbsp;
	<a href="<?php echo $language->get('url_jetcache_buy'); ?>" target="_blank" class="jetcache-button-buy"><?php echo $language->get('entry_jetcache_buy'); ?></a>

  </div>



<div class="sc-flex-block">

    <a href="#" id="httpsfix_cache_remove" onclick="
		$.ajax({
			url: '<?php echo $jetcache_url_cache_remove; ?>',
			dataType: 'html',
			beforeSend: function() {
               $('.div_cache_remove').show().html('<?php echo $language->get('text_jetcache_loading'); ?>');
			},
			success: function(content) {
				if (content) {
					$('.div_cache_remove').show().html('<span style=\'color:#fff\'>'+content+'<\/span>');
					setTimeout('jetcache_div_hide()', 2000);
				}
			},
			error: function(content) {
				$('.div_cache_remove').show().html('<span style=\'color:red\'><?php echo $language->get('text_jetcache_cache_remove_fail'); ?><\/span>');
			}
		}); return false;" class="jetcache-button-buy" style=""><?php echo $language->get('text_jetcache_url_cache_remove'); ?></a>
		<div class="div_cache_remove"></div>
</div>






<div class="sc-flex-block">
<?php if ($queries != $queries_cache) { ?>
	<?php echo $language->get('entry_jetcache_db').' ('.$language->get('text_jetcache_queries').') <br>Jet:&nbsp;&nbsp;x'.  round($queries / $queries_cache, 0); ?>
	<?php } else { ?>
	 &nbsp;<br>&nbsp;
	<?php } ?>
</div>


  <div class="sc-flex-block">

		<div class="sc-flex-container">

			<div class="sc-flex-container-left">
				<div>
				 <?php echo $language->get('entry_jetcache_queries'); ?>&nbsp;
				</div>

				<?php if ($queries != $queries_cache) { ?>
				<div>
				   <?php echo $language->get('entry_jetcache_queries_cache'); ?>&nbsp;
				</div>
				<?php } ?>

		    </div>


			<div>
				<div>
				  <?php echo round($queries,3); ?>
				</div>
				<?php if ($queries != $queries_cache) { ?>
				<div>
				  <?php echo round($queries_cache,3); ?>
				</div>
				<?php } ?>
		    </div>

		</div>
   </div>


  <div class="sc-flex-block">
	<?php if ($load != $cache) { ?>
		<?php echo $language->get('entry_jetcache_pages').'<br>Jet:&nbsp;&nbsp;x'. $rate;  ?>
	<?php } else { ?>
	 &nbsp;<br>&nbsp;
	<?php } ?>
  </div>


	<div class="sc-flex-block">

		<div class="sc-flex-container">

			<div class="sc-flex-container-left">
				<div>
				 <?php echo $language->get('entry_jetcache_withoutcache'); ?>&nbsp;
				</div>
				<?php if ($load != $cache) { ?>
				<div>
				   <?php echo $language->get('entry_jetcache_cache'); ?>&nbsp;
				</div>
				<?php } ?>
		    </div>


			<div>
				<div>
				  <?php echo round($load,3); ?> <?php echo $language->get('entry_jetcache_sec'); ?>
				</div>
				<?php if ($load != $cache) { ?>
				<div>
				  <?php echo round($cache,3); ?> <?php echo $language->get('entry_jetcache_sec'); ?>
				</div>
				<?php } ?>
		    </div>

		</div>

  </div>
</div>


</div>
<script>
function jetcache_div_hide() {
	$('.div_cache_remove').hide();
}
</script>
<style>
.sc-flex-container {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
}

.sc-flex-container-left {
  justify-content: flex-start;
  align-items: flex-start;
  text-align: left;
}


.sc-jetcache-heading a {
	font-size: 1.2em;
	font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
	color: #fff;
	text-decoration: none;

}
.sc-jetcache-bottom-heading {
    background-color: #16a9de;
    color: #fff;
   /* height: 44px; */
    overflow: hidden;
    z-index: 10000;
    bottom: 0;
    width: 100%;
    position: fixed;
    text-align: center;
    padding-left: 20px;
    padding-right: 20px;
}

a.jetcache-button-buy, a.jetcache-button-buy:visited, a.jetcache-button-buy:focus {
	font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
    background-color: #21bef2;
    color: #fff;
    padding: 2px 8px;
    border: 1px solid #fff;
    text-decoration: none;
    font-size: 1em;
}

a.jetcache-button-buy:hover {
    color: #21bef2;
    background-color: #fff;
}

</style>

