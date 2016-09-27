import $ from 'jquery';

function onLoad() {
  $('.lazy').lazyload();
}

window.addEventListener('turbolinks:load', onLoad);
