<?php
class ControllerExtensionModuleGofilter extends Controller {

	public function index() {

		$this->document->addStyle('catalog/view/javascript/jquery/go_filter/go_filter.css');
		$this->document->addStyle('catalog/view/javascript/jquery/go_filter/jquery-ui.css');
		$this->document->addStyle('catalog/view/javascript/jquery/go_filter/jquery.scrollbar.css');
		
		$this->document->addScript('catalog/view/javascript/jquery/go_filter/jquery-ui.js');
		$this->document->addScript('catalog/view/javascript/jquery/go_filter/go_filter.js');
		$this->document->addScript('catalog/view/javascript/jquery/go_filter/jquery.scrollbar.js');
		
		$data = $this->filter_common();

		return $this->load->view('extension/module/gofilter', $data);
	
	}
	
	public function filter_common() {
		static $modul = 0;
		$this->load->language('extension/module/gofilter');

		$data['text_find_products'] = $this->language->get('text_find_products');
		$data['text_products'] = $this->language->get('text_products');
		$data['text_select_category'] = $this->language->get('text_select_category');
		$data['text_select_category_parametr'] = $this->language->get('text_select_category_parametr');
		$data['text_more'] = $this->language->get('text_more');
		$data['text_hide'] = $this->language->get('text_hide');
		$data['text_select_option'] = $this->language->get('text_select_option');
		$data['text_products_no_empty'] = $this->language->get('text_products_no_empty');
		$data['text_option_no_empty'] = $this->language->get('text_option_no_empty');
		$data['text_show'] = $this->language->get('text_show');
		$data['text_reset'] = $this->language->get('text_reset');
		$data['text_price'] = $this->language->get('text_price');
		$data['text_range_price'] = $this->language->get('text_range_price');
		$data['text_from'] = $this->language->get('text_from');
		$data['text_to'] = $this->language->get('text_to');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_manufacturers'] = $this->language->get('text_manufacturers');
		$data['text_stock_status'] = $this->language->get('text_stock_status');
		$data['text_rating'] = $this->language->get('text_rating');
		$data['text_keywords'] = $this->language->get('text_keywords');
		$data['text_keywords_placeholder'] = $this->language->get('text_keywords_placeholder');
		$data['text_keywords_placeholder_zap'] = $this->language->get('text_keywords_placeholder_zap');
		$data['text_keywords_placeholder_empty'] = $this->language->get('text_keywords_placeholder_empty');
		$data['text_reset_all'] = $this->language->get('text_reset_all');
			
		if (isset($this->request->post['go_mobile'])) {
			$data['go_mobile'] = true;
		} else {
			$data['go_mobile'] = false;
		}
		
		$data['url'] = '';

		if (isset($this->request->get['sort'])) {
			$data['url'] .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$data['url'] .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['limit'])) {
			$data['url'] .= '&limit=' . $this->request->get['limit'];
		}
		
		if (isset($this->request->get['nofilter'])) {
			$data['nofilter'] = $this->request->get['nofilter'];
		} else {
			$data['nofilter'] = false;
		}
		
		$data['route'] = 'common/home';
		
		if (isset($this->request->get['route'])) {
			$data['route'] = $this->request->get['route'];
		}
		
		if (isset($this->request->post['route_layout'])) {
			$data['route'] = $this->request->post['route_layout'];
		}
		
		if (isset($this->request->get['route_layout'])) {
			$data['route'] = $this->request->get['route_layout'];
		}
		
		$category_id = false;
		if (isset($this->request->get['path'])) {
			$data['category_id'] = $this->request->get['path'];
			$pars = explode('_', (string)$this->request->get['path']);
			$category_id = (int)array_pop($pars);
		}
		if (isset($this->request->post['path'])) {
			$pars = explode('_', (string)$this->request->post['path']);
			$category_id = (int)array_pop($pars);
		}
		
		$this->load->model('extension/module/gofilter');

		$data['location_href'] = $this->request->server['REQUEST_URI'];
			
		$layoute_id = $this->model_extension_module_gofilter->getRoute($data['route']);
		
		$module_info = $this->model_extension_module_gofilter->getGofilter('gofilter');

		$data['common_massiv'] = array();
		
		$massivs_status = array('status_price','status_category','status_keywords','status_manufacturers','status_stock','status_ratings','status_options','status_attributes');
		
