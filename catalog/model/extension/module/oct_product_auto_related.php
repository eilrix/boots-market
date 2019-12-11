<?php
/**************************************************************/
/*	@copyright	OCTemplates 2018.							  */
/*	@support	https://octemplates.net/					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelExtensionModuleOctProductAutoRelated extends Model {
    public function getProductAutoRelated($data = array()) {
        $product_info = $this->getProduct($data['product_id']);

        $product_data = $this->cache->get('octemplates.oct_product_auto_related.product.' . (int) $this->config->get('config_store_id') . '.' . (int) $this->config->get('config_customer_group_id') . '.' . (int) $product_info['product_id'] . '.' . (int)$this->config->get('config_language_id'));

        if (!$product_data) {
            //$sql = "SELECT p.product_id, (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int) $this->config->get('config_customer_group_id') . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int) $this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special";

            $sql = "SELECT p.product_id";

            if (!empty($data['filter_category_id'])) {
                if (!empty($data['filter_sub_category'])) {
                    $sql .= " FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (cp.category_id = p2c.category_id)";
                } else {
                    $sql .= " FROM " . DB_PREFIX . "product_to_category p2c";
                }
                $sql .= " LEFT JOIN " . DB_PREFIX . "product p ON (p2c.product_id = p.product_id)";
            } else {
                $sql .= " FROM " . DB_PREFIX . "product p";
            }

            $sql .= " LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND p.status = '1' AND p.quantity > 0 AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";

            if (!empty($data['filter_category_id'])) {
                if (!empty($data['filter_sub_category'])) {
                    $sql .= " AND cp.path_id = '" . (int) $data['filter_category_id'] . "'";
                } else {
                    $sql .= " AND p2c.category_id = '" . (int) $data['filter_category_id'] . "'";
                }
            }

            $implode = array();

            $words = explode(' ', $product_info['name']);

            $i = 0;
            foreach ($words as $word) {
                if ($i <= 1) {
                    $implode[] = " LCASE(pd.name) LIKE '%" . $this->db->escape($word) . "%'";
                }
                $i++;
            }

            if ($implode) {
                $sql .= " AND " . implode(" AND ", $implode) . "";
            }

            $sql .= " GROUP BY p.product_id";

            $sort_data = array(
                'pd.name',
                'p.sort_order',
                'p.date_added',
                'p.product_id'
            );

            if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
                if ($data['sort'] == 'pd.name' || $data['sort'] == 'p.product_id') {
                    $sql .= " ORDER BY LCASE(" . $data['sort'] . ")";
                } else {
                    $sql .= " ORDER BY " . $data['sort'];
                }
            } else {
                $sql .= " ORDER BY p.sort_order";
            }

            if (isset($data['order']) && ($data['order'] == 'DESC')) {
                $sql .= " DESC, LCASE(pd.name) DESC";
            } else {
                $sql .= " ASC, LCASE(pd.name) ASC";
            }

            if (isset($data['start']) || isset($data['limit'])) {
                if ($data['start'] < 0) {
                    $data['start'] = 0;
                }

                if ($data['limit'] < 1) {
                    $data['limit'] = 20;
                }

                $sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
            }

            $product_data = array();

            $query = $this->db->query($sql);

            foreach ($query->rows as $result) {
                if ($product_info['product_id'] != $result['product_id']) {
                    $product_data[$result['product_id']] = $this->getProduct($result['product_id']);
                }
            }

            $this->cache->set('octemplates.oct_product_auto_related.product.' . (int) $this->config->get('config_store_id') . '.' . (int) $this->config->get('config_customer_group_id') . '.' . (int) $product_info['product_id'] . '.' . (int)$this->config->get('config_language_id'), $product_data);
        }

        return $product_data;
    }

    public function getProduct($product_id) {
		if ($this->checkOctIfTableExist(DB_PREFIX . "manufacturer_description") && $this->checkIfColumnExist(DB_PREFIX . "manufacturer_description", "name")) {
			$query = $this->db->query("SELECT DISTINCT *, pd.name AS name, p.image, (SELECT md.name FROM " . DB_PREFIX . "manufacturer_description md WHERE md.manufacturer_id = p.manufacturer_id AND md.language_id = '" . (int)$this->config->get('config_language_id') . "') AS manufacturer, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special, (SELECT points FROM " . DB_PREFIX . "product_reward pr WHERE pr.product_id = p.product_id AND customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "') AS reward, (SELECT ss.name FROM " . DB_PREFIX . "stock_status ss WHERE ss.stock_status_id = p.stock_status_id AND ss.language_id = '" . (int)$this->config->get('config_language_id') . "') AS stock_status, (SELECT wcd.unit FROM " . DB_PREFIX . "weight_class_description wcd WHERE p.weight_class_id = wcd.weight_class_id AND wcd.language_id = '" . (int)$this->config->get('config_language_id') . "') AS weight_class, (SELECT lcd.unit FROM " . DB_PREFIX . "length_class_description lcd WHERE p.length_class_id = lcd.length_class_id AND lcd.language_id = '" . (int)$this->config->get('config_language_id') . "') AS length_class, (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating, (SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review r2 WHERE r2.product_id = p.product_id AND r2.status = '1' GROUP BY r2.product_id) AS reviews, p.sort_order FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");

			if ($query->num_rows) {
				return array(
					'product_id'       => $query->row['product_id'],
					'name'             => $query->row['name'],
					'description'      => $query->row['description'],
					'model'            => $query->row['model'],
					'quantity'         => $query->row['quantity'],
					'stock_status'     => $query->row['stock_status'],
					'image'            => $query->row['image'],
					'manufacturer_id'  => $query->row['manufacturer_id'],
					'manufacturer'     => $query->row['manufacturer'],
					'price'            => ($query->row['discount'] ? $query->row['discount'] : $query->row['price']),
					'special'          => $query->row['special'],
					'tax_class_id'     => $query->row['tax_class_id'],
					'weight'           => $query->row['weight'],
					'weight_class_id'  => $query->row['weight_class_id'],
					'length'           => $query->row['length'],
					'width'            => $query->row['width'],
					'height'           => $query->row['height'],
					'length_class_id'  => $query->row['length_class_id'],
					'subtract'         => $query->row['subtract'],
					'rating'           => round($query->row['rating']),
					'reviews'          => $query->row['reviews'] ? $query->row['reviews'] : 0,
					'minimum'          => $query->row['minimum'],
					'oct_stock_status_id' => $query->row['stock_status_id'],
				);
			} else {
				return false;
			}
		} else {
			$this->load->model('catalog/product');

			return $this->model_catalog_product->getProduct($product_id);
		}
	}

	public function checkOctIfTableExist($table_name) {
        $query = $this->db->query("SELECT COUNT(*) as total FROM information_schema.TABLES WHERE TABLE_SCHEMA = '" . DB_DATABASE . "' AND TABLE_NAME = '" . $table_name . "'")->row['total'];

        return $query;
    }

    public function checkIfColumnExist($table_name, $table_column) {
        $query = $this->db->query("SELECT COUNT(*) as total FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = '" . DB_DATABASE . "' AND TABLE_NAME = '" . $table_name . "' AND COLUMN_NAME  = '" . $table_column . "'")->row['total'];

        return $query;
    }
}
