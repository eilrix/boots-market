<?php
require_once 'func.php';
require_once 'Constants.php';
require_once 'InstagramException.php';

class Instagram {
	protected $username;
	protected $password;
	protected $debug;
	protected $uuid;
	protected $device_id;
	protected $username_id;
	protected $token;
	protected $isLoggedIn = false;
	protected $rank_token;
	protected $IGDataPath;

	public function __construct($username, $password, $debug = false, $IGDataPath = null) {
		$this->debug = $debug;
		$this->device_id = $this->generateDeviceId(md5($username.$password));

		if (!is_null($IGDataPath)) {
			$this->IGDataPath = $IGDataPath;
		} else {
			$this->IGDataPath = __DIR__.DIRECTORY_SEPARATOR.'data'.DIRECTORY_SEPARATOR;
		}

		$this->setUser($username, $password);
	}

	public function setUser($username, $password) {
		$this->username = $username;
		$this->password = $password;

		$this->uuid = $this->generateUUID(true);

		if ((file_exists($this->IGDataPath."$this->username-cookies.dat")) && (file_exists($this->IGDataPath."$this->username-userId.dat")) && (file_exists($this->IGDataPath."$this->username-token.dat"))) {
			$this->isLoggedIn = true;
			$this->username_id = trim(file_get_contents($this->IGDataPath."$username-userId.dat"));
			$this->rank_token = $this->username_id.'_'.$this->uuid;
			$this->token = trim(file_get_contents($this->IGDataPath."$username-token.dat"));
		}
	}

	public function login($force = false) {
		if (!$this->isLoggedIn || $force) {
			$fetch = $this->request('si/fetch_headers/?challenge_type=signup&guid='.$this->generateUUID(false), null, true);
			preg_match('#Set-Cookie: csrftoken=([^;]+)#', $fetch[0], $token);

			$data = array(
				'phone_id'            => $this->generateUUID(true),
				'_csrftoken'          => $token[0],
				'username'            => $this->username,
				'guid'                => $this->uuid,
				'device_id'           => $this->device_id,
				'password'            => $this->password,
				'login_attempt_count' => '0',
			);

			$login = $this->request('accounts/login/', $this->generateSignature(json_encode($data)), true);

			if ($login[1]['status'] == 'fail') {
				throw new InstagramException($login[1]['message']);

				return;
			}

			$this->isLoggedIn = true;
			$this->username_id = $login[1]['logged_in_user']['pk'];
			file_put_contents($this->IGDataPath.$this->username.'-userId.dat', $this->username_id);
			$this->rank_token = $this->username_id.'_'.$this->uuid;
			preg_match('#Set-Cookie: csrftoken=([^;]+)#', $login[0], $match);
			$this->token = $match[1];
			file_put_contents($this->IGDataPath.$this->username.'-token.dat', $this->token);

			$this->syncFeatures();
			$this->autoCompleteUserList();
			$this->timelineFeed();
			$this->getv2Inbox();
			$this->getRecentActivity();

			return $login[1];
		}

		$check = $this->timelineFeed();
		
		if(isset($check['message']) && $check['message'] == 'login_required') {
			$this->login(true);
		}
		
		$this->getv2Inbox();
		$this->getRecentActivity();
	}

    public function syncFeatures() {
        $data = json_encode(array(
			'_uuid'         => $this->uuid,
			'_uid'          => $this->username_id,
			'id'            => $this->username_id,
			'_csrftoken'    => $this->token,
			'experiments'   => Constants::EXPERIMENTS,
		));
		
		$request = $this->request('qe/sync/', $this->generateSignature($data));
		
        return $request[1];
    }

    protected function autoCompleteUserList(){
		$request = $this->request('friendships/autocomplete_user_list/');
		
        return $request[1];
    }

    protected function timelineFeed(){
		$request = $this->request('feed/timeline/');
		
        return $request[1];
    }

    protected function megaphoneLog(){
		$request = $this->request('megaphone/log/');
		
        return $request[1];
    }

    protected function expose(){
        $data = json_encode(array(
			'_uuid'        => $this->uuid,
			'_uid'         => $this->username_id,
			'id'           => $this->username_id,
			'_csrftoken'   => $this->token,
			'experiment'   => 'ig_android_profile_contextual_feed',
		));
		
		$request = $this->request('qe/expose/', $this->generateSignature($data));
        return $request[1];
    }

	public function logout() {
		$logout = $this->request('accounts/logout/');

		if ($logout == 'ok') {
			return true;
		} else {
			return false;
		}
	}

