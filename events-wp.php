<?php
/*
Plugin Name: Events WP
Plugin URI: https://github.com/JesusisFreedom/events-wp
Description: A brief description of the Plugin.
Version: See Package.json
Author: Austin Adams
Author URI: http://farmingtonwebdesign.net
License: MIT
*/

namespace Events;
define('EVWP_ROOT_PATH', __FILE__);
require __DIR__."/plugin/helpers.php";
require __DIR__."/plugin/shortcodes.php";

if(!is_admin()){
  helpers::addScript('EVWP-client-script', plugins_url( 'build/client.js', EVWP_ROOT_PATH ), false, false);
}