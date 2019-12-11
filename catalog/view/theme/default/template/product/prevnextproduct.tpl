<div class="product-navigation clearfix" style="margin-bottom:20px">
    <?php if ($prev) { ?>
        <a style="float:left;" title="<?php echo $prev['name']; ?>" class="btn btn-default" href="<?php echo $prev['href']; ?>">
		<i class="fa fa-caret-left"></i> <?php echo $prev['name']; ?></a>
    <?php } ?>
    <?php if ($next) { ?>
        <a style="float:right;" title="<?php echo $next['name']; ?>" class="btn btn-default" href="<?php echo $next['href']; ?>"><?php echo $next['name']; ?> <i class="fa fa-caret-right"></i></a>
    <?php } ?>
</div>