		$massivs_collapse = array('collapse_price','collapse_category','collapse_keywords','collapse_manufacturers','collapse_stock','collapse_ratings','collapse_options','collapse_attributes');
		
		$massivs_desktop = array('desktop_price','desktop_category','desktop_keywords','desktop_manufacturers','desktop_stock','desktop_ratings','desktop_options','desktop_attributes');
		
		$massivs_mobile = array('mobile_price','mobile_category','mobile_keywords','mobile_manufacturers','mobile_stock','mobile_ratings','mobile_options','mobile_attributes');
		
		$massivs_style = array('color_caption', 'color_group', 'bg_group', 'color_product', 'color_product_no', 'bg_price');
		
		$massivs_settings = array('popup_view', 'max_height', 'count_show', 'status_cache');
		
		$massivs_sort_and_data_default = array('prices','categories','keywords_filter','options','attributes','manufacturers','stock_statuses','ratings');
		
		foreach ($massivs_status as $massiv_status => $massiv_value) {$data[$massiv_value] = '1';}
		
		foreach ($massivs_collapse as $massiv_collapse => $massiv_value) {$data[$massiv_value] = 0;}
		
		foreach ($massivs_desktop as $massiv_desktop => $massiv_value) {$data[$massiv_value] = 1;}
		
		foreach ($massivs_mobile as $massiv_mobile => $massiv_value) {$data[$massiv_value] = 1;}
		
		$data['ratings_type'] = 'checkbox';
		$data['status_stock_type'] = 'checkbox';
		$data['manufacturers_type'] = 'checkbox';
		$data['keywords_type'] = ' ';
		$data['category_type'] = 'link';
		
		$data['common_massiv']['view']['prices'] = 0;
		$data['common_massiv']['view']['categories'] = 0;
		$data['common_massiv']['view']['keywords_filter'] = 0;
		$data['common_massiv']['view']['options'] = 0;
		$data['common_massiv']['view']['attributes'] = 0;
		$data['common_massiv']['view']['manufacturers'] = 0;
		$data['common_massiv']['view']['stock_statuses'] = 0;
		$data['common_massiv']['view']['ratings'] = 0;
		$data['common_massiv']['categories_layout'] = 0;
		$data['common_massiv']['child_category'] = 0;
		
		$data['on_category'] = false;
		
