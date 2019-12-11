<?php
/* All rights reserved belong to the module, the module developers http://opencartadmin.com */
// http://opencartadmin.com © 2011-2017 All Rights Reserved
// Distribution, without the author's consent is prohibited
// Commercial license
class ControllerAgooJetcacheJetcache extends Controller
{
	private $error = array();
	protected $data;
    /*
	public function index($data) {

		return $data;
	}
    */
	public function settings($data) {
		$this->data = $data;
		$this->config->set("blog_work", true);

       	$this->language->load('agoo/jetcache/jetcache');

		$this->data['header'] 	= '';
		$this->data['menu'] 	= '';
		$this->data['footer'] 	= '';
		$this->data['column_left'] 	= '';

		$this->template = 'agoo/jetcache/settings.tpl';
        $this->data['language'] = $this->language;

        $this->data['url_jetcache'] = $this->url->link('jetcache/jetcache', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['entry_url_jetcache'] = $this->language->get('entry_url_jetcache');


		if (!isset($this->data['ascp_settings']['jetcache_widget_status'])) {
			$this->data['ascp_settings']['jetcache_widget_status'] = true;
		}

        if (SC_VERSION < 20) {
			$html = $this->render();
		} else {
			$html = $this->load->view($this->template, $this->data);
		}

        $this->data['widgets']['jetcache']['code'] = 'jetcache';
        $this->data['widgets']['jetcache']['name'] = $this->language->get('text_widget_jetcache_settings');
        $this->data['widgets']['jetcache']['order'] = $this->language->get('order_jetcache');
        $this->data['widgets']['jetcache']['html'] = $html;

	    return $this->data;

	}



	private function table_exists($tableName) {
		$found= false;
		$like   = addcslashes($tableName, '%_\\');
		$result = $this->db->query("SHOW TABLES LIKE '" . $this->db->escape($like) . "';");
		$found  = $result->num_rows > 0;
		return $found;
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/blog')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
