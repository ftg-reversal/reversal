function onLoad() {
  $('#event-show').find('img').removeAttr('width height');
  $('#event-show').find('img').addClass('u-image-responsive');
  $('#page-show').find('img').removeAttr('width height');
  $('#page-show').find('img').addClass('u-image-responsive');
}

window.addEventListener('DOMContentLoaded', onLoad);
window.addEventListener('turbolinks:load', onLoad);
