<?php
class ModelExtensionInstagramExport extends Model {
	public function getProducts($data = array()) {
		if ($data) {
			$sql = "SELECT SQL_CALC_FOUND_ROWS p.*, pd.*,pi.date_export, 
                (SELECT COUNT(*) FROM " . DB_PREFIX . "instagram_export_photos WHERE product_id = p.product_id) AS export_products 
                FROM " . DB_PREFIX . "product p
                LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)
                LEFT JOIN " . DB_PREFIX . "product_to_category pc ON (p.product_id = pc.product_id)
                LEFT JOIN " . DB_PREFIX . "instagram_export_photos pi ON (pi.product_id = p.product_id)
                WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'"; 
		
			if (isset($data['filter_name']) && !is_null($data['filter_name'])) {
				$sql .= " AND LCASE(pd.name) LIKE '%" . $this->db->escape(strtolower($data['filter_name'])) . "%'";
			}

			if (isset($data['filter_model']) && !is_null($data['filter_model'])) {
				$sql .= " AND LCASE(p.model) LIKE '%" . $this->db->escape(strtolower($data['filter_model'])) . "%'";
			}
			
			if (isset($data['filter_post']) && is_numeric($data['filter_post']) && $data['filter_post']) {
				$sql .= " AND (SELECT COUNT(*) FROM " . DB_PREFIX . "instagram_export_photos WHERE product_id = p.product_id) >= 1";
			} else if (is_numeric($data['filter_post']) && !$data['filter_post']) {
                $sql .= " AND (SELECT COUNT(*) FROM " . DB_PREFIX . "instagram_export_photos WHERE product_id = p.product_id) = 0";
            }
			
			if (isset($data['filter_date_export']) && !is_null($data['filter_date_export'])) {
                $date = explode('-', $data['filter_date_export']);
				$sql .= " AND pi.date_export LIKE '" . $date[2] . "-" . $date[1] . "-" . $date[0] . "%'";
			}
			
			if (isset($data['filter_category']) && !is_null($data['filter_category'])) {
				$sql .= " AND pc.category_id = '" . (int)$data['filter_category'] . "'";
			}
            
            $sql .= ' GROUP BY p.product_id';
            
			$sort_data = array(
				'pd.name',
				'p.model',
				'p.price',
				'p.quantity',
				'p.status',
				'pi.date_export',
				'p.sort_order'
			);	
			
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY pd.name";	
			}
			
