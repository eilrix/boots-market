<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-autofeatured" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-autofeatured" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_title; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" placeholder="<?php echo $entry_title; ?>" id="input-name" class="form-control" value ="<?php echo $name; ?>" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>          
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-view"><?php echo $entry_title_view; ?></label>
            <div class="col-sm-10">
              <select name="titleview" id="input-view" class="form-control">
                <?php if ($titleview) { ?>
                <option value="1" selected="selected"><?php echo $title_view_all; ?></option>
                <option value="0"><?php echo $title_view_name; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $title_view_all; ?></option>
                <option value="0" selected="selected"><?php echo $title_view_name; ?></option>
                <?php } ?>
              </select>
            </div>
		  </div>
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-attribute"><?php echo $entry_attr; ?></label>
            <div class="col-sm-10">
              <input type="text" name="attribute" value="" placeholder="<?php echo $entry_attr; ?>" id="input-attribute" class="form-control" />
              <div id="attribute-list" class="well well-sm" style="height: 150px; overflow: auto;">
                <?php foreach ($attributes as $attribute) { ?>
                <div id="attribute-list<?php echo $attribute['attribute_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $attribute['name']; ?>
                  <input type="hidden" name="attribute[]" value="<?php echo $attribute['attribute_id']; ?>" />
                </div>
                <?php } ?>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-category-source"><?php echo $entry_category_source; ?></label>
            <div class="col-sm-10">
              <input type="text" name="category_source" value="" placeholder="<?php echo $entry_category_source; ?>" id="input-category-source" class="form-control" />
              <div id="category-list-source" class="well well-sm" style="height: 150px; overflow: auto;">
                <?php foreach ($categories_source as $category_source) { ?>
                <div id="category-list-source<?php echo $category_source['category_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $category_source['name']; ?>
                  <input type="hidden" name="category_source[]" value="<?php echo $category_source['category_id']; ?>" />
                </div>
                <?php } ?>
              </div>
            </div>
          </div>
		      <div class="form-group">
            <label class="col-sm-2 control-label" for="input-category"><?php echo $entry_category; ?></label>
            <div class="col-sm-10">
              <input type="text" name="category" value="" placeholder="<?php echo $entry_category; ?>" id="input-category" class="form-control" />
              <div id="category-list" class="well well-sm" style="height: 150px; overflow: auto;">
                <?php foreach ($categories as $category) { ?>
                <div id="category-list<?php echo $category['category_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $category['name']; ?>
                  <input type="hidden" name="category[]" value="<?php echo $category['category_id']; ?>" />
                </div>
                <?php } ?>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-one-cat"><?php echo $entry_one_cat; ?></label>
            <div class="col-sm-10">
              <select name="one_cat" id="input-one-cat" class="form-control">
                <?php if ($one_cat) { ?>
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
            <label class="col-sm-2 control-label" for="input-in-stock"><?php echo $entry_in_stock; ?></label>
            <div class="col-sm-10">
              <select name="in_stock" id="input-in_stock" class="form-control">
                <?php if ($in_stock) { ?>
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
            <label class="col-sm-2 control-label" for="input-limit"><?php echo $entry_limit; ?></label>
            <div class="col-sm-10">
              <input type="text" name="limit" value="<?php echo $limit; ?>" placeholder="<?php echo $entry_limit; ?>" id="input-limit" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-width"><?php echo $entry_width; ?></label>
            <div class="col-sm-10">
              <input type="text" name="width" value="<?php echo $width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-width" class="form-control" />
              <?php if ($error_width) { ?>
              <div class="text-danger"><?php echo $error_width; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-height"><?php echo $entry_height; ?></label>
            <div class="col-sm-10">
              <input type="text" name="height" value="<?php echo $height; ?>" placeholder="<?php echo $entry_height; ?>" id="input-height" class="form-control" />
              <?php if ($error_height) { ?>
              <div class="text-danger"><?php echo $error_height; ?></div>
              <?php } ?>
            </div>
          </div>
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-sortby"><?php echo $entry_sortby; ?></label>
            <div class="col-sm-10">
              <select name="sortby" id="input-sortby" class="form-control">
                <option value="random" <?php echo $sortby == 'random' ? 'selected="selected"' : '' ?>><?php echo $text_random; ?></option>
                <option value="price" <?php echo $sortby == 'price' ? 'selected="selected"' : '' ?>><?php echo $text_price; ?></option>
                <option value="attribute" <?php echo $sortby == 'attribute' ? 'selected="selected"' : '' ?>><?php echo $text_attribute; ?></option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
<script type="text/javascript"><!--
$('input[name=\'attribute\']').autocomplete({
    'source': function(request, response) {
      $.ajax({
        url: 'index.php?route=catalog/attribute/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
        dataType: 'json',
        success: function(json) {
          response($.map(json, function(item) {
            return {
              category: item.attribute_group,
              label: item.name,
              value: item.attribute_id
            }
          }));
        }
      });
    },
    'select': function(item) {
      $('input[name=\'attribute\']').val('');
    
    $('#attribute-list' + item['value']).remove();
    
    $('#attribute-list').append('<div id="attribute-list' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="attribute[]" value="' + item['value'] + '" /></div>');
    }
  });
$('input[name=\'category\']').autocomplete({
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['category_id']
					}
				}));
			}
		});
	},
	select: function(item) {
		$('input[name=\'category\']').val('');
		
		$('#category-list' + item['value']).remove();
		
		$('#category-list').append('<div id="category-list' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="category[]" value="' + item['value'] + '" /></div>');	
	}
});	
$('input[name=\'category_source\']').autocomplete({
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
      dataType: 'json',
      success: function(json) {
        response($.map(json, function(item) {
          return {
            label: item['name'],
            value: item['category_id']
          }
        }));
      }
    });
  },
  select: function(item) {
    $('input[name=\'category_source\']').val('');
    
    $('#category-list-source' + item['value']).remove();
    
    $('#category-list-source').append('<div id="category-list-source' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="category_source[]" value="' + item['value'] + '" /></div>'); 
  }
}); 


$('#attribute-list').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});
$('#category-list').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});
$('#category-list-source').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});
//--></script>
</div>
<?php echo $footer; ?>