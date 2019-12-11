<?php
class ModelExtensionModuleGofilter extends Model {
	
private $tax_rates = array();
	
public function getGofilter($code) {
		$setting_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "gofilter WHERE `code` = '" . $this->db->escape($code) . "'");
		
		if ($query->num_rows) {
			foreach ($query->rows as $result) {
				$setting_data[$result['key']] = $result['value'];
			}
		}

		return $setting_data;
}
	
public function getRoute($route) {
		$data_route = array();
		
		$query_route = $this->db->query("SELECT layout_id FROM " . DB_PREFIX . "layout_route WHERE '" . $this->db->escape($route) . "' LIKE route");
		
		if ($query_route->rows) {$data_route = $query_route->row['layout_id'];}
		
		return $data_route;
}

public function getParentcategory($category_id) {

		$data_parent = false ;
		
		if ($category_id) {
			$query_parent = $this->db->query("SELECT path_id FROM " . DB_PREFIX . "category_path WHERE category_id = '" . (int)$category_id . "'");
		
			if ($query_parent->rows) {
				if ($query_parent->row['path_id'] != $category_id) {
					if ($query_parent->rows) {$data_parent = $query_parent->row['path_id'];}
				}
			}
		}

		return $data_parent;
}

public function getChildcategory($category_id) {
	
	$category_array = array();
	
	if ($category_id) {
		$query_child = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "category_path WHERE path_id = '" . (int)$category_id . "'");
	
		if ($query_child->num_rows) {
			foreach ($query_child->rows as $value) {
				$category_array[] = (int)$value['category_id'];
			}
		}
	}

	return $category_array;
}
	
