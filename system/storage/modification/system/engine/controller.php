<?php
abstract class Controller {
	protected $registry;

	public function __construct($registry) {
		$this->registry = $registry;

				if( ! empty( $this->request->get['mfp'] ) && ! $this->config->get('mfp_path_was_verificed') && isset( $this->request->get['route'] ) ) {
					preg_match( '/path\[([^]]*)\]/', $this->request->get['mfp'], $mf_matches );
								
					if( class_exists( 'VQMod' ) ) {
						require_once VQMod::modCheck( modification( DIR_SYSTEM . '../catalog/model/module/mega_filter.php' ) );
					} else {
						require_once modification( DIR_SYSTEM . '../catalog/model/module/mega_filter.php' );
					}
				
					if( empty( $mf_matches[1] ) ) {
						preg_match( '#path,([^/]+)#', $this->request->get['mfp'], $mf_matches );
				
						if( ! empty( $mf_matches[1] ) ) {				
							if( class_exists( 'MegaFilterCore' ) ) {
								$mf_matches[1] = MegaFilterCore::__parsePath( $this, $mf_matches[1] );
							}
						}
					} else if( class_exists( 'MegaFilterCore' ) ) {
						$mf_matches[1] = MegaFilterCore::__parsePath( $this, $mf_matches[1] );
					}

					if( ! empty( $mf_matches[1] ) ) {
						if( empty( $this->request->get['mfilterAjax'] ) && ! empty( $this->request->get['path'] ) && $this->request->get['path'] != $mf_matches[1] ) {
							$this->request->get['mfp_org_path'] = $this->request->get['path'];
				
							if( 0 === ( $mf_strpos = strpos( $this->request->get['mfp_org_path'], $mf_matches[1] . '_' ) ) ) {
								$this->request->get['mfp_org_path'] = substr( $this->request->get['mfp_org_path'], $mf_strpos+strlen($mf_matches[1])+1 );
							}
						} else {
							$this->request->get['mfp_org_path'] = '';
						}
				
						//$this->request->get['path'] = $mf_matches[1];
						$this->request->get['mfp_path'] = $mf_matches[1];

						if( isset( $this->request->get['category_id'] ) || ( isset( $this->request->get['route'] ) && in_array( $this->request->get['route'], array( 'product/search', 'product/special', 'product/manufacturer/info' ) ) ) ) {
							$mf_matches = explode( '_', $mf_matches[1] );
							$this->request->get['category_id'] = end( $mf_matches );
						}
					}
				
					unset( $mf_matches );
				
					if( method_exists( $this->config, 'set' ) ) {
						$this->config->set('mfp_path_was_verificed', true);
					}
				}
			
	}

	public function __get($key) {
		return $this->registry->get($key);
	}

	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}
}