function onLoad() {
  Array.prototype.map.call(document.querySelectorAll('.ckeditor'), (e) => {
    CKEDITOR.replace(e); // eslint-disable-line no-undef
  });
}

window.addEventListener('turbolinks:load', onLoad);
