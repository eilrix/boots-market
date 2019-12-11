<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-instagram_export" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
			</div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-instagram_export" class="form-horizontal">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general_settings; ?></a></li>
						<li><a href="#tab-data" data-toggle="tab"><?php echo $tab_data_settings; ?></a></li>
						<!--<li><a href="#tab-cron" data-toggle="tab"><?php echo $tab_data_cron; ?></a></li>-->
						<li><a href="#tab-update" data-toggle="tab"><?php echo $tab_update_settings; ?></a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab-general">
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-username"><?php echo $entry_username; ?></label>
								<div class="col-sm-10">
									<input type="text" name="instagram_export_username" value="<?php echo $instagram_export_username; ?>" placeholder="<?php echo $entry_username; ?>" id="input-username" class="form-control" />
									<?php if ($error_username) { ?>
									<div class="text-danger"><?php echo $error_username; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-export_password"><?php echo $entry_pass; ?></label>
								<div class="col-sm-10">
									<input type="password" name="instagram_export_password" value="<?php echo $instagram_export_password; ?>" placeholder="<?php echo $entry_pass; ?>" id="input-export_password" class="form-control" />
									<?php if ($error_password) { ?>
									<div class="text-danger"><?php echo $error_password; ?></div>
									<?php } ?>
									<div class="pull-right">
										<br />
										<a id="do_login" href="javascript:;" data-toggle="tooltip" title="<?php echo $entry_test_login; ?>" class="btn btn-primary"><i class="fa fa-share"></i> <?php echo $entry_test_login; ?></a>
									</div>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-data">
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-export_width">
									<span data-toggle="tooltip" title="<?php echo $entry_help_image; ?>"><?php echo $entry_image_width; ?></span>
								</label>
								<div class="col-sm-10">
									<input type="text" name="instagram_export_width" value="<?php echo $instagram_export_width; ?>" placeholder="<?php echo $entry_image_width; ?>" id="input-export_width" class="form-control" />
									<?php if ($error_image_width) { ?>
										<div class="text-danger"><?php echo $error_image_width; ?></div>
									<?php } ?>
									<?php if ($error_image_width_big) { ?>
										<div class="text-danger"><?php echo $error_image_width_big; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-sort-order">
									<span data-toggle="tooltip" title="<?php echo $entry_help_comment; ?>"><?php echo $entry_comment_is; ?></span>
								</label>
								<div class="col-sm-10">
									<div class="checkbox">
										<label class="radio-inline">
											<?php if ($instagram_export_comment) { ?>
												<input type="radio" name="instagram_export_comment" value="1" checked="checked" />
												<?php echo $text_yes; ?>
											<?php } else { ?>
												<input type="radio" name="instagram_export_comment" value="1" />
												<?php echo $text_yes; ?>
											<?php } ?>
										  </label>
										  <label class="radio-inline">
											<?php if (!$instagram_export_comment) { ?>
												<input type="radio" name="instagram_export_comment" value="0" checked="checked" />
												<?php echo $text_no; ?>
											<?php } else { ?>
												<input type="radio" name="instagram_export_comment" value="0" />
												<?php echo $text_no; ?>
											<?php } ?>
										</label>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-comments_text"><?php echo $entry_comment;?></label>
								<div class="col-sm-6">
									<textarea name="instagram_export_comment_text" placeholder="<?php echo $entry_comment;?>" rows="5" id="input-comments_text" class="form-control"><?php echo $instagram_export_comment_text;?></textarea>
								</div>
								<div class="col-sm-4">
									<?php echo $text_info_comment; ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-sort-order">
									<span data-toggle="tooltip" title="<?php echo $entry_help_watermark; ?>"><?php echo $entry_watermark; ?></span>
								</label>
								<div class="col-sm-2">
									<div class="checkbox">
										<label class="radio-inline">
											<?php if ($instagram_export_watermark) { ?>
												<input type="radio" name="instagram_export_watermark" value="1" checked="checked" />
												<?php echo $text_yes; ?>
											<?php } else { ?>
												<input type="radio" name="instagram_export_watermark" value="1" />
												<?php echo $text_yes; ?>
											<?php } ?>
										  </label>
										  <label class="radio-inline">
											<?php if (!$instagram_export_watermark) { ?>
												<input type="radio" name="instagram_export_watermark" value="0" checked="checked" />
												<?php echo $text_no; ?>
											<?php } else { ?>
												<input type="radio" name="instagram_export_watermark" value="0" />
												<?php echo $text_no; ?>
											<?php } ?>
										</label>
									</div>
								</div>
								<label class="col-sm-1 control-label"><?php echo $entry_image; ?></label>
								<div class="col-sm-2">
									<a href="javascript:;" id="thumb-instagram_export_watermark_image" data-toggle="image" class="img-thumbnail">
										<img src="<?php echo $instagram_export_watermark_thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
									</a>
								  <input type="hidden" name="instagram_export_watermark_image" value="<?php echo $instagram_export_watermark_image; ?>" id="input-instagram_export_watermark_image" />
								  <?php if ($error_watermark_image) { ?>
									<div class="text-danger"><?php echo $error_watermark_image; ?></div>
									<?php } ?>
								</div>
								<label class="col-sm-1 control-label"><?php echo $entry_image_position; ?></label>
								<div class="col-sm-3">
									<select name="instagram_export_watermark_position" id="input-instagram_export_watermark_position" class="form-control">
										<?php if ($instagram_export_watermark_position == 'topleft') { ?>
											<option value="topleft" selected="selected">Вверху с лева</option>
										<?php } else { ?>
											<option value="topleft">Вверху с лева</option>
										<?php } ?>
										<?php if ($instagram_export_watermark_position == 'topright') { ?>
											<option value="topright" selected="selected">Вверху с права</option>
										<?php } else { ?>
											<option value="topright">Вверху с права</option>
										<?php } ?>
										<?php if ($instagram_export_watermark_position == 'bottomleft') { ?>
											<option value="bottomleft" selected="selected">Внизу с лева</option>
										<?php } else { ?>
											<option value="bottomleft">Внизу с лева</option>
										<?php } ?>
										<?php if ($instagram_export_watermark_position == 'bottomright') { ?>
											<option value="bottomright" selected="selected">Внизу с права</option>
										<?php } else { ?>
											<option value="bottomright">Внизу с права</option>
										<?php } ?>
										<?php if ($instagram_export_watermark_position == 'center') { ?>
											<option value="center" selected="selected">По центру</option>
										<?php } else { ?>
											<option value="center">По центру</option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-http_export">
									<span data-toggle="tooltip" title="<?php echo $entry_help_http_export; ?>"><?php echo $entry_http_export; ?></span>
								</label>
								<div class="col-sm-10">
									<input type="text" name="instagram_export_http_catalog" value="<?php echo $instagram_export_http_catalog; ?>" placeholder="<?php echo $entry_http_export; ?>" id="input-http_export" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-sort-order">
									<span data-toggle="tooltip" title="<?php echo $entry_help_bitly; ?>"><?php echo $entry_bitly; ?></span>
								</label>
								<div class="col-sm-2">
									<div class="checkbox">
										<label class="radio-inline">
											<?php if ($instagram_export_bitly) { ?>
												<input type="radio" name="instagram_export_bitly" value="1" checked="checked" />
												<?php echo $text_yes; ?>
											<?php } else { ?>
												<input type="radio" name="instagram_export_bitly" value="1" />
												<?php echo $text_yes; ?>
											<?php } ?>
										  </label>
										  <label class="radio-inline">
											<?php if (!$instagram_export_bitly) { ?>
												<input type="radio" name="instagram_export_bitly" value="0" checked="checked" />
												<?php echo $text_no; ?>
											<?php } else { ?>
												<input type="radio" name="instagram_export_bitly" value="0" />
												<?php echo $text_no; ?>
											<?php } ?>
										</label>
									</div>
								</div>
								<label class="col-sm-2 control-label" for="input-bitlyusername"><?php echo $entry_bitlyusername; ?></label>
								<div class="col-sm-2">
									<input type="text" name="instagram_export_bitlyusername" value="<?php echo $instagram_export_bitlyusername; ?>" placeholder="<?php echo $entry_bitlyusername; ?>" id="input-bitlyusername" class="form-control" />
									<?php if ($error_bitlyusername) { ?>
									<div class="text-danger"><?php echo $error_bitlyusername; ?></div>
									<?php } ?>
								</div>
								<label class="col-sm-2 control-label" for="input-bitlypassword"><?php echo $entry_bitlypass; ?></label>
								<div class="col-sm-2">
									<input type="password" name="instagram_export_bitlypassword" value="<?php echo $instagram_export_bitlypassword; ?>" placeholder="<?php echo $entry_bitlypass; ?>" id="input-bitlypassword" class="form-control" />
									<?php if ($error_bitlypassword) { ?>
									<div class="text-danger"><?php echo $error_bitlypassword; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-total_export"><?php echo $entry_total_products; ?></label>
								<div class="col-sm-10">
									<input type="text" name="instagram_export_total_products" value="<?php echo $instagram_export_total_products; ?>" placeholder="<?php echo $entry_total_products; ?>" id="input-total_export" class="form-control" />
								</div>
							</div>
						</div>
						<!--<div class="tab-pane" id="tab-cron">
							<div class="form-group">
								<div class="col-sm-2">
									В разработке
								</div>
							</div>
						</div>-->
						<div class="tab-pane" id="tab-update">
							<p>Текущая версия модуля: <strong><?php echo $version; ?></strong></p>
							<p>Обновление файлов производиться вручшую через FTP или через OCMod (необходима настройка FTP в админ панеле)</p>
							<p>Обновление базы данных необходимо выполнить только один раз!</p>
							<?php if ($need_update) { ?>
								<a id="update_module" href="javascript:;" data-toggle="tooltip" title="Обновить модуль экспорта в Instagram" class="btn btn-primary"><i class="fa fa-share"></i> Обновить данные в MySql</a>
							<?php } else { ?>
								<p><strong>У Вас установлена последняя версия Базы данных</strong></p>
							<?php } ?>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(document).on('click', '#do_login', function () {
	$.ajax({
		url: 'index.php?route=extension/instagram_export/authorizeTest&token=<?php echo $token; ?>',
		type: 'post',
		data: $('input#input-username, input#input-export_password'),
		dataType: 'json',
		beforeSend: function() {
        	$('#do_login').button('loading');
		},
        complete: function() {
			$('#do_login').button('reset');
        },
		success: function(json) {
			if (json['error']) {
				alert(json['error']);
			}
			
			if (json['success']) {
				alert(json['success']);
			}
		}
	});
});
$(document).on('click', '#update_module', function () {
	$.ajax({
		url: 'index.php?route=extension/instagram_export/updateModule&token=<?php echo $token; ?>',
		type: 'post',
		data: 'updateto=<?php echo $version; ?>',
		dataType: 'json',
		beforeSend: function() {
        	$('#update_module').button('loading');
		},
        complete: function() {
			$('#update_module').button('reset');
        },
		success: function(json) {
			if (json['error']) {
				alert("Что-то пошло не так!");
			}
			
			if (json['success']) {
				alert("Обновление успешно выполнено!");
				$("#update_module").remove();
			}
		}
	});
});
</script>
<?php echo $footer; ?>