		if (isset($module_info['gofilter_data'])) {
			foreach (json_decode($module_info['gofilter_data'], true) as $module => $value) {

				$test_stock_category = true;
				if (isset($value['categories_layout'])) {
					if (isset($value['child_category'])) {
						foreach ($value['categories_layout'] as $key_child => $value_child) {
							$value['categories_layout'][] = $this->model_extension_module_gofilter->getChildcategory($value_child);
						}
					}
					if (!in_array($category_id, $value['categories_layout']) and $category_id) {
						$test_stock_category = false;
					}
				}
				
				if (isset($value['layout'])) {
					if (in_array($layoute_id, $value['layout'])) {
						if ($test_stock_category) {
							$data['on_category'] = true;
							
							$data['common_massiv']['prices']['sort'] = $value['sort_price'];
							$data['common_massiv']['categories']['sort'] = $value['sort_category'];
							$data['common_massiv']['keywords_filter']['sort'] = $value['sort_keywords'];
							$data['common_massiv']['options']['sort'] = $value['sort_options'];
							$data['common_massiv']['attributes']['sort'] = $value['sort_attributes'];
							$data['common_massiv']['manufacturers']['sort'] = $value['sort_manufacturers'];
							$data['common_massiv']['stock_statuses']['sort'] = $value['sort_stock'];
							$data['common_massiv']['ratings']['sort'] = $value['sort_ratings'];
							if (isset($value['categories_layout'])) {$data['common_massiv']['categories_layout'] = $value['categories_layout'];}
							
							if (isset($value['view_price'])) {$data['common_massiv']['view']['prices'] = $value['view_price'];}
							if (isset($value['view_category'])) {$data['common_massiv']['view']['categories'] = $value['view_category'];}
							if (isset($value['view_keywords'])) {$data['common_massiv']['view']['keywords_filter'] = $value['view_keywords'];}
							if (isset($value['view_options'])) {$data['common_massiv']['view']['options'] = $value['view_options'];}
							if (isset($value['view_attributes'])) {$data['common_massiv']['view']['attributes'] = $value['view_attributes'];}
							if (isset($value['view_manufacturers'])) {$data['common_massiv']['view']['manufacturers'] = $value['view_manufacturers'];}
							if (isset($value['view_stock'])) {$data['common_massiv']['view']['stock_statuses'] = $value['view_stock'];}
							if (isset($value['view_ratings'])) {$data['common_massiv']['view']['ratings'] = $value['view_ratings'];}
							
							
							foreach ($massivs_status as $massiv_status => $massiv_value) {
								if (isset($value[$massiv_value])) {$data[$massiv_value] = $value[$massiv_value];} else {$data[$massiv_value] = false;}
							}
							
							foreach ($massivs_collapse as $massiv_collapse => $massiv_value) {
								if (isset($value[$massiv_value])) {$data[$massiv_value] = $value[$massiv_value];} else {$data[$massiv_value] = false;}
							}
							
							foreach ($massivs_desktop as $massiv_desktop => $massiv_value) {
								if (isset($value[$massiv_value])) {$data[$massiv_value] = $value[$massiv_value];} else {$data[$massiv_value] = false;}
							}
							
							foreach ($massivs_mobile as $massiv_mobile => $massiv_value) {
								if (isset($value[$massiv_value])) {$data[$massiv_value] = $value[$massiv_value];} else {$data[$massiv_value] = false;}
							}
							
							if (isset($value['name_module'])) {$data['name_module'] = $value['name_module'];} else {$data['name_module'] = false;}
							$data['ratings_type'] = $value['ratings_type'];
							$data['status_stock_type'] = $value['status_stock_type'];
							$data['manufacturers_type'] = $value['manufacturers_type'];
							$data['keywords_type'] = $value['keywords_type'];
							$data['category_type'] = $value['category_type'];
						}
					}
				}
				foreach ($massivs_style as $massiv_key => $massiv_value) {
					if (isset($value[$massiv_value])) {$data[$massiv_value] = $value[$massiv_value];}
				}
				foreach ($massivs_settings as $massiv_key => $massiv_value) {
					if (isset($value[$massiv_value])) {$data[$massiv_value] = $value[$massiv_value];}
				}
			}
		} else {
			$key_sort = 1;
			foreach ($massivs_sort_and_data_default as $massiv_sort_and_data_default => $massiv_sort_and_data_value) {
				$data['common_massiv'][$massiv_sort_and_data_value]['sort'] = $key_sort;
				$key_sort = $key_sort + 1;
			}
			
			
		}
		
		if (isset($data['name_module'])) {$data['name_module'] = $data['name_module'][(int)$this->config->get('config_language_id')];} else {$data['name_module'] = $this->language->get('heading_title');}

		foreach ($massivs_sort_and_data_default as $massiv_sort_and_data_default => $massiv_sort_and_data_value) {
			$data['common_massiv'][$massiv_sort_and_data_value]['data'] = $massiv_sort_and_data_value;
		}

		$data['category_id'] = false;
		
		if (isset($this->request->get['path'])) {
			$data['category_id'] = $this->request->get['path'];
			$pars = explode('_', (string)$this->request->get['path']);
			$data['category_id'] = (int)array_pop($pars);
		}
		
		if (isset($this->request->post['category_id'])) {
			$data['category_id'] = $this->request->post['category_id'];
		}
		
		if (isset($this->request->get['category_id'])) {
			$data['category_id'] = $this->request->get['category_id'];
		}
		
		if (isset($this->request->get['path'])) {
			$data['get_category_id'] = $this->request->get['path'];
		} else {
			$data['get_category_id'] = false;
		}

		$data['old_category_id'] = $this->model_extension_module_gofilter->getParentcategory($data['category_id']);

		$select = false;
		if (isset($this->request->get['select'])) {$select = $this->request->get['select'];}
		if (isset($this->request->post['select'])) {$select = $this->request->post['select'];}
		
		$post = false;
		if (isset($this->request->post)) {$post = $this->request->post;}
		
		$data['categories'] = array();
		
		$this->load->model('catalog/category');
		$this->load->model('catalog/product');
		
		$this->load->model('localisation/currency');
		
		$data['code'] = $this->session->data['currency'];
		
		$data['currencies'] = array();

		$resuls = $this->model_localisation_currency->getCurrencies();