    public function uploadPhoto($photo, $caption = null, $upload_id = null){
        $endpoint = Constants::API_URL.'upload/photo/';
        $boundary = $this->uuid;

        if (!is_null($upload_id)) {
            $fileToUpload = createVideoIcon($photo);
        } else {
            $upload_id = number_format(round(microtime(true) * 1000), 0, '', '');
            $fileToUpload = file_get_contents($photo);
        }

        $bodies = array(
            array(
                'type' => 'form-data',
                'name' => 'upload_id',
                'data' => $upload_id,
            ),
            array(
                'type' => 'form-data',
                'name' => '_uuid',
                'data' => $this->uuid,
            ),
            array(
                'type' => 'form-data',
                'name' => '_csrftoken',
                'data' => $this->token,
            ),
            array(
                'type' => 'form-data',
                'name' => 'image_compression',
				'data'   => '{"lib_name":"jt","lib_version":"1.3.0","quality":"70"}',
            ),
            array(
                'type'     => 'form-data',
                'name'     => 'photo',
                'data'     => $fileToUpload,
                'filename' => 'pending_media_'.number_format(round(microtime(true) * 1000), 0, '', '').'.jpg',
                'headers'  => array(
					'Content-Transfer-Encoding: binary',
                    'Content-type: application/octet-stream',
                ),
            ),
        );

        $data = $this->buildBody($bodies, $boundary);
        $headers = array(
			'Connection: close',
			'Accept: */*',
			'Content-type: multipart/form-data; boundary='.$boundary,
			'Content-Length: '.strlen($data),
			'Cookie2: $Version=1',
			'Accept-Language: en-US',
			'Accept-Encoding: gzip',
		);

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $endpoint);
        curl_setopt($ch, CURLOPT_USERAGENT, Constants::USER_AGENT);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        @curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_HEADER, true);
        curl_setopt($ch, CURLOPT_VERBOSE, $this->debug);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_COOKIEFILE, $this->IGDataPath."$this->username-cookies.dat");
        curl_setopt($ch, CURLOPT_COOKIEJAR, $this->IGDataPath."$this->username-cookies.dat");
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);

        $resp = curl_exec($ch);
        $header_len = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
        $header = substr($resp, 0, $header_len);
        $upload = json_decode(substr($resp, $header_len), true);

        curl_close($ch);

        if ($upload['status'] == 'fail') {
            throw new InstagramException($upload['message']);

            return;
        }

        if ($this->debug) {
            echo 'RESPONSE: '.substr($resp, $header_len)."\n\n";
        }

        $configure = $this->configure($upload['upload_id'], $photo, $caption);
        $this->expose();

        return $configure;
    }

    public function uploadVideo($video, $caption = null) {
        $videoData = file_get_contents($video);

        $endpoint = Constants::API_URL.'upload/video/';
        $boundary = $this->uuid;
        $upload_id = round(microtime(true) * 1000);
        $bodies = array(
			array(
              'type' => 'form-data',
              'name' => 'upload_id',
              'data' => $upload_id,
			),
			array(
              'type' => 'form-data',
              'name' => '_csrftoken',
              'data' => $this->token,
			),
			array(
              'type'   => 'form-data',
              'name'   => 'media_type',
              'data'   => '2',
			),
			array(
              'type' => 'form-data',
              'name' => '_uuid',
              'data' => $this->uuid,
			),
		);

        $data = $this->buildBody($bodies, $boundary);
        $headers = array(
			'Connection: keep-alive',
			'Accept: */*',
			'Host: i.instagram.com',
			'Content-type: multipart/form-data; boundary='.$boundary,
			'Accept-Language: en-en',
		);

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $endpoint);
        curl_setopt($ch, CURLOPT_USERAGENT, Constants::USER_AGENT);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        @curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_HEADER, true);
        curl_setopt($ch, CURLOPT_VERBOSE, false);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_COOKIEFILE, $this->IGDataPath."$this->username-cookies.dat");
        curl_setopt($ch, CURLOPT_COOKIEJAR, $this->IGDataPath."$this->username-cookies.dat");
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);

        $resp = curl_exec($ch);
        $header_len = curl_getinfo($ch, CURLINFO_HEADER_SIZE);

        $body = json_decode(substr($resp, $header_len), true);

        $uploadUrl = $body['video_upload_urls'][3]['url'];
        $job = $body['video_upload_urls'][3]['job'];

        $request_size = floor(strlen($videoData) / 4);

        $lastRequestExtra = (strlen($videoData) - ($request_size * 4));

        for ($a = 0; $a <= 3; $a++) {
            $start = ($a * $request_size);
            $end = ($a + 1) * $request_size + ($a == 3 ? $lastRequestExtra : 0);

            $headers = array(
				'Connection: keep-alive',
				'Accept: */*',
				'Host: upload.instagram.com',
				'Cookie2: $Version=1',
				'Accept-Encoding: gzip, deflate',
				'Content-Type: application/octet-stream',
				'Session-ID: '.$upload_id,
				'Accept-Language: en-en',
				'Content-Disposition: attachment; filename="video.mov"',
				'Content-Length: '.($end - $start),
				'Content-Range: '.'bytes '.$start.'-'.($end - 1).'/'.strlen($videoData),
				'job: '.$job,
			);
			
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $uploadUrl);
            curl_setopt($ch, CURLOPT_USERAGENT, Constants::USER_AGENT);
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            @curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
            curl_setopt($ch, CURLOPT_HEADER, true);
            curl_setopt($ch, CURLOPT_VERBOSE, false);
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($ch, CURLOPT_COOKIEFILE, $this->IGDataPath."$this->username-cookies.dat");
            curl_setopt($ch, CURLOPT_COOKIEJAR, $this->IGDataPath."$this->username-cookies.dat");
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, substr($videoData, $start, $end));

            $result = curl_exec($ch);
            $header_len = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $body = substr($result, $header_len);
            $array[] = array($body);
        }
		
        $resp = curl_exec($ch);
        $header_len = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
        $header = substr($resp, 0, $header_len);
        $upload = json_decode(substr($resp, $header_len), true);

        curl_close($ch);

        if ($upload['status'] == 'fail') {
            throw new InstagramException($upload['message']);

            return;
        }

        if ($this->debug) {
            echo 'RESPONSE: '.substr($resp, $header_len)."\n\n";
        }

        $configure = $this->configureVideo($upload_id, $video, $caption);
        $this->expose();

        return $configure;
    }

    public function direct_share($media_id, $recipients, $text = null){
        if (!is_array($recipients)) {
            $recipients = array($recipients);
        }

        $string = array();
        foreach ($recipients as $recipient) {
            $string[] = "\"$recipient\"";
        }

        $recipeint_users = implode(',', $string);

        $endpoint = Constants::API_URL.'direct_v2/threads/broadcast/media_share/?media_type=photo';
        $boundary = $this->uuid;
        $bodies = array(
            array(
                'type' => 'form-data',
                'name' => 'media_id',
                'data' => $media_id,
            ),
            array(
                'type' => 'form-data',
                'name' => 'recipient_users',
                'data' => "[[$recimient_users]]",
            ),
            array(
                'type' => 'form-data',
                'name' => 'client_context',
                'data' => $this->uuid,
            ),
            array(
                'type' => 'form-data',
                'name' => 'thread_ids',
                'data' => '["0"]',
            ),
            array(
                'type' => 'form-data',
                'name' => 'text',
                'data' => is_null($text) ? '' : $text,
            ),
        );

        $data = $this->buildBody($bodies, $boundary);
        $headers = array(
			'Proxy-Connection: keep-alive',
			'Connection: keep-alive',
			'Accept: */*',
			'Content-type: multipart/form-data; boundary='.$boundary,
			'Accept-Language: en-en',
        );

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $endpoint);
        curl_setopt($ch, CURLOPT_USERAGENT, Constants::USER_AGENT);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        @curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_HEADER, true);
        curl_setopt($ch, CURLOPT_VERBOSE, $this->debug);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_COOKIEFILE, $this->IGDataPath."$this->username-cookies.dat");
        curl_setopt($ch, CURLOPT_COOKIEJAR, $this->IGDataPath."$this->username-cookies.dat");
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);

        $resp = curl_exec($ch);
        $header_len = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
        $header = substr($resp, 0, $header_len);
        $upload = json_decode(substr($resp, $header_len), true);

        curl_close($ch);
    }

    protected function configureVideo($upload_id, $video, $caption = ''){
        $this->uploadPhoto($video, $caption, $upload_id);
		
		$v_s = getimagesize($video);
		
        $size = $v_s[0];

		$post = json_encode(array(
			'upload_id'          => $upload_id,
			'source_type'        => '3',
			'poster_frame_index' => 0,
			'length'             => 0.00,
			'audio_muted'        => false,
			'filter_type'        => '0',
			'video_result'       => 'deprecated',
			'clips'              => array(
				'length'           => getSeconds($video),
				'source_type'      => '3',
				'camera_position'  => 'back',
			),
			'extra' => array(
				'source_width'  => 960,
				'source_height' => 1280,
			),
			'device' => array(
				'manufacturer'    => 'Xiaomi',
				'model'           => 'HM 1SW',
				'android_version' => 18,
				'android_release' => '4.3',
			),
			'_csrftoken'  => $this->token,
			'_uuid'       => $this->uuid,
			'_uid'        => $this->username_id,
			'caption'     => $caption,
		));

        $post = str_replace('"length":0', '"length":0.00', $post);
		
		$request = $this->request('media/configure/?video=1', $this->generateSignature($post));
		
        return $request[1];
    }

    protected function configure($upload_id, $photo, $caption = '') {
		$p_s = getimagesize($photo);
        $size = $p_s[0];

		$post = json_encode(array(
			'upload_id'          => $upload_id,
			'camera_model'       => 'HM1S',
			'source_type'        => 3,
			'date_time_original' => date('Y:m:d H:i:s'),
			'camera_make'        => 'XIAOMI',
			'edits'              => array(
				'crop_original_size' => array($size, $size),
				'crop_zoom'          => 1.3333334,
				'crop_center'        => array(0.0, -0.0),
			),
			'extra' => array(
				'source_width'  => $size,
				'source_height' => $size,
			),
			'device' => array(
				'manufacturer'    => 'Xiaomi',
				'model'           => 'HM 1SW',
				'android_version' => 18,
				'android_release' => '4.3',
			),
			'_csrftoken'  => $this->token,
			'_uuid'       => $this->uuid,
			'_uid'        => $this->username_id,
			'caption'     => $caption,
		));

        $post = str_replace('"crop_center":[0,0]', '"crop_center":[0.0,-0.0]', $post);
		
		$request = $this->request('media/configure/', $this->generateSignature($post));
		
        return $request[1];
    }

	public function editMedia($mediaId, $captionText = '') {
		$data = json_encode(array(
			'_uuid'          => $this->uuid,
			'_uid'           => $this->username_id,
			'_csrftoken'     => $this->token,
			'caption_text'   => $captionText,
		));
		
		$request = $this->request("media/$mediaId/edit_media/", $this->generateSignature($data));
		
		return $request[1];
	}

	public function removeSelftag($mediaId) {
		$data = json_encode(array(
			'_uuid'          => $this->uuid,
			'_uid'           => $this->username_id,
			'_csrftoken'     => $this->token,
		));
		
		$request = $this->request("usertags/$mediaId/remove/", $this->generateSignature($data));
		
		return $request[1];
	}

	public function mediaInfo($mediaId) {
		$data = json_encode(array(
			'_uuid'      => $this->uuid,
			'_uid'       => $this->username_id,
			'_csrftoken' => $this->token,
			'media_id'   => $mediaId,
		));
		
		$request = $this->request("media/$mediaId/info/", $this->generateSignature($data));
		
		return $request[1];
	}

	public function deleteMedia($mediaId) {
		$data = json_encode(array(
			'_uuid'      => $this->uuid,
			'_uid'       => $this->username_id,
			'_csrftoken' => $this->token,
			'media_id'   => $mediaId,
		));
		
		$request = $this->request("media/$mediaId/delete/", $this->generateSignature($data));
		
		return $request[1];
	}

	public function comment($mediaId, $commentText) {
		$data = json_encode(array(
			'_uuid'          => $this->uuid,
			'_uid'           => $this->username_id,
			'_csrftoken'     => $this->token,
			'comment_text'   => $commentText,
		));
		
		$request = $this->request("media/$mediaId/comment/", $this->generateSignature($data));
		
		return $request[1];
	}

	public function deleteComment($mediaId, $captionText, $commentId) {
		$data = json_encode(array(
			'_uuid'          => $this->uuid,
			'_uid'           => $this->username_id,
			'_csrftoken'     => $this->token,
			'caption_text'   => $captionText,
		));
		
		$request = $this->request("media/$mediaId/comment/$commentId/delete/", $this->generateSignature($data));
		
		return $request[1];
	}

	public function changeProfilePicture($photo) {
		if (is_null($photo)) {
			echo "Photo not valid\n\n";

			return;
		}

		$uData = json_encode(array(
			'_csrftoken' => $this->token,
			'_uuid'      => $this->uuid,
			'_uid'       => $this->username_id,
		));

		$endpoint = Constants::API_URL.'accounts/change_profile_picture/';
		$boundary = $this->uuid;
		$bodies = array(
			array(
				'type' => 'form-data',
				'name' => 'ig_sig_key_version',
				'data' => Constants::SIG_KEY_VERSION,
			),
			array(
				'type' => 'form-data',
				'name' => 'signed_body',
				'data' => hash_hmac('sha256', $uData, Constants::IG_SIG_KEY).$uData,
			),
			array(
				'type'     => 'form-data',
				'name'     => 'profile_pic',
				'data'     => file_get_contents($photo),
				'filename' => 'profile_pic',
				'headers'  => array(
					'Content-type: application/octet-stream',
					'Content-Transfer-Encoding: binary',
				),
			),
		);

		$data = $this->buildBody($bodies, $boundary);
		$headers = array(
			'Proxy-Connection: keep-alive',
			'Connection: keep-alive',
			'Accept: */*',
			'Content-type: multipart/form-data; boundary='.$boundary,
			'Accept-Language: en-en',
			'Accept-Encoding: gzip, deflate',
		);

		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $endpoint);
		curl_setopt($ch, CURLOPT_USERAGENT, Constants::USER_AGENT);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		@curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
		curl_setopt($ch, CURLOPT_HEADER, true);
		curl_setopt($ch, CURLOPT_VERBOSE, $this->debug);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_COOKIEFILE, $this->IGDataPath."$this->username-cookies.dat");
		curl_setopt($ch, CURLOPT_COOKIEJAR, $this->IGDataPath."$this->username-cookies.dat");
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);

		$resp = curl_exec($ch);
		$header_len = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
		$header = substr($resp, 0, $header_len);
		$upload = json_decode(substr($resp, $header_len), true);

		curl_close($ch);
	}

	public function removeProfilePicture() {
		$data = json_encode(array(
			'_uuid'      => $this->uuid,
			'_uid'       => $this->username_id,
			'_csrftoken' => $this->token,
		));
		
		$request = $this->request('accounts/remove_profile_picture/', $this->generateSignature($data));
		
		return $request[1];
	}

	public function setPrivateAccount() {
		$data = json_encode(array(
			'_uuid'      => $this->uuid,
			'_uid'       => $this->username_id,
			'_csrftoken' => $this->token,
		));
		
		$request = $this->request('accounts/set_private/', $this->generateSignature($data));
		
		return $request[1];
	}

	public function setPublicAccount() {
		$data = json_encode(array(
			'_uuid'      => $this->uuid,
			'_uid'       => $this->username_id,
			'_csrftoken' => $this->token,
		));
		
		$request = $this->request('accounts/set_public/', $this->generateSignature($data));
		
		return $request[1];
	}

	public function getProfileData() {
		$data = json_encode(array(
			'_uuid'      => $this->uuid,
			'_uid'       => $this->username_id,
			'_csrftoken' => $this->token,
		));
		
		$request = $this->request('accounts/current_user/?edit=true', $this->generateSignature($data));
		
		return $request[1];
	}

	public function editProfile($url, $phone, $first_name, $biography, $email, $gender) {
		$data = json_encode(array(
			'_uuid'         => $this->uuid,
			'_uid'          => $this->username_id,
			'_csrftoken'    => $this->token,
			'external_url'  => $url,
			'phone_number'  => $phone,
			'username'      => $this->username,
			'full_name'     => $first_name,
			'biography'     => $biography,
			'email'         => $email,
			'gender'        => $gender,
		));
		
		$request = $this->request('accounts/edit_profile/', $this->generateSignature($data));
		
		return $request[1];
	}

	public function getUsernameInfo($usernameId) {
		$request = $this->request("users/$usernameId/info/");
		
		return $request[1];
	}

	public function getSelfUsernameInfo() {
		return $this->getUsernameInfo($this->username_id);
	}

	public function getRecentActivity() {
		$request = $this->request('news/inbox/?');
		$activity = $request[1];

		if ($activity['status'] != 'ok') {
			throw new InstagramException($activity['message']."\n");

			return;
		}

		return $activity;
	}

	public function getFollowingRecentActivity() {
		$request = $this->request('news/?');
		$activity = $request[1];

		if ($activity['status'] != 'ok') {
			throw new InstagramException($activity['message']."\n");

			return;
		}

		return $activity;
	}

	public function getv2Inbox() {
		$request = $this->request('direct_v2/inbox/?');
		$inbox = $request[1];

		if ($inbox['status'] != 'ok') {
			throw new InstagramException($inbox['message']."\n");

			return;
		}

		return $inbox;
	}

	public function getUserTags($usernameId) {
		$request = $this->request("usertags/$usernameId/feed/?rank_token=$this->rank_token&ranked_content=true&");
		$tags = $request[1];

		if ($tags['status'] != 'ok') {
			throw new InstagramException($tags['message']."\n");

			return;
		}

		return $tags;
	}

	public function getSelfUserTags() {
		return $this->getUserTags($this->username_id);
	}

	public function tagFeed($tag) {
		$request = $this->request("feed/tag/$tag/?rank_token=$this->rank_token&ranked_content=true&");
		$userFeed = $request[1];

		if ($userFeed['status'] != 'ok') {
			throw new InstagramException($userFeed['message']."\n");

			return;
		}

		return $userFeed;
	}

	public function getMediaLikers($mediaId) {
		$request = $this->request("media/$mediaId/likers/?");
		$likers = $request[1];
		if ($likers['status'] != 'ok') {
			throw new InstagramException($likers['message']."\n");

			return;
		}

		return $likers;
	}

	public function getGeoMedia($usernameId) {
		$request = $this->request("maps/user/$usernameId/");
		$locations = $request[1];

		if ($locations['status'] != 'ok') {
			throw new InstagramException($locations['message']."\n");

			return;
		}

		return $locations;
	}

	public function getSelfGeoMedia() {
		return $this->getGeoMedia($this->username_id);
	}

	public function fbUserSearch($query) {
		$request = $this->request("fbsearch/topsearch/?context=blended&query=$query&rank_token=$this->rank_token");
		$query = $request[1];

		if ($query['status'] != 'ok') {
			throw new InstagramException($query['message']."\n");

			return;
		}

		return $query;
	}

	public function searchUsers($query) {
		$request = $this->request('users/search/?ig_sig_key_version='.Constants::SIG_KEY_VERSION."&is_typeahead=true&query=$query&rank_token=$this->rank_token");
		$query = $request[1];

		if ($query['status'] != 'ok') {
			throw new InstagramException($query['message']."\n");

			return;
		}

		return $query;
	}

	public function searchUsername($usernameName) {
		$request = $this->request("users/$usernameName/usernameinfo/");
		$query = $request[1];

		if ($query['status'] != 'ok') {
			throw new InstagramException($query['message']."\n");

			return;
		}

		return $query;
	}

	public function syncFromAdressBook($contacts) {
		$data = 'contacts='.json_encode($contacts, true);
		
		$request = $this->request('address_book/link/?include=extra_display_name,thumbnails', $data);
		
		return $request[1];
	}

	public function searchTags($query) {
		$request = $this->request("tags/search/?is_typeahead=true&q=$query&rank_token=$this->rank_token");
		$query = $request[1];

		if ($query['status'] != 'ok') {
			throw new InstagramException($query['message']."\n");

			return;
		}

		return $query;
	}

	public function getTimeline($maxid = null) {
		$request = $this->request("feed/timeline/?rank_token=$this->rank_token&ranked_content=true".(!is_null($maxid) ? "&max_id=".$maxid : ''));
		$timeline = $request[1];

		if ($timeline['status'] != 'ok') {
			throw new InstagramException($timeline['message']."\n");

			return;
		}

		return $timeline;
	}

	public function getUserFeed($usernameId, $maxid = null, $minTimestamp = null) {
		$request = $this->request(
			"feed/user/$usernameId/?rank_token=$this->rank_token"
			.(!is_null($maxid) ? "&max_id=".$maxid : '')
			.(!is_null($minTimestamp) ? "&min_timestamp=".$minTimestamp : '')
			."&ranked_content=true"
		);
		
		$userFeed = $request[1];

		if ($userFeed['status'] != 'ok') {
			throw new InstagramException($userFeed['message']."\n");

			return;
		}

		return $userFeed;
	}

	public function getHashtagFeed($hashtagString, $maxid = null) {
		if (is_null($maxid)) {
			$endpoint = "feed/tag/$hashtagString/?rank_token=$this->rank_token&ranked_content=true&";
		} else {
			$endpoint = "feed/tag/$hashtagString/?max_id=".$maxid."&rank_token=$this->rank_token&ranked_content=true&";
		}
		
		$request = $this->request($endpoint);
		
		$hashtagFeed = $request[1];

		if ($hashtagFeed['status'] != 'ok') {
			throw new InstagramException($hashtagFeed['message']."\n");

			return;
		}

		return $hashtagFeed;
	}

	public function searchLocation($query) {
		$endpoint = "fbsearch/places/?rank_token=$this->rank_token&query=".$query;
		
		$request = $this->request($endpoint);
		
		$locationFeed = $request[1];

		if ($locationFeed['status'] != 'ok') {
			throw new InstagramException($locationFeed['message']."\n");

			return;
		}

		return $locationFeed;
	}

	public function getLocationFeed($locationId, $maxid = null) {
		if (is_null($maxid)) {
			$endpoint = "feed/location/$locationId/?rank_token=$this->rank_token&ranked_content=true&";
		} else {
			$endpoint = "feed/location/$locationId/?max_id=".$maxid."&rank_token=$this->rank_token&ranked_content=true&";
		}
		
		$request = $this->request($endpoint);
		
		$locationFeed = $request[1];

		if ($locationFeed['status'] != 'ok') {
			throw new InstagramException($locationFeed['message']."\n");

			return;
		}

		return $locationFeed;
	}

	public function getSelfUserFeed() {
		return $this->getUserFeed($this->username_id);
	}

	public function getPopularFeed() {
		$request = $this->request("feed/popular/?people_teaser_supported=1&rank_token=$this->rank_token&ranked_content=true&");
		
		$popularFeed = $request[1];

		if ($popularFeed['status'] != 'ok') {
			throw new InstagramException($popularFeed['message']."\n");

			return;
		}

		return $popularFeed;
	}

	public function getUserFollowings($usernameId, $maxid = null) {
		$request = $this->request("friendships/$usernameId/following/?max_id=$maxid&ig_sig_key_version=".Constants::SIG_KEY_VERSION."&rank_token=$this->rank_token");
		return $request[1];
	}

	public function getUserFollowers($usernameId, $maxid = null) {
		$request = $this->request("friendships/$usernameId/followers/?max_id=$maxid&ig_sig_key_version=".Constants::SIG_KEY_VERSION."&rank_token=$this->rank_token");
		return $request[1];
	}

	public function getSelfUserFollowers() {
		return $this->getUserFollowers($this->username_id);
	}

	public function getSelfUsersFollowing() {
		$request = $this->request('friendships/following/?ig_sig_key_version='.Constants::SIG_KEY_VERSION."&rank_token=$this->rank_token");
		return $request[1];
	}

	public function like($mediaId) {
		$data = json_encode(array(
			'_uuid'      => $this->uuid,
			'_uid'       => $this->username_id,
			'_csrftoken' => $this->token,
			'media_id'   => $mediaId,
		));
		
		$request = $this->request("media/$mediaId/like/", $this->generateSignature($data));
		
		return $request[1];
	}

	public function unlike($mediaId) {
		$data = json_encode(array(
			'_uuid'      => $this->uuid,
			'_uid'       => $this->username_id,
			'_csrftoken' => $this->token,
			'media_id'   => $mediaId,
		));
		
		$request = $this->request("media/$mediaId/unlike/", $this->generateSignature($data));
		
		return $request[1];
	}

	public function getMediaComments($mediaId) {
		$request = $this->request("media/$mediaId/comments/?");
		return $request[1];
	}

	public function setNameAndPhone($name = '', $phone = '') {
		$data = json_encode(array(
			'_uuid'         => $this->uuid,
			'_uid'          => $this->username_id,
			'first_name'    => $name,
			'phone_number'  => $phone,
			'_csrftoken'    => $this->token,
		));
		
		$request = $this->request('accounts/set_phone_and_name/', $this->generateSignature($data));
		
		return $request[1];
	}

	public function getDirectShare() {
		$request = $this->request('direct_share/inbox/?');
		return $request[1];
	}

	public function backup() {
		$myUploads = $this->getSelfUserFeed();
		
		foreach ($myUploads['items'] as $item) {
			if (!is_dir($this->IGDataPath.'backup/'."$this->username-".date('Y-m-d'))) {
				mkdir($this->IGDataPath.'backup/'."$this->username-".date('Y-m-d'));
			}
			file_put_contents($this->IGDataPath.'backup/'."$this->username-".date('Y-m-d').'/'.$item['id'].'.jpg',
			file_get_contents($item['image_versions2']['candidates'][0]['url']));
		}
	}

	public function follow($userId) {
		$data = json_encode(array(
			'_uuid'      => $this->uuid,
			'_uid'       => $this->username_id,
			'user_id'    => $userId,
			'_csrftoken' => $this->token,
		));
		
		$request = $this->request("friendships/create/$userId/", $this->generateSignature($data));
		
		return $request[1];
	}

	public function unfollow($userId) {
		$data = json_encode(array(
			'_uuid'      => $this->uuid,
			'_uid'       => $this->username_id,
			'user_id'    => $userId,
			'_csrftoken' => $this->token,
		));
		
		$request = $this->request("friendships/destroy/$userId/", $this->generateSignature($data));
		
		return $request[1];
	}

	public function block($userId) {
		$data = json_encode(array(
			'_uuid'      => $this->uuid,
			'_uid'       => $this->username_id,
			'user_id'    => $userId,
			'_csrftoken' => $this->token,
		));
		
		$request = $this->request("friendships/block/$userId/", $this->generateSignature($data));
		
		return $request[1];
	}

	public function unblock($userId) {
		$data = json_encode(array(
			'_uuid'      => $this->uuid,
			'_uid'       => $this->username_id,
			'user_id'    => $userId,
			'_csrftoken' => $this->token,
		));
		
		$request = $this->request("friendships/unblock/$userId/", $this->generateSignature($data));
		
		return $request[1];
	}

	public function userFriendship($userId) {
		$data = json_encode(array(
			'_uuid'      => $this->uuid,
			'_uid'       => $this->username_id,
			'user_id'    => $userId,
			'_csrftoken' => $this->token,
		));
		
		$request = $this->request("friendships/show/$userId/", $this->generateSignature($data));
		
		return $request[1];
	}

	public function getLikedMedia() {
		$request = $this->request('feed/liked/?');
		return $request[1];
	}

    public function generateSignature($data){
		$hash = hash_hmac('sha256', $data, Constants::IG_SIG_KEY);

        return 'ig_sig_key_version='.Constants::SIG_KEY_VERSION.'&signed_body='.$hash.'.'.urlencode($data);
    }

    public function generateDeviceId($seed){
        $volatile_seed = filemtime(__DIR__);

        return 'android-'.substr(md5($seed.$volatile_seed), 16);
    }

    public function generateUUID($type){
        $uuid = sprintf('%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
			mt_rand(0, 0xffff), mt_rand(0, 0xffff),
			mt_rand(0, 0xffff),
			mt_rand(0, 0x0fff) | 0x4000,
			mt_rand(0, 0x3fff) | 0x8000,
			mt_rand(0, 0xffff), mt_rand(0, 0xffff), mt_rand(0, 0xffff)
		);

        return $type ? $uuid : str_replace('-', '', $uuid);
    }

    protected function buildBody($bodies, $boundary){
        $body = '';
        foreach ($bodies as $b) {
            $body .= '--'.$boundary."\r\n";
            $body .= 'Content-Disposition: '.$b['type'].'; name="'.$b['name'].'"';
            if (isset($b['filename'])) {
                $ext = pathinfo($b['filename'], PATHINFO_EXTENSION);
                $body .= '; filename="'.'pending_media_'.number_format(round(microtime(true) * 1000), 0, '', '').'.'.$ext.'"';
            }
            if (isset($b['headers']) && is_array($b['headers'])) {
                foreach ($b['headers'] as $header) {
                    $body .= "\r\n".$header;
                }
            }

            $body .= "\r\n\r\n".$b['data']."\r\n";
        }
		
        $body .= '--'.$boundary.'--';

        return $body;
    }

    protected function request($endpoint, $post = null, $login = false){
        if (!$this->isLoggedIn && !$login) {
            throw new InstagramException("Not logged in\n");

            return;
        }

        $headers = array(
			'Connection: close',
			'Accept: */*',
			'Content-type: application/x-www-form-urlencoded; charset=UTF-8',
			'Cookie2: $Version=1',
			'Accept-Language: en-US',
		);

        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, Constants::API_URL.$endpoint);
        curl_setopt($ch, CURLOPT_USERAGENT, Constants::USER_AGENT);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        @curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_HEADER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_VERBOSE, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_COOKIEFILE, $this->IGDataPath."$this->username-cookies.dat");
        curl_setopt($ch, CURLOPT_COOKIEJAR, $this->IGDataPath."$this->username-cookies.dat");

        if ($post) {
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
        }

        $resp = curl_exec($ch);
        $header_len = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
        $header = substr($resp, 0, $header_len);
        $body = substr($resp, $header_len);

        curl_close($ch);

        if ($this->debug) {
            echo "REQUEST: $endpoint\n";
            if (!is_null($post)) {
                if (!is_array($post)) {
                    echo 'DATA: '.urldecode($post)."\n";
                }
            }
            echo "RESPONSE: $body\n\n";
        }

        return array($header, json_decode($body, true));
    }
}