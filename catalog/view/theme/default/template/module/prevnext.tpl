<div class="pagination">
<div class="links" style="height: 22px; margin: 0; padding-bottom: 0; padding-top: 0;"> 
      <?php if (isset($products[1])) { ?>
       <a id="nav-left" href="<?php echo $products[1]['href']; ?>" title="<?php echo $products[1]['button'];?>"></a>
      <?php } ?>
      <?php if (isset($products[2])) { ?>
       <a id="nav-right" href="<?php echo $products[2]['href']; ?>" title="<?php echo $products[2]['button'];?>"></a>
      <?php } ?>
    </div>
</div>
