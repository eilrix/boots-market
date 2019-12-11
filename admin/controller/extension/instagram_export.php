<?php
class ControllerExtensionInstagramExport extends Controller {
	private $version = '2.0.18';
	private $error = array();
	private $usleep = 500000;
	private $debug = false;
	private $progress = 1;
	private $totalProducts;
	
	public function index() {
		$this->load->model('extension/instagram_export');
		$this->load->model('catalog/product');		
		
		// if (is_file(DIR_LOGS.'instagram_license.txt')) {
		// 	$file = file(DIR_LOGS.'instagram_license.txt');
		// } else {
		// 	$file[0] = '';
		// }
		
		// if ($file[0] != $this->generateKey()) {
		// 	echo "У Вас нет ключа для этого домена! Обратитесь к разработчику модуля!";
		// 	die();
		// }
		
		if (!$this->model_extension_instagram_export->getTable()) {
			$this->response->redirect($this->url->link('extension/instagram_export/settings', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		if (!$this->config->get('instagram_export_username')) {
			$this->install();
			$this->response->redirect($this->url->link('extension/instagram_export/settings', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->getList();
	}
	
	public function settings() {
		$data = $this->load->language('extension/instagram_export');
		
		$this->load->model('extension/instagram_export');
		$this->load->model('setting/setting');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateSettings()) {			
			$this->model_setting_setting->editSetting('instagram_export', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success_settings');

			$this->response->redirect($this->url->link('extension/instagram_export', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->document->setTitle($this->language->get('heading_title_settings'));
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/instagram_export', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title_settings'),
			'href' => $this->url->link('extension/instagram_export/settings', 'token=' . $this->session->data['token'], 'SSL')
		);
		
		$data['heading_title'] = $this->language->get('heading_title_settings');
		
		if ($this->config->get('instagram_export_username')) {
			$data['instagram_export_username'] = $this->config->get('instagram_export_username');
		} else {
			$data['instagram_export_username'] = '';
		}
		
		if ($this->config->get('instagram_export_password')) {
			$data['instagram_export_password'] = $this->config->get('instagram_export_password');
		} else {
			$data['instagram_export_password'] = '';
		}
		
		if ($this->config->get('instagram_export_width')) {
			$data['instagram_export_width'] = $this->config->get('instagram_export_width');
		} else {
			$data['instagram_export_width'] = 620;
		}
		
		if (isset($this->request->post['instagram_export_comment'])) {
			$data['instagram_export_comment'] = $this->request->post['instagram_export_comment'];
		} elseif ($this->config->get('instagram_export_comment')) {
			$data['instagram_export_comment'] = $this->config->get('instagram_export_comment');
		} else {
			$data['instagram_export_comment'] = 0;
		}
		
		if (isset($this->request->post['instagram_export_watermark'])) {
			$data['instagram_export_watermark'] = $this->request->post['instagram_export_watermark'];
		} elseif ($this->config->get('instagram_export_watermark')) {
			$data['instagram_export_watermark'] = $this->config->get('instagram_export_watermark');
		} else {
			$data['instagram_export_watermark'] = 0;
		}
		
		if (isset($this->request->post['instagram_export_bitly'])) {
			$data['instagram_export_bitly'] = $this->request->post['instagram_export_bitly'];
		} elseif ($this->config->get('instagram_export_bitly')) {
			$data['instagram_export_bitly'] = $this->config->get('instagram_export_bitly');
		} else {
			$data['instagram_export_bitly'] = 0;
		}
		
		if ($this->config->get('instagram_export_watermark_image')) {
			$data['instagram_export_watermark_image'] = $this->config->get('instagram_export_watermark_image');
		} else {
			$data['instagram_export_watermark_image'] = '';
		}
		
		if ($this->config->get('instagram_export_watermark_position')) {
			$data['instagram_export_watermark_position'] = $this->config->get('instagram_export_watermark_position');
		} else {
			$data['instagram_export_watermark_position'] = 'bottomright';
		}
		
		$this->load->model('tool/image');

		if ($this->config->get('instagram_export_watermark_image') && is_file(DIR_IMAGE . $this->config->get('instagram_export_watermark_image'))) {
			$data['instagram_export_watermark_thumb'] = $this->model_tool_image->resize($this->config->get('instagram_export_watermark_image'), 50, 50);
		} else {
			$data['instagram_export_watermark_thumb'] = $this->model_tool_image->resize('no_image.png', 50, 50);
		}
		
		if ($this->config->get('instagram_export_comment_text')) {
			$data['instagram_export_comment_text'] = $this->config->get('instagram_export_comment_text');
		} else {
			$data['instagram_export_comment_text'] = $this->language->get('text_comment_deff');
		}
		
		if ($this->config->get('instagram_export_total_products')) {
			$data['instagram_export_total_products'] = $this->config->get('instagram_export_total_products');
		} else {
			$data['instagram_export_total_products'] = $this->config->get('config_limit_admin');
		}
		
		if ($this->config->get('instagram_export_http_catalog')) {
			$data['instagram_export_http_catalog'] = $this->config->get('instagram_export_http_catalog');
		} else {
			$data['instagram_export_http_catalog'] = '';
		}
		
		if ($this->config->get('instagram_export_bitlyusername')) {
			$data['instagram_export_bitlyusername'] = $this->config->get('instagram_export_bitlyusername');
		} else {
			$data['instagram_export_bitlyusername'] = '';
		}
		
		if ($this->config->get('instagram_export_bitlypassword')) {
			$data['instagram_export_bitlypassword'] = $this->config->get('instagram_export_bitlypassword');
		} else {
			$data['instagram_export_bitlypassword'] = '';
		}
		
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->error['error_username'])) {
			$data['error_username'] = $this->error['error_username'];
		} else {
			$data['error_username'] = '';
		}
		
		if (isset($this->error['error_password'])) {
			$data['error_password'] = $this->error['error_password'];
		} else {
			$data['error_password'] = '';
		}
		
		if (isset($this->error['error_image_width'])) {
			$data['error_image_width'] = $this->error['error_image_width'];
		} else {
			$data['error_image_width'] = '';
		}
		
		if (isset($this->error['error_image_width_big'])) {
			$data['error_image_width_big'] = $this->error['error_image_width_big'];
		} else {
			$data['error_image_width_big'] = '';
		}
		
		if (isset($this->error['error_bitlyusername'])) {
			$data['error_bitlyusername'] = $this->error['error_bitlyusername'];
		} else {
			$data['error_bitlyusername'] = '';
		}
		
		if (isset($this->error['error_bitlypassword'])) {
			$data['error_bitlypassword'] = $this->error['error_bitlypassword'];
		} else {
			$data['error_bitlypassword'] = '';
		}
		
		if (isset($this->error['error_watermark_image'])) {
			$data['error_watermark_image'] = $this->error['error_watermark_image'];
		} else {
			$data['error_watermark_image'] = '';
		}
		
		if ($this->model_extension_instagram_export->getTable()) {
			$data['need_update'] = false;
		} else {
			$data['need_update'] = true;
		}
		
		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 50, 50);
		
		$data['version'] = $this->version;
		$data['action'] = $this->url->link('extension/instagram_export/settings', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/instagram_export', 'token=' . $this->session->data['token'], 'SSL');
		$data['token'] = $this->session->data['token'];
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('extension/instagram_export_settings.tpl', $data));
	}
	
	protected function getList() {		
		$data = $this->load->language('extension/instagram_export');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}

		if (isset($this->request->get['filter_model'])) {
			$filter_model = $this->request->get['filter_model'];
		} else {
			$filter_model = null;
		}

		if (isset($this->request->get['filter_category'])) {
			$filter_category = $this->request->get['filter_category'];
		} else {
			$filter_category = NULL;
		}

		if (isset($this->request->get['filter_post'])) {
			$filter_post = $this->request->get['filter_post'];
		} else {
			$filter_post = NULL;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'pd.name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . urlencode(html_entity_decode($this->request->get['filter_category'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . $this->request->get['filter_model'];
		}

		if (isset($this->request->get['filter_post'])) {
			$url .= '&filter_post=' . $this->request->get['filter_post'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/instagram_export', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		$data['products'] = array();
		
		$limitsss = $this->config->get('instagram_export_total_products') ? $this->config->get('instagram_export_total_products') : $this->config->get('config_limit_admin');
		
		$filter_data = array(
			'filter_name'	  => $filter_name,
			'filter_model'	  => $filter_model,
			'filter_category' => $filter_category,
			'filter_post' 	  => $filter_post,
			'sort'            => $sort,
			'order'           => $order,
			'start'           => ($page - 1) * $limitsss,
			'limit'           => $limitsss
		);

		$this->load->model('tool/image');

		$product_total = $this->model_extension_instagram_export->getTotalProducts($filter_data);
		
		$results = $this->model_extension_instagram_export->getProducts($filter_data);
		
		$this->load->model('catalog/category');

		$filter_data = array(
			'sort'	=> 'name',
			'order'	=> 'ASC'
		);

		$data['categories'] = $this->model_catalog_category->getCategories($filter_data);

		foreach ($results as $result) {

			$category =  $this->model_catalog_product->getProductCategories($result['product_id']);
            
			if (is_file(DIR_IMAGE . $result['image'])) {
				$image = $this->model_tool_image->resize($result['image'], 40, 40);
			} else {
				$image = $this->model_tool_image->resize('no_image.png', 40, 40);
			}
			
			$data['products'][] = array(
				'product_id' => $result['product_id'],
				'image'      => $image,
				'name'       => $result['name'],
				'description' => $result['instagram_description'] ? $result['instagram_description'] : $result['meta_description'],
				'model'      => $result['model'],
				'tag'		 => $result['instagram_tag'] ? $result['instagram_tag'] : $result['tag'],
				'category'   => $category,
				'date_export'=> $result['date_export'] ? date('d.m.y H:i:s', strtotime($result['date_export'])) : $result['date_export'],
				'href'		 => $this->url->link('catalog/product/edit', 'token=' . $this->session->data['token'] . '&product_id=' . $result['product_id'] . $url, 'SSL')
			);
		}
		if (!$this->config->get('instagram_export_username')) {
			$data['username'] = false;
		} else {
			$data['username'] = true;
		}
		
		$data['token'] = $this->session->data['token'];

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}

		if (isset($this->request->get['filter_post'])) {
			$url .= '&filter_post=' . $this->request->get['filter_post'];
		}

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_name'] = $this->url->link('extension/instagram_export', 'token=' . $this->session->data['token'] . '&sort=pd.name' . $url, 'SSL');
		$data['sort_order'] = $this->url->link('extension/instagram_export', 'token=' . $this->session->data['token'] . '&sort=p.sort_order' . $url, 'SSL');
		
		$data['export_link'] = $this->url->link('extension/instagram_export/export', 'token=' . $this->session->data['token'], 'SSL');
		$data['progress_link'] = $this->url->link('extension/instagram_export/getProgress', 'token=' . $this->session->data['token'], 'SSL');
		$data['settings'] = $this->url->link('extension/instagram_export/settings', 'token=' . $this->session->data['token'], 'SSL');
		$data['token'] = $this->session->data['token'];
		
		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $product_total;
		$pagination->page = $page;
		$pagination->limit = $limitsss;
		$pagination->url = $this->url->link('extension/instagram_export', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limitsss) + 1 : 0, ((($page - 1) * $limitsss) > ($product_total - $limitsss)) ? $product_total : ((($page - 1) * $limitsss) + $limitsss), $product_total, ceil($product_total / $limitsss));

		$data['filter_name'] = $filter_name;
		$data['filter_model'] = $filter_model;
		$data['filter_category'] = $filter_category;
		$data['filter_post'] = $filter_post;

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/instagram_export.tpl', $data));
	}
	
	public function export() {
		if (isset($this->request->post['selected'])) {			
			session_write_close();
			$this->cache->set('instagram_export_progress', $this->progress);
			$jsonData = array(
				'error'=> '',
				'success' => ''
			);
			
			$this->load->language('extension/instagram_export');
			$this->load->model('catalog/product');
			$this->load->model('extension/instagram_export');
			
			$this->totalProducts = count($this->request->post['selected']);
			$this->cache->set('instagram_export_progress_total', $this->totalProducts);
			
			foreach ($this->request->post['selected'] as $product_id) {
				$error = false;
				$product_data = $this->model_extension_instagram_export->getProduct($product_id);
				
				if (!$this->ExportLoad($this->getExportContent($product_data), $product_id)) {
                    $error = true;
                }
				if (!$error) {
					$this->model_extension_instagram_export->insertExportProduct($product_id);
				}
			}
			
			if ($error){
				$jsonData['error'] = "<span>Произошла ошибка при экспорте товара!</span>";
			} else {
				$jsonData['success'] = "<span>Товары успешно экспортированы!</span>";
			}
			
			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($jsonData));
		} else {
			$this->response->redirect($this->url->link('extension/instagram_export', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}
	
	private function ExportLoad($product_data) {		
		if (!$this->loadIng($product_data)) {
            return false;
        } else {
			
			usleep($this->usleep);

			return true;
		}
	}
	
	private function loadIng($product_data) {
		require_once(DIR_SYSTEM . 'library/Instagram/Instagram.php');
		
		$Instagram = new Instagram($this->config->get('instagram_export_username'), $this->config->get('instagram_export_password'), $this->debug, DIR_CACHE);
		
		try {
			$Instagram->login();
		} catch (InstagramException $e) {
			return false;
			exit();
		}
		
		if (!empty($product_data['image'])) {
			try {
				$progress = $this->progress++;
				$this->cache->set('instagram_export_progress', $progress);
				$Instagram->uploadPhoto($product_data['image'], $product_data['content']);
			} catch (InstagramException $e) {
				return false;
				exit();
			}
		}
		
		return true;
	}
	
	public function authorizeTest() {
		if (isset($this->request->post)) {
			$json = array();
			
			if (!empty($this->request->post['instagram_export_username']) and !empty($this->request->post['instagram_export_password'])) {
				
				require_once(DIR_SYSTEM . 'library/Instagram/Instagram.php');
				
				$Instagram = new Instagram($this->request->post['instagram_export_username'], $this->request->post['instagram_export_password'], $this->debug, DIR_CACHE);
				
				try {
					$Instagram->login();
					$json['success'] = "Авторизация успешно выполнена";
				} catch (InstagramException $e) {
					$json['error'] = "Авторизация не выполнена, проверьте Имя пользователя и Пароль";
				}
				
			} else {
				$json['error'] = "Введите Имя пользователя и Пароль";
			}
		} else {
			$this->response->redirect($this->url->link('extension/instagram_export/settings', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function getProgress() {
        $progress = $this->cache->get('instagram_export_progress');
		$totalProducts = $this->cache->get('instagram_export_progress_total');
		
		$json['progress'] = $progress;
		$json['percent'] = ceil(($progress) * 100 / $totalProducts);
		$json['total'] = $totalProducts;
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	private function getExportContent($product_data) {
		$export_data = array();

        if ($product_data['image']) {
            $image = $this->resize($product_data['image'], $this->config->get('instagram_export_width'), $this->config->get('instagram_export_width'));
        } else {
            $image = '';
        }
        
        $special = false;
        $product_specials = $this->model_catalog_product->getProductSpecials($product_data['product_id']);
			
        foreach ($product_specials  as $product_special) {
			if (($product_special['date_start'] == '0000-00-00' || $product_special['date_start'] > date('Y-m-d')) && ($product_special['date_end'] == '0000-00-00' || $product_special['date_end'] < date('Y-m-d'))) {
				$special = $product_special['price'];
				break;
			}					
        }
		
        if ($special){
            $price = $this->currency->format($special);
        } else {
            $price = $this->currency->format($product_data['price']);
        }
		
		if ($product_data['quantity'] <= 0) {
            $stock = $product_data['stock_status'];
        } elseif ($this->config->get('config_stock_display')) {
            $stock = $product_data['quantity'];
        } else {
            $stock = 'Есть в наличии';
        }
		
		if ($this->config->get('instagram_export_http_catalog')) {
            $http_catalog = $this->config->get('instagram_export_http_catalog');
        }
        else {
            $http_catalog = HTTP_CATALOG;
        }
        
        $link = $http_catalog . 'index.php?route=product/product&product_id=' . $product_data['product_id'];
        
        if ($this->config->get('config_seo_url') && isset($product_data['category_id']) && $product_data['keyword']){
            $link = $http_catalog;
            if ($this->config->get('config_seo_url_include_path') !== 0) {
				$this->load->model('catalog/category');
                $category = $this->model_catalog_category->getCategory($product_data['category_id']);
                $tmpcat = array();
                
				if (isset($category['keyword'])) {
                    if ($category['keyword']) {
                        $tmpcat[] = urlencode($category['keyword']);
                    }
                }
				
                if (isset($category['parent_id'])) {
                    while ($category['parent_id']) {
                        $category = $this->model_catalog_category->getCategory($category['parent_id']);
                        if ($category['keyword']) {
                            $tmpcat[] = urlencode($category['keyword']);
                        }
                    }
                }
				
                if ($tmpcat) {
                    $link .= implode('/', array_reverse($tmpcat)) . '/';
                }
            }
            $link .= urlencode($product_data['keyword']) . $this->config->get('config_seo_url_postfix');
        }
		
		if ($this->config->get('instagram_export_bitly')) {
			$link = $this->get_bitly_short_url($link,$this->config->get('instagram_export_bitlyusername'),$this->config->get('instagram_export_bitlypassword'));
		}
		
        $export_data['image'] = $image;
		
		if ($this->config->get('instagram_export_comment') and $this->config->get('instagram_export_comment_text')) {
			if (isset($product_data['meta_h1'])) {
				$h1 = !empty($product_data['meta_h1']) ? $product_data['meta_h1'] : $product_data['name'];
			} else {
				$h1 = '';
			}
			
			if (isset($product_data['meta_title'])) {
				$title = !empty($product_data['meta_title']) ? $product_data['meta_title'] : $product_data['name'];
			} else {
				$title = '';
			}
			
			$tag = !empty($product_data['instagram_tag']) ? $product_data['instagram_tag'] : $product_data['tag'];
			$description = !empty($product_data['instagram_description']) ? $product_data['instagram_description'] : $product_data['meta_description'];
			
			$cont = array(
				'{h1}'		=> strip_tags(html_entity_decode($h1, ENT_QUOTES, 'UTF-8')),
				'{title}'	=> strip_tags(html_entity_decode($title, ENT_QUOTES, 'UTF-8')),
				'{name}'	=> strip_tags(html_entity_decode($product_data['name'], ENT_QUOTES, 'UTF-8')),
				'{model}'	=> strip_tags(html_entity_decode($product_data['model'], ENT_QUOTES, 'UTF-8')),
				'{desc}'	=> strip_tags(html_entity_decode($description, ENT_QUOTES, 'UTF-8')),
				'{tag}'		=> !empty($tag) ? "#".strip_tags(html_entity_decode(str_replace(',',' #',str_replace(' ','',$tag)), ENT_QUOTES, 'UTF-8')) : '',
				'{stock}'	=> $stock,
				'{link}'	=> $link,
				'{price}'	=> $price
			);
			
			$export_data['content'] = str_replace(array_keys($cont), array_values($cont), $this->config->get('instagram_export_comment_text'));
		} else {
			$export_data['content'] = '';
		}
		
        return $export_data;
	}
	
	private function get_bitly_short_url($url, $login, $appkey, $format = "txt") {
		$connectURL = "http://api.bit.ly/v3/shorten?login=".$login."&apiKey=".$appkey."&uri=".urlencode($url)."&format=".$format;
		
		return $this->curl_get_result($connectURL);
	}
	
	private function curl_get_result($url) {
		$ch = curl_init();
		$timeout = 5;
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
		$data = curl_exec($ch);
		curl_close($ch);
		
		return $data;
	}
	
	private function resize($filename, $width, $height) {		
		if (!is_file(DIR_IMAGE . $filename)) {
			if (is_file(DIR_IMAGE . 'no_image.jpg')) {
				$filename = 'no_image.jpg';
			} elseif (is_file(DIR_IMAGE . 'no_image.png')) {
				$filename = 'no_image.png';
			} else {
				return;
			}
		}

		$extension = pathinfo($filename, PATHINFO_EXTENSION);

		$old_image = $filename;
		$new_image = 'cache/' . utf8_substr($filename, 0, utf8_strrpos($filename, '.')) . '-insta-' . $width . 'x' . $height . '.' . $extension;

		if (!is_file(DIR_IMAGE . $new_image) || (filectime(DIR_IMAGE . $old_image) > filectime(DIR_IMAGE . $new_image))) {
			$path = '';

			$directories = explode('/', dirname(str_replace('../', '', $new_image)));

			foreach ($directories as $directory) {
				$path = $path . '/' . $directory;

				if (!is_dir(DIR_IMAGE . $path)) {
					@mkdir(DIR_IMAGE . $path, 0777);
				}
			}

			list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $old_image);

			if ($width_orig != $width || $height_orig != $height) {
				$image = new Image(DIR_IMAGE . $old_image);
				
				if ($this->config->get('instagram_export_watermark') && ($width > 120 || $height > 120)) {
					$watermark = DIR_IMAGE . $this->config->get('instagram_export_watermark_image');
					$image->watermark(new Image($watermark), $this->config->get('instagram_export_watermark_position'));
				}
				
				$image->resize($width, $height);
				$image->save(DIR_IMAGE . $new_image);
			} else {
				copy(DIR_IMAGE . $old_image, DIR_IMAGE . $new_image);
			}
		}

		return DIR_IMAGE . $new_image;
	}
	
	public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_model'])) {
			$this->load->model('catalog/product');
			$this->load->model('catalog/option');

			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}

			if (isset($this->request->get['filter_model'])) {
				$filter_model = $this->request->get['filter_model'];
			} else {
				$filter_model = '';
			}

			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit = 5;
			}

			$filter_data = array(
				'filter_name'  => $filter_name,
				'filter_model' => $filter_model,
				'start'        => 0,
				'limit'        => $limit
			);

			$results = $this->model_catalog_product->getProducts($filter_data);

			foreach ($results as $result) {
				$option_data = array();

				$product_options = $this->model_catalog_product->getProductOptions($result['product_id']);

				foreach ($product_options as $product_option) {
					$option_info = $this->model_catalog_option->getOption($product_option['option_id']);

					if ($option_info) {
						$product_option_value_data = array();

						foreach ($product_option['product_option_value'] as $product_option_value) {
							$option_value_info = $this->model_catalog_option->getOptionValue($product_option_value['option_value_id']);

							if ($option_value_info) {
								$product_option_value_data[] = array(
									'product_option_value_id' => $product_option_value['product_option_value_id'],
									'option_value_id'         => $product_option_value['option_value_id'],
									'name'                    => $option_value_info['name'],
									'price'                   => (float)$product_option_value['price'] ? $this->currency->format($product_option_value['price'], $this->config->get('config_currency')) : false,
									'price_prefix'            => $product_option_value['price_prefix']
								);
							}
						}

						$option_data[] = array(
							'product_option_id'    => $product_option['product_option_id'],
							'product_option_value' => $product_option_value_data,
							'option_id'            => $product_option['option_id'],
							'name'                 => $option_info['name'],
							'type'                 => $option_info['type'],
							'value'                => $product_option['value'],
							'required'             => $product_option['required']
						);
					}
				}

				$json[] = array(
					'product_id' => $result['product_id'],
					'name'       => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
					'model'      => $result['model'],
					'option'     => $option_data,
					'price'      => $result['price']
				);
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/instagram_export')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
	
	protected function validateSettings() {
		if (!$this->user->hasPermission('modify', 'extension/instagram_export')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->request->post['instagram_export_username']) {
			$this->error['error_username'] = $this->language->get('error_username');
		}

		if (!$this->request->post['instagram_export_password']) {
			$this->error['error_password'] = $this->language->get('error_password');
		}

		if (!$this->request->post['instagram_export_width']) {
			$this->error['error_image_width'] = $this->language->get('error_image_width');
		}

		if ($this->request->post['instagram_export_width'] > 1080) {
			$this->error['error_image_width_big'] = $this->language->get('error_image_width_big');
		}

		if ($this->request->post['instagram_export_bitly'] and !$this->request->post['instagram_export_bitlyusername']) {
			$this->error['error_bitlyusername'] = $this->language->get('error_bitlyusername');
		}
		
		if ($this->request->post['instagram_export_bitly'] and !$this->request->post['instagram_export_bitlypassword']) {
			$this->error['error_bitlypassword'] = $this->language->get('error_bitlypassword');
		}
		
		if ($this->request->post['instagram_export_watermark'] and !$this->request->post['instagram_export_watermark_image']) {
			$this->error['error_watermark_image'] = $this->language->get('error_watermark_image');
		}
		
		return !$this->error;
	}
	
	private function library($class) {
		$file = DIR_SYSTEM . 'library/' . str_replace('\\', '/', strtolower($class)) . '.php';
		
		if (is_file($file)) {
			include_once($this->modification($file));

			return true;
		} else {
			return false;
		}
	}
	
	private function modification($filename) {
		if (!defined('DIR_CATALOG')) {
			$file = DIR_MODIFICATION . 'catalog/' . substr($filename, strlen(DIR_APPLICATION));
		} else {
			$file = DIR_MODIFICATION . 'admin/' .  substr($filename, strlen(DIR_APPLICATION));
		}

		if (substr($filename, 0, strlen(DIR_SYSTEM)) == DIR_SYSTEM) {
			$file = DIR_MODIFICATION . 'system/' . substr($filename, strlen(DIR_SYSTEM));
		}

		if (is_file($file)) {
			return $file;
		}

		return $filename;
	}
	
	public function updateD () {
		$json = array();
		
		if (isset($this->request->post) and !empty($this->request->post)) {
			$this->load->model('extension/instagram_export');
			$this->model_extension_instagram_export->updateText($this->request->post);
			
			$json['success'] = true;
		} else {
			$json['error'] = true;
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function updateT () {
		$json = array();
		
		if (isset($this->request->post) and !empty($this->request->post)) {
			$this->load->model('extension/instagram_export');
			$this->model_extension_instagram_export->updateTag($this->request->post);
			
			$json['success'] = true;
		} else {
			$json['error'] = true;
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function updateModule() {
		$json = array();
		if (isset($this->request->post) and !empty($this->request->post)) {
			$this->update($this->version);
			$json['success'] = true;
		} else {
			$json['error'] = true;
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	private function generateKey() {
		$key = md5($_SERVER['SERVER_NAME'].'-fedka3359-+380979626100');
		$key = gzcompress($key);
		$key = base64_encode($key);
		$key = md5($key);
		
		return $key;
	}
	
	private function install() {
		if (!$this->model_extension_instagram_export->getTable()) {
			$this->load->model('setting/setting');
			$this->model_setting_setting->editSetting('instagram_export', array(
				'instagram_export_username' => '',
				'instagram_export_password' => '',
				'instagram_export_width' => 620,
				'instagram_export_comment' => 1,
				'instagram_export_watermark' => 0,
				'instagram_export_watermark_thumb' => '',
				'instagram_export_watermark_position' => 'bottomright',
				'instagram_export_http_catalog' => '',
				'instagram_export_bitlyusername' => '',
				'instagram_export_bitlypassword' => '',
				'instagram_export_bitly' => 0,
				'instagram_export_version' => $this->version,
				'instagram_export_comment_text' => '{name} - {model}. {desc} {tag}',
				'instagram_export_total_products' => $this->config->get('config_limit_admin')
			));
			
			$this->load->model('extension/instagram_export');
			$this->model_extension_instagram_export->install();
		}
    }
	
	private function update($version) {
		$this->load->model('setting/setting');
        $this->model_setting_setting->editSetting('instagram_export', array(
			'instagram_export_username' => $this->config->get('instagram_export_username'),
            'instagram_export_password' => $this->config->get('instagram_export_password'),
            'instagram_export_width' => $this->config->get('instagram_export_width'),
            'instagram_export_comment' => $this->config->get('instagram_export_comment'),
			'instagram_export_comment_text' => $this->config->get('instagram_export_comment_text'),
            'instagram_export_total_products' => $this->config->get('instagram_export_total_products'),
            'instagram_export_watermark' => 0,
            'instagram_export_watermark_thumb' => '',
            'instagram_export_watermark_position' => 'bottomright',
            'instagram_export_bitly' => 0,
            'instagram_export_http_catalog' => '',
			'instagram_export_bitlyusername' => '',
            'instagram_export_bitlypassword' => '',
            'instagram_export_version' => $version,
        ));
		
		$this->load->model('extension/instagram_export');
		$this->model_extension_instagram_export->update();
	}
}