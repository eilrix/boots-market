<?php
/**************************************************************/
/*	@copyright	OCTemplates 2018.							  */
/*	@support	https://octemplates.net/					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModuleOctProductAutoRelated extends Controller {
    private $error = array();

    public function index() {
        $this->load->language('extension/module/oct_product_auto_related');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('extension/module');
        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('oct_product_auto_related', $this->request->post);
            $this->cache->delete('product');
            $this->session->data['success'] = $this->language->get('text_success');
            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
        }

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_edit']     = $this->language->get('text_edit');
        $data['text_enabled']  = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_cache']    = $this->language->get('text_cache');

        $data['entry_limit']  = $this->language->get('entry_limit');
        $data['entry_width']  = $this->language->get('entry_width');
        $data['entry_height'] = $this->language->get('entry_height');
        $data['entry_status'] = $this->language->get('entry_status');

        $data['button_save']   = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');

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

        if (isset($this->session->data['warning'])) {
            $data['warning'] = $this->session->data['warning'];

            unset($this->session->data['warning']);
        } else {
            $data['warning'] = '';
        }

        if (isset($this->error['width'])) {
            $data['error_width'] = $this->error['width'];
        } else {
            $data['error_width'] = '';
        }

        if (isset($this->error['height'])) {
            $data['error_height'] = $this->error['height'];
        } else {
            $data['error_height'] = '';
        }

        if (isset($this->error['limit'])) {
            $data['error_limit'] = $this->error['limit'];
        } else {
            $data['error_limit'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/module/oct_product_auto_related', 'token=' . $this->session->data['token'], true)
        );

        $data['action'] = $this->url->link('extension/module/oct_product_auto_related', 'token=' . $this->session->data['token'], true);

        $data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

        $data['cache_cleaner'] = $this->url->link('extension/module/oct_product_auto_related/cache', 'token=' . $this->session->data['token'], true);

        if (isset($this->request->post['oct_product_auto_related_data'])) {
            $data['oct_product_auto_related_data'] = $this->request->post['oct_product_auto_related_data'];
        } else {
            $data['oct_product_auto_related_data'] = $this->config->get('oct_product_auto_related_data');
        }

        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/module/oct_product_auto_related.tpl', $data));
    }

    public function install() {
        $this->load->language('extension/module/oct_product_auto_related');

        $this->load->model('extension/extension');
        $this->load->model('setting/setting');
        $this->load->model('user/user_group');

        $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'extension/module/oct_product_auto_related');
        $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'extension/module/oct_product_auto_related');

        $this->model_setting_setting->editSetting('oct_product_auto_related', array(
            'oct_product_auto_related_data' => array(
                'status' => '1',
                'limit' => '4',
                'width' => '200',
                'height' => '200'
            )
        ));

        if (!in_array('oct_product_auto_related', $this->model_extension_extension->getInstalled('module'))) {
            $this->model_extension_extension->install('module', 'oct_product_auto_related');
        }

        $this->session->data['success'] = $this->language->get('text_success_install');
    }

    public function uninstall() {
        $this->load->model('extension/extension');
        $this->load->model('setting/setting');
        $this->model_extension_extension->uninstall('module', 'oct_product_auto_related');
        $this->model_setting_setting->deleteSetting('oct_product_auto_related');
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/module/oct_product_auto_related')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->request->post['oct_product_auto_related_data']['limit']) {
            $this->error['limit'] = $this->language->get('error_limit');
        }

        if (!$this->request->post['oct_product_auto_related_data']['width']) {
            $this->error['width'] = $this->language->get('error_width');
        }

        if (!$this->request->post['oct_product_auto_related_data']['height']) {
            $this->error['height'] = $this->language->get('error_height');
        }

        return !$this->error;
    }

    public function cache() {
        $this->load->language('extension/module/oct_product_auto_related');

        if (!$this->user->hasPermission('modify', 'extension/module/oct_product_auto_related')) {
            $this->session->data['warning'] = $this->language->get('error_permission');
        } else {
            $this->cache->delete('octemplates.oct_product_auto_related');

            $this->session->data['success'] = $this->language->get('text_success_cache');
        }

        $this->response->redirect($this->url->link('extension/module/oct_product_auto_related', 'token=' . $this->session->data['token'], true));
    }
}
