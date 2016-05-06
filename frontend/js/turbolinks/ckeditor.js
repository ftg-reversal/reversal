$(document).on('turbolinks:load', function() {
  $('.ckeditor').each(function(i, e) {
    CKEDITOR.replace(e.id);
  });
});
