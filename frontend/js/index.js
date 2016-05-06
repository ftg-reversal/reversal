require("jquery");
require("jquery-ujs");

require("font-awesome-webpack");

require("./vendor/widgets");

require("./views/header");

require("./vuejs/SummaryEditor.js");

$(document).on('turbolinks:load', function() {
  $('.ckeditor').each(function(i, e) {
    CKEDITOR.replace(e.id);
  });
});
