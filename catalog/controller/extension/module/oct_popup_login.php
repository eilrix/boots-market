<?php
/**************************************************************/
/*  @copyright  OCTemplates 2018.               */
/*  @support  https://octemplates.net/            */
/*  @license  LICENSE.txt                   */

/**************************************************************/

class ControllerExtensionModuleOctPopupLogin extends Controller {
  public function index() {
    $data = array();
    
    $this->load->language('extension/module/oct_popup_login');
    
    $data['heading_title'] = $this->language->get('heading_title');
    
    $data['text_login']     = $this->language->get('text_login');
    $data['entry_email']    = $this->language->get('entry_email');
    $data['entry_password'] = $this->language->get('entry_password');
    
    $data['button_login']     = $this->language->get('button_login');
    $data['button_register']  = $this->language->get('button_register');
    $data['button_forgotten'] = $this->language->get('button_forgotten');
    
    $data['register_url']  = $this->url->link('account/register', '', 'SSL');
    $data['forgotten_url'] = $this->url->link('account/forgotten', '', 'SSL');
    $data['account_url']   = $this->url->link('account/account', '', 'SSL');
    
    $this->response->setOutput($this->load->view('extension/module/oct_popup_login', $data));
  }
  
  public function login() {
    $json = array();
    
    $this->load->language('extension/module/oct_popup_login');
    $this->load->model('account/customer');
    
    // Check how many login attempts have been made.
    $login_info = $this->model_account_customer->getLoginAttempts($this->request->post['email']);
    
    if ($login_info && ($login_info['total'] >= $this->config->get('config_login_attempts')) && strtotime('-1 hour') < strtotime($login_info['date_modified'])) {
      $json['warning'] = $this->language->get('error_attempts');
    }
    
    // Check if customer has been approved.
    $customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);
    
    if ($customer_info && !$customer_info['approved']) {
      $json['warning'] = $this->language->get('error_approved');
    }
    
    if (!isset($json['warning'])) {
      if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
        $json['warning'] = $this->language->get('error_login');
        
        $this->model_account_customer->addLoginAttempt($this->request->post['email']);
      } else {
        $this->model_account_customer->deleteLoginAttempts($this->request->post['email']);
      }
    }
    
    $this->response->addHeader('Content-Type: application/json');
    $this->response->setOutput(json_encode($json));
  }
}