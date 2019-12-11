<?php
class ControllerJetcacheJetcache extends Controller
{
	private $error = array();
	protected $data;

	public function jetcache_construct() {

		return true;
	}


	public function index()	{
		$this->config->set('blog_work', true);
		$this->language->load('module/blog');
		$this->language->load('agoo/html/html');
		$this->language->load('agoo/jetcache/jetcache');

		$this->load->model('setting/setting');


		$this->data['widget_jetcache_version'] = $this->language->get('text_widget_jetcache_settings');
		$this->data['tab_general']  = $this->language->get('tab_general');
		$this->data['tab_list']     = $this->language->get('tab_list');

		$this->document->setTitle(strip_tags($this->data['widget_jetcache_version']));

		if (file_exists(DIR_APPLICATION . 'view/stylesheet/seocmspro.css')) {
			$this->document->addStyle('view/stylesheet/seocmspro.css');
		}
		if (file_exists(DIR_APPLICATION . 'view/stylesheet/jetcache/jetcache.css')) {
			$this->document->addStyle('view/stylesheet/jetcache/jetcache.css');
		}

		if (file_exists(DIR_APPLICATION . 'view/javascript/jquery/tabs.js')) {
			$this->document->addScript('view/javascript/jquery/tabs.js');
		} else {
			if (file_exists(DIR_APPLICATION . 'view/javascript/blog/tabs/tabs.js')) {
				$this->document->addScript('view/javascript/blog/tabs/tabs.js');
			}
		}
		if (file_exists(DIR_APPLICATION . 'view/javascript/blog/seocmspro.js')) {
			$this->document->addScript('view/javascript/blog/seocmspro.js');
		}

		if (SC_VERSION < 20) {
				$this->document->addStyle('view/javascript/seocms/bootstrap/css/bootstrap.css');
				//$this->document->addScript('view/javascript/seocms/bootstrap/jquery-2.1.1.min.js');
				//$this->document->addScript('view/javascript/seocms/bootstrap/js/bootstrap.min.js');
		}

        $this->data['ascp_settings'] = $this->config->get('ascp_settings');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            $this->request->post['ascp_settings']['seocms_jetcache_alter'] = 1;

			$this->cache->delete('jetcache');

			$data['asc_jetcache_settings']['asc_jetcache_settings'] = $this->request->post['asc_jetcache_settings'];
			$this->model_setting_setting->editSetting('asc_jetcache_settings', $data['asc_jetcache_settings']);

            $data['ascp_settings']['ascp_settings'] = array_merge($this->data['ascp_settings'], $this->request->post['ascp_settings']);
            $this->model_setting_setting->editSetting('ascp_settings', $data['ascp_settings']);

            if (isset($this->request->post['asc_jetcache_settings']['pages_db_status']) && $this->request->post['asc_jetcache_settings']['pages_db_status']) {
				if ($this->table_exists(DB_PREFIX . "jetcache_pages_0")) {

				} else {
                	$this->create_tables('pages');
				}
            }
            if (isset($this->request->post['asc_jetcache_settings']['cont_db_status']) && $this->request->post['asc_jetcache_settings']['cont_db_status']) {
				if ($this->table_exists(DB_PREFIX . "jetcache_cont_0")) {

				} else {
                	$this->create_tables('cont');
				}
            }
            if (isset($this->request->post['asc_jetcache_settings']['model_db_status']) && $this->request->post['asc_jetcache_settings']['model_db_status']) {
				if ($this->table_exists(DB_PREFIX . "jetcache_model_0")) {

				} else {
                	$this->create_tables('model');
				}
            }

			$this->session->data['success'] = $this->language->get('text_success');
				if (SC_VERSION < 20) {
					$this->redirect($this->url->link('jetcache/jetcache', 'token=' . $this->session->data['token'], 'SSL'));
				} else {
					$this->response->redirect($this->url->link('jetcache/jetcache', 'token=' . $this->session->data['token'], 'SSL'));
				}
		}