public function test_Count_options_group_select($select_options) {
		
		$test_options_id = array();
			
		foreach ($select_options as $key => $value) {
			$test_options_id[] = (int)$value;
		}
		if ($test_options_id) {
			$test_options_id_enum = $this->getGenerationEnumeration($test_options_id);
		}
		$options_id_query = $this->db->query("SELECT option_id FROM " . DB_PREFIX . "option_value WHERE option_value_id IN (" . $this->db->escape($test_options_id_enum) . ")");

		$options_id_array = array();
		if ($options_id_query->num_rows) {
			foreach ($options_id_query->rows as $key => $value) {
				$options_id_array[] = (int)$value['option_id'];
			}
		}
		$options_id_array = array_unique($options_id_array);
		
		return count($options_id_array);
		
}
public function stockStock() {
	$this->load->model('extension/module/gofilter');
	$module_info = $this->model_extension_module_gofilter->getGofilter('gofilter');
	
	$data['route'] = 'common/home';
	if (isset($this->request->get['route'])) {$data['route'] = $this->request->get['route'];}
	if (isset($this->request->post['route_layout'])) {$data['route'] = $this->request->post['route_layout'];}
	if (isset($this->request->get['route_layout'])) {$data['route'] = $this->request->get['route_layout'];}
	$layoute_id = $this->model_extension_module_gofilter->getRoute($data['route']);

	if (isset($module_info['gofilter_data'])) {
		foreach (json_decode($module_info['gofilter_data'], true) as $module => $value) {
			if (isset($value['layout'])) {
				if (in_array($layoute_id, $value['layout'])) {
					if (isset($value['view_stock'])) {
						$stock_stock = $value['view_stock'];
					}
				}
			}
		}
	}
	if (isset($stock_stock)) {
		return true;
	} else {
		return false;
	}
}

	
public function getidProducts($common_value_id) {
		
		unset($common_value_id['old_category_id']);	unset($common_value_id['path']); unset($common_value_id['route_layout']); unset($common_value_id['select']); unset($common_value_id['class']); unset($common_value_id['op']); unset($common_value_id['prices_max_value']); unset($common_value_id['prices_min_value']); unset($common_value_id['route']); unset($common_value_id['gofilter']); unset($common_value_id['nofilter']); unset($common_value_id['nofilter']);
		
		$sql = "SELECT DISTINCT p.product_id FROM " . DB_PREFIX . "product p";
		
		$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_store AS p2sq ON p.product_id = p2sq.product_id";
		
		if (isset($common_value_id['option_filter'])) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_option_value x ON (p.product_id = x.product_id)";
		}
			
		if (isset($common_value_id['attributes_filter'])) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_attribute xc ON (p.product_id = xc.product_id)";
		}
		
		if (isset($common_value_id['rating_filter'])) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "review r ON (p.product_id = r.product_id)";
		}
		
		if (isset($common_value_id['keywords_filter'])) {
			if ($common_value_id['keywords_filter'] != null) {
				$keywords = strtolower($common_value_id['keywords_filter']);
				if(strlen($keywords) >= 1) {
					$sql .= " LEFT JOIN " . DB_PREFIX . "product_description AS pdq ON p.product_id = pdq.product_id";
					$sql .= " LEFT JOIN " . DB_PREFIX . "manufacturer AS pmq ON p.manufacturer_id = pmq.manufacturer_id";
				}
				
			}
		}
		
		if (isset($common_value_id['category_id'])) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";
		}
		
		$sql .= " WHERE";
		
		$sql .= " p2sq.store_id = '" . (int)$this->config->get('config_store_id') . "' AND p.status = '1'";
		
		
		/* if (!$this->stockStock()) {
			$sql .= " AND p.quantity > 0";
		} */
		
		if (isset($common_value_id)) {$temp_common_value_id = $common_value_id; unset($temp_common_value_id['rating_filter']); unset($temp_common_value_id['sort']); unset($temp_common_value_id['order']); unset($temp_common_value_id['limit']); unset($temp_common_value_id['page']);unset($temp_common_value_id['go_mobile']);} else {$temp_common_value_id = false;}
		
		if ($temp_common_value_id) {
			$sql .= " AND";
		}

		if (isset($common_value_id['option_filter'])) {
			
			$count_options_select_group = $this->test_Count_options_group_select($common_value_id['option_filter']);
			
			if ($count_options_select_group == 1) {
				$sql_compare = " AND";
			} else {
				$sql_compare = " AND";
			}
			
			$kolvo_option = 0;
			foreach ($common_value_id['option_filter'] as $product_option_id => $value) {
				
				if ($kolvo_option == 0) {
					$sql .= " x.option_value_id = '" . (int)$value . "'";
				} else {
					$sql .= $sql_compare;
					$sql .= " x.product_id IN (SELECT x2.product_id  FROM " . DB_PREFIX . "product_option_value x2 WHERE x2.option_value_id = '" . (int)$value . "')";
				}
				
				$kolvo_option = $kolvo_option + 1;
			}
			
			if (isset($common_value_id['attributes_filter']) or isset($common_value_id['manufacturers_filter']) or isset($common_value_id['stock_status_filter']) or (isset($common_value_id['keywords_filter']) and ($common_value_id['keywords_filter'] != "")) or isset($common_value_id['category_id'])) {
				$sql .= " AND";
			}
		
		}
		
		if (isset($common_value_id['attributes_filter'])) {
			
			$kolvo_attribute = 0;
			foreach ($common_value_id['attributes_filter'] as $product_attribute => $value) {
			     foreach ($value as $key_1 => $value_1) {
    				if (isset($value_1)) {
    					if ($kolvo_attribute == 0) {
    						$sql .= " xc.text = '" . $this->db->escape($value_1) . "' AND xc.attribute_id = '" . (int)$product_attribute . "'";
    					} else {
    						$sql .= " AND xc.product_id IN (SELECT xc2.product_id  FROM " . DB_PREFIX . "product_attribute xc2 WHERE xc2.text = '" . $this->db->escape($value_1) . "' AND xc2.attribute_id = '" . (int)$product_attribute . "')";
    					}
                        $kolvo_attribute = $kolvo_attribute + 1;
    				}
                }
			}
			
			if (isset($common_value_id['manufacturers_filter']) or isset($common_value_id['stock_status_filter']) or (isset($common_value_id['keywords_filter']) and ($common_value_id['keywords_filter'] != "")) or isset($common_value_id['category_id'])) {
				$sql .= " AND";
			}
		}
	
		if (isset($common_value_id['manufacturers_filter']) and !in_array("", $common_value_id['manufacturers_filter'])) {
			
			$sql .=  " (";
			
			if (is_array($common_value_id['manufacturers_filter'])) {
				foreach ($common_value_id['manufacturers_filter'] as $key_manufacturer => $value_manufacturer) {
					$manufacturer_values_data[] = $value_manufacturer;
				}
			} else {
				$manufacturer_values_data[] = $common_value_id['manufacturers_filter'];
			}
				
			
			$manufacturer_values_data = array_map("unserialize", array_unique(array_map("serialize", $manufacturer_values_data)));
			
			$h = 0;
			foreach ($manufacturer_values_data as $stock_key => $manufacturer_value) {
				$h = $h + 1;
				if ($h == 1) {
					$sql .=  "p.manufacturer_id = '" . (int)$manufacturer_value . "'";
				} else {
					$sql .=  " OR p.manufacturer_id = '" . (int)$manufacturer_value . "'";
				}
			}
			
			$sql .=  ")";
			
			if (isset($common_value_id['stock_status_filter']) or (isset($common_value_id['keywords_filter']) and ($common_value_id['keywords_filter'] != "")) or isset($common_value_id['category_id'])) {
				$sql .= " AND";
			}
		}
			
		if (isset($common_value_id['stock_status_filter'])) {
			
				$sql .=  " (";
				
				$temp_array_stock_status_values_data = array();
				foreach ($common_value_id['stock_status_filter'] as $key_status => $value_status) {
					$temp_array = explode('-', (string)$value_status);
					$temp_array_stock_status_values_data[] = $temp_array;
				}
				
				$stock_status_values_data = array();
				if (is_array($common_value_id['stock_status_filter'])) {
					foreach ($common_value_id['stock_status_filter'] as $key => $value) {
							$stock_status_values_data[] = $value;
					}
				} else {
					$stock_status_values_data[] = $common_value_id['stock_status_filter'];
				}
				
				$stock_status_values_data = array_map("unserialize", array_unique(array_map("serialize", $stock_status_values_data)));
				$this->load->language('extension/module/gofilter');
				$sum = 0; $d = 0;
				foreach ($stock_status_values_data as $stock_key => $stock_value) {
					
					if ($sum > 0) {$sql .=  " OR ";}
					
					if ($stock_value == "stock") {
						$sql .=  "p.quantity > 0 OR p.stock_status_id = (SELECT stock_status_id FROM " . DB_PREFIX . "stock_status WHERE name = '" . $this->language->get('text_stock') . "' AND language_id = '" . (int)$this->config->get('config_language_id') . "')";
					} elseif ($stock_value == 0 and $d == 0) {
						$sql .=  "p.quantity <= 0";
					} else {
						$sql .=  "p.stock_status_id = '" . (int)$stock_value . "' AND p.quantity <= 0";
						$d = $d + 1;
					}
					
					$sum = $sum + 1;
				
				}
				
				$sql .=  ")";
				
				if ((isset($common_value_id['keywords_filter']) and ($common_value_id['keywords_filter'] != "")) or isset($common_value_id['category_id'])) {
					$sql .= " AND";
				}
		}
			
		if (isset($common_value_id['keywords_filter']) and ($common_value_id['keywords_filter'] != "")) {
			if ($common_value_id['keywords_filter'] != null) {
				
				$keywords = strtolower($common_value_id['keywords_filter']);
				
				if(strlen($keywords) >= 1) {
					
				if ($this->getDelimitier()) {$delimitier = $this->getDelimitier();} else {$delimitier = " ";}

				$parts = explode($delimitier, $keywords);
			
					$sql .= ' (';
					
					$u = 0;
					foreach($parts as $part) {
						$u = $u + 1;
						if ($u == 1) {
							$sql .= '(LOWER(p.model) LIKE "%' . $this->db->escape($part) . '%") OR (LOWER(pdq.name) LIKE "%' . $this->db->escape($part) . '%") OR (LOWER(pdq.meta_title) LIKE "%' . $this->db->escape($part) . '%") OR (LOWER(pdq.tag) LIKE "%' . $this->db->escape($part) . '%") OR (LOWER(pdq.meta_description) LIKE "%' . $this->db->escape($part) . '%") OR (LOWER(pdq.meta_keyword) LIKE "%' . $this->db->escape($part) . '%") OR (LOWER(pmq.name) LIKE "%' . $this->db->escape($part) . '%")';
						} else {
							$sql .= ' OR ';
							$sql .= '(LOWER(p.model) LIKE "%' . $this->db->escape($part) . '%") OR (LOWER(pdq.name) LIKE "%' . $this->db->escape($part) . '%") OR (LOWER(pdq.meta_title) LIKE "%' . $this->db->escape($part) . '%") OR (LOWER(pdq.tag) LIKE "%' . $this->db->escape($part) . '%") OR (LOWER(pdq.meta_description) LIKE "%' . $this->db->escape($part) . '%") OR (LOWER(pdq.meta_keyword) LIKE "%' . $this->db->escape($part) . '%") OR (LOWER(pmq.name) LIKE "%' . $this->db->escape($part) . '%")';
						}							
					}
					
					$sql .= ')';
					
					$sql .= ' AND pdq.language_id = ' . (int)$this->config->get('config_language_id');

				}
				
			}
			if (isset($common_value_id['category_id'])) {
				$sql .= " AND";
			}
		}
		
		if (isset($common_value_id['category_id'])) {
			$sql .= " p2c.category_id IN (SELECT category_id FROM " . DB_PREFIX . "category_path WHERE path_id = '" . (int)$common_value_id['category_id'] . "')";
		}
		if (isset($common_value_id['rating_filter'])) {
			$sql .= " GROUP BY p.product_id";
		}
		
		if (isset($common_value_id['rating_filter'])) {
			$sql .= " HAVING";
			$or = 0;
			foreach ($common_value_id['rating_filter'] as $key => $value) {
				if ($or > 0) {$sql .= " OR ";}
				if ($value != 0) {
					$sql .= " ROUND(AVG(r.rating), 0) = '" . (int)$value . "'";
				} else {
					$sql .= " COUNT(r.product_id) = 0";
				}
				$or++;
			}
		}
		
		$query_products = $this->db->query($sql);
		
		if ($query_products->num_rows) {
			return $query_products;
		} else {
			return $query_products = false;
		}

}
	
