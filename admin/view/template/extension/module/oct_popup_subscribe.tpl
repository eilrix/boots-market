<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form" formaction="<?php echo $action; ?>" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <button type="submit" form="form" formaction="<?php echo $delete; ?>" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></button>
        <button type="submit" form="form" formaction="<?php echo $csv; ?>" data-toggle="tooltip" title="<?php echo $button_csv; ?>" class="btn btn-primary"><i class="fa fa-download"></i></button>
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
        <form method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#subscribes-tab" data-toggle="tab"><?php echo $tab_subscribes; ?></a></li>
            <li><a href="#setting-tab" data-toggle="tab"><?php echo $tab_setting; ?></a></li>
			<li><a href="#templates-tab" data-toggle="tab"><?php echo $tab_email_templates; ?></a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane" id="setting-tab">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="oct_popup_subscribe_form_data[status]" id="input-status" class="form-control">
                    <?php if ($oct_popup_subscribe_form_data['status']) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_promo_text; ?></label>
                <div class="col-sm-10">
                  <ul class="nav nav-tabs" id="promo-text">
                    <?php foreach ($languages as $language) { ?>
                      <li>
                        <a href="#tab-promo-text-language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                      </li>
                    <?php } ?>
                  </ul>
                  <div class="tab-content">
                  <?php foreach ($languages as $language) { ?>
                    <div class="tab-pane" id="tab-promo-text-language<?php echo $language['language_id']; ?>">
                      <textarea id="promo-text-language<?php echo $language['language_id']; ?>" class="form-control summernote" style="height:auto;resize:vertical;" rows="3" name="oct_popup_subscribe_text_data[<?php echo $language['code']; ?>][promo_text]"><?php echo (!empty($oct_popup_subscribe_text_data[$language['code']]['promo_text'])) ? $oct_popup_subscribe_text_data[$language['code']]['promo_text'] : '';?></textarea>
                    </div>
                  <?php } ?>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_time_expire; ?></label>
                <div class="col-sm-10">
                  <div class="input-group">
                    <input value="<?php echo $oct_popup_subscribe_form_data['expire']; ?>" type="text" name="oct_popup_subscribe_form_data[expire]" class="form-control" />
                    <span class="input-group-addon"><?php echo $text_days; ?></span>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">Задержка (DELAY)</label>
                <div class="col-sm-10">
                  <div class="input-group">
                    <input value="<?php echo isset($oct_popup_subscribe_form_data['seconds']) ? $oct_popup_subscribe_form_data['seconds'] : '13000'; ?>" type="text" name="oct_popup_subscribe_form_data[seconds]" class="form-control" />
                    <span class="input-group-addon">ms</span>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_image; ?></label>
                <div class="col-sm-10"><a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="oct_popup_subscribe_form_data[image]" value="<?php echo $oct_popup_subscribe_form_data['image']; ?>" id="input-image" />
                </div>
              </div>
            </div>
            <div class="tab-pane active" id="subscribes-tab">
              <div class="table-responsive">
                <table class="table table-bordered table-hover">
                  <thead>
                    <tr>
                      <td style="width: 1px;" class="text-center">
                        <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" />
                      </td>
                      <td class="text-left"><?php if ($sort == 'email') { ?>
                        <a href="<?php echo $sort_email; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_email; ?></a>
                        <?php } else { ?>
                        <a href="<?php echo $sort_email; ?>"><?php echo $column_email; ?></a>
                        <?php } ?>
                      </td>
                      <td class="text-left"><?php if ($sort == 'approved') { ?>
                        <a href="<?php echo $sort_approved; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_approved; ?></a>
                        <?php } else { ?>
                        <a href="<?php echo $sort_approved; ?>"><?php echo $column_approved; ?></a>
                        <?php } ?>
                      </td>
                      <td class="text-left"><?php if ($sort == 'ip') { ?>
                        <a href="<?php echo $sort_ip; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_ip; ?></a>
                        <?php } else { ?>
                        <a href="<?php echo $sort_ip; ?>"><?php echo $column_ip; ?></a>
                        <?php } ?>
                      </td>
                      <td class="text-left"><?php if ($sort == 'date_added') { ?>
                        <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                        <?php } else { ?>
                        <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                        <?php } ?>
                      </td>
                      <td class="text-left"><?php echo $column_action; ?></td>
                    </tr>
                  </thead>
                  <tbody>
                    <?php if ($subscribes) { ?>
                    <?php foreach ($subscribes as $subscribe) { ?>
                    <tr>
                      <td class="text-center"><?php if (in_array($subscribe['subscribe_id'], $selected)) { ?>
                        <input type="checkbox" name="selected[]" value="<?php echo $subscribe['subscribe_id']; ?>" checked="checked" />
                        <?php } else { ?>
                        <input type="checkbox" name="selected[]" value="<?php echo $subscribe['subscribe_id']; ?>" />
                        <?php } ?>
                      </td>
                      <td class="text-left"><?php echo $subscribe['email']; ?></td>
                      <td class="text-left">
                        <?php if ($subscribe['approve'] == 1) { ?>
                          <?php echo $text_yes; ?>
                        <?php } else { ?>
                          <?php echo $text_no; ?>
                        <?php } ?>
                      </td>
                      <td class="text-left"><?php echo $subscribe['ip']; ?></td>
                      <td class="text-left"><?php echo $subscribe['date_added']; ?></td>
                      <td class="text-left">
                        <?php if ($subscribe['approve'] !== 1) { ?>
                        <a href="<?php echo $subscribe['approve']; ?>" data-toggle="tooltip" title="<?php echo $button_approve; ?>" class="btn btn-success"><i class="fa fa-thumbs-o-up"></i></a>
                        <?php } else { ?>
                        <button type="button" class="btn btn-success" disabled><i class="fa fa-thumbs-o-up"></i></button>
                        <?php } ?>
                      </td>
                    </tr>
                    <?php } ?>
                    <?php } else { ?>
                    <tr>
                      <td class="text-center" colspan="6"><?php echo $text_no_results; ?></td>
                    </tr>
                    <?php } ?>
                  </tbody>
                </table>
              </div>
            <div class="row">
              <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
              <div class="col-sm-6 text-right"><?php echo $results; ?></div>
            </div>
          </div>
			<div class="tab-pane" id="templates-tab">
				<fieldset>
					<legend><?php echo $tab_setting; ?></legend>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-template_status"><?php echo $entry_template_status; ?></label>					
						<div class="col-sm-10">
						  <select name="oct_popup_subscribe_form_data[template_status]" id="input-template_status" class="form-control">
							<?php if (isset($oct_popup_subscribe_form_data['template_status']) && $oct_popup_subscribe_form_data['template_status']) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					</div>
					<legend><?php echo $entry_template_first; ?></legend>
					<div class="form-group">
						<label class="col-sm-3 control-label"><?php echo $entry_approve_link; ?></label>					
						<div class="col-sm-9">
							<ul class="nav nav-tabs" id="email-template-first">
								<?php foreach ($languages as $language) { ?>						  
								<li>
									<a href="#tab-email_template_first<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
								</li>
								<?php } ?>					  
							</ul>
							<div class="tab-content">
								<?php foreach ($languages as $language) { ?>
									<div class="tab-pane" id="tab-email_template_first<?php echo $language['language_id']; ?>">
										<div class="input-group">
											<span class="input-group-addon"><?php echo $entry_subscribes_email; ?></span> <input value="<?php echo (isset($oct_popup_subscribe_text_data[$language['language_id']]['subject_email_template_first']) && !empty($oct_popup_subscribe_text_data[$language['language_id']]['subject_email_template_first'])) ? $oct_popup_subscribe_text_data[$language['language_id']]['subject_email_template_first'] : ''; ?>" type="text" name="oct_popup_subscribe_text_data[<?php echo $language['language_id']; ?>][subject_email_template_first]" class="form-control" />
										</div>
										<br />
										<textarea id="email_template_first<?php echo $language['language_id']; ?>" class="form-control summernote" style="height:auto;resize:vertical;" rows="3" name="oct_popup_subscribe_text_data[<?php echo $language['language_id']; ?>][email_template_first]"><?php echo (isset($oct_popup_subscribe_text_data[$language['language_id']]['email_template_first']) && !empty($oct_popup_subscribe_text_data[$language['language_id']]['email_template_first'])) ? $oct_popup_subscribe_text_data[$language['language_id']]['email_template_first'] : ''; ?></textarea>
									</div>
								<?php } ?>					  
							</div>
						</div>
					</div>
					<legend><?php echo $entry_template_second; ?></legend>
					<div class="form-group">
						<label class="col-sm-3 control-label"><?php echo $entry_unsubscribe_link; ?></label>					
						<div class="col-sm-9">
							<ul class="nav nav-tabs" id="email-template-second">
								<?php foreach ($languages as $language) { ?>						  
								<li>
									<a href="#tab-email_template_second<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
								</li>
								<?php } ?>					  
							</ul>
							<div class="tab-content">
								<?php foreach ($languages as $language) { ?>	
									<div class="tab-pane" id="tab-email_template_second<?php echo $language['language_id']; ?>">
										<div class="input-group">
											<span class="input-group-addon"><?php echo $entry_subscribes_email; ?></span> <input value="<?php echo (isset($oct_popup_subscribe_text_data[$language['language_id']]['subject_email_template_second']) && !empty($oct_popup_subscribe_text_data[$language['language_id']]['subject_email_template_second'])) ? $oct_popup_subscribe_text_data[$language['language_id']]['subject_email_template_second'] : ''; ?>" type="text" name="oct_popup_subscribe_text_data[<?php echo $language['language_id']; ?>][subject_email_template_second]" class="form-control" />
										</div>
										<br />
										<textarea id="email_template_second<?php echo $language['language_id']; ?>" class="form-control summernote" style="height:auto;resize:vertical;" rows="3" name="oct_popup_subscribe_text_data[<?php echo $language['language_id']; ?>][email_template_second]"><?php echo (isset($oct_popup_subscribe_text_data[$language['language_id']]['email_template_second']) && !empty($oct_popup_subscribe_text_data[$language['language_id']]['email_template_second'])) ? $oct_popup_subscribe_text_data[$language['language_id']]['email_template_second'] : '';?></textarea>
									</div>
								<?php } ?>					  
							</div>
						</div>
					</div>
				</fieldset>
			</div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
<?php if (isset($ckeditor) && $ckeditor) { ?>
  <?php foreach ($languages as $language) { ?>
    ckeditorInit('promo-text-language<?php echo $language['language_id']; ?>', getURLVar('token'));
	ckeditorInit('email_template_first<?php echo $language['language_id']; ?>', getURLVar('token'));
	ckeditorInit('email_template_second<?php echo $language['language_id']; ?>', getURLVar('token'));
  <?php } ?>
<?php } ?>
</script>
<script type="text/javascript">
	$('#promo-text a:first').tab('show');
	$('#email-template-first a:first').tab('show');
	$('#email-template-second a:first').tab('show');
</script>
<?php echo $footer; ?>