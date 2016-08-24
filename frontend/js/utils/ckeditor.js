function onLoad() {
  Array.prototype.map.call(document.querySelectorAll('.ckeditor'),  (e) => {
    CKEDITOR.replace(e);
  });
}

window.addEventListener('turbolinks:load', onLoad);