public function getDelimitier() {
		
	$this->load->model('extension/module/gofilter');
	
	$route = 'common/home';
	
	if (isset($this->request->get['route'])) {
		$route = $this->request->get['route'];
	}
	
	if (isset($this->request->post['route_layout'])) {
		$route = $this->request->post['route_layout'];
	}
	
	$layoute_id = $this->model_extension_module_gofilter->getRoute($route);
		
	$module_info = $this->model_extension_module_gofilter->getGofilter('gofilter');
	
	$delimitier = " ";
	
	if (isset($module_info['gofilter_data'])) {
		foreach (json_decode($module_info['gofilter_data'], true) as $module => $value) {
			if (isset($value['layout'])) {
				if (in_array($layoute_id, $value['layout'])) {
					$delimitier = $value['keywords_type'];
				}
			}
		}
	}
	
	return $delimitier;
}
	
public function getGenerationEnumeration($perem_id_data = array()) {
		$perem_id = "";
		$k = 0;
		if ($perem_id_data) {
			foreach ($perem_id_data as $key => $value) {
				$k = $k + 1;
				if ($k == 1) {
					$perem_id = (int)$value;
				} else {
					$perem_id .= ", " . (int)$value;
				}
			}
		}
		
		return $perem_id;
		
}

public function calculate($value, $tax_class_id, $calculate = true) {
		if ($tax_class_id && $calculate) {
			$amount = 0;

			$tax_rates = $this->getRates($value, $tax_class_id);

			foreach ($tax_rates as $tax_rate) {
				if ($calculate != 'P' && $calculate != 'F') {
					$amount += $tax_rate['amount'];
				} elseif ($tax_rate['type'] == $calculate) {
					$amount += $tax_rate['amount'];
				}
			}
			
			$common = round(($value - $amount), 0);
			
			if ($common < 0) {$common = 0;}
			
			return $common = $common + 1;
		} else {
			return $value;
		}
}
	
public function getRates($value, $tax_class_id) {

		$tax_rate_data = array();
	
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "tax_rate tr LEFT JOIN " . DB_PREFIX . "tax_rule trl ON (tr.tax_rate_id = trl.tax_rate_id) WHERE trl.tax_class_id IN (" . $this->db->escape($tax_class_id) . ") ORDER BY tr.type ASC");
		
	
		if ($query->num_rows) {

			$amount = 0;
			foreach ($query->rows as $tax_rate) {
				

				if ($tax_rate['type'] == 'F') {
					$amount += $tax_rate['rate'];
				} elseif ($tax_rate['type'] == 'P') {
					$amount += ($value - $amount) / (100 + $tax_rate['rate'])*$tax_rate['rate'] - $amount;
				}

				$tax_rate_data[$tax_rate['tax_rate_id']] = array(
					'type'        => $tax_rate['type'],
					'amount'      => $amount
				);
			}
			
		}
		
		return $tax_rate_data;
	
}
	
public function geProductsPrice($common_value_id, $option_products_id_data) {
	if ($option_products_id_data) {
		if (isset($common_value_id['prices_min_value']) and isset($common_value_id['prices_max_value'])) {
			$sql = "";
			$array_products = array();
			foreach ($option_products_id_data as $product_id) {
				$sql = "SELECT DISTINCT p.product_id FROM " . DB_PREFIX . "product p";
				$query_tax_class_id = $this->db->query("SELECT DISTINCT t.tax_class_id FROM " . DB_PREFIX . "product t WHERE t.product_id = '" . (int)$product_id . "'");
				if ($this->config->get('config_tax')) {
					if (isset($common_value_id['prices_min_value'])) {$prices_min_value = $this->calculate($common_value_id['prices_min_value'], $query_tax_class_id->row['tax_class_id'], $this->config->get('config_tax'));}
					if (isset($common_value_id['prices_max_value'])) {$prices_max_value = $this->calculate($common_value_id['prices_max_value'], $query_tax_class_id->row['tax_class_id'], $this->config->get('config_tax')) + 1;}
				} else {
					if (isset($common_value_id['prices_min_value'])) {$prices_min_value = $this->calculate($common_value_id['prices_min_value'], $query_tax_class_id->row['tax_class_id'], $this->config->get('config_tax'));}
					if (isset($common_value_id['prices_max_value'])) {$prices_max_value = $this->calculate($common_value_id['prices_max_value'], $query_tax_class_id->row['tax_class_id'], $this->config->get('config_tax')) + 1;}
				}
				$sql .= " LEFT JOIN " . DB_PREFIX . "product_special ps ON (p.product_id = ps.product_id) LEFT JOIN " . DB_PREFIX . "product_discount pd2 ON (pd2.product_id = p.product_id)";
				
				$sql .=  " WHERE";

				$sql .= " IF ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()), (((select ROUND(MAX(ps5.price), 0) from " . DB_PREFIX . "product_special ps5 WHERE ps5.product_id = '" . (int)$product_id . "' AND ps5.priority = (select MIN(ps7.priority) from " . DB_PREFIX . "product_special ps7 WHERE ps7.product_id = '" . (int)$product_id . "')) >= " . (int)$prices_min_value . ") AND ((select ROUND(MIN(ps6.price), 0) from " . DB_PREFIX . "product_special ps6 WHERE ps6.product_id = '" . (int)$product_id . "' AND ps6.priority = (select MIN(ps7.priority) from " . DB_PREFIX . "product_special ps7 WHERE ps7.product_id = '" . (int)$product_id . "')) <= " . (int)$prices_max_value . ")) AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "', p.price >= " . (int)$prices_min_value . " AND p.price <= " . (int)$prices_max_value . ")";

				$sql .=  " AND p.product_id = '" . $product_id . "'";
				
				$query_products_id = $this->db->query($sql);
				if ($query_products_id->num_rows) {
					$array_products[] = $query_products_id->row['product_id'];
				}
			}
			$array_products = array_unique($array_products);
		} else {
			$array_products = $option_products_id_data;
		}
		return $array_products;
	}
}
	
public function getOptionsProducts($common_value_id) {
			
	$query_products = $this->getidProducts($common_value_id);

	$option_products_id_data = array();
	if ($query_products) {
		foreach ($query_products->rows as $option_value_product_id) {
			$option_products_id_data[] = (int)$option_value_product_id['product_id'];
		}
	}
	
	$option_products_id = array_map("unserialize", array_unique(array_map("serialize", $option_products_id_data)));
	
	$option_products_id = $this->geProductsPrice($common_value_id, $option_products_id);

	return $option_products_id;
}
	
