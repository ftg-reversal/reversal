import $ from 'jquery';
import 'jquery-match-height';

function onLoad() {
  $('.p-user-card').matchHeight();
}

window.addEventListener('turbolinks:load', onLoad);
