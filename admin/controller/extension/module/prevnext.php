<?php
class ControllerExtensionModulePrevNext extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/prevnext');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('prevnext', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module/prevnext', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_status'] = $this->language->get('entry_status');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/prevnext', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/module/prevnext', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

		if (isset($this->request->post['prevnext_enable'])) {
			$data['prevnext_enable'] = $this->request->post['prevnext_enable'];
		} else {
			$data['prevnext_enable'] = $this->config->get('prevnext_enable');
		}

		if (isset($this->request->post['prevnext_category'])) {
			$data['prevnext_category'] = $this->request->post['prevnext_category'];
		} else {
			$data['prevnext_category'] = $this->config->get('prevnext_category');
		}

		if (isset($this->request->post['prevnext_manufacturer'])) {
			$data['prevnext_manufacturer'] = $this->request->post['prevnext_manufacturer'];
		} else {
			$data['prevnext_manufacturer'] = $this->config->get('prevnext_manufacturer');
		}

		if (isset($this->request->post['prevnext_special'])) {
			$data['prevnext_special'] = $this->request->post['prevnext_special'];
		} else {
			$data['prevnext_special'] = $this->config->get('prevnext_special');
		}

		if (isset($this->request->post['prevnext_anchor_prev'])) {
			$data['prevnext_anchor_prev'] = $this->request->post['prevnext_anchor_prev'];
		} else {
			$data['prevnext_anchor_prev'] = $this->config->get('prevnext_anchor_prev');
		}
		
		if (isset($this->request->post['prevnext_anchor_next'])) {
			$data['prevnext_anchor_next'] = $this->request->post['prevnext_anchor_next'];
		} else {
			$data['prevnext_anchor_next'] = $this->config->get('prevnext_anchor_next');
		}

		if (isset($this->request->post['prevnext_anchor'])) {
			$data['prevnext_anchor'] = $this->request->post['prevnext_anchor'];
		} else {
			$data['prevnext_anchor'] = $this->config->get('prevnext_anchor');
		}
		if (isset($this->request->post['prevnext_circle'])) {
			$data['prevnext_circle'] = $this->request->post['prevnext_circle'];
		} else {
			$data['prevnext_circle'] = $this->config->get('prevnext_circle');
		}
		
		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();
		
		$data['entry_category']     	= $this->language->get('entry_category');
		$data['entry_manufacturer'] 	= $this->language->get('entry_manufacturer');	
		$data['entry_special']      	= $this->language->get('entry_special');	
		$data['entry_anchor']       	= $this->language->get('entry_anchor');	
		$data['entry_links']        	= $this->language->get('entry_links');	
		$data['entry_links_next']   	= $this->language->get('entry_links_next');	
		$data['entry_links_prev']   	= $this->language->get('entry_links_prev');	
		$data['entry_circle_links']     = $this->language->get('entry_circle_links');	
		
		$data['text_circle_links_help'] = $this->language->get('text_circle_links_help');			
		$data['text_category_help'] 	= $this->language->get('text_category_help');	
		$data['text_manufacturer_help']	= $this->language->get('text_manufacturer_help');	
		$data['text_special_help']     	= $this->language->get('text_special_help');	
		$data['text_anchor_help']      	= $this->language->get('text_anchor_help');	
		
		$data['tab_settings']      	    = $this->language->get('tab_settings');	
		$data['tab_help']      	        = $this->language->get('tab_help');	
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/prevnext', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/prevnext')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}