public function getCategoryname($category_id) {
	if ($category_id) {
		$query = $this->db->query("SELECT name FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int)$category_id . "' AND language_id = '" . (int)$this->config->get('config_language_id') . "'");
		if (isset($query->row['name'])) {$category_name = $query->row['name'];} else {$category_name = '';}
	
		return $category_name;
	} else {
		return $category_name = false;
	}
}

	public function getOptionsProductsCategory($category_id) {
		
		$categories_value_query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "category_path WHERE path_id = '" . (int)$category_id . "'");
		
		$categories_id_data = array();
		if ($categories_value_query->num_rows) {
			foreach ($categories_value_query->rows as $categories_value) {
				$categories_id_data[] = (int)$categories_value['category_id'];
			}
		}
		
		$categories_ids = $this->getGenerationEnumeration($categories_id_data);
		
		if($categories_ids == "") {
			$categories_ids_value_query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "category WHERE status = 1");
			$categories_ids_data = array();
			if ($categories_ids_value_query->num_rows) {
				foreach ($categories_ids_value_query->rows as $categories_value) {
					$categories_ids_data[] = (int)$categories_value['category_id'];
				}
			}
			$categories_ids = $this->getGenerationEnumeration($categories_ids_data);
		}
		
		$products_value_query = $this->db->query("SELECT ptc.product_id FROM " . DB_PREFIX . "product_to_category ptc LEFT JOIN " . DB_PREFIX . "product p ON (ptc.product_id = p.product_id) WHERE category_id IN (" . $this->db->escape($categories_ids) . ") AND p.status = '1'");
		
		if ($products_value_query->num_rows) {
			
			$products_id_data = array();
			
			foreach ($products_value_query->rows as $product_value) {
				
				$products_id_data[] = (int)$product_value['product_id'];
				
			}
			
			$products_id_data = array_map("unserialize", array_unique(array_map("serialize", $products_id_data)));
			
			$products_id = array();
			$k = 0;
			foreach ($products_id_data as $products => $value) {
				$k = $k + 1;
				if ($k == 1) {
					$products_id = (int)$value;
				} else {
					$products_id .= ", " . (int)$value;
				}
			}
		} else {
			$products_id = false;
		}
		
		return $products_id;
	}
	
	public function getProductsCommon() {

		$products_value_query = $this->db->query("SELECT product_id FROM " . DB_PREFIX . "product WHERE status = '1'");

		$products_array = array();
		if ($products_value_query->num_rows) {
			foreach ($products_value_query->rows as $product_value) {
				$products_array[] = (int)$product_value['product_id'];
			}
		}

		return $products_array;
	}
	
public function getProductsstockCategory($category_id) {
		$products_value_query = $this->db->query("SELECT ptc.product_id FROM " . DB_PREFIX . "product_to_category ptc LEFT JOIN " . DB_PREFIX . "product p ON (ptc.product_id = p.product_id) WHERE category_id = '" . (int)$category_id . "' AND p.status = '1' ORDER BY product_id ASC");
		$products_array = array();
		if ($products_value_query->num_rows) {
			foreach ($products_value_query->rows as $product_value) {
				$products_array[] = (int)$product_value['product_id'];
			}
		}

		return $products_array;
}
	
public function getProductsPrices($products_array) {
	$prices_values_array = array();
	$prices_values = false;
	
	if ($products_array) {
		$products_array_enum = $this->getGenerationEnumeration($products_array);
		$query_prices = $this->db->query("SELECT DISTINCT p.price,p.tax_class_id,(SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_special pd ON (p.product_id = pd.product_id) WHERE p.product_id IN (" . $products_array_enum . ")");
		if ($query_prices->num_rows) {
			foreach ($query_prices->rows as $query_price) {
				if ((float)$query_price['special']) {
					$special = $this->tax->calculate($query_price['special'], $query_price['tax_class_id'], $this->config->get('config_tax'));
				} else {
					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->tax->calculate(($query_price['discount'] ? $query_price['discount'] : $query_price['price']), $query_price['tax_class_id'], $this->config->get('config_tax'));
					} else {
						$price = false;
					}
					$special = false;
				}
				$prices_values[] = 	(int)($special ? $special : $price);
			}
		}
	}
	if ($prices_values) {
		$prices_values_array[] = array(
			'max'      => max($prices_values),
			'min'      => min($prices_values)
		);
	}
	
	return $prices_values_array;
}
	
public function getCache() {
	$module_info = $this->model_extension_module_gofilter->getGofilter('gofilter');
	if (isset($module_info['gofilter_data'])) {
		$module_info_decode = json_decode($module_info['gofilter_data'], true);
	} else {
		$module_info_decode = false;
	}
	if (isset($module_info_decode['settings']['status_cache'])) {
		$oncache = true;
	} else {
		$oncache = false;
	}
	
	return $oncache;
}

public function get_array_column($input, $columnKey, $indexKey = null) {
        $array = array();
        foreach ($input as $value) {
            if (!isset($value[$columnKey])) {
                trigger_error("Key \"$columnKey\" does not exist in array");
                return false;
            }
    
            if (is_null($indexKey)) {
                $array[] = $value[$columnKey];
            } else {
                if (!isset($value[$indexKey])) {
                    trigger_error("Key \"$indexKey\" does not exist in array");
                    return false;
                }
                if (!is_scalar($value[$indexKey])) {
                    trigger_error("Key \"$indexKey\" does not contain scalar value");
                    return false;
                }
                $array[$value[$indexKey]] = $value[$columnKey];
            }
        }
        return $array;

}
	
