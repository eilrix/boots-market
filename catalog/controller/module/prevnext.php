<?php
/* PprMkr module PrevNext

       |-|-|
         |   PprMkr
         O
           
 Author:    R.Dijk
 Version:   1.0.1
 Feel free to donate: https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=HC6BRSDD65RQA&lc=NL&item_name=R%2e%20Dijk&item_number=via_pprmkr&currency_code=EUR&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted
*/
class ControllerModulePrevNext extends Controller {
	protected $category_id = 0;
	protected $path = array();
	
	protected function index($module) {
		if (isset($this->request->get['product_id'])) {
			$product_id = $this->request->get['product_id'];
		} else {
			$product_id = false;
		}

		if (isset($this->request->get['path'])) {
			$path = false;
			foreach (explode('_', $this->request->get['path']) as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path = $path_id;
				}
				
			}
		}
		else {
			$this->load->model('catalog/prevnextproduct');
			$path = $this->model_catalog_prevnextproduct->getPath($product_id);
		}
		
		if ( $product_id != false && $path != false ) {
		$this->language->load('module/prevnext');
		
    	$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['button_cart'] = $this->language->get('button_cart');
		
		$this->load->model('catalog/prevnextproduct');
		
		$this->data['products'] = array();		
		$this->data['products'] = $this->model_catalog_prevnextproduct->getPrevNextProduct($product_id,$path);
						
		$this->id = 'prevnext';
		$this->data['module'] = '1';//$module['name']; 

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/prevnext.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/module/prevnext.tpl';
			} else {
				$this->template = 'default/template/module/prevnext.tpl';
			}
		$this->document->addStyle('catalog/view/theme/default/stylesheet/prevnext.css');
		$this->render();
		}

		
  	}
	
 
    private function getPrevNext($currentId, $catId){
		$this->load->model('catalog/prevnextproduct');
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		
		$this->data['t_products'] = array();
		$results = $this->model_catalog_prevnextproduct->getPrevNextProduct($currentId,$catId);
		if ( $results ) {
		foreach( $results as $result){

			if ($result['image']) {
				$image = $result['image'];
			} else {
				$image = 'no_image.jpg';
			}
			$discount = $this->model_catalog_product->getProductDiscounts($result['product_id']);

			if ($discount) {
				$price = $this->currency->format($this->tax->calculate($discount, $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));

				$special = $this->model_catalog_product->getProductSpecials($result['product_id']);

				if ($special) {
					$special = $this->currency->format($this->tax->calculate($special, $result['tax_class_id'], $this->config->get('config_tax')));
				}
			}
			$options = $this->model_catalog_product->getProductOptions($result['product_id']);

			if ($options) {
				//$this->url->link('product/product', 'product_id=' . $result['product_id'])
				$add = $this->url->link('product/product','product_id=' . $result['product_id']);
				$view = $this->url->link('product/product','product_id=' . $result['product_id']);
			} else {
				$add = HTTPS_SERVER . 'index.php?route=checkout/cart&amp;product_id=' . $result['product_id'];
				$view = HTTPS_SERVER . 'index.php?route=product/product&amp;product_id=' . $result['product_id'];
			}

      		$this->data['t_products'][] = array(
        		'key' 		 => $result['product_id'],
        		'name'       => $result['name'] . ' - ' .$catId,
        		'image'		 => $this->model_tool_image->resize($image, 38, 38),
        		'thumb'		 => $this->model_tool_image->resize($image,$this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_width')),
				'price'      => $price,
				'special'	 => $special,
				'href'       => $this->url->link('product/product','product_id=' . $result['product_id']),
				'add'    		=> $add,
				'view'			=>$view

      		);

	  	}	  
  		}  
	    return $this->data['t_products'];
    } 		

}
?>