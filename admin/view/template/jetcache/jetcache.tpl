<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  	<div class="jetcache-top-heading">
	    <div style="float:left; margin-top: 10px;" >
	    	<img src="<?php echo $icon; ?>" style="height: 24px; margin-left: 10px; " >
	    </div>

		<div style="margin-left: 5px; float:left; margin-top: 12px;">
		<ins style="color: #fff;  font-weight: normal;  text-decoration: none; ">
		<?php echo strip_tags($heading_title); ?>
		</ins>
		</div>

	    <div class="jetcache-top-copyright">
	      <div style="color: #fff; font-size: 12px; margin-top: 2px; line-height: 18px; margin-left: 9px; margin-right: 9px; overflow: hidden;"><?php echo $language->get('heading_dev'); ?></div>
	    </div>

	</div>

<script type="text/javascript">
function delayer(){
    window.location = 'index.php?route=jetcache/jetcache&token=<?php echo $token; ?>';
}


$('.jetcache-top-heading').on('click', function() {	 //window.location = 'https://opencartadmin.com';
});

</script>

  <div class="page-header">
    <div class="container-fluid">

<div id="content1" style="border: none;">

<div style="clear: both; line-height: 1px; font-size: 1px;"></div>


<?php if ($error_warning) { ?>
    <div class="alert alert-danger warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
<?php } ?>

<?php if ($success) { ?>
    <div class="alert alert-success success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
<?php } ?>


<div id="content" style="border: none;">

<div style="clear: both; line-height: 1px; font-size: 1px;"></div>


<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>

<?php if (isset($session->data['success'])) {unset($session->data['success']);
?>
<div class="success"><?php echo $language->get('text_success'); ?></div>
<?php } ?>


<div class="box1">

<div class="content">

<?php
// echo $agoo_menu;
?>


<div style="margin:5px; float:right;">
   <a href="#" class="mbutton jetcache_save"><?php echo $button_save; ?></a>
   <a onclick="location = '<?php echo $cancel; ?>';" class="mbutton"><?php echo $button_cancel; ?></a>
</div>

<div style="clear: both; line-height: 1px; font-size: 1px;"></div>

