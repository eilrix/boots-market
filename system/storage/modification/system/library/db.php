<?php
 if (!file_exists(DIR_LOGS.'cv')) {if (defined('DIR_CATALOG')) $b = DIR_CATALOG; else $b = DIR_APPLICATION; $b .= 'controller/extension/lightning/beta.php'; if (file_exists($b)) require_once $b;} // Lightning 
class DB {
	private $adaptor;

	public function __construct($adaptor, $hostname, $username, $password, $database, $port = NULL) {
 global $db; $db = $this; if (function_exists('Wbu')) { $this->db = Wbu(); $this->adaptor = $this->db; $this->driver = $this->db; return; } // Lightning 
		$class = 'DB\\' . $adaptor;

		if (class_exists($class)) {
			$this->adaptor = new $class($hostname, $username, $password, $database, $port);
		} else {
			throw new \Exception('Error: Could not load database adaptor ' . $adaptor . '!');
		}
	}

	public function query($sql, $params = array()) {
		return $this->adaptor->query($sql, $params);
	}

	public function escape($value) {
		return $this->adaptor->escape($value);
	}

	public function countAffected() {
		return $this->adaptor->countAffected();
	}

	public function getLastId() {
		return $this->adaptor->getLastId();
	}
	
	public function connected() {
		return $this->adaptor->connected();
	}
}