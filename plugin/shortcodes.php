<?php
namespace Events;

add_shortcode( 'clndr', function($atts){
  wp_enqueue_script('EVWP-client-script');
  echo "<div class='ev-wp-clndr' id='ev-wp-clndr'></div>";
});