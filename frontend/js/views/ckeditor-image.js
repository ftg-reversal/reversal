function onLoad() {
  $('.ckeditor-text').find('img').removeAttr('width height');
  $('.ckeditor-text').find('img').addClass('u-image-responsive');
}

window.addEventListener('DOMContentLoaded', onLoad);
window.addEventListener('turbolinks:load', onLoad);
