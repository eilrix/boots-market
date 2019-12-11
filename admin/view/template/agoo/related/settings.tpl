 <table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">
	<tr>
	  <td><?php echo $language->get('entry_widget_status'); ?></td>
	  <td>
		  <div class="input-group">
			  <select class="form-control" name="ascp_settings[related_widget_status]">
			      <?php if (isset($ascp_settings['related_widget_status']) && $ascp_settings['related_widget_status']) { ?>
			      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
			      <option value="0"><?php echo $text_disabled; ?></option>
			      <?php } else { ?>
			      <option value="1"><?php echo $text_enabled; ?></option>
			      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
			      <?php } ?>
			    </select>
		    </div>
	    </td>
	</tr>
	<?php if (SC_VERSION > 15) { ?>
	<tr>
	  <td><?php echo $language->get('entry_related_theme'); ?></td>
	  <td>
		  <div class="input-group">
			  <select class="form-control" id="ascp_settings_related_theme" name="ascp_settings[related_theme]">
			      <?php if (isset($ascp_settings['related_theme']) && $ascp_settings['related_theme']) { ?>
			      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
			      <option value="0"><?php echo $text_disabled; ?></option>
			      <?php } else { ?>
			      <option value="1"><?php echo $text_enabled; ?></option>
			      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
			      <?php } ?>
			    </select>
		    </div>
	    </td>
	</tr>
	<tr id="sc_related_theme_title">
		<td class="left">
			<?php echo $language->get('entry_related_theme_title'); ?>
			<script>
			$( '#ascp_settings_related_theme')
			.change(function () {
				var str = '';
				$( '#ascp_settings_related_theme option:selected').each(function() {
				str = $(this).val();
				});
				if (str == 1) {
	              $('#sc_related_theme_title').show('slow');
				} else {
	              $('#sc_related_theme_title').hide('slow');
				}
			}).change();
			</script>
		</td>
		<td>
        <?php foreach ($languages as $lang) { ?>
			<div class="input-group marginbottom5px"><span class="input-group-addon"><?php echo strtoupper($lang['code']); ?><br><img src="<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" ></span>
				<textarea class="form-control" name="ascp_settings[related_theme_title][<?php echo $lang['language_id']; ?>]" rows="3" cols="50" ><?php if (isset($ascp_settings['related_theme_title'][$lang['language_id']])) { echo $ascp_settings['related_theme_title'][$lang['language_id']]; } else { echo ''; } ?></textarea>
			</div>
		<?php } ?>
		</td>
	</tr>



	<?php } ?>
 </table>
