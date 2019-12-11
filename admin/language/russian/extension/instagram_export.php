<?php
// Heading
$_['heading_title']				= 'Export товаров в Instagram';
$_['heading_title_settings']	= 'Настройка Экспорта в Instagram';

// Text
$_['text_success']				= 'Товары успешно Экспортированы!';
$_['text_list']					= 'Список товаров';
$_['text_edit']					= 'Редактировать настройки';
$_['text_info_comment'] 		= 'Можно использовать параметры:<br />{price} - цена;<br />{name} - название товара;<br />{title} - название товара (Берется с поля "meta_title")<br />{h1} - название товара (Берется с поля "meta_h1")<br />{model} - модель;<br />{link} - ссылка на товар (если домен кирилический обязательно укажите его в настройках)<br />{desc} - описание (берется с поля "meta_description", если хотите уникальный, заполните данные и нажмите "Обновить");<br />{stock} - Наличие товара<br />{tag} - теги товара, будут разделены Хэштегом "#" (беретется с поля "tag", если хотите уникальные, заполнитее данные и нажмите "Обновить");';
$_['text_comment_deff'] 		= '{name} - {model}. {desc} {tag}';
$_['text_export_products'] 		= 'Экспортировать товары';
$_['text_export_product'] 		= 'Экспортировать товар';
$_['text_settings']				= 'Настройки';

$_['column_name']				= 'Товар / Модель';
$_['column_model']				= 'Модель: ';
$_['column_image']				= 'Изображение';
$_['column_category']			= 'Категория';
$_['column_tag']				= 'Хэштеги товара';
$_['column_date']				= 'Instagram';
$_['column_description'] 		= 'Описание товара';
$_['column_action']				= 'Действие';
$_['column_update_date'] 		= 'Публикация';

$_['entry_name'] 				= 'Наименование:';
$_['entry_model']				= 'Модель:';
$_['entry_image']				= 'Водяной знак:';
$_['entry_image_position'] 		= 'Положение:';
$_['entry_comment']				= 'Шаблон описания: ';
$_['entry_export_plane']		= 'Запланировать';
$_['entry_total_products'] 		= 'Количество товаров на странице экспорта: ';
$_['entry_comment_is']			= 'Добавлять комментарий к фото: ';
$_['entry_watermark']			= 'Водяной знак для фотографий';
$_['entry_help_watermark']		= 'Использовать водяной знак для фотографий';
$_['entry_help_publick_plan']	= 'Запланировать публикацию';
$_['entry_publick_plan']		= 'Запланировать';
$_['entry_image_width']			= 'Ширина изображения: ';
$_['entry_update_text']			= 'Обновить';
$_['entry_test_login']			= 'Проверить авторизацию';
$_['entry_username']			= 'Логин пользователя: ';
$_['entry_pass']				= 'Пароль пользователя: ';
$_['entry_http_export']			= 'Кирилический домен: ';
$_['entry_help_http_export'] 	= 'Необходимо заполнить только если домен вашего сайта является кириллическим. Пример http://сайт.укр/ (обязательно / на конце)';
$_['entry_help_image']			= 'Оптимальный размер изображения 620px, максимальный размер - 1080px';
$_['entry_help_comment']		= 'При включеной функции, с фотографией будет добавлено описание в виде комментария';
$_['entry_help_updesc']			= 'Обновить описание товара для экспорта';
$_['entry_help_uptag']			= 'Обновить Хэштги товара для экспорта';
$_['entry_help_utmlink']		= 'UTM параметр ссылки для отслеживания в статистике передается GET параметром. Работает при использовании параметра {link}';
$_['entry_total_utmlink']		= 'UTM для ссылки';
$_['entry_bitly']				= 'Использовать короткие ссылки:';
$_['entry_help_bitly']			= 'Укорачивание ссілок просходит использую сервис - https://bitly.com/';
$_['entry_bitlyusername'] 		= 'Логин для API в Bitly.com';
$_['entry_bitlypass'] 			= 'API KEY в Bitly.com';

$_['text_success_settings']		= 'Настройки успешно сохранены';

$_['tab_general_settings']		= 'Настройки аккаунта';
$_['tab_data_settings']			= 'Дополнительные настройки';
$_['tab_data_cron']				= 'Автоматический Экспорт (CRON)';
$_['tab_update_settings']		= 'Обновление';
$_['text_export']				= 'Опубликовано';
$_['text_no_export']			= 'Не опубликовано';
$_['text_export_date']			= 'Запланировано';

// Error
$_['error_permission']			= 'У Вас нет прав на изменения Экспорта в Инстаграм!';
$_['error_image_width']			= 'Введите размер изображения';
$_['error_image_width_big']		= 'Размер изображения должен быть не больше 1080';
$_['error_bitlyusername'] 		= 'Введите Логин для API';
$_['error_bitlypassword'] 		= 'Введите API Key';
$_['error_watermark_image'] 	= 'Выберите изображение';
$_['error_export_products'] 	= 'Выберите товар(ы) для Экспорта!';