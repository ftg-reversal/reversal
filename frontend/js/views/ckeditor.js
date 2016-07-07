function onLoad() {
  Array.prototype.map.call(document.querySelectorAll('.ckeditor'),  (e) => {
    CKEDITOR.replace(e);
  });
}

window.addEventListener('DOMContentLoaded', onLoad);
window.addEventListener('turbolinks:load', onLoad);
