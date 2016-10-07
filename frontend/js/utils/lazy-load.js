function onLoad() {
  $('.lazy').lazyload();
}

window.addEventListener('turbolinks:load', onLoad);
