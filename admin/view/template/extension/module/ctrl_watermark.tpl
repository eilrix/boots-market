<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <?php if( !isset($license_error) ) { ?>
                <button type="submit" name="action" value="clean" form="form-clean" data-toggle="tooltip" title="<?php echo $button_clean; ?>" class="btn btn-default btn-danger"><i class="fa fa-eraser"></i> <?php echo $button_clean; ?></button>
                <button type="submit" name="action" value="save" onclick="beforeSave();" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                <button type="submit" name="action" value="save_and_close" onclick="beforeSave();" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
                <?php } else { ?>
                <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-default" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
                <?php } ?>
                <a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
            </div>
            <img width="36" height="36" style="float:left" src="view/image/ctrl.png" alt=""/>
            <h1><?php echo $heading_title_raw . " " . $ctrl_watermark_version; ?></h1>
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
            <div class="panel-heading ui-helper-clearfix">
                <div class="pull-left">
                    <h3 class="panel-title "><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
                </div>
                <div class="pull-right">
                <select id="ctrl_watermark_store" class="form-control pull-left">
                    <?php foreach( $stores as $store_id => $store_data ) { ?>
                    <option value="<?php echo $store_id; ?>"><?php echo $store_data['name']; ?></option>
                    <?php } ?>
                </select>
                </div>
            </div>
            <div class="panel-body">

                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                    <li><a href="#tab-excludes" data-toggle="tab"><?php echo $tab_excludes; ?></a></li>
                    <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
                    <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                </ul>

                <form action="<?php echo $clean; ?>" method="post" enctype="multipart/form-data" id="form-clean">
                    <input type="hidden" name="dummy" value="0" />
                </form>
                <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
                <div class="tab-content">
                    <div class="tab-pane active" id="tab-general">
                        <?php foreach( $stores as $store_id => $store_data ) { ?>

                        <div class="form-group store store_<?php echo $store_id; ?>" style="display: inline-block; width:100%">
                            <div class="col-sm-5">
                                <label class="control-label" for="ctrl_watermark_status_<?php echo $store_id; ?>"><?php echo $entry_status; ?></label>
                                <br>
                                <?php echo $entry_status_desc; ?>
                            </div>
                            <div class="col-sm-7">
                                <select name="ctrl_watermark_status_<?php echo $store_id; ?>" id="ctrl_watermark_status_<?php echo $store_id; ?>" class="form-control">
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                    <option value="1" <?php if ( ${'ctrl_watermark_status_' . $store_id} ) { ?> selected="selected" <?php } ?> ><?php echo $text_enabled; ?></option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group store store_<?php echo $store_id; ?>" style="display: inline-block; width:100%">
                            <div class="col-sm-5">
                                <label class="control-label" for="draggable-zone"><?php echo $entry_image; ?></label>
                                <br/>
                                <?php echo $entry_watermark_desc; ?>
                            </div>
                            <div class="col-sm-7">
                                <input type="hidden" value="" id="tmp_<?php echo $store_id; ?>"/>
                                <input type="hidden" name="ctrl_watermark_image_<?php echo $store_id; ?>" value="<?php echo ${'ctrl_watermark_image_' . $store_id }; ?>" id="ctrl_watermark_image_<?php echo $store_id; ?>"/>
                                <input type="hidden" name="ctrl_watermark_top_<?php echo $store_id; ?>" value="<?php echo ${'ctrl_watermark_top_' . $store_id }; ?>" id="ctrl_watermark_top_<?php echo $store_id; ?>"/>
                                <input type="hidden" name="ctrl_watermark_left_<?php echo $store_id; ?>" value="<?php echo ${'ctrl_watermark_left_' . $store_id }; ?>" id="ctrl_watermark_left_<?php echo $store_id; ?>"/>
                                <input type="hidden" name="ctrl_watermark_width_<?php echo $store_id; ?>" value="<?php echo ${'ctrl_watermark_width_' . $store_id }; ?>" id="ctrl_watermark_width_<?php echo $store_id; ?>"/>
                                <input type="hidden" name="ctrl_watermark_height_<?php echo $store_id; ?>" value="<?php echo ${'ctrl_watermark_height_' . $store_id }; ?>" id="ctrl_watermark_height_<?php echo $store_id; ?>"/>
                                <input type="hidden" name="ctrl_watermark_angle_<?php echo $store_id; ?>" value="<?php echo ${'ctrl_watermark_angle_' . $store_id }; ?>" id="ctrl_watermark_angle_<?php echo $store_id; ?>"/>
                                <div class="draggable-zone" style="background:url(<?php echo ${'ctrl_watermark_product_image_thumb_' . $store_id} ; ?>) 0 0 no-repeat">
                                    <div class="draggable-wrapper" style="width: <?php echo ${'ctrl_watermark_width_' . $store_id}*3; ?>px; height: <?php echo ${'ctrl_watermark_height_' . $store_id}*3; ?>px; left: <?php echo ${'ctrl_watermark_left_' . $store_id}*3; ?>px; top: <?php echo ${'ctrl_watermark_top_' . $store_id}*3; ?>px;">
                                        <div class="resizable-wrapper">
                                            <img id="ctrl_watermark_image_thumb_<?php echo $store_id; ?>" src="<?php echo ${'ctrl_watermark_image_root_' . $store_id} . 'image/' . ${'ctrl_watermark_image_' . $store_id}; ?>" width="<?php echo ${'ctrl_watermark_width_' . $store_id}*3; ?>" height="<?php echo ${'ctrl_watermark_height_' . $store_id}*3; ?>" alt="Водный знак"/>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top:0.5em;width:300px;text-align: right">
                                    <button type="button" target="ctrl_watermark_image_<?php echo $store_id; ?>" class="button-image btn btn-primary"><i class="fa fa-pencil"></i> <?php echo $text_browse; ?></button>
                                    <button type="button" target="ctrl_watermark_image_<?php echo $store_id; ?>" class="button-clear btn btn-danger"><i class="fa fa-eraser"></i> <?php echo $text_clear; ?></button>
                                </div>
                            </div>
                        </div>
                        <div class="form-group store store_<?php echo $store_id; ?>" style="display: inline-block; width:100%">
                            <div class="col-sm-5">
                                <label class="control-label" for="ctrl_watermark_hide_real_path_<?php echo $store_id; ?>"><?php echo $entry_hide_real_path; ?></label>
                                <br>
                                <?php echo $entry_hide_real_path_desc; ?>
                            </div>
                            <div class="col-sm-7">
                                <select name="ctrl_watermark_hide_real_path_<?php echo $store_id; ?>" id="ctrl_watermark_hide_real_path_<?php echo $store_id; ?>" class="form-control">
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                    <option value="1" <?php if (${'ctrl_watermark_hide_real_path_' . $store_id }) { ?> selected="selected" <?php } ?> ><?php echo $text_enabled; ?></option>
                                </select>
                            </div>
                        </div>

                        <?php } ?>
                    </div>
                    <div class="tab-pane" id="tab-excludes">
                        <?php foreach( $stores as $store_id => $store_data ) { ?>

                        <div class="form-group store store_<?php echo $store_id; ?>" style="display: inline-block; width:100%">
                            <div class="col-sm-5">
                                <label class="control-label"><?php echo $entry_min_size; ?></label>
                                <br/>
                                <?php echo $entry_min_size_desc; ?>
                            </div>
                            <div class="col-sm-7">
                                <label class="control-label" for="ctrl_watermark_min_width_<?php echo $store_id; ?>"><?php echo $text_width; ?></label>
                                <input type="text" name="ctrl_watermark_min_width_<?php echo $store_id; ?>" value="<?php echo ${'ctrl_watermark_min_width_' . $store_id}; ?>" placeholder="<?php echo $text_min_width; ?>" id="ctrl_watermark_min_width_<?php echo $store_id; ?>" class="form-control">
                                <label class="control-label" for="ctrl_watermark_min_height_<?php echo $store_id; ?>"><?php echo $text_height; ?></label>
                                <input type="text" name="ctrl_watermark_min_height_<?php echo $store_id; ?>" value="<?php echo ${'ctrl_watermark_min_height_' . $store_id}; ?>" placeholder="<?php echo $text_min_height; ?>" id="ctrl_watermark_min_height_<?php echo $store_id; ?>" class="form-control">
                            </div>
                        </div>
                        <div class="form-group store store_<?php echo $store_id; ?>" style="display: inline-block; width:100%">
                            <div class="col-sm-5">
                                <label class="control-label"><?php echo $entry_max_size; ?></label>
                                <br/>
                                <?php echo $entry_max_size_desc; ?>
                            </div>
                            <div class="col-sm-7">
                                <label class="control-label" for="ctrl_watermark_max_width"><?php echo $text_width; ?></label>
                                <input type="text" name="ctrl_watermark_max_width_<?php echo $store_id; ?>" value="<?php echo ${'ctrl_watermark_max_width_' . $store_id}; ?>" placeholder="<?php echo $text_max_width; ?>" id="ctrl_watermark_max_width_<?php echo $store_id; ?>" class="form-control">
                                <label class="control-label" for="ctrl_watermark_max_height"><?php echo $text_height; ?></label>
                                <input type="text" name="ctrl_watermark_max_height_<?php echo $store_id; ?>" value="<?php echo ${'ctrl_watermark_max_height_' . $store_id}; ?>" placeholder="<?php echo $text_max_height; ?>" id="ctrl_watermark_max_height_<?php echo $store_id; ?>" class="form-control">
                            </div>
                        </div>
                        <div class="form-group store store_<?php echo $store_id; ?>" style="display: inline-block; width:100%">
                            <div class="col-sm-5">
                                <label class="control-label"><?php echo $entry_exclude; ?></label>
                                <br/>
                                <?php echo $entry_exclude_desc; ?>
                            </div>
                            <div class="col-sm-7">
                                <div class="well well-sm" style="height: 150px; overflow: auto;">
                                    <?php $class = 'odd'; ?>
                                    <?php foreach ($image_directories as $item) { ?>
                                    <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                    <div class="<?php echo $class; ?>">
                                        <input type="checkbox" name="ctrl_watermark_exclude_<?php echo $store_id; ?>[]" value="<?php echo $item['value']; ?>"<?php if (is_array(${'ctrl_watermark_exclude_' .$store_id}) && in_array($item['value'], ${'ctrl_watermark_exclude_' .$store_id})) echo ' checked="checked"'; ?> />
                                        <?php echo $item['text']; ?>
                                    </div>
                                    <?php } ?>
                                </div>
                                <button type="button" onclick="$(this).parent().find(':checkbox').prop('checked', true);" class="btn btn-primary"><i class="fa fa-pencil"></i> <?php echo $text_select_all; ?></button>
                                <button type="button" onclick="$(this).parent().find(':checkbox').prop('checked', false);" class="btn btn-danger"><i class="fa fa-trash-o"></i> <?php echo $text_unselect_all; ?></button>
                            </div>
                        </div>

                        <?php } ?>
                    </div>
                    <div class="tab-pane" id="tab-support">


                        <div class="form-group col-sm-6">
                            <?php echo $module_support; ?>
                            <div class="col-sm-4" >
                                <label class="control-label" for="ctrl_watermark_debug"><?php echo $entry_debug; ?></label>
                                <br>
                                <?php echo $entry_debug_desc; ?>
                            </div>
                            <div class="col-sm-8">
                                <select name="ctrl_watermark_debug" id="ctrl_watermark_debug" class="form-control">
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                    <option value="1" <?php if ($ctrl_watermark_debug) { ?> selected="selected" <?php } ?> ><?php echo $text_enabled; ?></option>
                                </select>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <?php echo $module_promo1; ?>
                        </div>
                        <div class="col-sm-3">
                            <?php echo $module_promo2; ?>
                        </div>
                    </div>
                    <div class="tab-pane" id="tab-license">
                        <?php echo $module_licence; ?>
                    </div>
                </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(window).load(function(){
        var drWr, elem;

        <?php foreach( $stores as $store_id => $store_data ) { ?>

        drWr = $('.store_<?php echo $store_id; ?> .draggable-wrapper');
        elem = $('#ctrl_watermark_image_thumb_<?php echo $store_id; ?>');
        elem.resizable({
                aspectRatio: true,
                handles:     'ne, nw, se, sw'
            });

        $(".store_<?php echo $store_id; ?> .ui-resizable-ne")
                .css("width","20px").css("height","20px").css("right","-10px").css("top","-10px");
        $(".store_<?php echo $store_id; ?> .ui-resizable-nw")
                .css("width","20px").css("height","20px").css("left","-10px").css("top","-10px");
        $(".store_<?php echo $store_id; ?> .ui-resizable-se")
                .removeClass("ui-icon-gripsmall-diagonal-se")
                .removeClass("ui-icon")
                .css("width","20px").css("height","20px").css("right","-10px").css("bottom","-10px");
        $(".store_<?php echo $store_id; ?> .ui-resizable-sw")
                .css("width","20px").css("height","20px").css("left","-10px").css("bottom","-10px");

        drWr.draggable();

        elem.parent().rotatable({
            angle: <?php echo str_replace(",",".",${'ctrl_watermark_angle_' .$store_id } * pi() / 180); ?>
        });

        <?php } ?>
    });

    $('#ctrl_watermark_store').on("change", function(){
        var current = $(this).val();
        $(".store").hide();
        $(".store_" + current).show();
    }).trigger("change");

    <?php foreach( $stores as $store_id => $store_data ) { ?>

    $('.store_<?php echo $store_id; ?> .button-image').on('click', function() {
        $('#modal-image').remove();

        $('#tmp_<?php echo $store_id; ?>').val("").attr('target',$(this).attr('target'));
        $.ajax({
            url: 'index.php?route=common/filemanager&token=' + getURLVar('token') + '&target=tmp_<?php echo $store_id; ?>',
            dataType: 'html',
            beforeSend: function() {
                $('.store_<?php echo $store_id; ?> .button-image i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
                $('.store_<?php echo $store_id; ?> .button-image').prop('disabled', true);
            },
            complete: function() {
                $('.store_<?php echo $store_id; ?> .button-image i').replaceWith('<i class="fa fa-upload"></i>');
                $('.store_<?php echo $store_id; ?> .button-image').prop('disabled', false);
                $('#modal-image').on('hide.bs.modal', function(){
                    if( $('#tmp_<?php echo $store_id; ?>').val() != "") {
                        var target = $('#tmp_<?php echo $store_id; ?>').attr('target');
                        $("#" + target).val($('#tmp_<?php echo $store_id; ?>').val());

                        if( target == 'ctrl_watermark_image_<?php echo $store_id; ?>') {

                            $.ajax({
                              url: 'index.php?route=module/ctrl_watermark/getImgSize&token=<?php echo $token; ?>',
                              data: "src=" + $("#tmp_<?php echo $store_id; ?>").val(),
                              type: 'post',
                              dataType: 'json',
                              success: function(json) {   
                                    var rate, width, height;

                                    if (json["size"][0] > 130 || json["size"][1] > 130)
                                    {
                                        rate = (json["size"][0] > json["size"][1]) ? (json["size"][0]/130) : (json["size"][1]/130);
                                        width = Math.round(json["size"][0]/rate);
                                        height = Math.round(json["size"][1]/rate);
                                    }
                                    else
                                    {
                                        width = json["size"][0];
                                        height = json["size"][1];
                                    }

                                    $('#ctrl_watermark_image_thumb_<?php echo $store_id; ?>').css("width", width).css("height", height);
                                    $('.store_<?php echo $store_id; ?> .draggable-wrapper_<?php echo $store_id; ?>').css("width", width).css("height", height);
                                    $('.store_<?php echo $store_id; ?> .ui-wrapper').css("width", width).css("height", height);
                              }
                            });

                            $('#ctrl_watermark_image_thumb_<?php echo $store_id; ?>').attr('src', '<?php echo ${'ctrl_watermark_image_root_' . $store_id}; ?>image/' + $('#tmp_<?php echo $store_id; ?>').val());
                        } else if ( target == 'ctrl_watermark_product_image_<?php echo $store_id; ?>' ) {
                            $.ajax({
                                url: 'index.php?route=module/ctrl_watermark/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#tmp_<?php echo $store_id; ?>').val()),
                                dataType: 'text',
                                success: function(data) {
                                    $('.store_<?php echo $store_id; ?> .draggable-zone').css('background-image','url(' + data + ')');
                                }
                            });
                        }

                    }
                });
            },
            success: function(html) {
                $('body').append('<div id="modal-image" class="modal">' + html + '</div>');

                $('#modal-image').modal('show');
            }
        });
    });

    <?php } ?>

    <?php foreach( $stores as $store_id => $store_data) { ?>

    $('.store_<?php echo $store_id; ?> .button-clear').on('click', function() {
        $("#ctrl_watermark_image_thumb_<?php echo $store_id; ?>")
                .attr('src', '/image/<?php echo ${'ctrl_watermark_default_image_' . $store_id}; ?>')
                .css("width", <?php echo ${'ctrl_watermark_default_image_width_' . $store_id}*3; ?>)
                .css("height", <?php echo ${'ctrl_watermark_default_image_height_' . $store_id}*3; ?>);

        $(".store_<?php echo $store_id; ?> .draggable-wrapper")
                .css("left", <?php echo ${'ctrl_watermark_default_image_left_' . $store_id}*3; ?>)
                .css("top", <?php echo ${'ctrl_watermark_default_image_top_' . $store_id}*3; ?>)
                .css("width", <?php echo ${'ctrl_watermark_default_image_width_' . $store_id}*3; ?>)
                .css("height", <?php echo ${'ctrl_watermark_default_image_height_' . $store_id}*3; ?>);

        $(".store_<?php echo $store_id; ?> .ui-wrapper")
                .css("left", "auto")
                .css("top", "auto")
                .css("width", <?php echo ${'ctrl_watermark_default_image_width_' . $store_id}*3; ?>)
                .css("height", <?php echo ${'ctrl_watermark_default_image_height_' . $store_id}*3; ?>)
                .rotatable("angle",<?php echo str_replace(",",".",${'ctrl_watermark_default_image_angle_' . $store_id} * pi() / 180); ?> );

        $("#ctrl_watermark_image_<?php echo $store_id; ?>").val('<?php echo ${'ctrl_watermark_default_image_' . $store_id}; ?>');
        $("#ctrl_watermark_left_<?php echo $store_id; ?>").val(<?php echo ${'ctrl_watermark_default_image_left_' . $store_id}; ?>);
        $("#ctrl_watermark_top_<?php echo $store_id; ?>").val(<?php echo ${'ctrl_watermark_default_image_top_' . $store_id}; ?>);
        $("#ctrl_watermark_width_<?php echo $store_id; ?>").val(<?php echo ${'ctrl_watermark_default_image_width_' . $store_id}; ?>);
        $("#ctrl_watermark_height_<?php echo $store_id; ?>").val(<?php echo ${'ctrl_watermark_default_image_height_' . $store_id}; ?>);
        $("#ctrl_watermark_angle_<?php echo $store_id; ?>").val(<?php echo ${'ctrl_watermark_default_image_angle_' . $store_id}; ?>);
    });

    <?php } ?>

    function beforeSave(){
        var angle = 0;
        <?php foreach( $stores as $store_id => $store_data) { ?>

        angle = ( $(".store_<?php echo $store_id; ?> .ui-wrapper").rotatable("ui").angle.current * 180 ) / Math.PI;
        if( !angle)
            angle = 0;
        while( angle < 0 )
            angle += 360;
        while( angle >= 360 )
            angle -= 360;
        $("#ctrl_watermark_angle_<?php echo $store_id; ?>").val(
                Math.ceil(angle));
        $("#ctrl_watermark_width_<?php echo $store_id; ?>").val(
                Math.ceil($(".store_<?php echo $store_id; ?> .resizable-wrapper .ui-wrapper").css('width').replace(/[^0-9]/gi,"") / 3 ) );
        $("#ctrl_watermark_height_<?php echo $store_id; ?>").val(
                Math.ceil($(".store_<?php echo $store_id; ?> .resizable-wrapper .ui-wrapper").css('height').replace(/[^0-9]/gi,"") / 3 ) );
        $("#ctrl_watermark_left_<?php echo $store_id; ?>").val(
                Math.ceil( ( Number( $(".store_<?php echo $store_id; ?> .draggable-wrapper").css('left').replace(/[^\-\.0-9]/gi,"") ) +
                Number( $(".store_<?php echo $store_id; ?> .ui-wrapper").css('left').replace(/[^\-\.0-9]/gi,"") ) ) / 3 ) );
        $("#ctrl_watermark_top_<?php echo $store_id; ?>").val(
                Math.ceil( ( Number( $(".store_<?php echo $store_id; ?> .draggable-wrapper").css('top').replace(/[^\-\.0-9]/gi,"") ) +
                             Number( $(".store_<?php echo $store_id; ?> .ui-wrapper").css('top').replace(/[^\-\.0-9]/gi,"") ) ) / 3 ) );
        <?php } ?>
        return true;
    }

</script>

<?php echo $footer; ?>