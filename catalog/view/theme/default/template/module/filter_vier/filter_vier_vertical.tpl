<?php if($hiden) {
		//setting
        //ajax
        $ajax_err = true;
        if($clear_sl = !$ajax_filter) {
            $clear_sl = true;
        }
        //css
		$css_through = 'text-through';
        //animal-speed
        $animal_blok = 1000;
        /*arrow*/
        $cls_strel_hid = 'fa';
        
        //$cls_hiden = 'fa-angle-down';
        //$cls_visit = 'fa-angle-up';

        $cls_hiden = 'fas fa-plus';
        $cls_visit = 'fas fa-minus';
        
        $strel_hid = '<span class="strel_hid_fa"><i class="fa '.$cls_hiden.'" aria-hidden="true"></i></span>';
        $strel_vis = '<span class="strel_hid_fa"><i class="fa '.$cls_visit.'" aria-hidden="true"></i></span>';
        
        $shabl_title = '<span class="title_p_f">%2$s</span> %1$s';
        //$shabl_title = '%1$s <span class="title_p_f">%2$s</span>';
        
        $cls_hiden1 = 'fa-caret-right';
        $cls_visit1 = 'fa-caret-down';
        $unfoldi_hid = '<span class="strel_hid_fa"><i class="fa '.$cls_hiden1.'" aria-hidden="true"></i></span>';
        $unfoldi_vis = '<span class="strel_hid_fa"><i class="fa '.$cls_visit1.'" aria-hidden="true"></i></span>';
        $displ_unfoldi = '<p class="displ"><span class="unfoldi">'.$legend_more.$unfoldi_hid.'</span></p>';
        
        //botton_filter
        $arrow_bott_filt_vis = 'fa-angle-down';
        $arrow_bott_filt_hid = 'fa-angle-up';
        
        $shabl_bott_filt = '%2$s <span class="arrow_n_f">%1$s</span>';
        
        $strel_arrow_bott_filt = '<span class="strel_fa_mob"><i class="fa '.$arrow_bott_filt_vis.'" aria-hidden="true"></i></span>';
        /*end arrow*/
		$css_hide_text = 'hidis';
        $css_curs_point = 'curs_point';
        $css_scrl_text = 'scropis';
        $css_nulz_text = 'null';
        $css_bloc_slid = 'slid';
		$position_hide = $position_set;
        
        $a_rel_nf = 'rel="nofollow"';
        $txt_nofollow = ($noindex_rel) ? $a_rel_nf : null;
        //$txt_nofollow_pp = ($noindex_rel_nopp) ? null : $a_rel_nf;
        $arr_pz = array('qnts','nows','psp');
        $cls_act = 'actionis';
        $cls_no_src = 'no_src';
        
        //$action_get_del = '<span class="delis"><i class="fa fa-times" aria-hidden="true"></i></span>';
        $action_get_del = '<span class="delis">&times;</span>';
        
        //links
        $link_js = 'onclick="javascript:location=\'%1$s\'"';
        if($ajax_filter) {$link_js = '';}
        $link_html = 'href="%1$s"';
        $suff = '_html';
        $href_link_del = ${'link'.$suff};
        if($url_js) {$suff = '_js';}
        $href_link = ${'link'.$suff};

        /*style botton*/
        //$cls_btn = 'btn-default';
        $cls_btn = 'btn_fv';
        //$forms_total = '<span class="total_product '.$cls_btn.' count_%2$d">%1$s</span>';
        $forms_total = '<span class="text-through count_%2$d"> (%1$s)</span>';
?>
<?php echo $start_bloc; ?>
<!--/**
 * <?php echo $versi_module.'; '.$cntr.' sec: '.(microtime(true) - $sec); ?>
 **/-->
  <!-- name_filter -->
  <?php if(!empty($name_filter)) { ?>
  <div id="name_filter"><div id="head_filter" class="heading-title"><?php echo sprintf($shabl_bott_filt, $strel_arrow_bott_filt, $name_filter); ?></div></div>
  <?php } ?>
  <!-- / name_filter -->
  <div id="ajx_bloc_filter"></div>
  <div class="box-content">
    <div id="filter_vier">
    <?php foreach($view_posit as $view_get => $view_val) {
            if($view_get == 'chc') { // choice ?>
            <?php if(!empty($view_chc)) {
                    if(!empty($get_url_action)) { ?>
                <div id="action_get" class="block-fv <?php echo $view_get; ?>">
                    <div class="tec_vibor">
                        <p class="title-filter"><?php echo $legend_choice; ?> 
                            <span class="text_dia"><a <?php echo $a_rel_nf; ?> href="<?php echo $clear_filter; ?>"> <?php echo $legend_clears; ?></a></span>
                        </p>
                        <div class="clears"></div>
                        <?php if(!$mini_sel) {
                                foreach($get_url_action as $acti_gets) {
                                    foreach($acti_gets as $key => $acti_get) {
                                        $displ = null; if(empty($acti_get[key($acti_get)]['text'])){$displ = 'style="display: inline-block;"';} ?>
                                    <div class="onli_param_get">
                                    <p class="legend_get_url" <?php echo $displ; ?>><?php echo $acti_get[key($acti_get)]['legend']; ?></p>
                                    <?php foreach($acti_get as $action_get) {
                                            $action_get_text = $action_get['text']; ?>
                                        <span class="botton_fv <?php echo $cls_btn; ?>"><a <?php echo $a_rel_nf; ?> class="checkg active" href="<?php echo $action_get['del']; ?>" title="<?php echo $legend_remove_position; ?> <?php echo $action_get_text; ?>"><span><?php echo $action_get_text; ?></span><?php echo $action_get_del; ?></a></span>
                                    <?php } ?>
                                    </div>
                                <?php } ?>
                            <?php } ?>
                        <?php } ?>
                    </div>
                </div>
                <?php } ?>
            <?php } // / choice ?>
        <?php } elseif(in_array($view_get, $arr_pz)) { // qnts,nows,psp ?>
            <?php $main_id = 1; $param_id = 0; $pz = $view_get; if(!empty(${'view_'.$pz})) {
                    $rel_nf = (isset($canonic_view[$pz])) ? $a_rel_nf : null; 
                    if($noindex_rel_nopp) {
                        $rel_nf =  $a_rel_nf;
                        if(${'view_'.$pz}['blok_noindex']) {
                            $rel_nf = null;
                        }
                    }
                    ?>
            <div class="block-fv <?php echo $view_get; ?> qnp">
                <div class="onli_param no_ram">
                <?php $total_all = null; if($flag_count[$pz]) { $total_all = sprintf($forms_total, ${'view_'.$pz}['total'], ${'view_'.$pz}['total_css']); }
                    $text_through = $cls_act;
                    if(${'view_'.$pz}['action']) { if(${'view_'.$pz}['total'] == 0) {$text_through = $css_through;}
                            $href = sprintf($href_link_del, ${'view_'.$pz}['del_href']);
                ?>
                    <p class="<?php echo $text_through; ?>"><label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="checka active" <?php echo $href; ?> title="<?php echo $legend_remove_position; ?>"><?php echo ${'legend_'.$pz}; ?></a></label></p>
                    <?php } elseif(${'view_'.$pz}['total'] == 0) { ?>
                    <p class="text-through"><a class="checkb curs_def"><?php echo ${'legend_'.$pz}; echo $total_all; ?></a></p>
                    <?php } else { ?>
                    <?php 
                        $href = sprintf($href_link, ${'view_'.$pz}['href']);
                    ?>
                    <p><label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="checkb" <?php echo $href; ?> ><?php echo ${'legend_'.$pz}; echo $total_all; ?></a></label></p>
                <?php } ?>
                </div>
            </div>
            <?php } // / qnts,nows,psp  ?>
        <?php } elseif($view_get == 'prs') { // prices ?>
            <?php if($view_prs || $slider_status) {
                    $main_id = 1;
                    //position
                    $strelka = null;
                    $css_nulz = null;
                    $css_hide = null;
                    $text_curs = null;
                    if($null_position_prs) {
                        $strelka = ($action_prs) ? $strel_vis : $strel_hid;
                        $css_hide = ' '.$css_hide_text;
                        $css_nulz = ' '.$css_nulz_text;
                        $text_curs = $css_curs_point;
                    }
                    $text_title = $legend_price;
                    $es_sl = false; $act_sl = null; 
                    if($action_prs) { $es_sl = true; $act_sl = ' active'; $css_hide = null; }
            ?>
            <div class="block-fv <?php echo $view_get; ?>">
                <div class="block_param">
                    <p class="title-filter <?php echo $text_curs; ?>"><?php echo sprintf($shabl_title, $strelka, $text_title); ?></p>
                    <div class="onli_param slid<?php echo $css_nulz, $css_hide;//, $css_scrl ?>">
            <?php if($slider_status) { // slider_price ?>
                        <div class="slider_attr">
                            <table class="width_100_pr input_slider">
                                <tr>
                                    <td><input name="prs[min]" id="left_count" class="form-control" type="text" value=""/></td>
                                    <td class="symbol_sld"><?php if(!$del_symbol) { ?>
                                    <span><?php echo $symbol; ?></span>
                                    <?php } ?></td>
                                    <td><input name="prs[max]" id="right_count" class="form-control" type="text" value=""/></td>
                                </tr>
                            </table>
                            <div>
                                <input class="attrb_sl" type="text" id="price_slider" value="" />
                                <input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="" /><span class="slidez<?php echo $act_sl; ?>"></span>
                            </div>
                            <div class="height_prim">
                                <table class="width_100_pr">
                                    <tr>
                                        <td id="cler_prs"><?php if($es_sl && $clear_sl) { ?><span class="text_clears"><a class="clear_slider" href="<?php echo $base_prs['del_href']; ?>"><?php echo $legend_clears; ?></a></span><?php } ?></td>
                                        <?php if(!$ajax_filter) { ?>
                                        <td><div class="button_attr"><input type="button" id="button_price" <?php echo $base_prs['bloc_slider']; ?> class="<?php echo $cls_btn; ?> bot_filt" value="<?php echo $legend_apply; ?>" /></div></td>
                                        <?php } ?>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <script>
                            $(document).ready(function(){
                                var $cler_sl = $('#cler_prs')
                                    <?php if(!$ajax_filter) { ?>
                                    ,$button_sld = $('#button_price')
                                    <?php } ?>
                                    ,razdelit = '<?php echo $delit_param; ?>'
                                    ,c_price = ''
                                    ,get_main_bloc = '<?php echo $view_get.'['.$main_id.']'; ?>'
                                    ,flag_es_sl = <?php echo ($es_sl) ? 'true' : 'false'; ?>
                                    ,$rangeSld = $("#price_slider")
                                    ,$from = $("#left_count")
                                    ,$to = $("#right_count")
                                    ,clear_slider = false
                                    ,range_sld
                                    <?php foreach($base_prs['arr_view'] as $v) {
                                        echo ','.$v.' = '.$base_prs[$v];
                                    } ?>
                                    ,disable = <?php echo $base_prs['disable']; ?>
                                    ,input_values_separator = razdelit
                                    ,step = '<?php echo $base_prs['step']; ?>'
                                    ,symbol = '<?php echo $symbol; ?>'
                                    ,grid = <?php echo $base_prs['grid']; ?>;
                                
                                $from.attr('value', from);
                                $to.attr('value', to);
                                var updateValues = function () {
                                    if(isNaN(from)) {
                                        from = min;
                                    }
                                    if(isNaN(to)) {
                                        to = max;
                                    }
                                    $from.prop("value", from);
                                    $to.prop("value", to);
                                };
                                
                                $rangeSld.ionRangeSlider({
                                    type: 'double'
                                    ,hide_min_max: true
                                    ,hide_from_to: true
                                    //,hide_from_to: false
                                    ,input_values_separator: input_values_separator
                                    ,keyboard: true
                                    ,force_edges: true
                                    ,disable: disable
                                    ,from: from
                                    ,to: to
                                    ,min: min
                                    ,max: max
                                    ,step: step
                                    ,grid: grid
                                    //,grid_num: 5
                                    //,grid_snap: true
                                    //,prefix: symbol
                                    //,postfix: symbol
                                    //,values: values
                                    //,prettify_enabled: false
                                    <?php if($ajax_filter) { ?>
                                    ,onStart: function() {
                                        var temp_param = corectPrice('-', '');
                                        $rangeSld.next('input').attr('value', temp_param);
                                    }
                                    ,onFinish: function() {
                                        var temp_param = corectPrice('-', '');
                                        getDataPoles($rangeSld, $cler_sl, temp_param, get_main_bloc, clear_slider);
                                    }
                                    ,onUpdate: function() {
                                        var temp_param = corectPrice('-', '');
                                        getDataPoles($rangeSld, $cler_sl, temp_param, get_main_bloc, clear_slider);
                                    }
                                    <?php } ?>
                                    ,onChange: function (data) {
                                        from = data.from;
                                        to = data.to;
                                        updateValues();
                                    }
                                });
                                
                                <?php if($ajax_filter) { ?>
                                $cler_sl.on('click', 'a', function(e) {
                                    e.preventDefault();
                                    var slider = $rangeSld.data("ionRangeSlider");
                                    slider.reset();
                                    $from.val(slider.old_from);
                                    $to.val(slider.old_to);
                                    $cler_sl.empty();
                                    $rangeSld.next('input').attr('value', '').next('.slidez').removeClass('active');
                                    actionGet();
                                });
                                <?php } ?>
                                
                                range_sld = $rangeSld.data("ionRangeSlider");
                                var updateRange = function () {
                                    range_sld.update({
                                        from: from,
                                        to: to
                                    });
                                };
                                $from.on("change", function () {
                                    from = +$(this).prop("value");
                                    if (from < min) {
                                        from = min;
                                    }
                                    if (from > to) {
                                        from = to;
                                    }
                                    updateValues();
                                    updateRange();
                                });
                                $to.on("change", function () {
                                    to = +$(this).prop("value");
                                    if (to > max) {
                                        to = max;
                                    }
                                    if (to < from) {
                                        to = from;
                                    }
                                    updateValues();
                                    updateRange();
                                });

                                function corectPrice(razdelit, c_price) {
                                    var curs_tax = <?php echo $base_prs['tec_curs_tax']; ?>;
                                    var decimal_tec = <?php echo $decimal_tec; ?>;
                                    var correct_curs = 0;
                                    if(decimal_tec == 0) {
                                        if(curs_tax != 1) {
                                            decimal_tec = 2;
                                        }
                                        if(curs_tax < 1) {
                                            correct_curs = 0.0499;
                                        }
                                    }
                                    var shz = /\./g;
                                    var val_attrbs = $rangeSld.val();
                                    var all_min_max_prs = '';
                                    var arr_atrb = val_attrbs.split('-');
                                    if((arr_atrb[0] !== undefined) && (arr_atrb[1] !== undefined)) {
                                        var pr_min = arr_atrb[0];
                                        var pr_max = arr_atrb[1];
                                        if(pr_min === pr_max) {
                                            all_min_max_prs = ((pr_min / curs_tax - correct_curs).toFixed(decimal_tec));
                                        }
                                        else {
                                            var pr_min_tax = ((pr_min / curs_tax - correct_curs).toFixed(decimal_tec));
                                            var pr_max_tax = ((pr_max / curs_tax + correct_curs).toFixed(decimal_tec));
                                            all_min_max_prs = pr_min_tax + razdelit + pr_max_tax;
                                        }
                                        if(c_price) {
                                            all_min_max_prs = all_min_max_prs.replace(shz, c_price);
                                        }
                                    }
                                    return all_min_max_prs;
                                }
                                <?php if(!$ajax_filter) { ?>
                                    <?php if($base_prs['seo_url']) { ?>
                                    razdelit = '<?php echo $separators[1]; ?>';
                                    c_price = '<?php echo $cent_delit; ?>';
                                    <?php } ?>
                                    $button_sld.on('click', function() {
                                        var all_min_max_prs = corectPrice(razdelit, c_price);
                                        if(all_min_max_prs) {
                                            var shabl = '<?php echo $base_prs['shabl']; ?>';
                                            var slidery_u = '<?php echo $base_prs['href']; ?>'.replace(shabl, all_min_max_prs);
                                            otpravUrl(corrUrl(slidery_u));
                                        }
                                    });
                                <?php } ?>
                            });
                        </script>
            <?php } else { // end slider_price, start link price
                    $rel_nf = ($null_position_prs) ? $txt_nofollow : null;
                    foreach($view_prs as $prs) {
                        $total_all = null;
                        if($noindex_rel_nopp) {
                            $rel_nf =  $a_rel_nf;
                            if(${$view_get}['blok_noindex']) {
                                $rel_nf = null;
                            }
                        }
                        if($flag_count[$view_get]) { $total_all = sprintf($forms_total, $prs['total'], $prs['total_css']); }
                        $text_through = $cls_act;
                        $param_id = $prs['start'].'-'.$prs['end'];
                        if($prs['action']) {
                            if($prs['total'] == 0) {$text_through = $css_through;}
                            if($prs['temp_action']) {
                ?>
                    <p class="text-through"><a class="checka curs_def"><?php echo $prs['text']; ?></a></p>   
                        <?php } else { 
                            $href = sprintf($href_link_del, ${$view_get}['del_href']);
                        ?>
                    <p class="<?php echo $text_through; ?>"><label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="checka active" <?php echo $href; ?> title="<?php echo $legend_remove_position; ?>"><?php echo $prs['text']; ?></a></label></p>    
                        <?php } ?>
                    <?php } elseif($prs['total'] == 0) { ?>
                    <p class="text-through"><a class="checkb curs_def"><?php echo $prs['text']; echo $total_all; ?></a></p>
                    <?php } else { 
                        $href = sprintf($href_link, ${$view_get}['href']);
                    ?>
                    <p><label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="checkb" <?php echo $href; ?>><?php echo $prs['text']; echo $total_all; ?></a></label></p>
                    <?php } ?>
                <?php } ?>
        <?php } ?>
                    </div>
                </div>
            </div>
            <?php } // / prices ?>
        <?php } elseif($view_get == 'attrb') { //attributes ?>
            <?php if(!empty($view_attrb)) { ?>
            <div class="block-fv <?php echo $view_get; ?>">
                <?php if(!empty($legend_attr)) { ?>
                    <p class="ligendis"><?php echo $legend_attr; ?></p>
                <?php }
                    foreach($view_attrb as $k_id_group => $attributes) {
                        if($attributes['group_view']) { ?>
                        <p class="groupis name_group_attr"><?php echo $attributes['group_view']; ?></p>
                        <?php }
                        foreach($attributes['data'] as $k_attr => $attribute) {
                            $strelka = null;
                            $css_hide = null;
                            $text_curs = null;
                            $css_nulz = null;
                            $css_bloc = null;
                            $main_id = $attribute['main_id'];
                            $flag_slider = $attribute['slider'];
                            $flag_botton = $attribute['button'];
                            $position_hide = ($null_position = $attribute['null_position']) ? 0 : $position_set;
                            if($attributes['flag_group']) {
                                $id_attrb = 'gr_attrb_'.$k_id_group;
                            }
                            else {
                                $id_attrb = 'attrb_'.$main_id;
                            }
                            if($null_position) {
                                $text_curs = $css_curs_point;
                                $strelka = $strel_hid;
                                $css_hide = ' '.$css_hide_text;
                                //bloc_hide
                                if($attributes['action_gr'] || $attributes['action'][$main_id]) {
                                    $css_hide = null;
                                    $strelka = $strel_vis;
                                }
                                //end bloc_hide
                                $css_nulz = ' '.$css_nulz_text;
                                if(!$css_hide) {
                                    $css_nulz = null;
                                    $position_hide = $position_set;
                                }
                            }
                            if($flag_slider) {
                                $css_bloc = ' '.$css_bloc_slid;
                                if(isset($slider_attr[$main_id])) {
                                    $base_sl = $slider_attr[$main_id];
                                    $in_sl = 'attrb_sl_'.$main_id; $bt_sl = 'bt_sl_'.$main_id; $cler_sl = 'cler_sl_'.$main_id;
                                    $es_sl = false;
                                    $act_sl = null;
                                    if($base_sl['del_href']) {
                                        $css_hide = null;
                                        if($null_position) {$strelka = $strel_vis;}
                                        $es_sl = true;
                                        $act_sl = ' active';
                                    }
                                }
                            }
                            $img_fv = null; if($flag_botton) { $img_fv = ' img_fv';}
                            $text_title = $attribute['name']; ?>
                    <div class="block_param">
                        <p id="<?php echo $id_attrb; ?>" class="title-filter <?php echo $text_curs; ?>"><?php echo sprintf($shabl_title, $strelka, $text_title); ?></p>
                        <?php $es_next = false; $count_text = $attribute['count_param']; $css_scrl = ($scroll_item && !$css_bloc && ($count_text > $blok_item)) ? ' '.$css_scrl_text : null; ?>
                        <div class="onli_param<?php echo $css_nulz, $css_bloc, $css_hide , $css_scrl, $img_fv; ?>">
                    <?php if($flag_slider) { // slider_attrib ?>
                        <div class="slider_attr">
                            <div>
                                <input class="attrb_sl" type="text" id="<?php echo $in_sl; ?>" value="" />
                                <input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $base_sl['val_get']; ?>" /><span class="slidez<?php echo $act_sl; ?>"></span>
                            </div>
                            <div class="height_prim">
                                <table class="width_100_pr">
                                    <tr>
                                        <td id="<?php echo $cler_sl; ?>"><?php if($es_sl && $clear_sl) { ?><span class="text_clears"><a class="clear_slider" href="<?php echo $base_sl['del_href']; ?>"><?php echo $legend_clears; ?></a></span><?php } ?></td>
                                        <?php if(!$ajax_filter) { ?>
                                        <td><div class="button_attr"><input type="button" id="<?php echo $bt_sl; ?>" <?php echo $base_sl['bloc_slider']; ?> class="<?php echo $cls_btn; ?> bot_filt" value="<?php echo $legend_apply; ?>" /></div></td>
                                        <?php } ?>
                                    </tr>
                                </table>
                                <div class="clears"></div>
                            </div>
                        </div>
                        <script>
                            $(function () {
                                var $cler_sl = $('#<?php echo $cler_sl; ?>')
                                    <?php if(!$ajax_filter) { ?>
                                    ,$button_sld = $('#<?php echo $bt_sl; ?>')
                                    <?php } ?>
                                    ,legend_clears = '<?php echo $legend_clears; ?>'
                                    ,get_main_bloc = '<?php echo $view_get.'['.$main_id.']'; ?>'
                                    ,clear_slider = false
                                    ,$rangeSld = $("#<?php echo $in_sl; ?>")
                                    ,from = <?php echo $base_sl['from']; ?>
                                    ,to = <?php echo $base_sl['to']; ?>
                                    ,disable = <?php echo $base_sl['disable']; ?>
                                    ,separ = '<?php echo $base_sl['separ']; ?>'
                                    ,grid = <?php echo $base_sl['hide_values']; ?>
                                    ,values = <?php echo $base_sl['values']; ?>;
                                
                                $rangeSld.ionRangeSlider({
                                    type: 'double'
                                    ,hide_min_max: true
                        			,hide_from_to: false
                                    ,input_values_separator: separ
                                    ,keyboard: true
                                    ,force_edges: true
                                    ,disable: disable
                                    ,from: from
                                    ,to: to
                                    //,step: 1
                                    //,prefix: "$"
                                    //,postfix: ""
                                    ,values: values
                                    ,grid: grid
                                    ,extra_classes: 'sld_attr <?php echo $bt_sl; ?>'
                                    //,grid_margin: false
                                    //,grid_snap: true
                                    //,grid_num: 10
                                    //,prettify_enabled: false
                                    <?php if($ajax_filter) { ?>
                                    ,onFinish: function(data) {
                                        var temp_param = data.from_value+'-'+data.to_value;
                                        getDataPoles($rangeSld, $cler_sl, temp_param, get_main_bloc, clear_slider);
                                    }
                                    <?php } ?>
                                });
                                <?php if($ajax_filter) { ?>
                                $cler_sl.on('click', 'a', function(e) {
                                    e.preventDefault();
                                    var slider = $rangeSld.data("ionRangeSlider");
                                    slider.reset();
                                    $cler_sl.empty();
                                    $rangeSld.next('input').attr('value', '').next('.slidez').removeClass('active');
                                    actionGet();
                                });
                                <?php } else { ?>
                                $button_sld.on('click', function() {
                                    var shabl = '<?php echo $shabl.$main_id ?>';
                                    var val_attrbs = $("#<?php echo $in_sl; ?>").val();
                                    var arr_atrb = val_attrbs.split(separ);
                                    if((arr_atrb[0] !== undefined) && (arr_atrb[1] !== undefined)) {
                                        if(arr_atrb[0] === arr_atrb[1]) {
                                            val_attrbs = arr_atrb[0];
                                        }
                                    }
                                    <?php if($base_sl['seo_url']) { ?>
                                    var shz = /\./g;
                                    val_attrbs = val_attrbs.replace(shz, '<?php echo $cent_delit; ?>');
                                    <?php } ?>
                                    var slidery_u = '<?php echo $base_sl['href']; ?>'.replace(shabl, val_attrbs);
                                    otpravUrl(corrUrl(slidery_u));
                                });
                                <?php } ?>
                            });
                        </script>
                <?php } else {  // end slider_attrib
                        $i=0;
                        foreach($attribute['param'] as $attrb) {
                            $main_id = $attrb['main_id'];
                            $name_text = $attrb['text'];
                            $param_id = $attrb['param_id'];
                            $rel_nf = ($null_position) ? $txt_nofollow : null;
                            if($noindex_rel_nopp) {
                                $rel_nf =  $a_rel_nf;
                                if($attrb['blok_noindex']) {
                                    $rel_nf = null;
                                }
                            }
                            if($attrb['button']) { ?>
                    <div class="botton_opts">
                        <?php  if($attrb['action']) { 
                            $href = sprintf($href_link_del, ${$view_get}['del_href']);
                        ?>
                        <label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="non_decor active" <?php echo $href; ?> title="<?php echo $legend_remove_position; ?> <?php //echo $name_text; ?>"><p class="kvadrat tec_attr <?php echo $cls_btn; ?>"><?php echo $name_text;?></p></a></label>
                        <?php } elseif($attrb['total'] == 0) { ?>
                        <a class="non_decor curs_def"><p class="kvadrat kvadrat_null <?php echo $cls_btn; ?>"><?php echo $name_text; ?></p></a>
                        <?php }  else { 
                            $href = sprintf($href_link, ${$view_get}['href']);
                        ?>
                        <label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="non_decor" <?php echo $href; ?> title="<?php //echo $name_text; ?>"><p class="kvadrat <?php echo $cls_btn; ?>"><?php echo $name_text; ?></p></a></label>
                        <?php } ?>
                    </div>
                    <?php } else {
                            $total_all = null; if($flag_count[$view_get]) { $total_all = sprintf($forms_total, $attrb['total'], $attrb['total_css']); }
                            $view_next = null;
                            if(!$css_nulz) {
                                $view_next = ($i === $position_hide) ? $displ_unfoldi : null;
                                if($view_next) {
                                    $es_next = true;
                                }
                            }
                            if($view_next) { echo $view_next; ?>
                        <div class="skrit <?php echo $css_hide_text; ?>">
                        <?php } ?>
                        <?php $text_through = $cls_act; 
                            if($attrb['action']) { 
                                if($attrb['total'] == 0) {$text_through = $css_through;}
                                $href = sprintf($href_link_del, ${$view_get}['del_href']);
                        ?>
                        <p class="<?php echo $text_through; ?>"><label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="checka active" <?php echo $href; ?> title="<?php echo $legend_remove_position; ?>"><?php echo $name_text; ?></a></label></p>
                        <?php } elseif($attrb['total'] == 0) { ?>
                        <p class="text-through"><a class="checkb curs_def"><?php echo $name_text; echo $total_all ?></a></p>
                        <?php } else {
                            $href = sprintf($href_link, ${$view_get}['href']);
                        ?>
                        <p><label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="checkb" <?php echo $href; ?>><?php echo $name_text; echo $total_all ?></a></label></p>
                        <?php } ?>
                        <?php if($es_next && ($i === ($count_text-1))) { ?>
                        </div>
                        <?php } ?>
                    <?php } ?>
                    <?php $i++; ?>  
                <?php  }
                     } ?>
                    </div>
                </div>
            <?php } ?>
        <?php } ?>
            </div>
            <?php } // end attributes ?>           
        <?php } elseif($view_get == 'optv') { //options ?>
            <?php if(!empty($view_optv)) { ?>
            <div class="block-fv <?php echo $view_get; ?>">
                <?php if(!empty($legend_option)) { ?>
                    <p class="ligendis"><?php echo $legend_option; ?></p>
                <?php } ?>
            <?php foreach($view_optv as $option) { ?>
                <div class="block_param">
                    <?php
                        $main_id = $option['main_id'];
                        $position_hide = ($null_position = $option['null_position']) ? 0 : $position_set;
                        //position
                        $strelka = null;
                        $css_nulz = null;
                        $css_hide = null;
                        $text_curs = null;
                        $rel_nf = ($null_position) ? $txt_nofollow : null;
                        if($null_position) {
                            $text_curs = $css_curs_point;
                            $strelka = $strel_hid;
                            $css_hide = ' '.$css_hide_text;
                            //bloc_hide
                            if($option['action']) {
                                $css_hide = null;
                                $strelka = $strel_vis;
                            }
                            //end bloc_hide
                            $css_nulz = ' '.$css_nulz_text;
                            if(!$css_hide) {
                                $css_nulz = null;
                                $position_hide = $position_set;
                            }
                        }
                        $flag_image = $option['flag_image'];
                        $img_fv = ($flag_image || $view_button_opt) ? ' img_fv' : null;
                        $text_title = $option['name'];
                    ?>
                    <p class="title-filter <?php echo $text_curs; ?>"><?php echo sprintf($shabl_title, $strelka, $text_title); ?></p>
                    <?php $es_next = false; $count_text = $option['count_param']; $css_scrl = ($scroll_item && ($count_text > $blok_item)) ? ' '.$css_scrl_text : null; ?>
                    <div class="onli_param<?php echo $css_nulz, $css_hide, $css_scrl, $img_fv; ?>">
                    <?php $i = 0; 
                        foreach($option['param'] as $optv) {
                            $param_id = $optv['param_id'];
                            $name_text = $optv['text'];
                            if($noindex_rel_nopp) {
                                $rel_nf =  $a_rel_nf;
                                if($optv['blok_noindex']) {
                                    $rel_nf = null;
                                }
                            }
                            if($flag_image) {
                                $src_img = $optv['image']; $src_null = ($src_img) ? null : $cls_no_src; ?>
                    <div class="img_opts <?php echo $src_null; ?>">
                        <?php  if($optv['action']) { 
                            $href = sprintf($href_link_del, ${$view_get}['del_href']);   
                        ?>
                        <label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="non_decor active" <?php echo $href; ?> title="<?php echo $legend_remove_position; ?> <?php echo $name_text; ?>"><img class="img_param tec_img" alt="<?php echo $name_text; ?>" src="<?php echo $src_img;?>" /></a></label>
                        <?php } elseif($optv['total'] == 0) { ?>
                        <a class="non_decor curs_def"><img class="img_param_null" alt="<?php echo $name_text; ?>" src="<?php echo $src_img;?>"/></a>
                        <?php } else { 
                            $href = sprintf($href_link, ${$view_get}['href']);   
                        ?>
                        <label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="non_decor" title="<?php echo $name_text; ?>" <?php echo $href; ?>><img class="img_param" alt="<?php echo $name_text; ?>" src="<?php echo $src_img;?>"/></a></label>
                        <?php } ?>
                    </div> 
                    <?php } elseif($view_button_opt) { ?>
                    <div class="botton_opts">
                        <?php  if($optv['action']) { 
                            $href = sprintf($href_link_del, ${$view_get}['del_href']);
                        ?>
                        <label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="non_decor active" <?php echo $href; ?> title="<?php echo $legend_remove_position; ?> <?php echo $name_text; ?>"><p class="kvadrat tec_attr <?php echo $cls_btn; ?>"><?php echo $name_text;?></p></a></label>
                        <?php } elseif($optv['total'] == 0) { ?>
                        <a class="non_decor curs_def"><p class="kvadrat kvadrat_null <?php echo $cls_btn; ?>"><?php echo $name_text; ?></p></a>
                        <?php } else { 
                            $href = sprintf($href_link, ${$view_get}['href']);
                        ?>
                        <label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="non_decor" <?php echo $href; ?> title="<?php echo $name_text; ?>"><p class="kvadrat <?php echo $cls_btn; ?>"><?php echo $name_text; ?></p></a></label>
                        <?php } ?>
                    </div>
                    <?php } else {
                            $total_all = null; 
                            if($flag_count['optv']) {$total_all = sprintf($forms_total, $optv['total'], $optv['total_css']);}
                            $view_next = null;
                            if(!$css_nulz) {
                                $view_next = ($i === $position_hide) ? $displ_unfoldi : null;
                                if($view_next) {
                                    $es_next = true;
                                }
                            }                            
                            if($view_next) { echo $view_next; ?>
                        <div class="skrit <?php echo $css_hide_text; ?>">
                        <?php } ?>
                        <?php  $text_through = $cls_act;
                            if($optv['action']) { if($optv['total'] == 0) {$text_through = $css_through;} 
                            $href = sprintf($href_link_del, ${$view_get}['del_href']);
                        ?>
                        <p class="<?php echo $text_through; ?>"><label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="checka active" <?php echo $href; ?> title="<?php echo $legend_remove_position; ?>"><?php echo $name_text; ?></a></label></p>
                        <?php } elseif($optv['total'] == 0) { ?>
                        <p class="text-through"><a class="checkb curs_def"><?php echo $name_text; echo $total_all; ?></a></p>
                        <?php } else { 
                            $href = sprintf($href_link, ${$view_get}['href']);
                        ?>
                        <p><label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="checkb" <?php echo $href; ?>><?php echo $name_text; echo $total_all; ?></a></label></p>
                        <?php } ?>
                        <?php if($es_next && ($i === ($count_text-1))) { ?>
                        </div>
                        <?php } ?>
                    <?php } ?>  
                    <?php $i++; ?>
                <?php } ?>
                </div>
                </div>
            <?php } ?>
            </div>
            <?php } // end options ?>
        <?php } elseif($view_get == 'manufs') { // brands ?>
            <?php if(!empty($view_manufs)) { ?>
            <div class="block-fv <?php echo $view_get; ?>">
                <div class="block_param">
                    <?php $position_hide = ($null_position_manufs) ? 0 : $position_set;
                        $strelka = null;
                        $css_nulz = null;
                        $css_hide = null;
                        $text_curs = null;
                        $main_id = 1;
                        $rel_nf = ($null_position_manufs) ? $txt_nofollow : null;
                        if($null_position_manufs) {
                            $text_curs = $css_curs_point;
                            $strelka = $strel_hid;
                            $css_hide = ' '.$css_hide_text;
                            //bloc_hide
                            if($manuf_action) {
                                $css_hide = null;
                                $strelka = $strel_vis;
                            }
                            //end bloc_hide
                            $css_nulz = ' '.$css_nulz_text;
                            if(!$css_hide) {
                                $css_nulz = null;
                                $position_hide = $position_set;
                            }
                        }
                        if(!empty($legend_manuf)) { $text_title = $legend_manuf; ?>
                    <p class="title-filter <?php echo $text_curs; ?>"><?php echo sprintf($shabl_title, $strelka, $text_title); ?></p>
                    <?php }
                        $es_next = false; $count_text = $manuf_count_param; $css_scrl = ($scroll_item && ($count_text > $blok_item)) ? ' '.$css_scrl_text : null;
                        $img_fv = null; if($view_img_manufs) { $img_fv = ' img_fv';}
                        ?>
                    <div class="onli_param<?php echo $css_nulz, $css_hide, $css_scrl, $img_fv ?>"><!-- onli_param -->
                <?php $i = 0;
                    foreach($view_manufs as $manufs) {
                        $param_id = $manufs['param_id'];
                        $name_text = $manufs['text'];
                        if($noindex_rel_nopp) {
                            $rel_nf =  $a_rel_nf;
                            if($manufs['blok_noindex']) {
                                $rel_nf = null;
                            }
                        }
                        if($view_img_manufs) {
                            $src_img = $manufs['image']; $src_null = ($src_img) ? null : $cls_no_src; ?>
                    <div class="img_opts <?php echo $src_null; ?>">
                        <?php if($manufs['action']) { 
                            $href = sprintf($href_link_del, ${$view_get}['del_href']);
                        ?>
                        <label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="non_decor active" <?php echo $href; ?> title="<?php echo $legend_remove_position; ?> <?php echo $name_text; ?>"><img class="img_param tec_img" alt="<?php echo $name_text; ?>" src="<?php echo $src_img;?>" /></a></label>
                        <?php }  elseif($manufs['total'] == 0) { ?>
                        <a class="non_decor curs_def"><img class="img_param_null" alt="<?php echo $name_text; ?>" src="<?php echo $src_img;?>"/></a>
                        <?php }  else { 
                            $href = sprintf($href_link, ${$view_get}['href']);
                        ?>
                        <label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="non_decor" title="<?php echo $name_text; ?>" <?php echo $href; ?>><img class="img_param<?php //echo $_null; ?>" alt="<?php echo $name_text; ?>" src="<?php echo $src_img;?>"/></a></label>
                        <?php } ?>
                    </div> 
                    <?php } else {
                            $total_all = null; if($flag_count['manufs']) { $total_all = sprintf($forms_total, $manufs['total'], $manufs['total_css']); }
                            $view_next = null;
                            if(!$css_nulz) {
                                $view_next = ($i === $position_hide) ? $displ_unfoldi : null;
                                if($view_next) {
                                    $es_next = true;
                                }
                            }                            
                            if($view_next) { echo $view_next; ?>
                        <div class="skrit <?php echo $css_hide_text; ?>">
                        <?php } ?>
                        <?php  $text_through = $cls_act; 
                            if($manufs['action']) { if($manufs['total'] == 0) {$text_through = $css_through;} 
                                $href = sprintf($href_link_del, ${$view_get}['del_href']);
                        ?>
                        <p class="<?php echo $text_through; ?>"><label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="checka active" <?php echo $href; ?> title="<?php echo $legend_remove_position; ?>"><?php echo $name_text; ?></a></label></p>
                        <?php } elseif($manufs['total'] == 0) { ?>
                        <p class="text-through"><a <?php echo $rel_nf; ?> class="checkb curs_def"><?php echo $name_text; echo $total_all; ?></a></p>
                        <?php } else {
                            $href = sprintf($href_link, ${$view_get}['href']);
                        ?>
                        <p><label><input type="hidden" name="<?php echo $view_get; ?>[<?php echo $main_id; ?>]" value="<?php echo $param_id; ?>" /><a <?php echo $rel_nf; ?> class="checkb" <?php echo $href; ?>><?php echo $name_text; echo $total_all; ?></a></label></p>
                        <?php } ?>
                        <?php if($es_next && ($i === ($count_text-1))) { ?>
                        </div>
                        <?php } ?>
                    <?php } ?>
                        <?php $i++; ?>
                <?php } ?>
                    </div>
                </div>
            </div>
            <?php } ?>
        <?php } // end brands ?>
    <?php } // end foreach view_posit ?>
       	<div class="clears"></div>
        <?php if($ajax_filter && !is_null($ajx_total_prod)) { ?>
        <div id="bloc_primenit"><div><span class="aj_blc aj_bloc_txt"><?php echo $legend_aj_bloc_txt; ?></span><span class="aj_blc ajx_total_prod"><?php echo $ajx_total_prod; ?></span><span id="primenit"><strong class="aj_blc aj_bloc_btn"><?php echo $legend_aj_bloc_btn; ?></strong></span><span id="clear_vibor" class="aj_blc aj_blc_del"><i class="fa fa-trash-o"></i></span></div></div>
        <?php } ?>
        </div><!-- / filter_vier -->
   </div><!-- / box-content -->
<script>
    function corrUrl(url) {
        var shza = /&amp;/g;
        return url.replace(shza, '&');
    }
    function otpravUrl(url_adr) {
        location.assign(url_adr);
    }
    function yesMobil() {
        var oj = {};
        var f_v_w = $("#filter_vier").width();
        var of_left = $("#filter_vier").offset().left;
        var margin_2 = (of_left * 2);
        var of_f_v_w = (f_v_w + of_left);
        var all_width = $(document.body).width();
        //all_width = (all_width - margin_2);
        oj["f_v_w"] = f_v_w;
        oj["of_f_v_w"] = of_f_v_w;
        oj["all_width"] = (all_width - margin_2);
        oj["flag_mobil"] = false;
        if((f_v_w + f_v_w/2) > all_width) {
            oj["flag_mobil"] = true;
        }
        return oj;
    }
    $('.displ').on('click p', function() {
        var bloc_text = $(this).closest('.onli_param');
        var bloc_text_null = bloc_text.find('.skrit');
        var bloc_displ = bloc_text.find('.unfoldi');
        <?php if($animal_blok) { ?>
        bloc_text_null.slideToggle('<?php echo $animal_blok; ?>');
        <?php } else { ?>
        bloc_text_null.toggleClass('<?php echo $css_hide_text; ?>');
        <?php } ?>
        if(bloc_displ.text() == '<?php echo $legend_more; ?>') {
            bloc_displ.html('<?php echo $legend_hide.$unfoldi_vis; ?>');
        }
        else {
            bloc_displ.html('<?php echo $legend_more.$unfoldi_hid; ?>');
        }
    });
    $('.title-filter<?php echo '.'.$css_curs_point; ?>').on('click', function() {
        var bloc_text = $(this);
        <?php if($animal_blok) { ?>
        bloc_text.next('.onli_param').slideToggle('<?php echo $animal_blok; ?>');
        <?php } else { ?>
        bloc_text.next('.onli_param').toggleClass('<?php echo $css_hide_text; ?>');
        <?php } ?>
        bloc_text.find('.fa').toggleClass("<?php echo $cls_hiden; ?> <?php echo $cls_visit; ?>");
    });

    $(document).ready(function() {
        $('#name_filter').on('click', function() {
            var blok_fv = $('#filter_vier');
            <?php if($animal_blok) { ?>
            blok_fv.slideToggle('<?php echo $animal_blok; ?>');
            <?php } else { ?>
            blok_fv.toggle();
            <?php } ?>
            $('#name_filter .fa').toggleClass("<?php echo $arrow_bott_filt_vis; ?> <?php echo $arrow_bott_filt_hid; ?>");
        });
        //scroll
        <?php if($scrollis) { ?>
        var n_ses = 'scrollis';
        var scrollis = sessionStorage.getItem(n_ses);
        if(scrollis) {
            window.scrollTo(0, scrollis);
            sessionStorage.removeItem(n_ses);
        }
        $('.block-fv a').click(sesScroll);
        $('.button_attr input').click(sesScroll);
        <?php  if($ajax_filter) { ?>
        var oj = yesMobil();
        if(!oj.flag_mobil) {
            $('#primenit').click(sesScroll);
            $('#clear_vibor').click(sesScroll);
        }
        <?php }  ?>
        function sesScroll() {
            sessionStorage.setItem(n_ses, (window.scrollY) ? window.scrollY 
              : document.documentElement.scrollTop ? document.documentElement.scrollTop 
              : document.body.scrollTop
            );
        }
        <?php } ?>
        //end scroll
    });
</script>
<?php if($ajax_filter) { ?>
<script>
    $(document).mouseup(function(e) {
        var bp = $("#bloc_primenit");
        if(bp.has(e.target).length === 0) {
            bp.hide();
        }
    });

    var legend_clears = '<?php echo $legend_clears; ?>';
    var versi_put = '<?php echo $versi_put; ?>';

    function getDataPoles(rangeSld, cler_sl, temp_param, nam, flag_es_sl) {
        rangeSld.next('input').attr('value', temp_param).next('.slidez').addClass('active');
        if(flag_es_sl) {
            cler_sl.html('<span class="text_clears"><a class="clear_slider">'+legend_clears+'</a></span>');
        }
        onliParamGet(cler_sl, nam, true);
    }
    function blocFilter(flag) {
        var $abf = $('#ajx_bloc_filter');
        if(flag) {
            $abf.css({"z-index":"10","width":"100%","height":"100%","position":"absolute","background":"rgba(0, 0, 0, 0.1)"});
        }
        else {
            $abf.attr('style', '');
        }
    }
    function ajs_filter(param, dtype, file, coord_y, coord_x) {
        $.ajax({
            type: 'GET'
            ,url: 'index.php?route='+versi_put+file
            //,async: true
            ,dataType: dtype
            //,cache: false
            ,data: param
            ,beforeSend: function(){
                blocFilter(true);
            }
            ,success: function(data) {
                if(file == 'ajax_filter') {
                    if(data) {
                        var temp_action_get = $('#action_get').html();
                        //_ajax
                        var $bfv = $('#block_filter_vier');
                        $bfv.html(data);
                        $('#filter_vier').css({"display":"block"});
                        if(temp_action_get == undefined) {
                          $('#action_get').remove();
                        }
                        else {
                            $('#action_get').html(temp_action_get);
                        }
                        if(coord_y) {
                            $('#bloc_primenit').css({"display":"inline-block","position":"absolute"}).offset(coord_y);
                            if(coord_x) {
                                $('#bloc_primenit').css(coord_x);
                            }
                        }
                    }
                }
                else if(file == 'ajax_url') {
                    if(data.result) {
                        otpravUrl(corrUrl(data.result));
                    }
                }
            }
            ,complete: function(){
                blocFilter(false);
            }
        });
    }

    function getParamFilt(router, bloc, clear_filter) {
        var obj_param = {};
        if(clear_filter) {
            router = true;
        }
        else {
            $("#block_filter_vier .active").prev("input").each(function () {
                var nam = this.name;
                var v = this.value;
                if(bloc) {
                    if(nam == bloc) {
                        obj_param['-'+nam] = v;
                    }
                }
                if(nam in obj_param) {
                    obj_param[nam] = obj_param[nam] + '-' + v;
                }
                else {
                    obj_param[nam] = v;
                }
    	    });
        }
        if(router) {
            <?php foreach($get_route as $key => $val) { ?>
            obj_param['<?php echo $key; ?>'] = '<?php echo $val ?>';
            <?php } ?>
        }
        return obj_param;
    }
    $(".onli_param.img_fv").on('click', "a:not(.curs_def)", function(e) {
        e.preventDefault();
        var $param = $(this);
        $param.toggleClass("active");
        var nam = $param.prev().attr('name');
        onliParamGet($param, nam, false);
    });
    $(".onli_param:not(.img_fv)").on('click', "a:not(.curs_def):not(.clear_slider)", function(e) {
        e.preventDefault();
        var $param = $(this);
        $param.toggleClass("checka active").toggleClass("checkb");
        var nam = $param.prev().attr('name');
        onliParamGet($param, nam, false);
    });
    $("#primenit").on('click', function() {
        var total_tovar = <?php echo ($ajx_total_prod) ? $ajx_total_prod : '0'; ?>;
        if(total_tovar) {
            var obj_param = {};
            obj_param = getParamFilt(true, '', false);
            ajs_filter(obj_param, 'json', 'ajax_url', '', '');
        }
    });
    $('#clear_vibor').on('click', function() {
        actionGet();
    });
    function onliParamGet(elem, nam, flag_sl) {
        var of_top = elem.offset().top;
        //,"left":0
        var oj_top = {"top":of_top};
        var oj_l_r = positBottom(flag_sl);
        var param = getParamFilt(true, nam, false);
        ajs_filter(param, 'html', 'ajax_filter', oj_top, oj_l_r);
    }
    function actionGet() {
        var url_start = clearGet();
        if(url_start) {
            otpravUrl(url_start);
        }
        else {
            var param = getParamFilt(true, '', true);
            ajs_filter(param, 'html', 'ajax_filter', '', '');
        }
    }

    function positBottom(flag_sl) {
        var oj = yesMobil();
        var f_v_w = oj["f_v_w"];
        var of_f_v_w = oj["of_f_v_w"];
        var all_width = oj["all_width"];
        var flag_mobil = oj["flag_mobil"];
        var posit = "left";
        var correct = 12;
        var corr_mob = 3;
        var val_posit = (f_v_w+correct);
        var oj_l_r = {};
        if(flag_mobil) {
            posit = "left";
            val_posit = correct;
        }
        else if((of_f_v_w - all_width) > 1) {
            posit = "right";
        }
        val_posit = val_posit;
        if(flag_mobil) {
            if(flag_sl) {
                oj_l_r["margin-top"] = "-140px";
            }
            else {
                oj_l_r["margin-top"] = "-"+(val_posit*corr_mob)+"px";
            }
            oj_l_r["margin-left"] = (f_v_w / corr_mob);
        }
        else {
            oj_l_r[posit] = val_posit+"px";
        }
        return oj_l_r;
    }
    function clearGet() {
        var url_start = corrUrl('<?php echo $href_start; ?>');
        var url_real = window.location.href;
        if(url_real != url_start) {
            return url_start;
        }
        else {
            return false;
        }
    }
</script>
<?php } ?>
<?php echo $end_bloc; ?>
<?php } ?>