		$this->data['token'] = $this->session->data['token'];
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['entry_jetcache_template'] = $this->language->get('entry_jetcache_template');
  		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['tab_list'] = $this->language->get('tab_list');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['url_jetcache'] = $this->url->link('jetcache/jetcache', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_record'] = $this->url->link('catalog/record', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_fields'] = $this->url->link('catalog/fields', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_comment'] = $this->url->link('catalog/comment', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_create'] = $this->url->link('jetcache/jetcache/createtables', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_delete'] = $this->url->link('jetcache/jetcache/deletesettings', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_modules'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_modules_text'] = $this->language->get('url_modules_text');
		$this->data['url_jetcache_text'] = $this->language->get('url_jetcache_text');
		$this->data['url_record_text'] = $this->language->get('url_record_text');
		$this->data['url_fields_text'] = $this->language->get('url_fields_text');
		$this->data['url_comment_text'] = $this->language->get('url_comment_text');
		$this->data['url_create_text'] = $this->language->get('url_create_text');
		$this->data['url_delete_text'] = $this->language->get('url_delete_text');
		$this->data['url_options'] = $this->url->link('jetcache/jetcache', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_schemes'] = $this->url->link('jetcache/jetcache/schemes', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_widgets'] = $this->url->link('jetcache/jetcache/widgets', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['action'] = $this->url->link('jetcache/jetcache', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		foreach ($this->data['languages'] as $code => $language) {
			if (!isset($language['image'])) {
            	$this->data['languages'][$code]['image'] = "language/".$code."/".$code.".png";
			} else {
                $this->data['languages'][$code]['image'] = "view/image/flags/".$language['image'];
			}
			if (!file_exists(DIR_APPLICATION.$this->data['languages'][$code]['image'])) {
				$this->data['languages'][$code]['image'] = "view/image/seocms/sc_1x1.png";
			}
		}

        $this->data['config_language_id'] = $this->config->get('config_language_id');


		$this->load->model('setting/store');
		$this->data['stores'] = $this->model_setting_store->getStores();

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}


		$this->data['breadcrumbs'] = array();
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('jetcache/jetcache', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' / '
		);
		if (isset($this->request->post['asc_jetcache_settings'])) {
			$this->data['asc_jetcache_settings'] = $this->request->post['asc_jetcache_settings'];
		} else {
			$this->data['asc_jetcache_settings'] = $this->config->get('asc_jetcache_settings');
		}



		$this->data['modules'] = array();
		if (isset($this->request->post['jetcache_module'])) {
			$this->data['modules'] = $this->request->post['jetcache_module'];
		} elseif ($this->config->get('jetcache_module')) {
			$this->data['modules'] = $this->config->get('jetcache_module');
		}

		if (isset($this->request->post['asc_jetcache_settings']['ex_route'])) {
              foreach ($this->request->post['asc_jetcache_settings']['ex_route'] as $type_id => $ex_route) {
                 if ($ex_route ['route'] == '') {
                   $this->request->post['asc_jetcache_settings']['ex_route'][$ex_route ['type_id']] ['route'] = 'Type-'.$ex_route ['type_id'];
              	 }

              	 if ($type_id != $ex_route ['type_id']) {
              	 	unset($this->request->post['asc_jetcache_settings']['ex_route'][$type_id]);
              	 	$this->request->post['asc_jetcache_settings']['ex_route'][$ex_route ['type_id']] = $ex_route;
              	 }
              }
		}



        if (!isset($this->data['asc_jetcache_settings']['seocms_jetcache_gzip_level'])) {
        	$this->data['asc_jetcache_settings']['seocms_jetcache_gzip_level'] = 9;
        }

		 if (!isset($this->data['gzip_level'])) {
			 $this->data['gzip_level'] =
			 array(0 => 0, 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9);
          }


		 if (!isset($this->data['asc_jetcache_settings']['ex_route'])) {
			 $this->data['asc_jetcache_settings']['ex_route'] =
			 array( 0 =>
			 		array(
			 				'route' => 'checkout/%',
			 				'type_id' => '0',
			 				'status' => '1'
			 			 ),
					1 =>
			 		array(
			 				'route' =>  'account/%',
			 				'type_id' => '1',
			 				'status' => '1'
			 			 ),
					2 =>
			 		array(
			 				'route' =>  'api/%',
			 				'type_id' => '2',
			 				'status' => '1'
			 			 ),
					3 =>
			 		array(
			 				'route' =>  'error/%',
			 				'type_id' => '3',
			 				'status' => '1'
			 			 ),
					4 =>
			 		array(
			 				'route' =>  '%/country',
			 				'type_id' => '4',
			 				'status' => '1'
			 			 ),
					5 =>
			 		array(
			 				'route' =>  '%/captcha',
			 				'type_id' => '5',
			 				'status' => '1'
			 			 ),
					6 =>
			 		array(
			 				'route' =>  '%/ajax_viewed',
			 				'type_id' => '6',
			 				'status' => '1'
			 			 ),
					7 =>
			 		array(
			 				'route' =>  'simplecheckout/%',
			 				'type_id' => '7',
			 				'status' => '1'
			 			 )

			 );
		 }


		if (isset($this->request->post['asc_jetcache_settings']['ex_page'])) {
              foreach ($this->request->post['asc_jetcache_settings']['ex_page'] as $type_id => $ex_page) {
                 if ($ex_page ['url'] == '') {
                   $this->request->post['asc_jetcache_settings']['ex_page'][$ex_page ['type_id']] ['url'] = 'Type-'.$ex_page ['type_id'];
              	 }

              	 if ($type_id != $ex_page ['type_id']) {
              	 	unset($this->request->post['asc_jetcache_settings']['ex_page'][$type_id]);
              	 	$this->request->post['asc_jetcache_settings']['ex_page'][$ex_page ['type_id']] = $ex_page;
              	 }
              }
		}

		 if (!isset($this->data['asc_jetcache_settings']['ex_page']) || empty($this->data['asc_jetcache_settings']['ex_page'])) {
			 $this->data['asc_jetcache_settings']['ex_page'] =
			 array( 0 =>
			 		array(
			 				'url' => 'simplecheckout',
			 				'type_id' => 0,
			 				'accord' => 0,
			 				'status' => 0
			 			 )


			 );
		 }



		if (isset($this->request->post['asc_jetcache_settings']['add_cont'])) {
              foreach ($this->request->post['asc_jetcache_settings']['add_cont'] as $type_id => $add_cont) {
                 if ($add_cont['cont'] == '') {
                   $this->request->post['asc_jetcache_settings']['add_cont'][$add_cont['type_id']] ['cont'] = 'Type-'.$add_cont['type_id'];
              	 }

              	 if ($type_id != $add_cont['type_id']) {
              	 	unset($this->request->post['asc_jetcache_settings']['add_cont'][$type_id]);
              	 	$this->request->post['asc_jetcache_settings']['add_cont'][$add_cont['type_id']] = $add_cont;
              	 }
              }
		}

		if (SC_VERSION > 22) {
			$array_cont['bestseller'] = 'extension/module/bestseller';
			$array_cont['featured'] = 'extension/module/featured';
			$array_cont['affiliate'] = 'extension/module/affiliate';
            $array_cont['category'] = 'extension/module/category';
            $array_cont['latest'] = 'extension/module/latest';
            $array_cont['special'] = 'extension/module/special';
		} else {
			$array_cont['bestseller'] = 'module/bestseller';
			$array_cont['featured'] = 'module/featured';
			$array_cont['affiliate'] = 'module/affiliate';
			$array_cont['category'] = 'module/category';
            $array_cont['latest'] = 'module/latest';
            $array_cont['special'] = 'module/special';
		}


		if (!isset($this->data['asc_jetcache_settings']['ex_session']) || empty($this->data['asc_jetcache_settings']['ex_session'])) {
			$this->data['asc_jetcache_settings']['ex_session'] = 'product_viewed'.PHP_EOL;
		}


		 if (!isset($this->data['asc_jetcache_settings']['add_cont']) || empty($this->data['asc_jetcache_settings']['add_cont'])) {
			 $this->data['asc_jetcache_settings']['add_cont'] =
			 array( 0 =>
			 		array(
			 				'cont' => 'common/footer',
			 				'type_id' => 0,
			 				'status' => 1
			 			 ),
			 		1 =>
			 		array(

			 				'cont' => $array_cont['bestseller'],
			 				'type_id' => 1,
			 				'status' => 1
			 			 ),
			 		2 =>
			 		array(
			 				'cont' => $array_cont['featured'],
			 				'type_id' => 2,
			 				'status' => 1
			 			 ),
			 		3 =>
			 		array(
			 				'cont' => $array_cont['category'],
			 				'type_id' => 3,
			 				'status' => 1
			 			 ),
			 		4 =>
			 		array(
			 				'cont' => $array_cont['latest'],
			 				'type_id' => 4,
			 				'status' => 1
			 			 ),
			 		5 =>
			 		array(
			 				'cont' => $array_cont['special'],
			 				'type_id' => 5,
			 				'status' => 1
			 			 ),
			 		6 =>
			 		array(
			 				'cont' => $array_cont['affiliate'],
			 				'type_id' => 6,
			 				'status' => 0
			 			 ),
			 		7 =>
			 		array(
			 				'cont' => 'common/column_left',
			 				'type_id' => 7,
			 				'status' => 0
			 			 ),
			 		8 =>
			 		array(
			 				'cont' => 'common/column_right',
			 				'type_id' => 8,
			 				'status' => 0
			 			 ),
			 		9 =>
			 		array(
			 				'cont' => 'common/content_top',
			 				'type_id' => 9,
			 				'status' => 0
			 			 ),
			 		10 =>
			 		array(
			 				'cont' => 'common/content_bottom',
			 				'type_id' => 10,
			 				'status' => 0
			 			 ),
			 		11 =>
			 		array(
			 				'cont' => 'common/header',
			 				'type_id' => 11,
			 				'status' => 1
			 			 ),
			 		12 =>
			 		array(
			 				'cont' => 'common/home',
			 				'type_id' => 12,
			 				'status' => 0
			 		)

			 );
		 }

		if (!isset($this->data['ascp_settings']['cache_auto_clear'])) {
        	$this->data['ascp_settings']['cache_auto_clear'] = 168;
		}

		if (!isset($this->data['ascp_settings']['cache_max_hache_folders_level'])) {
        	$this->data['ascp_settings']['cache_max_hache_folders_level'] = 1;
		}

		if (!$this->config->get('asc_cache_auto_clear')) {
             $this->model_setting_setting->editSetting('asc_cache_auto', array('asc_cache_auto_clear' => time()));
		}

        if (version_compare(VERSION, '2.0', '<')) {
	        $mod_str = 'module/httpsfix/cacheremove';
	        $mod_str_value = 'mod=1&';
        } else {
	        $mod_str = 'extension/modification/refresh';
	        $mod_str_value = '';
        }

        $this->data['url_ocmod_refresh'] = $this->url->link($mod_str, $mod_str_value.'token=' . $this->session->data['token'], 'SSL');
        $this->data['url_cache_remove'] = $this->url->link('module/blog/cacheremove', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['url_cache_image_remove'] = $this->url->link('module/blog/cacheremove', 'image=1&token=' . $this->session->data['token'], 'SSL');

        /*
        agoo_cont('agooa/adminmenu', $this->registry);
        $this->data['agoo_menu'] = $this->controller_agooa_adminmenu->index();
        */


		$this->data['icon'] = getSCWebDir(DIR_IMAGE , $this->data['ascp_settings']).'jetcache/jetcache-icon.png';

  		$this->language->load('localisation/currency');
  		$this->load->model('localisation/currency');

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'title';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		$data = array(
			'sort'  => $sort,
			'order' => $order,
		);
		$results = $this->model_localisation_currency->getCurrencies($data);

		foreach ($results as $result) {
			$this->data['currencies'][] = array(
				'currency_id'   => $result['currency_id'],
				'title'         => $result['title'] . (($result['code'] == $this->config->get('config_currency')) ? $this->language->get('text_default') : null),
				'code'          => $result['code'],
				'value'         => $result['value'],
				'date_modified' => date($this->language->get('date_format_short'), strtotime($result['date_modified']))
			);
		}

		$this->load->model('design/layout');
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->data['session']     = $this->session;
		$this->template         = 'jetcache/jetcache.tpl';
		$this->children         = array(
			'common/header',
			'common/footer'
		);
		$this->data['registry'] = $this->registry;
		$this->data['language'] = $this->language;
		$this->data['config']   = $this->config;


		if (SC_VERSION < 20) {
			$this->data['column_left'] = '';
			$html                      = $this->render();
		} else {
			$this->data['header']      = $this->load->controller('common/header');
			$this->data['menu']        = $this->load->controller('common/menu');
			$this->data['footer']      = $this->load->controller('common/footer');
			$this->data['column_left'] = $this->load->controller('common/column_left');
			$html                      = $this->load->view($this->template, $this->data);
		}
		$this->response->setOutput($html);

	}

/***************************************/
	private function validate()
	{
		$this->language->load('jetcache/jetcache');
		if (!$this->user->hasPermission('modify', 'jetcache/jetcache')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if (!$this->error) {
			return true;
		} else {
			$this->request->post = array();
			return false;
		}
	}

/***************************************/
	public function deletesettings()
	{
	    if (($this->request->server['REQUEST_METHOD'] == 'GET') && $this->validate()) {
		    $html = "";
			$this->language->load('jetcache/jetcache');
			$this->load->model('setting/setting');

			$this->model_setting_setting->deleteSetting('asc_jetcache_settings');
			$this->model_setting_setting->deleteSetting('asc_widget_jetcache_version');

			$html =  $this->language->get('text_success');

			$this->response->setOutput($html);
		} else {

			$html = $this->language->get('error_permission');

			$this->response->setOutput($html);
		}
	}

/***************************************/
	public function createTables()
	{
         if (($this->request->server['REQUEST_METHOD'] == 'GET') && $this->validate()) {
            $html = "";
			$this->language->load('jetcache/jetcache');
			$this->data['widget_jetcache_version'] = $this->language->get('widget_jetcache_version');
			$this->load->model('setting/setting');

			$setting_version = Array(
				'asc_widget_jetcache_version' => $this->data['widget_jetcache_version']
			);
			$this->model_setting_setting->editSetting('asc_widget_jetcache_version', $setting_version);


			$msql = "SELECT * FROM `" . DB_PREFIX . "layout_route` WHERE `route`='product/search'";
			$query = $this->db->query($msql);
			if (count($query->rows) <= 0) {
				$msql = "INSERT INTO `" . DB_PREFIX . "layout` (`name`) VALUES  ('Search');";
				$query = $this->db->query($msql);
				$msql = "INSERT INTO `" . DB_PREFIX . "layout_route` (`route`, `layout_id`) VALUES  ('product/search'," . $this->db->getLastId() . ");";
				$query = $this->db->query($msql);
			}


		if ($this->config->get('config_seo_url_type')!='seo_url') {
			$devider = true;
		} else {
			$devider = false;
		}

		if (!$this->config->get('asc_jetcache_settings') && !is_array($this->config->get('asc_jetcache_settings'))) {
            $aoptions = Array(
            	'switch' => true,
            	'cache_widgets' => false,
            	'pagination' => false

            );


            $this->load->model('localisation/language');
			$languages = $this->model_localisation_language->getLanguages();
			foreach ($languages as $language) {

				$prefix = $language['code'].'/';
				if ($this->config->get('config_language') == $language['code']) {
					$prefix = '';
				}
				$aoptions['prefix'][$language['code']] = $prefix;
				$aoptions['hreflang'][$language['code']] = $language['code'];

				$pagination_title = $this->language->get('text_pagination_title');

				if ($language['code'] == 'ru') {
					$pagination_title = $this->language->get('text_pagination_title_russian');
				}
				if ($language['code'] == 'ua') {
					$pagination_title = $this->language->get('text_pagination_title_ukraine');
				}

				$aoptions['pagination_title'][$language['code']] = $pagination_title;
			}

			$settings = Array(
				'asc_jetcache_settings' => $aoptions
			);
			$this->model_setting_setting->editSetting('asc_jetcache_settings', $settings);

			$html .= $this->language->get('text_install_ok');

		} else {
            $html .= $this->language->get('text_install_already');
		}


		$this->response->setOutput($html);
		}  else {
			$html = $this->language->get('error_permission');
			$this->response->setOutput($html);
		}
	}

	private function table_exists($tableName) {
		$found= false;
		$like   = addcslashes($tableName, '%_\\');
		$result = $this->db->query("SHOW TABLES LIKE '" . $this->db->escape($like) . "';");
		$found  = $result->num_rows > 0;
		return $found;
	}

	public function visual($arg) {
	}


	private function create_tables($table) {

		for ($i = 0; $i < 5; $i++) {

$sql[$i] = "
CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "jetcache_".$table."_".$i."` (
`id` INT(11) NOT NULL,
`key_db` VARCHAR(255) NOT NULL,
`value_db` LONGTEXT NOT NULL,
`time_expire_db` INT(11) NOT NULL,
PRIMARY KEY (`key_db`),
INDEX (`time_expire_db`)) ENGINE = MyISAM CHARACTER
SET utf8 COLLATE utf8_general_ci;";
}

		foreach ($sql as $qsql) {
			$query = $this->db->query($qsql);
		}

	}

/***************************************/
}
