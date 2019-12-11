<?php
/**************************************************************/
/*	@copyright	OCTemplates 2018.							  */
/*	@support	https://octemplates.net/					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ControllerExtensionModuleOctBlogCategory extends Controller {
    private $error = array();

    public function index() {
        $this->load->language('extension/module/oct_blog_category');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('extension/module');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            if (!isset($this->request->get['module_id'])) {
                $this->model_extension_module->addModule('oct_blog_category', $this->request->post);
            } else {
                $this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
            }

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
        }

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_edit']         = $this->language->get('text_edit');
        $data['text_enabled']      = $this->language->get('text_enabled');
        $data['text_disabled']     = $this->language->get('text_disabled');
        $data['text_blog_setting'] = $this->language->get('text_blog_setting');
        $data['text_sort_order_1'] = $this->language->get('text_sort_order_1');
        $data['text_sort_order_2'] = $this->language->get('text_sort_order_2');
        $data['text_sort_order_3'] = $this->language->get('text_sort_order_3');
        $data['text_sort_order_4'] = $this->language->get('text_sort_order_4');

        $data['entry_name']       = $this->language->get('entry_name');
        $data['entry_width']      = $this->language->get('entry_width');
        $data['entry_height']     = $this->language->get('entry_height');
        $data['entry_status']     = $this->language->get('entry_status');
        $data['entry_sort_order'] = $this->language->get('entry_sort_order');
        $data['entry_show_image'] = $this->language->get('entry_show_image');

        $data['button_save']   = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->error['name'])) {
            $data['error_name'] = $this->error['name'];
        } else {
            $data['error_name'] = '';
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

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
        );

        if (!isset($this->request->get['module_id'])) {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('extension/module/oct_blog_category', 'token=' . $this->session->data['token'], true)
            );
        } else {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('extension/module/oct_blog_category', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true)
            );
        }

        $data['blog_setting'] = $this->url->link('octemplates/blog_setting', 'token=' . $this->session->data['token'], true);

        if (!isset($this->request->get['module_id'])) {
            $data['action'] = $this->url->link('extension/module/oct_blog_category', 'token=' . $this->session->data['token'], true);
        } else {
            $data['action'] = $this->url->link('extension/module/oct_blog_category', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true);
        }

        $data['token'] = $this->session->data['token'];

        $data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

        if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
        }

        if (isset($this->request->post['name'])) {
            $data['name'] = $this->request->post['name'];
        } elseif (!empty($module_info)) {
            $data['name'] = $module_info['name'];
        } else {
            $data['name'] = '';
        }

        if (isset($this->request->post['width'])) {
            $data['width'] = $this->request->post['width'];
        } elseif (!empty($module_info)) {
            $data['width'] = $module_info['width'];
        } else {
            $data['width'] = 25;
        }

        if (isset($this->request->post['height'])) {
            $data['height'] = $this->request->post['height'];
        } elseif (!empty($module_info)) {
            $data['height'] = $module_info['height'];
        } else {
            $data['height'] = 25;
        }

        $data['oct_blogs'] = array();

        if (isset($this->request->post['oct_blog'])) {
            $blogs = $this->request->post['oct_blog'];
        } elseif (!empty($module_info['oct_blog'])) {
            $blogs = $module_info['oct_blog'];
        } else {
            $blogs = array();
        }

        $this->load->model('octemplates/blog_category');

        foreach ($blogs as $oct_blog_category_id) {
            $blog_info = $this->model_octemplates_blog_category->getCategory($oct_blog_category_id);

            if ($blog_info) {
                $data['oct_blogs'][] = array(
                    'oct_blog_category_id' => $blog_info['oct_blog_category_id'],
                    'name' => $blog_info['name']
                );
            }
        }

        if (isset($this->request->post['status'])) {
            $data['status'] = $this->request->post['status'];
        } elseif (!empty($module_info)) {
            $data['status'] = $module_info['status'];
        } else {
            $data['status'] = '';
        }

        if (isset($this->request->post['sort_order'])) {
            $data['sort_order'] = $this->request->post['sort_order'];
        } elseif (!empty($module_info)) {
            $data['sort_order'] = $module_info['sort_order'];
        } else {
            $data['sort_order'] = '';
        }

        if (isset($this->request->post['show_image'])) {
            $data['show_image'] = $this->request->post['show_image'];
        } elseif (!empty($module_info)) {
            $data['show_image'] = $module_info['show_image'];
        } else {
            $data['show_image'] = '';
        }

        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/module/oct_blog_category.tpl', $data));
    }

	public function install() {
		$this->load->model('extension/extension');
        $this->load->model('setting/setting');
		$this->load->model('octemplates/blog_setting');
		$this->load->model('user/user_group');
        $this->load->model('localisation/language');

		if (!in_array('oct_blog_setting', $this->model_extension_extension->getInstalled('octemplates'))) {
			$this->model_octemplates_blog_setting->installTables();

			$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'octemplates/blog_setting');
			$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'octemplates/blog_setting');
			$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'octemplates/blog_category');
			$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'octemplates/blog_category');
			$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'octemplates/blog_article');
			$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'octemplates/blog_article');
			$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'octemplates/blog_comments');
			$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'octemplates/blog_comments');

			foreach ($this->model_localisation_language->getLanguages() as $language) {
				$default_language_data[$language['language_id']] = array(
					'seo_title' => '',
					'seo_meta_description' => '',
					'seo_meta_keywords' => '',
					'seo_h1' => '',
					'seo_description' => ''
				);
			}

			$this->model_setting_setting->editSetting('oct_blog_setting', array(
				'oct_blog_setting_data' => array(
					'status' => '1',
					'comment_moderation' => '1',
					'desc_limit' => '400',
					'main_image_width' => '400',
					'main_image_height' => '300',
					'main_image_popup_width' => '800',
					'main_image_popup_height' => '600',
					'sub_image_width' => '400',
					'sub_image_height' => '300',
					'r_p_image_width' => '228',
					'r_p_image_height' => '228',
					'r_a_image_width' => '400',
					'r_a_image_height' => '300',
					'a_image_width_in_category' => '400',
					'a_image_height_in_category' => '300',
					'comment_write' => '1',
					'comment_show' => '1',
					'c_image_width' => '80',
					'c_image_height' => '80',
					'language' => $default_language_data
				)
			));

			$this->model_extension_extension->install('octemplates', 'oct_blog_setting');
		}
	}

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/module/oct_blog_category')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
            $this->error['name'] = $this->language->get('error_name');
        }

        if (!$this->request->post['width']) {
            $this->error['width'] = $this->language->get('error_width');
        }

        if (!$this->request->post['height']) {
            $this->error['height'] = $this->language->get('error_height');
        }

        return !$this->error;
    }
}
