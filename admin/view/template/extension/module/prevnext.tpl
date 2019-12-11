<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-prevnext" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
		<ul class="nav nav-tabs" id="user_log_tabs">
			<li class="active"><a href="#tab-settings" data-toggle="tab"><?php echo $tab_settings; ?></a></li>
			<li><a href="#tab-help" data-toggle="tab"><?php echo $tab_help; ?></a></li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane" id="tab-help">
				<div class="container">
					<h3 style="color:red">Благодарю вас за выбор модуля!</h3>
					<p>Если у вас возникла проблема с работой модуля в этом контексте, то вы всегда можете запросить бесплатную техническую поддержку по адресу покупки модуля.</p>
		
					<h3>Назначение модуля</h3>
					<p>Модуль предназначен для вывода в карточке товара ссылок Предыдущий Следующий</p>
					<h4 class="text-primary">Особенности модуля</h4>
					Модуль имеет несколько алгоритмов выборки товаров.
					<ul>
						<li>Основной - (Предпочтение по категории)
							<p>Предыдущий|Следующий товар выбирается из той же категории, где находится текущий товар</p></li>
						<li>По производителю - (Предпочтение по производителю)
							<p>Предыдущий|Следующий товар выбирается того же производителя что и текущий товар</p></li>
						<li>По акции - (Предпочтение по акции)
							<p>Предыдущий|Следующий товар выбирается из акций, если текущий товар акционный</p></li>
					</ul>
					<p>Каждый метод имеет как преимущества, так и недостатки, связанные с различным размещением и подходом к СЕО</p>
					<p>Порядок применения предпочтений:<br>
					по акциям (если установлено)<br>
					по производителю (если установлено)<br>
					по категории (если установлено или не установлено) - этот признак введен для будущих изменений
					</p>
					<h4 class="text-primary">Зачем это нужно</h4>
					<p>Перелинковка, юзабилити</p>
					<h4 class="text-primary">Сео особенности</h4>
					<p>Не все сеоспециалисты любят анкорные ссылки в карточке товара, это может отрицаьелно повлиять на продвижение</p>
					<p>Поэтому введен такой параметр как <i>Анкерная(имя товара)|Безанкерная(пред/след) ссылка</i>.
					Соответственно для безанкерной ссылки вводятся языковые название ссылки.</p>

					<h4 class="text-primary">Настройка вывода</h4>
					<p>Место вывода блока - можно поменять в ocmod файле.
					Шаблон ссылок вынесен в отдельный файл.</p>
				</div>
			</div>
			<div class="tab-pane active" id="tab-settings">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-prevnext" class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
						<div class="col-sm-10">
						<select name="prevnext_enable" id="input-status" class="form-control">
							<?php if ($prevnext_enable) { ?>
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
						<label class="col-sm-2 control-label" for="input-category"><?php echo $entry_category; ?></label>
						<div class="col-sm-10">
							<?php $checked = ($prevnext_category)?' checked="checked"':''; ?>
						<input type="checkbox" value="1" name="prevnext_category" id="input-category" class="form-control" <?php echo $checked; ?> />
						<div class="form-text">
						<?php echo $text_category_help; ?>
						</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-manufacturer"><?php echo $entry_manufacturer; ?></label>
						<div class="col-sm-10">
							<?php $checked = ($prevnext_manufacturer)?' checked="checked"':''; ?>
						<input type="checkbox" value="1" name="prevnext_manufacturer" id="input-manufacturer" class="form-control" <?php echo $checked; ?> />
						<div class="form-text">
						<?php echo $text_manufacturer_help; ?>
						</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-special"><?php echo $entry_special; ?></label>
						<div class="col-sm-10">
							<?php $checked = ($prevnext_special)?' checked="checked"':''; ?>
						<input type="checkbox" value="1" name="prevnext_special" id="input-special" class="form-control" <?php echo $checked; ?> />
						<div class="form-text">
						<?php echo $text_special_help; ?>
						</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-circle"><?php echo $entry_circle_links; ?></label>
						<div class="col-sm-10">
							<?php $checked = ($prevnext_circle)?' checked="checked"':''; ?>
						<input type="checkbox" value="1" name="prevnext_circle" id="input-circle" class="form-control" <?php echo $checked; ?> />
						<div class="form-text">
						<?php echo $text_circle_links_help; ?>
						</div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-anchor"><?php echo $entry_anchor; ?></label>
						<div class="col-sm-10">
							<?php $checked = ($prevnext_anchor)?' checked="checked"':''; ?>
						<input type="checkbox" value="1" name="prevnext_anchor" id="input-anchor" class="form-control" <?php echo $checked; ?> />
						</div>
					</div>
					<div class="form-group" id="text-links" style="display:none">
						<label class="col-sm-2 control-label"><?php echo $entry_links; ?></label>
						<div class="col-sm-10">
						<div class="form-group">
							<label class="col-sm-2 control-label"><?php echo $entry_links_next; ?></label>
							<div class="col-sm-10">
							<?php foreach ($languages as $language) { ?>
							<div class="input-group">
								<span class="input-group-addon"><img title="<?php echo $language['name']; ?>" src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png"></span>
								<input type="text" class="form-control" value="<?php echo isset($prevnext_anchor_next[$language['language_id']])? $prevnext_anchor_next[$language['language_id']] : ''; ?>" name="prevnext_anchor_next[<?php echo $language['language_id']; ?>]">
							</div>
							<?php } ?>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"><?php echo $entry_links_prev; ?></label>
							<div class="col-sm-10">
							<?php foreach ($languages as $language) { ?>
							<div class="input-group">
								<span class="input-group-addon"><img title="<?php echo $language['name']; ?>" src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png"></span>
								<input type="text" class="form-control" value="<?php echo isset($prevnext_anchor_prev[$language['language_id']])? $prevnext_anchor_prev[$language['language_id']] : ''; ?>" name="prevnext_anchor_prev[<?php echo $language['language_id']; ?>]">
							</div>
							<?php } ?>
							</div>
						</div>
						</div>
					</div>
				</form>
			</div>
		</div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
function change_anchor(){
	var anchor = $('#input-anchor').is(':checked');
	if (anchor) {
		$('#text-links').show();
	} else {
		$('#text-links').hide();
	}
}
$('#input-anchor').on('change',function(){
	change_anchor();
})
change_anchor();
</script>
<?php echo $footer; ?>