function onLoad() {
  $('.ckeditor-text a').playTube({
    width: 480,
    height: 370,
  });
}

window.addEventListener('turbolinks:load', onLoad);