public function getCommonProducts($category) {
	
		/* if (!$this->stockStock()) {
			$sql_no_settings_stock = "";
		} else {
			
		} */
		
		$sql_no_settings_stock = "";
		
		$common_value_data = array();
		
		$options = array();

		if ($category) {
			$text_sql_category_left_join = " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";
			$text_sql_category_where = " AND p2c.category_id IN (SELECT category_id FROM " . DB_PREFIX . "category_path WHERE path_id = '" . (int)$category . "')";
			$category_id_cache = ".gofilter.category" . $category . "." . (int)$this->config->get('config_store_id') . "." . (int)$this->config->get('config_language_id');
		} else {
			$text_sql_category_left_join = "";
			$text_sql_category_where = "";
			$category_id_cache = ".gofilter.common." . (int)$this->config->get('config_store_id') . "." . (int)$this->config->get('config_language_id');
		}

		$sql_options = "SELECT pov.option_id,od.name as name_option,o.type,pov.option_value_id,ovd.name as name_option_value,ov.image,COUNT(DISTINCT p.product_id) as total,o.sort_order FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_option_value pov ON (p.product_id = pov.product_id) LEFT JOIN " . DB_PREFIX . "option o ON (pov.option_id = o.option_id) LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (pov.product_id = p2s.product_id)" . $text_sql_category_left_join . " WHERE " . $sql_no_settings_stock . "p.status = '1' AND pov.option_id IS NOT NULL AND od.language_id = '" . (int)$this->config->get('config_language_id') . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'" . $text_sql_category_where . " GROUP BY pov.option_value_id ORDER BY o.sort_order ASC";
		
		if (!$this->getCache()) {
			$query_options = $this->db->query($sql_options);
			if ($query_options->num_rows) {$query_options_rows = $query_options->rows;} else {$query_options_rows = false;}
		} else {
			if (!$this->cache->get('options' . $category_id_cache)) {
				$query_options = $this->db->query($sql_options);
				if ($query_options->num_rows) {$query_options_rows = $query_options->rows;} else {$query_options_rows = false;}
				$this->cache->set('options' . $category_id_cache, $query_options->rows);
			} else {
				$query_options_rows = $this->cache->get('options' . $category_id_cache);
			}
		}

		$temp_option_id_data = array();
		if ($query_options_rows) {
			$option_value_id_query_rows = array_map("unserialize", array_unique(array_map("serialize", $query_options_rows)));
			foreach ($option_value_id_query_rows as $option_val_id) {
				$temp_option_id_data[(int)$option_val_id['option_id']][] = array(
					'option_name' 			=> $option_val_id['name_option'],
					'option_type' 			=> $option_val_id['type'],
					'option_value_id' 		=> (int)$option_val_id['option_value_id'],
					'option_value_image' 	=> $option_val_id['image'],
					'option_value_name' 	=> $option_val_id['name_option_value'],
					'option_value_total' 	=> $option_val_id['total'],
				);
			}
			foreach ($temp_option_id_data as $temp_key => $temp_value) {
				$option_values = array();
				$option_name = "";
				$option_type = "";
				foreach ($temp_value as $key => $value) {
					$option_values[] = array(
						'option_value_id'          => $value['option_value_id'],
						'option_value_name' 	   => $value['option_value_name'],
						'option_value_total' 	   => $value['option_value_total'],
						'option_value_image'       => $value['option_value_image'],
					);
					$option_name = $value['option_name'];
					$option_type = $value['option_type'];
				}
				$common_value_data['options'][] = array(
					'option_id'          	   => $temp_key,
					'name'          	       => $option_name,
					'type'          		   => $option_type,
					'option_value'      	   => $option_values
				);
				
			}

		}
		
		$sql_attributes = "SELECT pa.attribute_id,pa.text,COUNT(DISTINCT pa.product_id) AS total,ad.name FROM " . DB_PREFIX . "product p" . $text_sql_category_left_join . " LEFT JOIN " . DB_PREFIX . "product_attribute pa ON (p.product_id = pa.product_id)  LEFT JOIN " . DB_PREFIX . "attribute a ON (pa.attribute_id = a.attribute_id) LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (a.attribute_id = ad.attribute_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (pa.product_id = p2s.product_id) WHERE " . $sql_no_settings_stock . "p.status = '1' AND pa.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'" . $text_sql_category_where . " GROUP BY pa.attribute_id,ad.name,pa.text";

		if (!$this->getCache()) {
			$query_attributes = $this->db->query($sql_attributes);
			if ($query_attributes->num_rows) {$query_attributes_rows = $query_attributes->rows;} else {$query_attributes_rows = false;}
		} else {
			if (!$this->cache->get('attributes' . $category_id_cache)) {
				$query_attributes = $this->db->query($sql_attributes);
				if ($query_attributes->num_rows) {$query_attributes_rows = $query_attributes->rows;} else {$query_attributes_rows = false;}
				$this->cache->set('attributes' . $category_id_cache, $query_attributes->rows);
			} else {
				$query_attributes_rows = $this->cache->get('attributes' . $category_id_cache);
			}
		}
		
		$temp_attribute_id_data = array();
		if ($query_attributes_rows) {
			foreach ($query_attributes_rows as $attribute_value_id) {
				if ($attribute_value_id['name']) {
					$temp_attribute_id_data[$attribute_value_id['name']][] = array(
						'attribute_id'		=> (int)$attribute_value_id['attribute_id'],
						'text'				=> $attribute_value_id['text'],
						'total'				=> $attribute_value_id['total'],
					);
				}
			}
		}
		foreach ($temp_attribute_id_data as $temp_key => $temp_value) {
			$attribute_values = array();
			$temp_attribute_id = "";
			foreach ($temp_value as $key => $value) {
				$attribute_values[] = array(
					'attribute_id'          	=> $value['attribute_id'],
					'text' 	   					=> $value['text'],
					'attribute_text_total' 	  	=> $value['total'],
				);
				$temp_attribute_id = $value['attribute_id'];
			}
			$common_value_data['attributes'][] = array(
				'attribute_id'      => $temp_attribute_id,
				'name'          	=> $temp_key,
				'attribute'      	=> $attribute_values
			);
		}
		
		$sql_manufacturers = "SELECT p.manufacturer_id,m.name,m.image,COUNT(DISTINCT p.product_id) as total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id)" . $text_sql_category_left_join . " WHERE " . $sql_no_settings_stock . "p.status = '1' AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'" . $text_sql_category_where . " GROUP BY p.manufacturer_id";

		if (!$this->getCache()) {
			$query_manufacturers = $this->db->query($sql_manufacturers);
			if ($query_manufacturers->num_rows) {$query_manufacturers_rows = $query_manufacturers->rows;} else {$query_manufacturers_rows = false;}
		} else {
			if (!$this->cache->get('manufacturers' . $category_id_cache)) {
				$query_manufacturers = $this->db->query($sql_manufacturers);
				if ($query_manufacturers->num_rows) {$query_manufacturers_rows = $query_manufacturers->rows;} else {$query_manufacturers_rows = false;}
				$this->cache->set('manufacturers' . $category_id_cache, $query_manufacturers->rows);
			} else {
				$query_manufacturers_rows = $this->cache->get('manufacturers' . $category_id_cache);
			}
		}
		
		$this->load->model('tool/image');
		
		if ($query_manufacturers_rows) {
			foreach ($query_manufacturers_rows as $query_manufacturer) {
					if ($query_manufacturer['manufacturer_id']) {
						$common_value_data['manufacturers'][] = array(
						'manufacturer_id'    				=> $query_manufacturer['manufacturer_id'],
						'name'          	 				=> $query_manufacturer['name'],
						'image'                    	    	=> $query_manufacturer['image'] ? $this->model_tool_image->resize($query_manufacturer['image'], 20, 20) : '',
						'manufacturer_value_total' 	   		=> $query_manufacturer['total'],
					);
				}
			}
		}

		$post_category_id = 0;
		if (isset($this->request->post['category_id'])) {$post_category_id = $this->request->post['category_id'];}
		if (isset($this->request->get['category_id'])) {$post_category_id = $this->request->get['category_id'];}
		
		
		if ($post_category_id != 0) {
			if (isset($this->request->get['category_id'])) {
				$category_id_enum = $this->request->get['category_id'];
			}
			if (isset($this->request->post['category_id'])) {
				$category_id_enum = $this->request->post['category_id'];
			}
			$sql_categories = "SELECT DISTINCT c.category_id,p.product_id FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "product_to_category ptc ON (c.category_id = ptc.category_id) LEFT JOIN " . DB_PREFIX . "product p ON (ptc.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE ptc.category_id IN (SELECT category_id FROM " . DB_PREFIX . "category_path WHERE path_id = '" . (int)$category_id_enum . "') AND " . $sql_no_settings_stock . "c.status = '1' AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND p.status = '1' ORDER BY c.sort_order";
		} else {
			$sql_categories = "SELECT DISTINCT c.category_id,p.product_id FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_path cp ON (c.category_id = cp.path_id) LEFT JOIN " . DB_PREFIX . "product_to_category ptc ON (cp.path_id = ptc.category_id) LEFT JOIN " . DB_PREFIX . "product p ON (ptc.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE " . $sql_no_settings_stock . "c.status = '1' AND c.parent_id = '0' AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND p.status = '1' ORDER BY c.sort_order";
		}
		
		if (!$this->getCache()) {
			$query_categories = $this->db->query($sql_categories);
			if ($query_categories->num_rows) {$query_categories_rows = $query_categories->rows;} else {$query_categories_rows = false;}
		} else {
			if (!$this->cache->get('categories' . $category_id_cache)) {
				$query_categories = $this->db->query($sql_categories);
				if ($query_categories->num_rows) {$query_categories_rows = $query_categories->rows;} else {$query_categories_rows = false;}
				$this->cache->set('categories' . $category_id_cache, $query_categories_rows);
			} else {
				$query_categories_rows = $this->cache->get('categories' . $category_id_cache);
			}
		}
		
		$categories_parent_child_array = array();
		if ($query_categories_rows) {
			foreach ($query_categories_rows as $key_child_products => $value_child_products) {
				$categories_parent_child_array[$value_child_products['category_id']][] = $value_child_products['product_id'];
			}
		}
		$categories_count = array();
		foreach ($categories_parent_child_array as $key => $category_id) {
			$common_value_data['categories'][] = array(
				'category_id' 	=> $key,
				'count' 		=> count($category_id),
			);
		}

		$sql_prices = "SELECT DISTINCT p.price,p.tax_class_id,(SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_special pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)" . $text_sql_category_left_join . " WHERE " . $sql_no_settings_stock . "p.status = '1'" . $text_sql_category_where . " AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";
		
		if (!$this->getCache()) {
			$query_prices = $this->db->query($sql_prices);
			if ($query_prices->num_rows) {$query_prices_rows = $query_prices->rows;} else {$query_prices_rows = false;}
		} else {
			if (!$this->cache->get('prices' . $category_id_cache)) {
				$query_prices = $this->db->query($sql_prices);
				if ($query_prices->num_rows) {$query_prices_rows = $query_prices->rows;} else {$query_prices_rows = false;}
				$this->cache->set('prices' . $category_id_cache, $query_prices->rows);
			} else {
				$query_prices_rows = $this->cache->get('prices' . $category_id_cache);
			}
		}
		$prices_values = array();
		if ($query_prices_rows) {
			foreach ($query_prices_rows as $query_price) {
				if ((float)$query_price['special']) {
					$special = $this->tax->calculate($query_price['special'], $query_price['tax_class_id'], $this->config->get('config_tax'));
				} else {
					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->tax->calculate(($query_price['discount'] ? $query_price['discount'] : $query_price['price']), $query_price['tax_class_id'], $this->config->get('config_tax'));
					} else {
						$price = false;
					}
					$special = false;
				}
				$prices_values[] = 	(int)($special ? $special : $price);
			}
		}
				
		if ($prices_values) {
			$common_value_data['prices'][] = array(
				'max'      => max($prices_values),
				'min'      => min($prices_values)
			);
		}

		$sql_stock_statuses_stock = "SELECT IF(p.quantity <= '0', ps.stock_status_id, 'stock') as status_id,IF(p.quantity <= '0', ps.name, 'stock') as stock_name FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "stock_status ps ON (p.stock_status_id = ps.stock_status_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)" . $text_sql_category_left_join . " WHERE " . $sql_no_settings_stock . "p.status = '1'" . $text_sql_category_where . " AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND ps.language_id = '" . (int)$this->config->get('config_language_id') . "'";
		
		if (!$this->getCache()) {
			$query_stock_statuses_stock = $this->db->query($sql_stock_statuses_stock);
			if ($query_stock_statuses_stock->num_rows) {$query_stock_statuses_stock_rows = $query_stock_statuses_stock->rows;} else {$query_stock_statuses_stock_rows = false;}
		} else {
			if (!$this->cache->get('stock' . $category_id_cache)) {
				$query_stock_statuses_stock = $this->db->query($sql_stock_statuses_stock);
				if ($query_stock_statuses_stock->num_rows) {$query_stock_statuses_stock_rows = $query_stock_statuses_stock->rows;} else {$query_stock_statuses_stock_rows = false;}
				$this->cache->set('stock' . $category_id_cache, $query_stock_statuses_stock->rows);
			} else {
				$query_stock_statuses_stock_rows = $this->cache->get('stock' . $category_id_cache);
			}
		}
		$this->load->language('extension/module/gofilter');
		$temp_stock_status = array();
		if ($query_stock_statuses_stock_rows) {
			foreach ($query_stock_statuses_stock_rows as $query_stock_status_stock) {
				$name_text = $query_stock_status_stock['stock_name'];
				if ($query_stock_status_stock['stock_name'] == "stock") {
					$name_text = $this->language->get('text_stock');
				}
				$temp_stock_status[] = array(
					'status_id'			=> $query_stock_status_stock['status_id'],
					'stock_name'		=> $name_text,
				);
			}
		}
		foreach ($temp_stock_status as $key => $value) {
			if(!function_exists('array_column')) {
                $count = array_count_values($this->get_array_column($temp_stock_status, 'stock_name'));
            } else {
                $count = array_count_values(array_column($temp_stock_status, 'stock_name'));
            }
			$common_value_data['stock_status'][$value['stock_name']] = array(
				'status_id'  => $value['status_id'],
				'name'  	 => $value['stock_name'],
				'count'  	 => $count[$value['stock_name']],
			);
		}
		
		$sql_ratins = "SELECT IF(r.product_id IS NOT NULL, ROUND(AVG(r.rating), 0), 0) as ratings, IF(r.product_id IS NOT NULL, COUNT(DISTINCT r.product_id), COUNT(DISTINCT p.product_id)) as total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) LEFT JOIN " . DB_PREFIX . "review r ON (p.product_id = r.product_id)" . $text_sql_category_left_join . " WHERE " . $sql_no_settings_stock . "p.status = '1'" . $text_sql_category_where . " AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' GROUP BY r.product_id";
		
		if (!$this->getCache()) {
			$query_ratins = $this->db->query($sql_ratins);
			if ($query_ratins->num_rows) {$query_ratins_rows = $query_ratins->rows;} else {$query_ratins_rows = false;}
		} else {
			if (!$this->cache->get('ratings' . $category_id_cache)) {
				$query_ratins = $this->db->query($sql_ratins);
				if ($query_ratins->num_rows) {$query_ratins_rows = $query_ratins->rows;} else {$query_ratins_rows = false;}
				$this->cache->set('ratings' . $category_id_cache, $query_ratins->rows);
			} else {
				$query_ratins_rows = $this->cache->get('ratings' . $category_id_cache);
			}
		}
		
		if ($query_ratins_rows) {
			foreach ($query_ratins_rows as $query_stock_status_stock) {
				$common_value_data['ratings'][] = array(
					'rating'  				 => $query_stock_status_stock['ratings'],
					'rating_value_total'  	 => $query_stock_status_stock['total'],
				);
			}
		}
		
		return $common_value_data;
}
	