		foreach ($resuls as $result) {
			if ($result['status']) {
				$data['currencies'][] = array(
					'title'        => $result['title'],
					'code'         => $result['code'],
					'symbol_left'  => $result['symbol_left'],
					'symbol_right' => $result['symbol_right']
				);
			}
		}
		if (isset($this->request->post['category_id'])) {
			$data['category_name'] = $this->model_extension_module_gofilter->getCategoryname($this->request->post['category_id']);
		} elseif (isset($this->request->get['category_id'])) {
			$data['category_name'] = $this->model_extension_module_gofilter->getCategoryname($this->request->get['category_id']);
		} else {
			if (isset($this->request->get['path'])) {
				$parts = explode('_', (string)$this->request->get['path']);
				$parts = (int)array_pop($parts);
				$data['category_name'] = $this->model_extension_module_gofilter->getCategoryname($parts);
			} else {
				$data['category_name'] = false;
			}
		}
		if (isset($this->request->get['category_id']) or isset($this->request->get['products_id']) or isset($this->request->get['category_filter']) or isset($this->request->get['prices_min_value']) or isset($this->request->get['prices_max_value']) or isset($this->request->get['keywords_filter']) or isset($this->request->get['manufacturers_filter']) or isset($this->request->get['attributes_filter'])) {
			$data['filter_getting'] = true;
		} else {$data['filter_getting'] = false;}
		 
		$data['options'] = array();
		$data['attributes'] = array();
		
		if (isset($this->request->post['cl'])) {$data['count_container'] = $this->request->post['cl'];} else {$data['count_container'] = false;}
		
		$prev_product_array = "";
		if (isset($this->request->post['prev_product'])) {
			$prev_product_array = $this->request->post['prev_product'];
		}
		if (isset($this->request->get['prev_product'])) {
			$prev_product_array = $this->request->get['prev_product'];
		}
		
		if ($data['category_id']) {
			$results = $this->model_extension_module_gofilter->getCommonProducts($data['category_id']);
		} else {
			$results = $this->model_extension_module_gofilter->getCommonProducts(false);
		}

		$data['old_price'] = false;
		if (isset($this->request->post['op'])) {$data['old_price'] = $this->request->post['op'];}
		if (isset($this->request->get['op'])) {$data['old_price'] = $this->request->get['op'];}
		unset($this->request->post['op']); unset($this->request->get['op']);
		
		$count = 0;
		if (isset($this->request->get)) {$count = count($this->request->get);}
		if (isset($this->request->post)) {$count = count($this->request->post);}
		
		$data['class'] = false;
		if (isset($this->request->post['class'])) {$data['class'] = $this->request->post['class'];}
		if (isset($this->request->get['class'])) {$data['class'] = $this->request->get['class'];}
		unset($this->request->post['class']); unset($this->request->get['class']);

