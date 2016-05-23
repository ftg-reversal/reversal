const matchHeight = require('jquery-match-height');

function onLoad() {
    $('.card').matchHeight();
}

window.addEventListener('DOMContentLoaded', onLoad);
window.addEventListener('turbolinks:load', onLoad);
