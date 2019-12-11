<?php
class ControllerExtensionModuleCtrlWatermark extends Controller
{
    private $error = array();
    
    protected function log($message)
    {
        file_put_contents(DIR_LOGS . $this->config->get("config_error_filename"), date("Y-m-d H:i:s - ") . "CTRL+WaterMark " . $message . "\r\n", FILE_APPEND);
    }
    protected function initBreadcrumbs($items, $data)
    {
        $newItems            = array_merge(array(
            array(
                "common/home",
                "text_home"
            )
        ), $items);
        $data['breadcrumbs'] = array();
        foreach ($newItems as $item) {
            if (isset($this->session->data['token'])) {
                $data['breadcrumbs'][] = array(
                    'href' => $this->url->link($item[0], 'token=' . $this->session->data['token'], 'SSL'),
                    'text' => $this->language->get($item[1]),
                    'separator' => (count($this->data['breadcrumbs']) == 0 ? false : ' :: ')
                );
            } else {
                $data['breadcrumbs'][] = array(
                    'href' => $this->url->link($item[0], 'SSL'),
                    'text' => $this->language->get($item[1]),
                    'separator' => (count($this->data['breadcrumbs']) == 0 ? false : ' :: ')
                );
            }
        }
        return $data;
    }
    protected function initParams($items, $data)
    {
        foreach ($items as $item) {
            if (isset($this->request->post[$item[0]])) {
                $data[$item[0]] = $this->request->post[$item[0]];
            } else if ($this->config->has($item[0])) {
                $data[$item[0]] = $this->config->get($item[0]);
            } else if (isset($item[1])) {
                $data[$item[0]] = $item[1];
            }
        }
        return $data;
    }
    protected function getWatermarkDirectories($dir, $result)
    {
        $items = glob($dir . '/*', GLOB_ONLYDIR);
        if (!empty($items)) {
            foreach ($items as $entry) {
                if ($entry == '.' || $entry == '..')
                    continue;
                $result[] = array(
                    'text' => substr($entry, strlen(DIR_IMAGE . 'catalog/')),
                    'value' => $entry
                );
                $result   = $this->getWatermarkDirectories($entry, $result);
            }
        }
        return $result;
    }
    private function deldir($dirname)
    {
        if (file_exists($dirname)) {
            if (is_dir($dirname)) {
                $dir = opendir($dirname);
                while ($filename = readdir($dir)) {
                    if ($filename != "." && $filename != "..") {
                        $file = $dirname . "/" . $filename;
                        $this->deldir($file);
                    }
                }
                closedir($dir);
                rmdir($dirname);
            } else {
                @unlink($dirname);
            }
        }
    }
    public function image()
    {
        $this->load->model('tool/image');
        if (isset($this->request->get['image'])) {
            $this->response->setOutput($this->model_tool_image->resize(html_entity_decode($this->request->get['image'], ENT_QUOTES, 'UTF-8'), 200, 200));
        }
    }
    public function getImgSize()
    {
        $json            = array();
        $json['success'] = false;
        $isfile          = file_exists(DIR_IMAGE . $this->request->post["src"]);
        if (!$isfile)
            return;
        $size = getimagesize(DIR_IMAGE . $this->request->post["src"]);
        if ($size) {
            $json["size"]    = $size;
            $json['success'] = true;
        }
        $this->response->setOutput(json_encode($json));
    }
    public function clean()
    {
        $dirs = glob(DIR_IMAGE . 'cache/*');
        foreach ($dirs as $dir) {
            $this->deldir($dir);
        }
        $this->language->load('extension/module/ctrl_watermark');
        $this->session->data['success'] = $this->language->get('text_success_clean');
        $this->response->redirect($this->url->link('extension/module/ctrl_watermark', 'token=' . $this->session->data['token'], 'SSL'));
    }
    public function index()
    {
        $data = $this->language->load('extension/module/ctrl_watermark');
        $this->document->setTitle($this->language->get('heading_title_title'));
        $this->document->addStyle('view/javascript/ctrl/jquery-ui.css');
        $this->document->addScript('view/javascript/ctrl/jquery-ui.js');
        $this->document->addStyle('view/stylesheet/ctrl_watermark.css');
        $this->document->addScript('view/javascript/ctrl/jquery.ui.rotatable.js');
        $this->load->model('setting/setting');
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('ctrl_watermark', $this->request->post);
            $this->session->data['success'] = $this->language->get('text_success');
            if ($this->request->post['action'] == "save") {
                $this->response->redirect($this->url->link('extension/module/ctrl_watermark', 'token=' . $this->session->data['token'], 'SSL'));
            } else {
                $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'));
            }
        }
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        }
        $data                      = $this->initBreadcrumbs(array(
            array(
                "extension/module",
                "text_module"
            ),
            array(
                "module/ctrl_watermark",
                "heading_title_title"
            ) 
        ), $data);
        $data['clean']             = $this->url->link('extension/module/ctrl_watermark/clean', 'token=' . $this->session->data['token'], 'SSL');
        $data['save']              = $this->url->link('extension/module/ctrl_watermark', 'token=' . $this->session->data['token'], 'SSL');
        $data['save_and_close']    = $this->url->link('extension/module/ctrl_watermark', 'token=' . $this->session->data['token'] . "&close=1", 'SSL');
        $data['close']             = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL');
        $data['token']             = $this->session->data['token'];
        $data['image_directories'] = $this->getWatermarkDirectories(DIR_IMAGE . 'catalog', array());
        $this->load->model('setting/store');
        $stores    = array();
        $stores[0] = array(
            "name" => $this->config->get('config_name') . $this->language->get('text_default'),
            "url" => rtrim($this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG, "/") . "/"
        );
        foreach ($this->model_setting_store->getStores() as $store) {
            $stores[$store['store_id']] = array(
                "name" => $store['name'],
                "url" => rtrim($store["url"], "/") . "/"
            );
        }
        $data['stores'] = $stores;
        $this->load->model("tool/image");
        $data = $this->initParams(array(
            array(
                "ctrl_watermark_debug",
                0
            )
        ), $data);
        foreach ($stores as $store_id => $store_data) {
            $data       = $this->initParams(array(
                array(
                    "ctrl_watermark_status_" . $store_id,
                    1
                ),
                array(
                    "ctrl_watermark_hide_real_path_" . $store_id,
                    1
                ),
                array(
                    "ctrl_watermark_debug_" . $store_id,
                    0
                ),
                array(
                    "ctrl_watermark_exclude_" . $store_id,
                    array(
                        DIR_IMAGE . "catalog/watermark"
                    )
                ),
                array(
                    "ctrl_watermark_size_" . $store_id,
                    50
                ),
                array(
                    "ctrl_watermark_min_height_" . $store_id,
                    150
                ),
                array(
                    "ctrl_watermark_min_width_" . $store_id,
                    150
                ),
                array(
                    "ctrl_watermark_max_height_" . $store_id,
                    600
                ),
                array(
                    "ctrl_watermark_max_width_" . $store_id,
                    600
                ),
                array(
                    "ctrl_watermark_left_" . $store_id,
                    40
                ),
                array(
                    "ctrl_watermark_top_" . $store_id,
                    78
                ),
                array(
                    "ctrl_watermark_width_" . $store_id,
                    56
                ),
                array(
                    "ctrl_watermark_height_" . $store_id,
                    22
                ),
                array(
                    "ctrl_watermark_angle_" . $store_id,
                    0
                )
            ), $data);
            $savedImage = $this->config->get("ctrl_watermark_image_" . $store_id);
            if ($savedImage && file_exists(DIR_IMAGE . $savedImage) && is_file(DIR_IMAGE . $savedImage)) {
                $data["ctrl_watermark_image_" . $store_id] = $savedImage;
            } else {
                $data["ctrl_watermark_image_" . $store_id] = "catalog/watermark/watermark.png";
            }
            $data["ctrl_watermark_default_image_" . $store_id]        = "catalog/watermark/watermark.png";
            $sizes                                                    = getimagesize(DIR_IMAGE . $data["ctrl_watermark_default_image_" . $store_id]);
            $data["ctrl_watermark_default_image_width_" . $store_id]  = 40;
            $data["ctrl_watermark_default_image_height_" . $store_id] = ceil($sizes[1] * (40 / $sizes[0]));
            $data["ctrl_watermark_default_image_left_" . $store_id]   = 50;
            $data["ctrl_watermark_default_image_top_" . $store_id]    = 90 - $data["ctrl_watermark_default_image_height_" . $store_id];
            $data["ctrl_watermark_default_image_angle_" . $store_id]  = 0;
            $data["ctrl_watermark_product_image_" . $store_id]        = "catalog/watermark/product.jpg";
            $data["ctrl_watermark_product_image_thumb_" . $store_id]  = $this->model_tool_image->resize($data["ctrl_watermark_product_image_" . $store_id], 300, 300);
            $data["ctrl_watermark_image_root_" . $store_id]           = $store_data['url'];
        }
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        $this->response->setOutput($this->load->view('extension/module/ctrl_watermark.tpl', $data));
    }
    private function validate()
    {
        if (!$this->user->hasPermission('modify', 'extension/module/ctrl_watermark')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }
}
;