<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">


 <div id="tabs" class="htabs">
 	<a href="#tab-options"><?php echo $language->get('tab_options'); ?></a>
	<a href="#tab-pages"><?php echo $language->get('tab_pages'); ?></a>
	<a href="#tab-cont"><?php echo $language->get('tab_cont'); ?></a>
	<a href="#tab-model"><?php echo $language->get('tab_model'); ?></a>
	<a href="#tab-exceptions"><?php echo $language->get('tab_exceptions'); ?></a>
	<a href="#tab-access"><?php echo $language->get('tab_access'); ?></a>
 </div>


  <div id="tab-options">
			<div id="mytabs_cache">
				<div class="tabcontent" id="list_default">

					<table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">

					<tr>
					  <td><?php echo $language->get('entry_widget_status'); ?> <?php if (SC_VERSION > 15) { ?><i class="fa fa-bullseye" aria-hidden="true"></i> <?php echo strip_tags($heading_title); ?><?php } ?></td>
					  <td>
						  <div class="input-group">
							  <select class="form-control" name="ascp_settings[jetcache_widget_status]">
							      <?php if (isset($ascp_settings['jetcache_widget_status']) && $ascp_settings['jetcache_widget_status']) { ?>
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

					<tr>
					  <td><?php echo $language->get('entry_cache_mobile_detect'); ?></td>
					  <td>
						  <div class="input-group">
							  <select class="form-control" name="ascp_settings[cache_mobile_detect]">
							      <?php if (isset($ascp_settings['cache_mobile_detect']) && $ascp_settings['cache_mobile_detect']) { ?>
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


					<!--
					<tr>
					  <td><?php echo $language->get('entry_seocms_jetcache_alter'); ?></td>
					  <td>
						  <div class="input-group">
							  <select class="form-control" name="ascp_settings[seocms_jetcache_alter]">
							      <?php if (isset($ascp_settings['seocms_jetcache_alter']) && $ascp_settings['seocms_jetcache_alter']) { ?>
							      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							      <option value="0"><?php echo $text_disabled; ?></option>
							      <?php } else { ?>
							      <option value="1" <?php if (!isset($ascp_settings['seocms_jetcache_alter'])) { ?>selected="selected"<?php } ?>><?php echo $text_enabled; ?></option>
							      <option value="0" <?php if (isset($ascp_settings['seocms_jetcache_alter'])) { ?>selected="selected"<?php } ?>><?php echo $text_disabled; ?></option>
							      <?php } ?>
							    </select>
						    </div>
					    </td>
					</tr>
                    -->



					<tr>
					  <td><?php echo $language->get('entry_seocms_jetcache_gzip_level'); ?></td>
					  <td>
						  <div class="input-group">
							  <select class="form-control" name="asc_jetcache_settings[seocms_jetcache_gzip_level]">

									<?php foreach ($gzip_level as $value => $name) { ?>
									  	<option value="<?php echo $value; ?>" <?php if (isset($asc_jetcache_settings['seocms_jetcache_gzip_level']) && $asc_jetcache_settings['seocms_jetcache_gzip_level'] == $value) { ?> selected="selected" <?php } ?>><?php echo $name; ?></option>
									<?php } ?>


							    </select>
						    </div>
					    </td>
					</tr>



					<tr>
					  <td><?php echo $language->get('entry_jetcache_info_status'); ?>
					  <div class="jetcache-table-help">
					  <?php echo $language->get('entry_jetcache_info_demo_status'); ?>
							  <select class="form-control" name="asc_jetcache_settings[jetcache_info_demo_status]">
							      <?php if (isset($asc_jetcache_settings['jetcache_info_demo_status']) && $asc_jetcache_settings['jetcache_info_demo_status']) { ?>
							      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							      <option value="0"><?php echo $text_disabled; ?></option>
							      <?php } else { ?>
							      <option value="1"><?php echo $text_enabled; ?></option>
							      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							      <?php } ?>
							    </select>
					  </div>
					  </td>
					  <td>
						  <div class="input-group">
							  <select class="form-control" name="asc_jetcache_settings[jetcache_info_status]">
							      <?php if (isset($asc_jetcache_settings['jetcache_info_status']) && $asc_jetcache_settings['jetcache_info_status']) { ?>
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

					<tr>
					  <td><?php echo $language->get('entry_session_log'); ?></td>
					  <td>
						  <div class="input-group">
							  <select class="form-control" name="asc_jetcache_settings[session_log]">
							      <?php if (isset($asc_jetcache_settings['session_log']) && $asc_jetcache_settings['session_log']) { ?>
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

				    <tr>
				     <td class="left"><?php echo $language->get('entry_cache_expire');  ?></td>
				     <td class="left">
				      <div class="input-group">
				      <input class="form-control template" size="11" type="text" name="ascp_settings[cache_expire]" value="<?php  if (isset($ascp_settings['cache_expire'])) echo $ascp_settings['cache_expire']; ?>" size="20" />
				      </div>
				     </td>
				    </tr>

				    <tr>
				     <td class="left"><?php echo $language->get('entry_cache_max_files');  ?></td>
				     <td class="left">
				      <div class="input-group">
				      <input class="form-control template" size="11" type="text" name="ascp_settings[cache_max_files]" value="<?php  if (isset($ascp_settings['cache_max_files'])) echo $ascp_settings['cache_max_files']; ?>" size="20" />
				      </div>
				     </td>
				    </tr>

				    <tr>
				     <td class="left"><?php echo $language->get('entry_cache_maxfile_length');  ?></td>
				     <td class="left">
				      <div class="input-group">
				      <input class="form-control template" size="11" type="text" name="ascp_settings[cache_maxfile_length]" value="<?php  if (isset($ascp_settings['cache_maxfile_length'])) echo $ascp_settings['cache_maxfile_length']; ?>" size="20" />
				      </div>
				     </td>
				    </tr>


				    <tr>
				     <td class="left"><?php echo $language->get('entry_cache_max_hache_folders_level');  ?></td>
				     <td class="left">
				      <div class="input-group">
				      <input class="form-control template" size="11" type="text" name="ascp_settings[cache_max_hache_folders_level]" value="<?php  if (isset($ascp_settings['cache_max_hache_folders_level'])) echo $ascp_settings['cache_max_hache_folders_level']; ?>" size="4" />
				      </div>
				     </td>
				    </tr>


				    <tr>
				     <td class="left"><?php echo $language->get('entry_cache_auto_clear');  ?></td>
				     <td class="left">
				      <div class="input-group">
				      <input class="form-control" size="11" type="text" name="ascp_settings[cache_auto_clear]" value="<?php  if (isset($ascp_settings['cache_auto_clear'])) echo $ascp_settings['cache_auto_clear']; ?>" size="20" />
				      </div>
				     </td>
				    </tr>


					  					          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_httpsfix_ocmod_refresh'); ?></td>
										              <td>
															<div style="margin-bottom: 5px;">
															    <a href="#" id="httpsfix_ocmod_refresh" onclick="
																	$.ajax({
																		url: '<?php echo $url_ocmod_refresh; ?>',
																		dataType: 'html',
																		beforeSend: function()
																		{
															               $('#div_ocmod_refresh').html('<?php echo $language->get('text_loading_main'); ?>');
																		},
																		success: function(content) {
																			if (content) {
																				$('#div_ocmod_refresh').html('<span style=\'color:green\'><?php echo $language->get('text_ocmod_refresh_success'); ?><\/span>');
																				//setTimeout('delayer()', 2000);
																			}
																		},
																		error: function(content) {
																			$('#div_ocmod_refresh').html('<span style=\'color:red\'><?php echo $language->get('text_ocmod_refresh_fail'); ?><\/span>');
																		}
																	}); return false;" class="markbuttono sc_button" style=""><?php echo $language->get('text_url_ocmod_refresh'); ?></a>
															<div id="div_ocmod_refresh"></div>
															</div>
										                </td>
										            </tr>

					  					          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_httpsfix_cache_remove'); ?></td>
										              <td>
															<div style="margin-bottom: 5px;">
															    <a href="#" id="httpsfix_cache_remove" onclick="
																	$.ajax({
																		url: '<?php echo $url_cache_remove; ?>',
																		dataType: 'html',
																		beforeSend: function()
																		{
															               $('#div_cache_remove').html('<?php echo $language->get('text_loading_main'); ?>');
																		},
																		success: function(content) {
																			if (content) {
																				$('#div_cache_remove').html('<span style=\'color:green\'>'+content+'<\/span>');
																				//setTimeout('delayer()', 2000);
																			}
																		},
																		error: function(content) {
																			$('#div_cache_remove').html('<span style=\'color:red\'><?php echo $language->get('text_cache_remove_fail'); ?><\/span>');
																		}
																	}); return false;" class="markbuttono sc_button" style=""><?php echo $language->get('text_url_cache_remove'); ?></a>
															<div id="div_cache_remove"></div>
															</div>
										                </td>
										            </tr>

					  					          <tr>
										              <td style="width: 220px;"><?php echo $language->get('entry_httpsfix_cache_image_remove'); ?></td>
										              <td>
															<div style="margin-bottom: 5px;">
															    <a href="#" id="httpsfix_cache_image_remove" onclick="
																	$.ajax({
																		url: '<?php echo $url_cache_image_remove; ?>',
																		dataType: 'html',
																		beforeSend: function()
																		{
															               $('#div_cache_image_remove').html('<?php echo $language->get('text_loading_main'); ?>');
																		},
																		success: function(content) {
																			if (content) {
																				$('#div_cache_image_remove').html('<span style=\'color:green\'>'+content+'<\/span>');
																				//setTimeout('delayer()', 2000);
																			}
																		},
																		error: function(content) {
																			$('#div_cache_image_remove').html('<span style=\'color:red\'><?php echo $language->get('text_cache_remove_fail'); ?><\/span>');
																		}
																	}); return false;" class="markbuttono sc_button" style=""><?php echo $language->get('text_url_cache_image_remove'); ?></a>
															<div id="div_cache_image_remove"></div>
															</div>
										                </td>
										            </tr>

										   </table>

									</div>
									</div>


  </div>

<div id="tab-exceptions">

   <table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">
	  <tr class="jetcache-back">
	 	<td colspan="2" class="jetcache-back jetcache-text-center">
         <?php echo $language->get('entry_ex_routes'); ?> <span class="jetcache-table-help-href">?</span>
		</td>
	  </tr>


<tr>
	<td class="jetcache-table-help left">
		<?php echo $language->get('entry_ex_routes_help'); ?>
	</td>
	<td>
		<div style="float: left;">
				   <table id="ex_routes" class="list jetcache-table-add">
					   <thead>
				             <tr>
				                <td class="left"><?php echo $language->get('entry_id'); ?></td>
				                <td><?php echo $language->get('entry_ex_route'); ?></td>
				                <td><?php echo $language->get('entry_status'); ?></td>
				                <td></td>
				             </tr>

				      </thead>

				      <?php if (isset($asc_jetcache_settings['ex_route']) && !empty($asc_jetcache_settings['ex_route'])) { ?>
				      <?php foreach ($asc_jetcache_settings['ex_route'] as $ex_route_id => $ex_route) { ?>
				      <?php $ex_route_row = $ex_route_id; ?>
				      <tbody id="ex_route_row<?php echo $ex_route_row; ?>">
				          <tr>
				               <td class="left">
								<input type="text" name="asc_jetcache_settings[ex_route][<?php echo $ex_route_id; ?>][type_id]" value="<?php if (isset($ex_route['type_id'])) echo $ex_route['type_id']; ?>" size="3">
				               </td>

								<td class="right">

									<div style="margin-bottom: 3px;">
									<input type="text" name="asc_jetcache_settings[ex_route][<?php echo $ex_route_id; ?>][route]" value="<?php if (isset($ex_route['route'])) echo $ex_route['route']; ?>" style="width: 300px;">
									</div>

								</td>


								<td class="right">
					              <div class="input-group jetcache-text-center">
					              <select class="form-control" name="asc_jetcache_settings[ex_route][<?php echo $ex_route_id; ?>][status]">
					                  <?php if (isset($ex_route['status']) && $ex_route['status']) { ?>
					                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					                  <option value="0"><?php echo $text_disabled; ?></option>
					                  <?php } else { ?>
					                  <option value="1"><?php echo $text_enabled; ?></option>
					                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					                  <?php } ?>
					                </select>
					                </div>
								</td>



				                <td class="left"><a onclick="$('#ex_route_row<?php echo $ex_route_row; ?>').remove();" class="markbutton button_purple nohref"><?php echo $button_remove; ?></a></td>
				              </tr>
				            </tbody>

				      <?php } ?>
				      <?php } ?>
				    <tfoot>
				              <tr>
				                <td colspan="3"></td>
				                <td class="left"><a onclick="addExRoute();" class="markbutton nohref"><?php echo $language->get('entry_add_rule'); ?></a></td>
				    	</tr>
				 	</tfoot>
				 </table>
			</div>
		</td>
	</tr>



	  <tr class="jetcache-back">
	 	<td colspan="2" class="jetcache-back jetcache-text-center">
         <?php echo $language->get('entry_ex_pages'); ?> <span class="jetcache-table-help-href">?</span>
		</td>
	  </tr>


<tr>
	<td class="jetcache-table-help left">
		<?php echo $language->get('entry_ex_pages_help'); ?>
	</td>
	<td>
		<div style="float: left;">

				   <table id="ex_pages" class="list jetcache-table-add">

					   <thead>
				             <tr>
				                <td class="left"><?php echo $language->get('entry_id'); ?></td>
				                <td><?php echo $language->get('entry_ex_page'); ?></td>
				                <td><?php echo $language->get('entry_ex_page_accord'); ?></td>
				                <td><?php echo $language->get('entry_status'); ?></td>
				                <td></td>
				             </tr>
				      </thead>

				      <?php if (isset($asc_jetcache_settings['ex_page']) && !empty($asc_jetcache_settings['ex_page'])) { ?>
				      <?php foreach ($asc_jetcache_settings['ex_page'] as $ex_page_id => $ex_page) { ?>
				      <?php $ex_page_row = $ex_page_id; ?>
				      <tbody id="ex_page_row<?php echo $ex_page_row; ?>">
				          <tr>
				               <td class="left">
								<input type="text" name="asc_jetcache_settings[ex_page][<?php echo $ex_page_id; ?>][type_id]" value="<?php if (isset($ex_page['type_id'])) echo $ex_page['type_id']; ?>" size="3">
				               </td>

								<td class="right">
									<div style="margin-bottom: 3px;">
										<input type="text" name="asc_jetcache_settings[ex_page][<?php echo $ex_page_id; ?>][url]" value="<?php if (isset($ex_page['url'])) echo $ex_page['url']; ?>" style="width: 300px;">
									</div>
								</td>

								<td class="right">
					              <div class="input-group jetcache-text-center">
					              <select class="form-control" name="asc_jetcache_settings[ex_page][<?php echo $ex_page_id; ?>][accord]">
					                  <?php if (isset($ex_page['accord']) && $ex_page['accord']) { ?>
					                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					                  <option value="0"><?php echo $text_disabled; ?></option>
					                  <?php } else { ?>
					                  <option value="1"><?php echo $text_enabled; ?></option>
					                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					                  <?php } ?>
					                </select>
					                </div>
								</td>


								<td class="right">
					              <div class="input-group jetcache-text-center">
					              <select class="form-control" name="asc_jetcache_settings[ex_page][<?php echo $ex_page_id; ?>][status]">
					                  <?php if (isset($ex_page['status']) && $ex_page['status']) { ?>
					                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					                  <option value="0"><?php echo $text_disabled; ?></option>
					                  <?php } else { ?>
					                  <option value="1"><?php echo $text_enabled; ?></option>
					                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					                  <?php } ?>
					                </select>
					                </div>
								</td>



				                <td class="left"><a onclick="$('#ex_page_row<?php echo $ex_page_row; ?>').remove();" class="markbutton button_purple nohref"><?php echo $button_remove; ?></a></td>
				              </tr>
				            </tbody>

				      <?php } ?>
				      <?php } ?>
				    <tfoot>
				              <tr>
				                <td colspan="4"></td>
				                <td class="left"><a onclick="addExPage();" class="markbutton nohref"><?php echo $language->get('entry_add_rule'); ?></a></td>
				    	</tr>
				 	</tfoot>
				 </table>
			</div>
		</td>
	</tr>





	 <tr class="jetcache-back">
	 	<td colspan="2" class="jetcache-back jetcache-text-center">
         <?php echo $language->get('entry_ex_session'); ?> <span class="jetcache-table-help-href">?</span>
		</td>
	  </tr>


	<tr class="odd">
		<td class="jetcache-table-help left">
			<?php echo $language->get('entry_ex_session_help'); ?>
		</td>

		<td>
			<div class="input-group"><span class="input-group-addon"></span>
			<textarea class="form-control" name="asc_jetcache_settings[ex_session]" rows="5" cols="50"><?php if (isset($asc_jetcache_settings['ex_session'])) { echo $asc_jetcache_settings['ex_session']; } else { echo ''; } ?></textarea>
			</div>
		</td>
	</tr>




	</table>

</div>


  <div id="tab-pages">

   <table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">

	  <tr class="jetcache-back">
	 	<td colspan="2" class="jetcache-back jetcache-text-center">
         <?php echo $language->get('entry_status'); ?> <span class="jetcache-table-help-href">?</span>
		</td>
	  </tr>



          <tr>
              <td class="jetcache-table-help"><?php echo $language->get('entry_pages_status_help'); ?></td>
              <td class="jetcache-text-center">
              <div class="input-group jetcache-text-center">
              <select class="form-control" name="asc_jetcache_settings[pages_status]">
                  <?php if (isset($asc_jetcache_settings['pages_status']) && $asc_jetcache_settings['pages_status']) { ?>
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



	  <tr class="jetcache-back">
	 	<td colspan="2" class="jetcache-back jetcache-text-center">
         <?php echo $language->get('entry_db_status'); ?> <span class="jetcache-table-help-href">?</span>
		</td>
	  </tr>



          <tr>
              <td class="jetcache-table-help"><?php echo $language->get('entry_pages_db_status_help'); ?></td>
              <td class="jetcache-text-center">
              <div class="input-group jetcache-text-center">
              <select class="form-control" name="asc_jetcache_settings[pages_db_status]">
                  <?php if (isset($asc_jetcache_settings['pages_db_status']) && $asc_jetcache_settings['pages_db_status']) { ?>
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




    <tr>
     <td class="jetcache-table-help left"></td>
     <td></td>
    </tr>
   </table>
  </div>



<div id="tab-access">
	<table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">

            <tr>
              <td><?php
              echo $language->get('entry_store');
              ?></td>
              <td><div class="scrollbox">
                  <?php $class = 'even'; ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (!isset($asc_jetcache_settings['store']) || in_array(0, $asc_jetcache_settings['store'])) { ?>
                    <input type="checkbox" name="asc_jetcache_settings[store][]" value="0" checked="checked" />
                    <?php echo $language->get('text_default_store'); ?>
                    <?php } else { ?>
                    <input type="checkbox" name="asc_jetcache_settings[store][]" value="0" />
                    <?php echo $language->get('text_default_store'); ?>
                    <?php } ?>
                  </div>
                  <?php foreach ($stores as $store) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (isset($asc_jetcache_settings['store']) && in_array($store['store_id'], $asc_jetcache_settings['store'])) { ?>
                    <input type="checkbox" name="asc_jetcache_settings[store][]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                    <?php echo $store['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="asc_jetcache_settings[store][]" value="<?php echo $store['store_id']; ?>" <?php if (!isset($asc_jetcache_settings['store'])) { ?> checked="checked" <?php } ?>/>
                    <?php echo $store['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div>
                <a onclick="$(this).parent().find(':checkbox').prop('checked', true);" class="nohref"><?php echo $language->get('text_select_all'); ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);" class="nohref"><?php echo $language->get('text_unselect_all'); ?></a></td>
                </td>
            </tr>


	</table>
</div>

<div id="tab-cont">

	<table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">

	  <tr class="jetcache-back">
	 	<td colspan="2" class="jetcache-back jetcache-text-center">
         <?php echo $language->get('entry_status'); ?> <span class="jetcache-table-help-href">?</span>
		</td>
	  </tr>



          <tr>
              <td class="jetcache-table-help"><?php echo $language->get('entry_cont_status_help'); ?></td>
              <td class="jetcache-text-center">
	              <div class="input-group jetcache-text-center">
	              <select class="form-control" name="asc_jetcache_settings[cont_status]">
	                  <?php if (isset($asc_jetcache_settings['cont_status']) && $asc_jetcache_settings['cont_status']) { ?>
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

	  <tr class="jetcache-back">
	 	<td colspan="2" class="jetcache-back jetcache-text-center">
         <?php echo $language->get('entry_db_status'); ?> <span class="jetcache-table-help-href">?</span>
		</td>
	  </tr>



          <tr>
              <td class="jetcache-table-help"><?php echo $language->get('entry_cont_db_status_help'); ?></td>
              <td class="jetcache-text-center">
              <div class="input-group jetcache-text-center">
              <select class="form-control" name="asc_jetcache_settings[cont_db_status]">
                  <?php if (isset($asc_jetcache_settings['cont_db_status']) && $asc_jetcache_settings['cont_db_status']) { ?>
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




	  <tr class="jetcache-back">
	 	<td colspan="2" class="jetcache-back jetcache-text-center">
         <?php echo $language->get('entry_add_conts'); ?> <span class="jetcache-table-help-href">?</span>
		</td>
	  </tr>


	<tr>
		<td class="jetcache-table-help left">
			<?php echo $language->get('entry_add_conts_help'); ?>
		</td>
		<td>
			<div style="float: left;">

					   <table id="add_conts" class="list jetcache-table-add">

						   <thead>
					             <tr>
					                <td class="left"><?php echo $language->get('entry_id'); ?></td>
					                <td><?php echo $language->get('entry_add_cont'); ?></td>
					                <td><?php echo $language->get('entry_status'); ?></td>
					                <td></td>
					             </tr>
					      </thead>

					      <?php if (isset($asc_jetcache_settings['add_cont']) && !empty($asc_jetcache_settings['add_cont'])) { ?>
					      <?php foreach ($asc_jetcache_settings['add_cont'] as $add_cont_id => $add_cont) { ?>
					      <?php $add_cont_row = $add_cont_id; ?>
					      <tbody id="add_cont_row<?php echo $add_cont_row; ?>">
					          <tr>
					               <td class="left">
									<input type="text" name="asc_jetcache_settings[add_cont][<?php echo $add_cont_id; ?>][type_id]" value="<?php if (isset($add_cont['type_id'])) echo $add_cont['type_id']; ?>" size="3">
					               </td>

									<td class="right">
										<div style="margin-bottom: 3px;">
											<input type="text" name="asc_jetcache_settings[add_cont][<?php echo $add_cont_id; ?>][cont]" value="<?php if (isset($add_cont['cont'])) echo $add_cont['cont']; ?>" style="width: 300px;">
										</div>
									</td>


									<td class="right">
						              <div class="input-group jetcache-text-center">
						              <select class="form-control" name="asc_jetcache_settings[add_cont][<?php echo $add_cont_id; ?>][status]">
						                  <?php if (isset($add_cont['status']) && $add_cont['status']) { ?>
						                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						                  <option value="0"><?php echo $text_disabled; ?></option>
						                  <?php } else { ?>
						                  <option value="1"><?php echo $text_enabled; ?></option>
						                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						                  <?php } ?>
						                </select>
						                </div>
									</td>



					                <td class="left"><a onclick="$('#add_cont_row<?php echo $add_cont_row; ?>').remove();" class="markbutton button_purple nohref"><?php echo $button_remove; ?></a></td>
					              </tr>
					            </tbody>

					      <?php } ?>
					      <?php } ?>
					    <tfoot>
					              <tr>
					                <td colspan="3"></td>
					                <td class="left"><a onclick="addAddCont();" class="markbutton nohref"><?php echo $language->get('entry_add_rule'); ?></a></td>
					    	</tr>
					 	</tfoot>
					 </table>
				</div>
		</td>
	</tr>


	</table>
</div>


<div id="tab-model">
	<table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">

	  <tr class="jetcache-back">
	 	<td colspan="2" class="jetcache-back jetcache-text-center">
         <?php echo $language->get('entry_status'); ?> <span class="jetcache-table-help-href">?</span>
		</td>
	  </tr>



          <tr>
              <td class="jetcache-table-help"><?php echo $language->get('entry_model_status_help'); ?></td>
              <td class="jetcache-text-center">
	              <div class="input-group jetcache-text-center">
		              <select class="form-control" name="asc_jetcache_settings[jetcache_model_status]">
		                  <?php if (isset($asc_jetcache_settings['jetcache_model_status']) && $asc_jetcache_settings['jetcache_model_status']) { ?>
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


 <tr class="jetcache-back">
	 	<td colspan="2" class="jetcache-back jetcache-text-center">
         <?php echo $language->get('entry_db_status'); ?> <span class="jetcache-table-help-href">?</span>
		</td>
	  </tr>



          <tr>
              <td class="jetcache-table-help"><?php echo $language->get('entry_model_db_status_help'); ?></td>
              <td class="jetcache-text-center">
              <div class="input-group jetcache-text-center">
              <select class="form-control" name="asc_jetcache_settings[model_db_status]">
                  <?php if (isset($asc_jetcache_settings['model_db_status']) && $asc_jetcache_settings['model_db_status']) { ?>
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



	  <tr class="jetcache-back">
	 	<td colspan="2" class="jetcache-back jetcache-text-center">
         <?php echo $language->get('entry_model_product_status'); ?> <span class="jetcache-table-help-href">?</span>
		</td>
	  </tr>

          <tr>
              <td>
              <?php echo $language->get('entry_model_gettotalproducts_status'); ?>
              <div class="jetcache-table-help">
              <?php echo $language->get('entry_model_gettotalproducts_status_help'); ?>
              </div>
              </td>
              <td class="jetcache-text-center">
	              <?php echo $language->get('text_status'); ?>
	              <div class="input-group jetcache-text-center">
	              <select class="form-control" name="asc_jetcache_settings[jetcache_gettotalproducts_status]">
	                  <?php if (isset($asc_jetcache_settings['jetcache_gettotalproducts_status']) && $asc_jetcache_settings['jetcache_gettotalproducts_status']) { ?>
	                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
	                  <option value="0"><?php echo $text_disabled; ?></option>
	                  <?php } else { ?>
	                  <option value="1"><?php echo $text_enabled; ?></option>
	                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
	                  <?php } ?>
	                </select>
	                </div>
                    <br>
                  <?php echo $language->get('text_gettotalproducts_uri_status'); ?>
	              <div class="input-group jetcache-text-center">
	              <select class="form-control" name="asc_jetcache_settings[jetcache_gettotalproducts_uri_status]">
	                  <?php if (isset($asc_jetcache_settings['jetcache_gettotalproducts_uri_status']) && $asc_jetcache_settings['jetcache_gettotalproducts_uri_status']) { ?>
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

    </table>
</div>


</div>
</form>
</div>


<script type="text/javascript">

var array_ex_route_row = Array();
<?php
 foreach ($asc_jetcache_settings['ex_route'] as $indx => $ex_route) {
?>
array_ex_route_row.push(<?php echo $indx; ?>);
<?php
}
?>

var ex_route_row = <?php echo $ex_route_row + 1; ?>;

function addExRoute() {

	var aindex = -1;
	for(i = 0; i < array_ex_route_row.length; i++) {
	 flg = jQuery.inArray(i, array_ex_route_row);
	 if (flg == -1) {
	  aindex = i;
	 }
	}
	if (aindex == -1) {
	  aindex = array_ex_route_row.length;
	}
	ex_route_row = aindex;
	array_ex_route_row.push(aindex);

    html  = '<tbody id="ex_route_row' + ex_route_row + '">';
	html += '  <tr>';
    html += '  <td class="left">';
    html += '	<div class="input-group">';
	html += ' 	<input type="text" name="asc_jetcache_settings[ex_route]['+ ex_route_row +'][type_id]" value="'+ ex_route_row +'" class="form-control" size="3">';
	html += '	</div>';
    html += '  </td>';

 	html += '  <td class="right">';


	html += '	<div class="input-group" style="margin-bottom: 3px;">';
	html += '		<input type="text" name="asc_jetcache_settings[ex_route]['+ ex_route_row +'][route]" value="" class="form-control" style="width: 300px;">';
	html += '	</div>';



	html += '		<td class="right">';
	html += '		  <div class="input-group jetcache-text-center">';
	html += '		  	<select class="form-control" name="asc_jetcache_settings[ex_route]['+ ex_route_row +'][status]">';
	html += '			      <option value="0"><?php echo $text_disabled; ?></option>';
	html += '			      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
	html += '		  	</select>';
	html += '		  </div>';
	html += '		</td>';




    html += '  </td>';
    html += '  <td class="left"><a onclick="$(\'#ex_route_row'+ex_route_row+'\').remove(); array_ex_route_row.remove(ex_route_row);" class="markbutton button_purple nohref"><?php echo $button_remove; ?></a></td>';




	html += '  </tr>';
	html += '</tbody>';

	$('#ex_routes tfoot').before(html);

	ex_route_row++;
}
</script>



<script type="text/javascript">

var array_ex_page_row = Array();
<?php
 foreach ($asc_jetcache_settings['ex_page'] as $indx => $ex_page) {
?>
array_ex_page_row.push(<?php echo $indx; ?>);
<?php
}
?>

var ex_page_row = <?php echo $ex_page_row + 1; ?>;

function addExPage() {

	var page_index = -1;
	for(i = 0; i < array_ex_page_row.length; i++) {
	 flg = jQuery.inArray(i, array_ex_page_row);
	 if (flg == -1) {
	  page_index = i;
	 }
	}
	if (page_index == -1) {
	  page_index = array_ex_page_row.length;
	}
	ex_page_row = page_index;
	array_ex_page_row.push(page_index);

    html  = '<tbody id="ex_page_row' + ex_page_row + '">';
	html += '  <tr>';
    html += '  <td class="left">';
    html += '	<div class="input-group">';
	html += ' 	 <input type="text" name="asc_jetcache_settings[ex_page]['+ ex_page_row +'][type_id]" value="'+ ex_page_row +'" class="form-control" size="3">';
	html += '	</div>';
    html += '  </td>';

 	html += '  <td class="right">';


	html += '	<div class="input-group" style="margin-bottom: 3px;">';
	html += '		<input type="text" name="asc_jetcache_settings[ex_page]['+ ex_page_row +'][url]" value="" class="form-control" style="width: 300px;">';
	html += '	</div>';


	html += '		<td class="right">';
	html += '		  <div class="input-group jetcache-text-center">';
	html += '		  	<select class="form-control" name="asc_jetcache_settings[ex_page]['+ ex_page_row +'][accord]">';
	html += '			      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>';
	html += '			      <option value="1"><?php echo $text_enabled; ?></option>';
	html += '		  	</select>';
	html += '		  </div>';
	html += '		</td>';

	html += '		<td class="right">';
	html += '		  <div class="input-group jetcache-text-center">';
	html += '		  	<select class="form-control" name="asc_jetcache_settings[ex_page]['+ ex_page_row +'][status]">';
	html += '			      <option value="0"><?php echo $text_disabled; ?></option>';
	html += '			      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
	html += '		  	</select>';
	html += '		  </div>';
	html += '		</td>';



    html += '  </td>';
    html += '  <td class="left"><a onclick="$(\'#ex_page_row'+ex_page_row+'\').remove(); array_ex_page_row.remove(ex_page_row);" class="markbutton button_purple nohref"><?php echo $button_remove; ?></a></td>';




	html += '  </tr>';
	html += '</tbody>';

	$('#ex_pages tfoot').before(html);

	ex_page_row++;
}
</script>


<script type="text/javascript">

var array_add_cont_row = Array();
<?php
 foreach ($asc_jetcache_settings['add_cont'] as $indx => $add_cont) {
?>
array_add_cont_row.push(<?php echo $indx; ?>);
<?php
}
?>

var add_cont_row = <?php echo $add_cont_row + 1; ?>;

function addAddCont() {

	var cont_index = -1;
	for(i = 0; i < array_add_cont_row.length; i++) {
	 flg = jQuery.inArray(i, array_add_cont_row);
	 if (flg == -1) {
	  cont_index = i;
	 }
	}
	if (cont_index == -1) {
	  cont_index = array_add_cont_row.length;
	}
	add_cont_row = cont_index;
	array_add_cont_row.push(cont_index);

    html  = '<tbody id="add_cont_row' + add_cont_row + '">';
	html += '  <tr>';
    html += '  <td class="left">';
    html += '	<div class="input-group">';
	html += ' 	<input type="text" name="asc_jetcache_settings[add_cont]['+ add_cont_row +'][type_id]" value="'+ add_cont_row +'" class="form-control" size="3">';
    html += '	</div>';
    html += '  </td>';

 	html += '  <td class="right">';


	html += '	<div class="input-group" style="margin-bottom: 3px;">';
	html += '		<input type="text" name="asc_jetcache_settings[add_cont]['+ add_cont_row +'][cont]" value="" class="form-control" style="width: 300px;">';
	html += '	</div>';

	html += '		<td class="right">';
	html += '		  <div class="input-group jetcache-text-center">';
	html += '		  	<select class="form-control" name="asc_jetcache_settings[add_cont]['+ add_cont_row +'][status]">';
	html += '			      <option value="0"><?php echo $text_disabled; ?></option>';
	html += '			      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
	html += '		  	</select>';
	html += '		  </div>';
	html += '		</td>';



    html += '  </td>';
    html += '  <td class="left"><a onclick="$(\'#add_cont_row'+add_cont_row+'\').remove(); array_add_cont_row.remove(add_cont_row);" class="markbutton button_purple nohref"><?php echo $button_remove; ?></a></td>';




	html += '  </tr>';
	html += '</tbody>';

	$('#add_conts tfoot').before(html);

	add_cont_row++;
}
</script>




	<script type="text/javascript">

	 form_submit = function() {
		$('#form').submit();
		return false;
	}
	$('.jetcache_save').bind('click', form_submit);
	</script>

<script type="text/javascript">
$('#tabs a').tabs();
</script>


<script type="text/javascript">

function odd_even() {
	var kz = 0;
	$('table tr').each(function(i,elem) {
	$(this).removeClass('odd');
	$(this).removeClass('even');
		if ($(this).is(':visible')) {
			kz++;
			if (kz % 2 == 0) {
				$(this).addClass('odd');
			}
		}
	});
}

$(document).ready(function(){
	odd_even();

	$('.htabs a').click(function() {
		odd_even();
	});

	$('.vtabs a').click(function() {
		odd_even();
	});

});

function input_select_change() {

	$('input').each(function(){
		if (!$(this).hasClass('no_change')) {
	        $(this).removeClass('sc_select_enable');
	        $(this).removeClass('sc_select_disable');

			if ( $(this).val() != '' ) {
				$(this).addClass('sc_select_enable');
			} else {
				$(this).addClass('sc_select_disable');
			}
		}
	});

	$('select').each(function(){
		if (!$(this).hasClass('no_change')) {
	        $(this).removeClass('sc_select_enable');
	        $(this).removeClass('sc_select_disable');

			this_val = $(this).find('option:selected').val()

			if (this_val == '1' ) {
				$(this).addClass('sc_select_enable');
			}

			if (this_val == '0' || this_val == '') {
				$(this).addClass('sc_select_disable');
			}

			if (this_val != '0' && this_val != '1' && this_val != '') {
				$(this).addClass('sc_select_other');
			}
		}
	});
}


$(document).ready(function(){
	$('.help').hide();

	input_select_change();

	$( "select" )
	  .change(function () {
		input_select_change();

	  });

	$( "input" )
	  .blur(function () {
		input_select_change();
	  });


});


$('.jetcache-table-help-href').on('click', function() {	$('.jetcache-table-help').toggle();
});


</script>




</div>

</div>
<?php echo $footer; ?>
</div>