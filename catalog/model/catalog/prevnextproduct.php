<?php
class ModelCatalogPrevNextProduct extends Model {
	public function getPrevNextProduct($product_info, $category_id = 0) {
		if (!$this->config->get('prevnext_enable')) { return false;}
		$this->path = '';
		
		$this->product_id = $product_info['product_id'];

		$prevnext_anchor_next = $this->config->get('prevnext_anchor_next');
		$prevnext_anchor_prev = $this->config->get('prevnext_anchor_prev');
		
		if (!isset($prevnext_anchor_next[$this->config->get('config_language_id')])) {
			$this->text_next = 'next';
		} else {
			$this->text_next = $prevnext_anchor_next[$this->config->get('config_language_id')];
		}
		if (!isset($prevnext_anchor_prev[$this->config->get('config_language_id')])) {
			$this->text_prev = 'prev';
		} else {
			$this->text_prev = $prevnext_anchor_prev[$this->config->get('config_language_id')];
		}

		// А все от лени
		if (!$this->config->get('prevnext_anchor')) {
			$this->field_name = ", pd.name name";
			$this->table = 	" JOIN ". DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id AND pd.language_id = ". (int)$this->config->get('config_language_id') . ")";
		} else {
			$this->field_name = '';
			$this->table      = '';
		}
		
