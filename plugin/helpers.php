<?php
namespace Events;
class helpers
{

  public static function addStyle($label, $path, $admin = false)
  {
    $action_prefix = $admin ? 'admin_' : 'wp_';
    add_action("{$action_prefix}enqueue_scripts", function () use ($label, $path) {
      wp_register_style($label, $path);
      wp_enqueue_style($label);
    });
  }

  public static function addScript($label, $path, $admin = false, $enqueue = true)
  {
    $action_prefix = $admin ? 'admin_' : 'wp_';
    add_action("{$action_prefix}enqueue_scripts", function () use ($label, $path, $enqueue) {
      wp_register_script($label, $path, [], null, true);
      if ($enqueue) wp_enqueue_script($label);
    });
  }
}