			if (isset($data['order']) && ($data['order'] == 'DESC')) {
				$sql .= " DESC";
			} else {
				$sql .= " ASC";
			}
		
			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}				

				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}	
			
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}	
            
			$query = $this->db->query($sql);
		
			return $query->rows;
		} else {
			$product_data = $this->cache->get('product.' . $this->config->get('config_language_id'));
		
			if (!$product_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY pd.name ASC");
	
				$product_data = $query->rows;
			
				$this->cache->set('product.' . $this->config->get('config_language_id'), $product_data);
			}	
	
			return $product_data;
		}
	}
	
	 public function getTotalProducts($data = array()) {
		$sql = "SELECT COUNT(DISTINCT p.product_id) AS total,
            (SELECT COUNT(*) FROM " . DB_PREFIX . "instagram_export_photos WHERE product_id = p.product_id) AS export_products
            FROM " . DB_PREFIX . "product p 
            LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)
			LEFT JOIN " . DB_PREFIX . "product_to_category pc ON (p.product_id = pc.product_id)
			LEFT JOIN " . DB_PREFIX . "instagram_export_photos pi ON (pi.product_id = p.product_id)
        ";
		
		$sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
		
		if (!empty($data['filter_name'])) {
			$sql .= " AND LCASE(pd.name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}

		if (!empty($data['filter_model'])) {
			$sql .= " AND LCASE(p.model) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_model'])) . "%'";
		}
		
		if (isset($data['filter_post']) && is_numeric($data['filter_post']) && $data['filter_post']) {
			$sql .= " AND (SELECT COUNT(*) FROM " . DB_PREFIX . "instagram_export_photos WHERE product_id = p.product_id) >= 1";
		} else if (is_numeric($data['filter_post']) && !$data['filter_post']) {
			$sql .= " AND (SELECT COUNT(*) FROM " . DB_PREFIX . "instagram_export_photos WHERE product_id = p.product_id) = 0";
		}
		
		if (isset($data['filter_date_export']) && !is_null($data['filter_date_export'])) {
			$date = explode('-', $data['filter_date_export']);
			$sql .= " AND pi.date_export LIKE '" . $date[2] . "-" . $date[1] . "-" . $date[0] . "%'";
		}
		
		if (isset($data['filter_category']) && !is_null($data['filter_category'])) {
            $sql .= " AND pc.category_id = '" . (int)$data['filter_category'] . "'";
        }
		
		$query = $this->db->query($sql);
		
		return $query->row['total'];
	}
	
	public function getProduct($product_id) {
		$query = $this->db->query("SELECT p.*, pd.name, pd.instagram_tag, pd.tag, pd.meta_title, pd.meta_h1, pd.instagram_description, pd.meta_description, pc.category_id,
            (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id . "') AS keyword,
            (SELECT ss.name FROM " . DB_PREFIX . "stock_status ss WHERE ss.stock_status_id = p.stock_status_id AND ss.language_id = '" . (int)$this->config->get('config_language_id') . "') AS stock_status,
            m.name AS manufacturer
            FROM " . DB_PREFIX . "product p 
            LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) 
            LEFT JOIN " . DB_PREFIX . "product_to_category pc ON (p.product_id = pc.product_id) 
            LEFT JOIN " . DB_PREFIX . "instagram_export_photos pi ON (pi.product_id = p.product_id) 
            LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id)
            WHERE 
            p.product_id = '" . (int)$product_id . "' 
            AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'
        ");
		
		return $query->row;
	}
	
	public function insertExportProduct($product_id) {
		$query = $this->db->query("SELECT product_id FROM " . DB_PREFIX . "instagram_export_photos WHERE product_id='".(int)$product_id."'");
		
		if (isset($query->row['product_id'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "instagram_export_photos SET product_id = '" . (int)$product_id . "', date_export = NOW() WHERE product_id = '" . (int)$product_id . "'");
		} else {
			$this->db->query("INSERT INTO " . DB_PREFIX . "instagram_export_photos SET product_id = '" . (int)$product_id . "', date_export = NOW()");
		}
	}
	
	public function getTable() {
		$query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "instagram_export_photos'");
		
		if ($query->num_rows) {
			return true;
		} else {
			return false;
		}
	}
	
	public function updateText($data) {
		$this->db->query("UPDATE " . DB_PREFIX . "product_description SET instagram_description = '" . $this->db->escape($data['text']) . "' WHERE product_id = '" . (int)$data['product_id'] . "'");
	}
	
	public function updateTag($data) {
		$this->db->query("UPDATE " . DB_PREFIX . "product_description SET instagram_tag = '" . $this->db->escape($data['text']) . "' WHERE product_id = '" . (int)$data['product_id'] . "'");
	}
	
	public function install() {
		if (!$this->getTable()) {
			$this->db->query("
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "instagram_export_photos` (
			  `product_id` int(11) NOT NULL,
			  `date_export` datetime NOT NULL
			) ENGINE=MyISAM DEFAULT CHARSET=utf8;
			");
			
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "product_description` ADD `instagram_description` TEXT NOT NULL AFTER `description`");
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "product_description` ADD `instagram_tag` TEXT NOT NULL AFTER `tag`");
		}
	}
	
	public function update() {
		$this->db->query("
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "instagram_export_photos` (
		  `product_id` int(11) NOT NULL,
		  `date_export` datetime NOT NULL
		) ENGINE=MyISAM DEFAULT CHARSET=utf8;
		");
		
		$this->db->query("ALTER TABLE `" . DB_PREFIX . "product_description` ADD `instagram_description` TEXT NOT NULL AFTER `description`");
		$this->db->query("ALTER TABLE `" . DB_PREFIX . "product_description` ADD `instagram_tag` TEXT NOT NULL AFTER `tag`");
	}
}