public function getProductsCategory($products_array) {
		$select = false;
		if (isset($this->request->get['select'])) {$select = $this->request->get['select'];}
		if (isset($this->request->post['select'])) {$select = $this->request->post['select'];}
		unset($this->request->post['select']); unset($this->request->get['select']);
		
		$attribute_id_data = array();
		$attribute_sort_order = array();
		
		$products_id = array();
		
		$this->load->model('tool/image');
		
		if ($products_array) {
			$enum_products_array = $this->getGenerationEnumeration($products_array);
			$common_value_data = array();

			if ($enum_products_array != "") {
				$attribute_value_id_query = $this->db->query("SELECT pa.attribute_id,pa.text,COUNT(DISTINCT pa.product_id) AS total,ad.name FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "attribute a ON (pa.attribute_id = a.attribute_id) LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (a.attribute_id = ad.attribute_id) WHERE pa.product_id IN (" . $enum_products_array . ") AND pa.language_id = '" . (int)$this->config->get('config_language_id') . "' GROUP BY pa.attribute_id,pa.text");
				
				$temp_attribute_id_data = array();
				if ($attribute_value_id_query->num_rows) {
					foreach ($attribute_value_id_query->rows as $attribute_value_id) {
						if ($attribute_value_id['name']) {
							$temp_attribute_id_data[$attribute_value_id['name']][] = array(
								'attribute_id' 	   	=> $attribute_value_id['attribute_id'],
								'text'				=> $attribute_value_id['text'],
								'total'				=> $attribute_value_id['total'],
							);
						}
					}
				}
				foreach ($temp_attribute_id_data as $temp_key => $temp_value) {
					$attribute_values = array();
					foreach ($temp_value as $key => $value) {
						$attribute_values[] = array(
							'attribute_id' 	   		=> $value['attribute_id'],
							'text' 	   				=> $value['text'],
							'total' 	  			=> $value['total'],
						);
					}
					$common_value_data['attributes'][] = array(
						'attribute'      	=> $attribute_values
					);
				}

				$option_value_id_query = $this->db->query("SELECT option_id,option_value_id,COUNT(DISTINCT product_id) as total FROM " . DB_PREFIX . "product_option_value WHERE product_id IN (" . $enum_products_array . ") GROUP BY option_value_id");
				
				$option_id_data = array();
				$temp_option_id_data = array();
				if ($option_value_id_query->num_rows) {
					$option_value_id_query_rows = array_map("unserialize", array_unique(array_map("serialize", $option_value_id_query->rows)));
					foreach ($option_value_id_query_rows as $option_val_id) {
						$temp_option_id_data[(int)$option_val_id['option_id']][] = array(
							'option_value_id' 		=> (int)$option_val_id['option_value_id'],
							'option_value_total' 	=> $option_val_id['total'],
						);
					}
					foreach ($temp_option_id_data as $temp_key => $temp_value) {
						$option_values = array();
						$option_name = "";
						$option_type = "";
						foreach ($temp_value as $key => $value) {
							$option_values[] = array(
								'option_value_id'          => $value['option_value_id'],
								'option_value_total' 	   => $value['option_value_total'],
							);
						}
						$option_id_data[] = array(
							'option_value'      	   => $option_values
						);
					}
					$option_id_data = array_map("unserialize", array_unique(array_map("serialize", $option_id_data)));
					foreach ($option_id_data as $option_id) {
						$option_values = array();
						if ($option_id['option_value']) {
							foreach ($option_id['option_value'] as $option_value) {
								$option_values[] = array(
									'option_value_id'          => $option_value['option_value_id'],
									'option_value_total' 	   => $option_value['option_value_total'],
								);
							}
						}
						$common_value_data['options'][] = array(
							'option_value'      	   => $option_values
						);
					}
				}
			}
			foreach ($products_array as $product_value => $value) {
				$products_id[] = (int)$value;
				$products_id = array_map("unserialize", array_unique(array_map("serialize", $products_id)));
			}
		}
		$post_category_id = 0;
		if (isset($this->request->post['category_id'])) {$post_category_id = $this->request->post['category_id'];}
		if (isset($this->request->get['category_id'])) {$post_category_id = $this->request->get['category_id'];}
		if ($post_category_id != 0) {
			if (isset($this->request->get['category_id'])) {
				if (is_array($this->request->get['category_id'])) {$category_id_enum = $this->getGenerationEnumeration($this->request->get['category_id']);} else {$category_id_enum = $this->request->get['category_id'];}
			}
			if (isset($this->request->post['category_id'])) {
				if (is_array($this->request->post['category_id'])) {$category_id_enum = $this->getGenerationEnumeration($this->request->post['category_id']);} else {$category_id_enum = $this->request->post['category_id'];}
			}
			$query_categories_parent = $this->db->query("SELECT DISTINCT cp.category_id FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "category c ON (cp.category_id = c.category_id) WHERE cp.path_id = '" . (int)$category_id_enum . "' AND c.status = 1");
		} else {
			$query_categories_parent = $this->db->query("SELECT DISTINCT category_id FROM " . DB_PREFIX . "category WHERE status = 1 AND parent_id = 0");
		}
		$categories_parent_array = array();
		if ($query_categories_parent->num_rows) {
			foreach ($query_categories_parent->rows as $key => $value) {
				$categories_parent_array[] = $value['category_id'];
			}
		}
		$categories_parent_child_array = array();
		foreach ($categories_parent_array as $key => $value) {
			
			$query_categories_child = $this->db->query("SELECT DISTINCT category_id FROM " . DB_PREFIX . "category_path WHERE path_id = '" . (int)$value . "'");
			
			$temp_categories = array();
			if ($query_categories_child->num_rows) {
				foreach ($query_categories_child->rows as $key_child => $value_child) {
					$temp_categories[] = (int)$value_child['category_id'];
				}
				$temp_categories = array_unique($temp_categories);
				$temp_categories_enum = $this->getGenerationEnumeration($temp_categories);
				$query_categories_child_products = $this->db->query("SELECT DISTINCT ptc.product_id FROM " . DB_PREFIX . "product_to_category ptc LEFT JOIN " . DB_PREFIX . "product p ON (ptc.product_id = p.product_id) WHERE ptc.category_id IN (" . $temp_categories_enum . ") AND p.status = '1'");
				if ($query_categories_child_products->num_rows) {
					foreach ($query_categories_child_products->rows as $key_child_products => $value_child_products) {
						$categories_parent_child_array[$value][] = $value_child_products['product_id'];
					}
				}

			}
		}
		
		$categories = array();
		$categories_common_count = array();
		$categories_path = array();
		
		foreach ($products_id as $product_id) {
			foreach ($categories_parent_child_array as $key => $value) {
				foreach ($value as $key_child => $value_child) {
					if ($value_child == $product_id) {
						$categories[$key][] = (int)$product_id;
					}
				}
			}
		}

		$categories_count = array();
		foreach ($categories as $key => $category_id) {
			
			$categories_count[] = array(
				'category_id' 	=> $key,
				'count' 		=> count($category_id),
			);
		}
		
		if($categories_count) {
			$common_value_data['categories'] = $categories_count;
		}
		
		if (isset($this->request->get['path'])) {
			$category_id = $this->request->get['path'];
			$pars = explode('_', (string)$this->request->get['path']);
			$category_id = (int)array_pop($pars);
		} else {
			$category_id = false;
		}
		
		if (isset($this->request->post['category_id'])) {
			$category_id = $this->request->post['category_id'];
			
		}
		if ($products_array) {
			$products_ids = $this->getGenerationEnumeration($products_array);
		} else {
			$products_ids = false;
		}

		if ($products_ids) {
			$query_manufacturers = $this->db->query("SELECT p.manufacturer_id,m.name,m.image,COUNT(DISTINCT p.product_id) as total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id) WHERE p.product_id IN (" . $this->db->escape($products_ids) . ") GROUP BY p.manufacturer_id");
			
			if ($query_manufacturers->num_rows) {
				
				foreach ($query_manufacturers->rows as $query_manufacturer) {

					if ($query_manufacturer['total']) {$total_manufacturers = $query_manufacturer['total'];} else {$total_manufacturers = "";}

					$common_value_data['manufacturers'][] = array(
						'manufacturer_id'    				=> $query_manufacturer['manufacturer_id'],
						'manufacturer_value_total' 	   		=> $total_manufacturers,
					);
				}
			}
		}
		
		if (isset($common_value_data['manufacturers'])) {$common_value_data['manufacturers'] = array_map("unserialize", array_unique(array_map("serialize", $common_value_data['manufacturers'])));}
		
		if ($products_ids) {
			if (isset($this->request->post['attributes_filter']) or isset($this->request->post['rating_filter']) or isset($this->request->post['keywords_filter']) or isset($this->request->post['option_filter']) or isset($this->request->post['manufacturers_filter']) or isset($this->request->post['prices_max_value'])) {
				$test_click_no_stock_status = true;
			}
			
			/* По статусу */
			$this->load->language('extension/module/gofilter');
			
			$query_stock_statuses_stock = $this->db->query("SELECT IF(p.quantity > 0 OR ps.name = '" . $this->db->escape(mb_strtolower($this->language->get('text_stock'), 'UTF-8')) . "', 'stock', ps.stock_status_id) as stock_status_id,IF(p.quantity > 0, '" . $this->db->escape(mb_strtolower($this->language->get('text_stock'), 'UTF-8')) . "', ps.name) as name,COUNT(DISTINCT p.product_id) as total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "stock_status ps ON (p.stock_status_id = ps.stock_status_id) WHERE p.product_id IN (" . $this->db->escape($products_ids) . ") AND ps.language_id = '" . (int)$this->config->get('config_language_id') . "' GROUP BY stock_status_id");
			
			if ($query_stock_statuses_stock->num_rows) {
				foreach ($query_stock_statuses_stock->rows as $query_stock_status_stock) {
					$common_value_data['stock_status'][] = array(
						'stock_status_id'	=>	$query_stock_status_stock['stock_status_id'],
						'total'				=>	$query_stock_status_stock['total'],
					);
				}
			}
			/* По статусу */
	
		}
		if (isset($common_value_data['stock_status'])) {$common_value_data['stock_status'] = array_map("unserialize", array_unique(array_map("serialize", $common_value_data['stock_status'])));}
		
		if ($products_id) {
			$ratings = array();
			$products_id_enum = $this->getGenerationEnumeration($products_id);
			
			$query_ratings = $this->db->query("SELECT ROUND(AVG(rating), 0) AS rating_total FROM " . DB_PREFIX . "review WHERE product_id IN (" . $products_id_enum . ") AND status = '1' GROUP BY product_id ORDER BY product_id ASC");
			
			if ($query_ratings->num_rows) {
				foreach ($query_ratings->rows as $rating) {
					if ($rating['rating_total']) {
							$ratings[] = array(
							'rating'	=>	(int)$rating['rating_total']
						);
					}
				}
			}
			foreach ($products_id as $key => $product_id) {
				$query_ratings = $this->db->query("SELECT ROUND(AVG(rating), 0) AS rating_total FROM " . DB_PREFIX . "review WHERE product_id = '" . (int)$product_id . "' AND status = '1' GROUP BY product_id ORDER BY product_id ASC");
				if ($query_ratings->num_rows) {
					foreach ($query_ratings->rows as $rating) {
						$ratings[] = array(
							'rating'	=>	(int)$rating['rating_total']
						);
					}
				} else {
					$ratings[] = array(
						'rating'	=>	'0'
					);
				}
			}
		}
		
		if (isset($ratings)) {
			$rating_values = array();
			foreach ($ratings as $key => $values) {
				foreach ($values as $key => $value) {
					$rating_values[] = (int)$value;
				}
			}
			
			array_multisort($rating_values, SORT_DESC, $rating_values);
		
			$rating_sort = array();
			foreach ($rating_values as $key => $value) {
				$rating_sort[] = $key;
			}
			
			$common_value_data['ratings'] = array_count_values($rating_values);

		}

		if ($products_id) {
			$query_prices = $this->db->query("SELECT DISTINCT p.price,p.tax_class_id,(SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_special pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.product_id IN (" . $products_id_enum . ") AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");
			
			$prices_values = array();
			if ($query_prices->num_rows) {
				foreach ($query_prices->rows as $query_price) {
					if ((float)$query_price['special']) {
						$special = $this->tax->calculate($query_price['special'], $query_price['tax_class_id'], $this->config->get('config_tax'));
					} else {
						if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
							$price = $this->tax->calculate(($query_price['discount'] ? $query_price['discount'] : $query_price['price']), $query_price['tax_class_id'], $this->config->get('config_tax'));
						} else {
							$price = false;
						}
						$special = false;
					}
					$prices_values[] = 	(int)($special ? $special : $price);
				}
			}
			if ($prices_values) {
				$common_value_data['prices'][] = array(
					'max'      => max($prices_values),
					'min'      => min($prices_values)
				);
			}
		}
		
		if ($products_id) {
			return $common_value_data;
		} else {
			return false;
		}

}


}