		if (isset($this->request->get['route_layout']) or isset($this->request->post['route_layout'])) {
			if ($this->request->get && $this->request->get['route'] != "extension/module/gofilter/live_option_product") {
				$products = $this->model_extension_module_gofilter->getOptionsProducts($this->request->get);
				$results_product = $this->model_extension_module_gofilter->getProductsCategory($this->request->get);
			}
			if ($this->request->post) {
				$products = $this->model_extension_module_gofilter->getOptionsProducts($this->request->post);
				$results_product = $this->model_extension_module_gofilter->getProductsCategory($products);
			}
			$data['products'] = $this->getGenerationEnumeration($products);
		}
		if (isset($products)) {
			$data['count_products'] = count($products);
		} else {
			$data['count_products'] = 0;
		}
		if ($results) {
			$common_results_category = array();
			if (isset($results_product['categories'])) {
				foreach ($results_product['categories'] as $key => $value) {
					$common_results_category[] = (int)$value['category_id'];
				}
			} else {$common_results_category = false;}

			if (isset($results['categories'])) {
				if ($data['category_id'] and $data['category_type'] != "select") {
					$categories = $this->model_catalog_category->getCategories($data['category_id']);
					$data['parent_category_id'] = $this->model_catalog_category->getCategory($data['category_id']);
				} else {
					$categories = $this->model_catalog_category->getCategories(0);
				}
				foreach ($categories as $category) {
					$filter_data = array(
						'filter_category_id'  => $category['category_id'],
						'filter_sub_category' => true
					);
					$total_categories = $this->model_catalog_product->getTotalProducts($filter_data);
					if ($data['category_id'] == $category['category_id']) {
						$category_value_required = "1";
					} else {
						$category_value_required = false;
					}
					if ($common_results_category) {
						if (in_array($category['category_id'], $common_results_category)) {
							$category_stock_required = true;
						} else {
							$category_stock_required = false;
						}
					} else {$category_stock_required = true;}
					
					if (isset($results_product['categories'])) {
						foreach ($results_product['categories'] as $key_results => $value_results) {
							if ($value_results['category_id'] == $category['category_id']) {
								$total_categories = $value_results['count'];
							}
						}
					}
					if (isset($category['category_id'])) {
						if (isset($this->request->post['category_id']) and isset($this->request->post)) {
							$post_child_category = $this->request->post;
							unset($post_child_category['category_id']);
							$post_child_category['category_id'] = $category['category_id'];
							/* $total_categories = count($this->model_extension_module_gofilter->getOptionsProducts($post_child_category)); */
						}
					}
					if ($category['name']) {
						$data['categories'][] = array(
							'category_id' 						=> $category['category_id'],
							'name'        						=> $category['name'],
							'total'        						=> $total_categories,
							'category_value_required'   		=> $category_value_required,
							'category_stock_required'   		=> $category_stock_required
						);
					}
				}
			} else {
				if ($data['category_id']) {
					$data['parent_category_id'] = $this->model_catalog_category->getCategory($data['category_id']);
				}
			}
			
			if (isset($results['options'])) {
				$common_results_options_product = array();
				if (isset($results_product['options'])) {
					foreach ($results_product['options'] as $result_product) {
						foreach ($result_product['option_value'] as $key => $value) {
							$common_results_options_product[] = (int)$value['option_value_id'];
						}
					}
				}
				$option_value_array_required = array();
				if (isset($this->request->post['option_filter'])) {
					foreach ($this->request->post['option_filter'] as $key => $value) {
						$option_value_array_required[] = (int)$value;
					}
				}
				if (isset($this->request->get['option_filter'])) {
					foreach ($this->request->get['option_filter'] as $key => $value) {
						$option_value_array_required[] = (int)$value;
					}
				}
				foreach ($results['options'] as $result_option) {
					$option_values = array();
					foreach ($result_option['option_value'] as $value) {
						$option_value_required = true;
						if (!in_array($value['option_value_id'], $option_value_array_required)) {
							$option_value_required = false;
						}
						$option_stock_required = true;
						if (!in_array($value['option_value_id'], $common_results_options_product) and $common_results_options_product) {
							$option_stock_required = false;
						}
						$total_options = 0;
						if (isset($results_product)) {
							if (isset($results_product['options'])) {
								foreach ($results_product['options'] as $result_product) {
									foreach ($result_product['option_value'] as $value_result) {
										if ($value_result['option_value_id'] == $value['option_value_id']) {
											$total_options = $value_result['option_value_total'];
										}
									}
								}
							} else {
								$option_stock_required = false;
							}
						} else {
							$total_options = $value['option_value_total'];
						}
						if ($total_options == 0) {$option_stock_required = false;}
						if ($value['option_value_name']) {
							$option_values[] = array(
								'option_value_id'          => $value['option_value_id'],
								'option_value_required'    => $option_value_required,
								'option_stock_required'    => $option_stock_required,
								'option_value_name' 	   => $value['option_value_name'],
								'option_value_total' 	   => $total_options,
								'image'                    => $value['option_value_image'] ? $this->model_tool_image->resize($value['option_value_image'], 20, 20) : '',
							);
						}
					}
					$data['options'][] = array(
						'option_id'  				=> $result_option['option_id'],
						'name'       				=> $result_option['name'],
						'type'       				=> $result_option['type'],
						'option_value'      		=> $option_values
					);
				}
			}
			$common_results_product_attributes_product = array(); $common_results_key_attributes_product = array();
			if (isset($results['attributes'])) {
				if (isset($results_product['attributes'])) {
					foreach ($results_product['attributes'] as $key => $value) {
						foreach ($value['attribute'] as $result_value) {
							$common_results_product_attributes_product[] = $result_value['text'];
							$common_results_key_attributes_product[] = $result_value['attribute_id'];
						}
					}
				}
				
				$attributes_value_array_required = array(); $attributes_key_array_required = array();
				if (isset($this->request->post['attributes_filter'])) {
					foreach ($this->request->post['attributes_filter'] as $key => $value) {
						foreach ($value as $key_2 => $value_2) {
							$attributes_value_array_required[] = $value_2;
						}
						$attributes_key_array_required[] = $key;
					}
				}
				if (isset($this->request->get['attributes_filter'])) {
					foreach ($this->request->get['attributes_filter'] as $key => $value) {
						foreach ($value as $key_2 => $value_2) {
							$attributes_value_array_required[] = $value_2;
						}
						$attributes_key_array_required[] = $key;
					}
				}
				foreach ($results['attributes'] as $attribute) {
					$attribute_values = array();
					foreach ($attribute['attribute'] as $value) {
						$attribute_value_required = false;
						if (in_array($value['text'], $attributes_value_array_required) and in_array($value['attribute_id'], $attributes_key_array_required) and $attributes_key_array_required) {
							$attribute_value_required = true;
						}

						$attribute_stock_required = true;
						if ((!in_array($value['text'], $common_results_product_attributes_product) and $common_results_product_attributes_product) or (!in_array($value['attribute_id'], $common_results_key_attributes_product) and $common_results_key_attributes_product)) {
							$attribute_stock_required = false;
						}
						$total_attributes = 0;
						if (isset($results_product)) {
							if (isset($results_product['attributes'])) {
								foreach ($results_product['attributes'] as $key => $value_result) {
									foreach ($value_result['attribute'] as $result_value) {
										if ($result_value['text'] == $value['text'] and $result_value['attribute_id'] == $value['attribute_id']) {
											$total_attributes = $result_value['total'];
										}
									}
								}
							} else {
								$attribute_stock_required = false;
							}
						} else {
							$total_attributes = $value['attribute_text_total'];
						}
						if ($total_attributes == 0) {$attribute_stock_required = false;}
						if ($value['text']) {
							$attribute_values[] = array(
								'attribute_id'          	=> $value['attribute_id'],
								'text' 	   					=> $value['text'],
								'attribute_text_total' 	  	=> $total_attributes,
								'attribute_value_required'  => $attribute_value_required,
								'attribute_stock_required'  => $attribute_stock_required,
							);
						}
							
					}
					$data['attributes'][] = array(
						'attribute_id'  	=> $attribute['attribute_id'],
						'name'       		=> $attribute['name'],
						'attribute'       	=> $attribute_values,
					);
				} 
			}

			if (isset($results['manufacturers'])) {
				$manufacturer_value_array_required = array();
				if (isset($this->request->post['manufacturers_filter'])) {
					foreach ($this->request->post['manufacturers_filter'] as $key_status => $value_status) {
						$manufacturer_value_array_required[] = $value_status;
					}
				}
				if (isset($this->request->get['manufacturers_filter'])) {
					foreach ($this->request->get['manufacturers_filter'] as $key_status => $value_status) {
						$manufacturer_value_array_required[] = $value_status;
					}
				}
				$common_results_manufacturers_product = array();
				if (isset($results_product['manufacturers'])) {
					foreach ($results_product['manufacturers'] as $key => $value) {
						$common_results_manufacturers_product[] = (int)$value['manufacturer_id'];
					}
				}
				foreach ($results['manufacturers'] as $manufacturer) {
					$manufacturers_value_required = false;
					if (in_array($manufacturer['manufacturer_id'], $manufacturer_value_array_required)) {
						$manufacturers_value_required = true;
					}
					$manufacturers_stock_required = true;
					if ($common_results_manufacturers_product) {
						if (!in_array($manufacturer['manufacturer_id'], $common_results_manufacturers_product) and $common_results_manufacturers_product) {
							$manufacturers_stock_required = false;
						}
					}
					if (isset($post['option_filter']) or isset($post['rating_filter']) or isset($post['keywords_filter']) or isset($post['stock_status_filter']) or isset($post['attributes_filter']) or isset($post['prices_max_value'])) {
						$test_click_no_manuf = true;
					}
					if (isset($select) and $select == "manuf" and !isset($test_click_no_manuf)) {$manufacturers_stock_required = true;}
					
					$total_manufacturers = $manufacturer['manufacturer_value_total'];

					if (isset($results_product['manufacturers'])) {
						foreach ($results_product['manufacturers'] as $value) {
							if ($value['manufacturer_id'] == $manufacturer['manufacturer_id']) {
								$total_manufacturers = $value['manufacturer_value_total'];
							}
						}
					}
					if ($manufacturer['name']) {
						$data['manufacturers'][] = array(
							'manufacturer_id'  					=> $manufacturer['manufacturer_id'],
							'name'       						=> $manufacturer['name'],
							'image'       						=> $manufacturer['image'],
							'manufacturer_value_required'   	=> $manufacturers_value_required,
							'manufacturer_value_total'   		=> $total_manufacturers,
							'manufacturers_stock_required'  	=> $manufacturers_stock_required
						);
					}
				}
			}
			
			if (isset($results['stock_status'])) {
				$stock_status_value_array_required = array();
				if (isset($this->request->post['stock_status_filter'])) {
					foreach ($this->request->post['stock_status_filter'] as $key_status => $value_status) {
						$stock_status_value_array_required[] = $value_status;
					}
				}
				if (isset($this->request->get['stock_status_filter'])) {
					foreach ($this->request->get['stock_status_filter'] as $key_status => $value_status) {
						$stock_status_value_array_required[] = $value_status;
					}
				}
				$common_results_stock_status_product = array();
				if (isset($results_product['stock_status'])) {
					foreach ($results_product['stock_status'] as $value) {
						$common_results_stock_status_product[] = $value['stock_status_id'];
					}
				}
				foreach ($results['stock_status'] as $key_status => $stock_status) {
					if (mb_strtolower($stock_status['name'], 'UTF-8') != mb_strtolower($this->language->get('text_stock'), 'UTF-8')) {$status_id = $stock_status['status_id'];} else {$status_id = "stock";}
					if (in_array($status_id, $stock_status_value_array_required)) {
						$stock_status_value_required = true;
					} else {
						$stock_status_value_required = false;
					}
					$stock_status_stock_required = true;
					if (!in_array($status_id, $common_results_stock_status_product) and $common_results_stock_status_product) {
						$stock_status_stock_required = false;
					}
					if (isset($post['attributes_filter']) or isset($post['rating_filter']) or isset($post['keywords_filter']) or isset($post['option_filter']) or (isset($post['manufacturers_filter']) and $post['manufacturers_filter'] == "") or isset($post['prices_max_value'])) {
						$test_click_no_stock_status = true;
					}
					if (isset($post['select']) and $post['select'] == "stock" and !isset($test_click_no_stock_status)) { $stock_status_stock_required = true;}
					
					$total_stock = $stock_status['count'];
					if (isset($results_product['stock_status'])) {
						foreach ($results_product['stock_status'] as $value) {
							if ($value['stock_status_id'] == $status_id) {
								$total_stock = $value['total'];
							}
						}
					}
					if ($stock_status['name']) {
						$data['stock_statuses'][] = array(
							'status_id'       					=> $status_id,
							'stock_status_value_required'   	=> $stock_status_value_required,
							'name'       						=> $stock_status['name'],
							'stock_status_value_total'   		=> $total_stock,
							'stock_status_stock_required'   	=> $stock_status_stock_required,
						);
					}
				}
			}
			
			if (isset($results['prices'])) {
				foreach ($results['prices'] as $price) {
					$data['max_price'] = $price['max'];
					if ($data['old_price']) {
						$data['max_price_const'] = $data['old_price'];
					} else {
						$data['max_price_const'] = $price['max'];
					}
					$data['prices_max_value'] = $price['max'];
					$data['min_price'] = $price['min'];
					$data['step_price'] = $data['max_price']/20;
					
					
				}
				if (isset($results_product['prices'])) {
					foreach ($results_product['prices'] as $value) {
						$data['max_price'] = $value['max'];
						if ($data['old_price']) {
						$data['max_price_const'] = $data['old_price'];
					} else {
						$data['max_price_const'] = $value['max'];
					}
					$data['prices_max_value'] = $value['max'];
					$data['min_price'] = $value['min'];
					$data['step_price'] = $data['max_price']/20;
					}
					
				}
			}
			
			$common_results_ratings_product = array();

			if (isset($results_product['ratings'])) {
				foreach ($results_product['ratings'] as $key => $value) {
					$common_results_ratings_product[] = (int)$key;
				}
			}
			
			if (isset($results['ratings'])) {
				$rating_value_array_required = array();
				if (isset($this->request->post['rating_filter'])) {
					foreach ($this->request->post['rating_filter'] as $key_rating => $value_rating) {
						$rating_value_array_required[] = $value_rating;
					}
				}
				if (isset($this->request->get['rating_filter'])) {
					foreach ($this->request->get['rating_filter'] as $key_rating => $value_rating) {
						$rating_value_array_required[] = $value_rating;
					}
				}
				foreach ($results['ratings'] as $key => $value) {
					$ratings_stock_required = true;
					if ($common_results_ratings_product) {
						if (!in_array($value['rating'], $common_results_ratings_product)) {
							$ratings_stock_required = false;
						}
					}
					if (in_array($value['rating'], $rating_value_array_required)) {
						$rating_value_required = "1";
					} else {
						$rating_value_required = false;
					}
					if (isset($this->request->post['option_filter']) or isset($this->request->post['attributes_filter']) or isset($this->request->post['keywords_filter']) or isset($this->request->post['stock_status_filter']) or isset($this->request->post['manufacturers_filter']) or isset($this->request->post['prices_max_value'])) {
						$test_click_no_rating = true;
					}
					if ($select == "rating" and !isset($test_click_no_rating)) {
						$ratings_stock_required = true;
					}
					$data['ratings'][] = array(
						'rating'  						=> $value['rating'],
						'rating_value_total'  			=> $value['rating_value_total'],
						'rating_value_required'   		=> $rating_value_required,
						'ratings_stock_required'   		=> $ratings_stock_required
					);
				}
			}

		}
		
