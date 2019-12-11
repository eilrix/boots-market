<?php

class ModelToolCtrlImage extends Model
{
    /* CTRL+Watermark - begin */
    protected function debug($message) {
        if ($this->config->get("ctrl_watermark_debug"))
            $this->log($message);
    }

    protected function log($message)
    {
        file_put_contents(DIR_LOGS . $this->config->get("config_error_filename"), date("Y-m-d H:i:s - ") . "CTRL+Watermark: " . $message . "\r\n", FILE_APPEND);
    }

    protected function getImageUrl($new_image)
    {
        $parts = explode('/', $new_image);
        $new_url = implode('/', array_map('rawurlencode', $parts));
        if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
            return $this->config->get('config_ssl') . 'image/' . $new_url;
        } else {
            return $this->config->get('config_url') . 'image/' . $new_url;
        }
    }

    public function resize($filename, $width, $height, $type = "")
    {

        if (!file_exists(DIR_IMAGE . $filename) || !is_file(DIR_IMAGE . $filename)) {
            return;
        }

        $store_id = $this->config->get('config_store_id');

        $info = pathinfo($filename);
        $extension = $info['extension'];
        $old_image = $filename;
        $new_image = 'cache/' . utf8_substr($filename, 0, utf8_strrpos($filename, '.')) . '-' . $width . 'x' . $height . $type;

        $watermark = $this->config->get("ctrl_watermark_status_${store_id}");
        if (!$watermark) {
            $this->debug("Watermark for store ${store_id} is disabled");
        }

        if($watermark) {
            $watermark_image = $this->config->get("ctrl_watermark_image_${store_id}");
            if (!$watermark_image ) {
                $this->debug("Watermark image for store ${store_id} is not selected");
                $watermark = FALSE;
            } else if ( !file_exists(DIR_IMAGE . $watermark_image) ) {
                $this->debug("Watermark image not found: " . $watermark_image);
                $watermark = FALSE;
            }
        }

        if($watermark) {
            $watermark_min_height = $this->config->get("ctrl_watermark_min_width_${store_id}");
            $watermark_min_width = $this->config->get("ctrl_watermark_min_height_${store_id}");
            if ($watermark_min_width > $width || $watermark_min_height > $height) {
                $this->debug("Requested image size is too small for watermark: $width x $height, watermark is used from $watermark_min_width x $watermark_min_height");
                $watermark = FALSE;
            }
        }

        if($watermark) {
            $watermark_max_height = $this->config->get("ctrl_watermark_max_width_${store_id}");
            $watermark_max_width = $this->config->get("ctrl_watermark_max_height_${store_id}");
            if (($watermark_max_width != 0 && $watermark_max_width < $width) || ($watermark_max_height != 0 && $watermark_max_height < $height)) {
                $this->debug("Requested image size is too big for watermark: $width x $height, watermark is used until $watermark_max_width x $watermark_max_height");
                $watermark = FALSE;
            }
        }

        if($watermark) {
            $exclude = $this->config->get("ctrl_watermark_exclude_${store_id}");
            if(is_array($exclude)) {
                $find = dirname(DIR_IMAGE . $filename);
                foreach ($exclude as $dir) {
                    if (strpos($find, $dir) === 0) {
                        $watermark = FALSE;
                        $this->debug("Image path is in excludes: $find");
                        break;
                    }
                }
            }
        }

        $watermark_width = $this->config->get("ctrl_watermark_width_${store_id}");
        $watermark_height = $this->config->get("ctrl_watermark_height_${store_id}");
        $watermark_left = $this->config->get("ctrl_watermark_left_${store_id}");
        $watermark_top = $this->config->get("ctrl_watermark_top_${store_id}");
        $watermark_angle = $this->config->get("ctrl_watermark_angle_${store_id}");
        $watermark_hide_real_path = $this->config->get("ctrl_watermark_hide_real_path_${store_id}");

        if ($watermark) {
            $new_image .= '-w' . (int)$watermark_left . "-" . (int)$watermark_top . '-' . (int)$watermark_width . "-" . (int)$watermark_height . "-" . (int)$watermark_angle;
        }
        $new_image .= '.' . $extension;
        if( $watermark_hide_real_path ) {
            $new_image = 'cache/' . md5($new_image) . '.' . $extension;
            $this->debug("hidden watermark image: $new_image");
        }
        if (!file_exists(DIR_IMAGE . $new_image) || (filemtime(DIR_IMAGE . $old_image) > filemtime(DIR_IMAGE . $new_image))) {
            $path = '';

            $directories = explode('/', dirname(str_replace('../', '', $new_image)));

            foreach ($directories as $directory) {
                $path = $path . '/' . $directory;

                if (!file_exists(DIR_IMAGE . $path)) {
                    @mkdir(DIR_IMAGE . $path, 0777);
                }
            }

            list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $old_image);

            if ($width_orig != $width || $height_orig != $height || $watermark) {

                $image = new Image(DIR_IMAGE . $old_image);
                $image->resize($width, $height, $type);

                if ($watermark) {
                    $this->debug("applying watermark: $new_image");
                    $scale_x = $width / 100; //scaling proportionally
                    $scale_y = $height / 100; //scaling proportionally
                    $image->_watermark(DIR_IMAGE . $watermark_image,
                            $watermark_left * $scale_x,
                            $watermark_top * $scale_y,
                            $watermark_width * $scale_x,
                            $watermark_height * $scale_x,
                            $watermark_angle
                        );
                }
                $image->save(DIR_IMAGE . $new_image);
            } else {
                if ($watermark) {
                    $this->debug("watermark for store ${store_id} was not called for unknown reason");
                }
                copy(DIR_IMAGE . $old_image, DIR_IMAGE . $new_image);
            }
        } else {
            if ($watermark) {
                $this->debug("watermark was not called because destination file is already exists");
            }
        }

        return $this->getImageUrl($new_image);
    }
}