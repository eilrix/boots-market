<?php
final class Registry {
	private $data = array();

	public function get($key) {
		return (isset($this->data[$key]) ? $this->data[$key] : null);
	}

	public function set($key, $value) {
 global $registry; if ($key != 'db') $registry = $this; //Lightning 
		$this->data[$key] = $value;
	}

	public function has($key) {
		return isset($this->data[$key]);
	}
}