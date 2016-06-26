const matchHeight = require('jquery-match-height');

function onLoad() {
  $('.user-card').matchHeight();
}

window.addEventListener('DOMContentLoaded', onLoad);
window.addEventListener('turbolinks:load', onLoad);