		if ((float)$product_info['special'] && $this->config->get('prevnext_special')) {
			$results = $this->getSpecial();
		} elseif ((int)$product_info['manufacturer_id'] && $this->config->get('prevnext_manufacturer')) {
			$results = $this->getManufacturer($product_info['manufacturer_id']);
		} else {
			$results = $this->getCategory();
		}
		return $this->render($results);
	}
	private function getSpecial() {
		$product_id = $this->product_id;
		$sql = "
			SELECT p.product_id" . $this->field_name;
		$sql .= "
			FROM ". DB_PREFIX . "product p ";			
		$sql .= $this->table;	
		$sql .= "
				WHERE 1 AND (";
							
		$sql .= "p.product_id = (SELECT DISTINCT ps1.product_id 
			FROM " . DB_PREFIX . "product_special ps1 
			LEFT JOIN " . DB_PREFIX . "product p1 ON (ps1.product_id = p1.product_id) 
			JOIN " . DB_PREFIX . "product_to_store p2s1 ON (p1.product_id = p2s1.product_id AND p2s1.store_id = '" . (int)$this->config->get('config_store_id') . "')
			WHERE p1.status = '1' 
				AND ps1.product_id < ". (int)$product_id . "
				AND p1.date_available <= NOW() 
				AND ps1.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' 
				AND ((ps1.date_start = '0000-00-00' OR ps1.date_start < NOW()) 
				     AND (ps1.date_end = '0000-00-00' OR ps1.date_end > NOW())
					) 
				GROUP BY ps1.product_id 
				ORDER BY ps1.product_id DESC LIMIT 1)";

		$sql .= ' OR ';
		$sql .= "p.product_id = (SELECT DISTINCT ps2.product_id 
			FROM " . DB_PREFIX . "product_special ps2 
			LEFT JOIN " . DB_PREFIX . "product p2 ON (ps2.product_id = p2.product_id) 
			JOIN " . DB_PREFIX . "product_to_store p2s2 ON (p2.product_id = p2s2.product_id AND p2s2.store_id = '" . (int)$this->config->get('config_store_id') . "')
			WHERE p2.status = '1' 
				AND ps2.product_id > ". (int)$product_id . "
				AND p2.date_available <= NOW() 
				AND ps2.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' 
				AND ((ps2.date_start = '0000-00-00' OR ps2.date_start < NOW()) 
				     AND (ps2.date_end = '0000-00-00' OR ps2.date_end > NOW())
					) 
				GROUP BY ps2.product_id 
				ORDER BY ps2.product_id ASC LIMIT 1)";
		$sql .= " )";
		$results = $this->db->query($sql);
		$products = array();

		if ($results->num_rows == 1 && $this->config->get('prevnext_circle')) {
			if ($results->rows[0]['product_id'] > $product_id) {
				//нет пред 
				$sql = "
					SELECT DISTINCT p.product_id" . $this->field_name;
				$sql .= "
					FROM ". DB_PREFIX . "product p ";			
				$sql .= $this->table;	
				$sql .= "
					JOIN " . DB_PREFIX . "product_special ps ON (ps.product_id = p.product_id) 
					JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "')
					WHERE p.status = '1' 
						AND p.product_id > ". (int)$product_id . "
						AND p.date_available <= NOW() 
						AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' 
						AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) 
							AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())
						) 
					GROUP BY p.product_id 
					ORDER BY p.product_id ASC LIMIT 1";				
				$res = $this->db->query($sql);
				if ($res->num_rows) {
					$products[] = $res->row;
				}
				$products[] = $results->row;				
			} else {
				//нет след
				$sql = "
					SELECT DISTINCT p.product_id" . $this->field_name;
				$sql .= "
					FROM ". DB_PREFIX . "product p ";			
				$sql .= $this->table;	
				$sql .= "
					JOIN " . DB_PREFIX . "product_special ps ON (ps.product_id = p.product_id) 
					JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "')
					WHERE p.status = '1' 
						AND p.product_id < ". (int)$product_id . "
						AND p.date_available <= NOW() 
						AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' 
						AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) 
							AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())
						) 
					GROUP BY p.product_id 
					ORDER BY p.product_id DESC LIMIT 1";				
				$res = $this->db->query($sql);
				$products[] = $results->row;
				if ($res->num_rows) {
					$products[] = $res->row;
				}
			}
		} else {
			$products = $results->rows;
		}
		return $products;
	} 

	private function getManufacturer($manufacturer_id) {
		$product_id = $this->product_id;

		$sql = "
			SELECT p.product_id" . $this->field_name;
		$sql .= "
			FROM ". DB_PREFIX . "product p ";
		$sql .= $this->table;
		$sql .= "	JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "')";

		$sql .= "
				WHERE p.status = 1
					AND (
						p.product_id = (
							SELECT p2.product_id FROM ". DB_PREFIX . "product p2 
							WHERE p2.product_id < ". (int)$product_id . "
								AND p2.manufacturer_id = " . (int)$manufacturer_id . "
								AND p2.status = '1'
								AND p2.date_available <= NOW()
							ORDER BY p2.product_id DESC 
							LIMIT 1
						)
						OR
						p.product_id = (
							SELECT p3.product_id FROM ". DB_PREFIX . "product p3 
							WHERE p3.product_id > ". (int)$product_id . "
								AND p3.manufacturer_id = " . (int)$manufacturer_id . "
								AND p3.status = '1'
								AND p3.date_available <= NOW()
							ORDER BY p3.product_id ASC
							LIMIT 1
						)
					)";
		$results = $this->db->query($sql);
	
		if ($results->num_rows == 1  && $this->config->get('prevnext_circle')) {
			$products = array();
			if ($results->rows[0]['product_id'] > $product_id) {
				//нет пред 
				$sql = "
					SELECT p.product_id" . $this->field_name;
				$sql .= "
					FROM ". DB_PREFIX . "product p ";
				$sql .= $this->table;
				$sql .= "	JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "')";
				$sql .= "
						WHERE p.product_id > ". (int)$product_id . "
							AND p.status = '1'
							AND p.manufacturer_id = " . (int)$manufacturer_id . "							
							AND p.date_available <= NOW()
						ORDER BY p.product_id DESC
						LIMIT 1";
				$res = $this->db->query($sql);
				if ($res->num_rows) {
					$products[] = $res->row;
				}
				$products[] = $results->row;				
			} else {
				//нет след
				$sql = "
					SELECT p.product_id" . $this->field_name;
				$sql .= "
					FROM ". DB_PREFIX . "product p ";
				$sql .= $this->table;
				$sql .= "	JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "')";
				$sql .= "
						WHERE p.product_id < ". (int)$product_id . "
							AND p.status = '1'
							AND p.manufacturer_id = " . (int)$manufacturer_id . "							
							AND p.date_available <= NOW()
						ORDER BY p.product_id ASC
						LIMIT 1";
				$res = $this->db->query($sql);
				$products[] = $results->row;
				if ($res->num_rows) {
					$products[] = $res->row;
				}
			}
		} else {
			$products = $results->rows;
		}
		return $products;
	}

	private function getCategory() {
		$product_id = $this->product_id;
		$category_id = 0;
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
			$category_id = (int)array_pop($parts);
			$this->path = 'path=' . $this->request->get['path'] . '&';
		}
		
		$sql = "
			SELECT p.product_id" . $this->field_name;
		$sql .= "
			FROM ". DB_PREFIX . "product p ";
		$sql .= $this->table;
		$sql .= "	JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "')";

		$sql .= "
			WHERE p.status = 1
				AND ( ";
		
		$sql_prev  = "
					p.product_id = (
						SELECT p2.product_id FROM ". DB_PREFIX . "product p2 ";
		if ($category_id) {
			$sql_prev .= "
						JOIN ". DB_PREFIX . "product_to_category p2c ON (p2.product_id = p2c.product_id AND p2c.category_id = '" . (int)$category_id . "')";		
		}		
		$sql_prev .= "
						WHERE p2.product_id < ". (int)$product_id . "
							AND p2.status = '1'
							AND p2.date_available <= NOW()
						ORDER BY p2.product_id DESC 
						LIMIT 1
					)";
		
		$sql .= $sql_prev;
		$sql .= "
					OR
				";

		$sql_next = "
					p.product_id = (
						SELECT p3.product_id FROM ". DB_PREFIX . "product p3 ";
		if ($category_id) {
			$sql_next .= "
						JOIN ". DB_PREFIX . "product_to_category p3c ON (p3.product_id = p3c.product_id AND p3c.category_id = '" . (int)$category_id . "')";		
		}		
		$sql_next .= "
						WHERE p3.product_id > ". (int)$product_id . "
							AND p3.status = '1'
							AND p3.date_available <= NOW()
						ORDER BY p3.product_id ASC
						LIMIT 1
					)";

		$sql .= $sql_next;
		$sql .= ") ORDER BY p.product_id";
		$results = $this->db->query($sql);
		$products = array();
		if ($results->num_rows == 1  && $this->config->get('prevnext_circle')) {
			if ($results->rows[0]['product_id'] > $product_id) {
				//нет пред 
				$sql = "
					SELECT p.product_id" . $this->field_name;
				$sql .= "
					FROM ". DB_PREFIX . "product p ";
				$sql .= $this->table;
				$sql .= "	JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "')";

				if ($category_id) {
					$sql .= "
						JOIN ". DB_PREFIX . "product_to_category p3c ON (p.product_id = p3c.product_id AND p3c.category_id = '" . (int)$category_id . "')";		
				}		
				$sql .= "
						WHERE p.product_id > ". (int)$product_id . "
							AND p.status = '1'
							AND p.date_available <= NOW()
						ORDER BY p.product_id DESC
						LIMIT 1";
				$res = $this->db->query($sql);
				if ($res->num_rows) {
					$products[] = $res->row;
				}
				$products[] = $results->row;				
			} else {
				//нет след
				$sql = "
					SELECT p.product_id" . $this->field_name;
				$sql .= "
					FROM ". DB_PREFIX . "product p ";
				$sql .= $this->table;
				$sql .= "	JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "')";

				if ($category_id) {
					$sql .= "
						JOIN ". DB_PREFIX . "product_to_category p3c ON (p.product_id = p3c.product_id AND p3c.category_id = '" . (int)$category_id . "')";		
				}		
				$sql .= "
						WHERE p.product_id < ". (int)$product_id . "
							AND p.status = '1'
							AND p.date_available <= NOW()
						ORDER BY p.product_id ASC
						LIMIT 1";
				$res = $this->db->query($sql);
				$products[] = $results->row;
				if ($res->num_rows) {
					$products[] = $res->row;
				}
			}
		} else {
			$products = $results->rows;
		}
		return $products;
	}

	private function render($results) {
		$product_id = $this->product_id;
		$prev_next['next'] = false;
		$prev_next['prev'] = false;
		$prev_next_key = array(
			array(
				'key' => 'prev',
				'text'=> $this->text_prev
			),
			array(
				'key' => 'next',
				'text'=> $this->text_next
			)
		);
		if ($results) {
			$i = 0;
			$c = count($results);
			if ($c > 1) {
				foreach ($results as $row) {
					$prev_next[$prev_next_key[$i]['key']]  = array(
						'href' => $this->url->link('product/product', $this->path . 'product_id=' . $row['product_id']),
						'name' => (!$this->config->get('prevnext_anchor'))?$row['name']:$prev_next_key[$i]['text']
					);
					$i++;
				}
			} elseif ($c == 1 && !$this->config->get('prevnext_circle')) {
				if ($results[0]['product_id'] > $product_id ) {
					$prev_next['next'] = array(
						'href' => $this->url->link('product/product', $this->path . 'product_id=' . $results[0]['product_id']),
						'name' => (!$this->config->get('prevnext_anchor'))?$results[0]['name']:$prev_next_key[$i]['text']
					);
					$prev_next['prev'] = false;
				} else {
					$prev_next['prev'] = array(
						'href' => $this->url->link('product/product', $this->path . 'product_id=' . $results[0]['product_id']),
						'name' => (!$this->config->get('prevnext_anchor'))?$results[0]['name']:$prev_next_key[$i]['text']
					);
					$prev_next['next'] = false;
				}
			}
			$data['next'] =  $prev_next['next'];
			$data['prev'] =  $prev_next['prev'];
			
			return $this->load->view('product/prevnextproduct.tpl', $data);

		} else {
			return false;
		}
	}
}