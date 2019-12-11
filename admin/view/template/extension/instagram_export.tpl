<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<div class="modal fade" id="exportModel">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
					</div>
				</div>
			</div>
		</div>
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<?php if ($success) { ?>
		<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
			</div>
			<div class="panel-body">
				<div class="well">
					<div class="row">
						<div class="col-sm-3">
							<div class="form-group">
								<label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
								<input type="text" name="filter_name" value="<?php echo $filter_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label class="control-label" for="input-status"><?php echo $column_category; ?></label>
								<select name="filter_category" id="input-status" class="form-control">
									<option value="*"></option>
									<?php foreach ($categories as $category) { ?>
									<?php if ($category['product_count'] >= 1) { ?>
									<?php if ($category['category_id']==$filter_category) { ?>
									<option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
									<?php } else { ?>
									<option value="<?php echo $category['category_id']; ?>">&nbsp;&nbsp;<?php echo $category['name']; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
									<?php } ?>
									<?php } ?>
									<?php } ?>
								</select>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label class="control-label" for="input-model"><?php echo $entry_model; ?></label>
								<input type="text" name="filter_model" value="<?php echo $filter_model; ?>" placeholder="<?php echo $entry_model; ?>" id="input-model" class="form-control" />
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label class="control-label" for="input-model">Instagram</label>
								<select name="filter_post" id="input-post" class="form-control">
									<option value="*"></option>
									<?php if ($filter_post) { ?>
										<option value="1" selected="selected"><?php echo $text_yes; ?></option>
									<?php } else { ?>
										<option value="1"><?php echo $text_yes; ?></option>
									<?php } ?>
									<?php if (!$filter_post && !is_null($filter_post)) { ?>
										<option value="0" selected="selected"><?php echo $text_no; ?></option>
									<?php } else { ?>
										<option value="0"><?php echo $text_no; ?></option>
									<?php } ?>
								</select>
							</div>
							<button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
						</div>
					</div>
				</div>
				<div class="page-header">
					<div class="container-fluid">
						<div class="pull-right">
							<?php if ($username) { ?>
								<a id="add_export" href="javascript:;" data-toggle="tooltip" title="<?php echo $text_export_products;?>" class="btn btn-primary"><i class="fa fa-share"></i> <?php echo $text_export_products;?></a>
								<!--<a id="delete_export" href="javascript:;" data-toggle="tooltip" title="Удалить из Instagram" class="btn btn-danger"><i class="fa fa-remove"></i> Удалить из Instagram</a>-->
							<?php } ?>
							<a href="<?php echo $settings; ?>" data-toggle="tooltip" title="<?php echo $text_settings; ?>" class="btn btn-default"><i class="fa fa-cog"></i> <?php echo $text_settings; ?></a>
						</div>
					</div>
				</div>
				<form action="javascript:;" method="post" enctype="multipart/form-data" id="form-product">
					<div class="table-responsive">
						<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
									<td class="text-center"><?php echo $column_image; ?></td>
									<td class="text-left"><?php if ($sort == 'pd.name') { ?>
										<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
										<?php } else { ?>
										<a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
										<?php } ?>
									</td>
									<td class="text-left"><?php echo $column_description; ?></td>
									<td class="text-left"><?php echo $column_tag; ?></td>
									<td class="text-left"><?php echo $column_date; ?></td>
								</tr>
							</thead>
							<tbody>
								<?php if ($products) { ?>
								<?php foreach ($products as $product) { ?>
								<tr>
									<td class="text-center"><?php if (in_array($product['product_id'], $selected)) { ?>
										<input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" checked="checked" />
										<?php } else { ?>
										<input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" />
										<?php } ?>
									</td>
									<td class="text-center">
										<?php if ($product['image']) { ?>
											<img src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>" class="img-thumbnail" />
										<?php } else { ?>
											<span class="img-thumbnail list"><i class="fa fa-camera fa-2x"></i></span>
										<?php } ?>
									</td>
									<td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a><br /><small><?php echo $column_model; ?><?php echo $product['model']; ?><small></td>
									<td class="text-center">
										<textarea id="descr_text_<?php echo $product['product_id']; ?>" cols="30" rows="3" style="resize:none;" class="form-control" name="instagram_text"><?php echo $product['description']; ?></textarea>
										<div class="text-right">
											<br />
											<a id="update_desc_<?php echo $product['product_id']; ?>" onclick="update_description(<?php echo $product['product_id']; ?>);" class="edit_export_text" href="javascript:;" data-toggle="tooltip" title="<?php echo $entry_help_updesc; ?>"><i class="fa fa-share"></i> <?php echo $entry_update_text; ?></a>
										</div>
									</td>
									<td class="text-left">
										<textarea id="tag_text_<?php echo $product['product_id']; ?>" cols="30" rows="3" style="resize:none;" class="form-control" name="instagram_tag"><?php echo $product['tag']; ?></textarea>
										<div class="text-right">
											<br />
											<a id="update_tag_<?php echo $product['product_id']; ?>" onclick="update_tag(<?php echo $product['product_id']; ?>);" class="edit_export_tag" style="float:right;" href="javascript:;" data-toggle="tooltip" title="<?php echo $entry_help_uptag; ?>"><i class="fa fa-share"></i> <?php echo $entry_update_text; ?></a>
										</div>
									</td>
									<td class="text-left">
										<?php if (!empty($product['date_export'])) { ?>
											<i class="fa fa-check-circle"></i> <?php echo $text_export; ?><br /><?php echo $product['date_export']; ?>
										<?php } else { ?>
											<i class="fa fa-check-circle"></i> <?php echo $text_no_export; ?>
										<?php } ?>
										
									</td>
								</tr>
								<?php } ?>
								<?php } else { ?>
								<tr>
									<td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
								</tr>
								<?php } ?>
							</tbody>
						</table>
					</div>
				</form>
				<div class="row">
					<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
					<div class="col-sm-6 text-right"><?php echo $results; ?></div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript"><!--
		$('#button-filter').on('click', function() {
			var url = 'index.php?route=extension/instagram_export&token=<?php echo $token; ?>';
		
			var filter_name = $('input[name=\'filter_name\']').val();
		
			if (filter_name) {
				url += '&filter_name=' + encodeURIComponent(filter_name);
			}
		
			var filter_model = $('input[name=\'filter_model\']').val();
		
			if (filter_model) {
				url += '&filter_model=' + encodeURIComponent(filter_model);
			}		
		
			var filter_category = $('select[name=\'filter_category\']').val();
		
			if (filter_category != '*') {
				url += '&filter_category=' + encodeURIComponent(filter_category);
			}		
		
			var filter_post = $('select[name=\'filter_post\']').val();
		
			if (filter_post != '*') {
				url += '&filter_post=' + encodeURIComponent(filter_post);
			}
		
			location = url;
		});
	//--></script>
	<script type="text/javascript"><!--
		$('input[name=\'filter_name\']').autocomplete({
			'source': function(request, response) {
				$.ajax({
					url: 'index.php?route=extension/instagram_export/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
					dataType: 'json',
					success: function(json) {
						response($.map(json, function(item) {
							return {
								label: item['name'],
								value: item['product_id']
							}
						}));
					}
				});
			},
			'select': function(item) {
				$('input[name=\'filter_name\']').val(item['label']);
			}
		});
		
		$('input[name=\'filter_model\']').autocomplete({
			'source': function(request, response) {
				$.ajax({
					url: 'index.php?route=extension/instagram_export/autocomplete&token=<?php echo $token; ?>&filter_model=' +  encodeURIComponent(request),
					dataType: 'json',
					success: function(json) {
						response($.map(json, function(item) {
							return {
								label: item['model'],
								value: item['product_id']
							}
						}));
					}
				});
			},
			'select': function(item) {
				$('input[name=\'filter_model\']').val(item['label']);
			}
		});
		
		function getProgress() {
			$.ajax({
				url: 'index.php?route=extension/instagram_export/getProgress&token=<?php echo $token; ?>',
				dataType: "json",
				success: function (json) {
					$("#progress_value").text(json['percent']);
					$("#progressbar_wrapper").find('.progress-bar').attr('aria-valuenow',json['progress']);
					$("#progressbar_wrapper").find('.progress-bar').css('width',json['percent']+'%');
				}
			});
		}

		$(document).on('click', '#add_export', function () {
			var total_products = $('input[name="selected[]"]:checked').length;
			
			if (total_products < 1) {
				return alert('<?php echo $error_export_products; ?>');
			}
			
			var html = '<div id="loading_info" class="loading_info"><span id="action_message">Идёт процесс экспорта товаров в Instagram, пожалуйста подождите.<br />Это может занять некоторое время.</span><br /><br />';
				
			if (total_products) {
				html += '<div id="progressbar_wrapper"><div class="progress"><div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="' + total_products +'" style="width:0;">Экспортировано <span id="progress_value">0</span>%</div></div></div>';
			}
			
			html += '</div>';
			
			$('#exportModel .modal-title').text('Экспорт товаров в Instagram...');
			$('#exportModel .modal-body').html(html);
			$('#exportModel .modal-footer').hide();
			$('#exportModel').modal();
			$('#progressbar_wrapper').show();
			$('#progress_value').text(0);
			$('#total_export').text(total_products);
			
			var request = $.ajax({
				url: 'index.php?route=extension/instagram_export/export&token=<?php echo $token; ?>',
				type: "POST",
				data: $('#form-product input[type=\'checkbox\']:checked'),
				dataType: "json"
			});
			
			var progress_timer = setInterval('getProgress();', 2000);
			
			request.done(function(data) {
				clearInterval(progress_timer);

				data_ref(data);
			});
		});
		
		var data_ref = function (data) {
			$("#progress_value").text('100');
			$("#progressbar_wrapper").find('.progress-bar').css('width','100%').delay(1000);
			
			$('#loading_info').hide();
			$("#form-product").trigger('reset');
			$('#exportModel').modal('hide');
		};
		
		function update_description (id) {
			var sender = $("#update_desc_"+id);
			$.ajax({
				url: 'index.php?route=extension/instagram_export/updateD&token=<?php echo $token; ?>',
				type: 'post',
				data: 'text=' + $('textarea#descr_text_'+id).val() + '&product_id=' + id,
				dataType: 'json',
				beforeSend: function() {
					$(sender).button('loading');
				},
				complete: function() {
					$(sender).button('reset');
				},
				success: function(json) {
					if (json['error']) {
						alert("Что-то пошло не так!");
					}
					
					if (json['success']) {
						alert("Описание успешно обновленно!");
					}
				}
			});
		}
		
		function update_tag (id) {
			var sender = $("#update_tag_"+id);
			$.ajax({
				url: 'index.php?route=extension/instagram_export/updateT&token=<?php echo $token; ?>',
				type: 'post',
				data: 'text=' + $('textarea#tag_text_'+id).val() + '&product_id=' + id,
				dataType: 'json',
				beforeSend: function() {
					$(sender).button('loading');
				},
				complete: function() {
					$(sender).button('reset');
				},
				success: function(json) {
					if (json['error']) {
						alert("Что-то пошло не так!");
					}
					
					if (json['success']) {
						alert("Описание успешно обновленно!");
					}
				}
			});
		}
	//--></script>
</div>
<?php echo $footer; ?>