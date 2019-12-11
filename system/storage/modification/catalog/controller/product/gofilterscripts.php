<?php
class ControllerProductGofilterscripts extends Controller {
	public function index() {

        $data['oct_popup_view_data'] = $this->config->get('oct_popup_view_data');
        $data['button_popup_view'] = $this->language->get('button_popup_view');
      
		
		$data = array();
		
		$this->load->language('extension/module/gofilter');
		
		$data['text_reset_all'] = $this->language->get('text_reset_all');

		if (isset($this->request->get['nofilter'])) {
			$data['nofilter'] = $this->request->get['nofilter'];
		} else {
			$data['nofilter'] = false;
		}
		
		return $this->load->view('product/gofilterscripts', $data);
	}
}
