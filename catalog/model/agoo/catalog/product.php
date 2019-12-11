<?php
/* All rights reserved belong to the module, the module developers http://opencartadmin.com */
// http://opencartadmin.com © 2011-2017 All Rights Reserved
// Distribution, without the author's consent is prohibited
// Commercial license
class agooModelCatalogProduct extends Controller
{
	protected  $agooobject;
    protected  $jetcache_settings;

   	public function __call($name, array $params) {

		$object = 'ModelCatalogProduct';

		if (!class_exists('ModelCatalogProduct')) {
			$file  = DIR_APPLICATION . 'model/catalog/product.php';
		    $original_file = $file;
		    if (function_exists('modification')) {
		 		$file = modification($file);
		 	}

			if (class_exists('VQMod',false)) {
				if (VQMod::$directorySeparator) {
					if (strpos($file,'vq2-')!==FALSE) {
					} else {
						if (version_compare(VQMod::$_vqversion,'2.5.0','<')) {
							//trigger_error("You are using an old VQMod version '".VQMod::$_vqversion."', please upgrade your VQMod!");
							//exit;
						}
						if ($original_file != $file) {
							$file = VQMod::modCheck($file,$original_file);
						} else {
							$file = VQMod::modCheck($original_file);
						}
					}
				}
			}

			if (file_exists($file)) {
				include_once($file);
			}
		}

        $general_settings = $this->registry->get('config')->get('ascp_settings');
        $this->jetcache_settings = $this->registry->get('config')->get('asc_jetcache_settings');

		$sc_access = $this->sc_get_jetcache_access($name, $general_settings);

		if ($sc_access) {

				if (!$this->config->get('blog_work')) {
					$this->config->set('blog_work', true);
					$off_blog_work = true;
				} else {
					$off_blog_work = false;
				}

                $cachedata['params'] = $params;
				$cachedata['name'] = $name;
				$hash = md5(json_encode($cachedata));
                $cache_filename = $this->sc_set_cache_name($hash);
				$cache_content = $this->cache->get($cache_filename);

				if ($off_blog_work) {
					$this->config->set('blog_work', false);
				}

				if (isset($cache_content[$hash])) {
                	return $cache_content[$hash];
				}
		}

		$this->agooobject =  new $object($this->registry);
		$data = call_user_func_array(array($this->agooobject , $name), $params);

		if ($sc_access) {
			if (!$this->config->get('blog_work')) {
				$this->config->set('blog_work', true);
				$off_blog_work = true;
			} else {
				$off_blog_work = false;
			}

	        $cachedata['params'] = $params;
			$cachedata['name'] = $name;
			$hash = md5(json_encode($cachedata));
	        $cache_filename = $this->sc_set_cache_name($hash);

			$cache_content[$hash] = $data;
			$this->cache->set($cache_filename, $cache_content);

			if ($off_blog_work) {
				$this->config->set('blog_work', false);
			}
		}

		return $data;
   	}

	private function sc_get_jetcache_access($name, $general_settings) {

      	$access_status = false;

      	if (isset($this->jetcache_settings['store']) && in_array($this->config->get('config_store_id'), $this->jetcache_settings['store'])) {
       		$access_status = true;
      	} else {
			return $access_status = false;
		}


		if (strtolower($name) == 'gettotalproducts' &&
		(isset($this->jetcache_settings['jetcache_gettotalproducts_status']) && $this->jetcache_settings['jetcache_gettotalproducts_status'])
		) {
			$access_status = true;
		} else {
			return $access_status = false;
		}

		if (!$this->registry->get('admin_work') && $access_status &&
		(isset($general_settings['jetcache_widget_status']) && $general_settings['jetcache_widget_status']) &&
		(isset($this->jetcache_settings['jetcache_model_status']) && $this->jetcache_settings['jetcache_model_status'])
		) {
			$access_status = true;
		} else {
			return $access_status = false;
		}

        return $access_status;
	}


	private function sc_set_cache_name($hash) {
		$route_name = $this->config->get('config_language_id').'_'.$this->config->get('config_store_id');

	    if (isset($this->jetcache_settings['jetcache_gettotalproducts_uri_status']) && $this->jetcache_settings['jetcache_gettotalproducts_uri_status']) {
			$data_cache['uri'] = $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			$data_cache['get'] = $this->request->get;
			$hash_uri = '.' . md5(json_encode($data_cache));
	    } else {
			$hash_uri = '';
	    }

	    if (isset($this->jetcache_settings['model_db_status']) && $this->jetcache_settings['model_db_status']) {
			$sc_cache_name  = 'blog.db.model.gettotalproducts_' . $route_name . $hash_uri;
	    } else {
			$sc_cache_name  = 'blog.jetcache_gettotalproducts_' . $route_name . $hash_uri;
	    }

		return $sc_cache_name;
	}

}