		$q = 0;
		foreach ($data['common_massiv'] as $key => $value) {
			if (isset($value['sort'])) {
				$data_type_filter[] = $key;
				$sort_type_filter[] = $value['sort'];
			} else {
				$q = $q + 1;
				$data_type_filter[] = $key;
				$sort_type_filter[] = $q;
			}

		}
		
		array_multisort($sort_type_filter, SORT_ASC, $data_type_filter);

		
		$data['type_filters'] = $data_type_filter;

		/* формирование массива данных для сортировки */
		
		if (isset($data['keywords_type'])) {$data['delimitier'] = $data['keywords_type'];} else {$data['delimitier'] = " ";}
		
		if (isset($this->request->get['keywords_filter'])) {
			if ($this->request->get['keywords_filter'] != "") {
				$data['keywords_filter'] = "";
				$data['keywords_filter_text'] = $this->request->get['keywords_filter'];
				$arr_kewords = explode($data['delimitier'], (string)$this->request->get['keywords_filter']);
				foreach ($arr_kewords as $key => $value) {
					$data['keywords_filter'][] = $value;
				}
			}
		}
		
		if (isset($this->request->post['keywords_filter'])) {
			if ($this->request->post['keywords_filter'] != "") {
				$data['keywords_filter'] = "";
				$data['keywords_filter_text'] = $this->request->post['keywords_filter'];
				$arr_kewords = explode($data['delimitier'], (string)$this->request->post['keywords_filter']);
				foreach ($arr_kewords as $key => $value) {
					$data['keywords_filter'][] = $value;
				}
			}
		}

		
		if (isset($this->request->post['prices_max_value'])) {
			$data['get_price_max'] = $this->request->post['prices_max_value'];
			$data['get_price_min'] = $this->request->post['prices_min_value'];
			$data['max_price'] = $this->request->post['prices_max_value'];
			$data['prices_max_value'] = $this->request->post['prices_max_value'];
		} else {
			if (!isset($data['prices_max_value'])) {
				$data['prices_max_value'] = false;
			} 
			$data['get_price_max'] = false;
			$data['get_price_min'] = false;
		}

		if (isset($this->request->post['prices_min_value'])) {$data['min_price'] = $this->request->post['prices_min_value'];} else {$data['min_price'] = 0;}
		
		$data['gofilter_cloud'] = $this->load->controller('product/gofilterscripts');
		
		$data['modul'] = $modul++;
		
		return $data;
		
	}
	
	public function live_option_product() {
		
		$data = $this->filter_common();

		return $this->response->setOutput($this->load->view('extension/module/gofilter', $data));

	}
	
	public function getGenerationEnumeration($perem_id_data) {
		
		$perem_id = "-1";
		$k = 0;
		if ($perem_id_data) {
			foreach ($perem_id_data as $key => $value) {
				$k = $k + 1;
				if ($k == 1) {
					$perem_id = (int)$value;
				} else {
					$perem_id .= "," . (int)$value;
				}
			}
		}
		return $perem_id;
	}
	
	public function live_home_filter() {
		
		$data = $this->filter_common();
		
		return $this->response->setOutput($this->load->view('extension/module/gofilter', $data));
		
	}
	
}