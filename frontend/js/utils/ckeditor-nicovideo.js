function onLoad() {
  $('.ckeditor-text a').playTube({
    width: 240,
    height: 180,
  });
}

window.addEventListener('turbolinks:load', onLoad);
