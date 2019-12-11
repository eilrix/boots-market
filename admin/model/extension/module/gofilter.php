<?php
class ModelExtensionModuleGofilter extends Model {

	public function createGofilter() {
			
		$res0 = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "gofilter'");
		if($res0->num_rows == 0){
			$this->db->query("
				CREATE TABLE IF NOT EXISTS `". DB_PREFIX. "gofilter` (
				  `id` int(11) NOT NULL AUTO_INCREMENT,
				  `code` varchar(255) NOT NULL,
				  `key` varchar(255) NOT NULL,
				  `value` longtext NOT NULL,
				  `serialized` int(11) NOT NULL,
				  PRIMARY KEY (`id`)
				) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
			");
		}
	
	}
	
	public function getGofilter($code) {
		$setting_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "gofilter WHERE `code` = '" . $this->db->escape($code) . "'");

		foreach ($query->rows as $result) {
			$setting_data[$result['key']] = $result['value'];
		}

		return $setting_data;
	}

	public function editGofilter($code, $data) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "gofilter` WHERE `code` = '" . $this->db->escape($code) . "'");

		foreach ($data as $key => $value) {
			if (substr($key, 0, strlen($code)) == $code) {
				if (!is_array($value)) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "gofilter SET `code` = '" . $this->db->escape($code) . "', `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape($value) . "'");
				} else {
					$this->db->query("INSERT INTO " . DB_PREFIX . "gofilter SET `code` = '" . $this->db->escape($code) . "', `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape(json_encode($value)) . "', serialized = '1'");
				}
			}
		}
	}
	
	public function getRouting($route_id) {
		$query = $this->db->query("SELECT route FROM " . DB_PREFIX . "layout_route WHERE layout_id = '" . (int)$route_id . "'");
		if($query->num_rows){
			$route = $query->row['route'];
		} else {
			$route = false;
		}
		return $route;
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
}
