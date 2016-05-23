const matchHeight = require('jquery-match-height');

function onLoad() {
    $('.card').matchHeight();
}

window.addEventListener('DOMContentLoaded', onLoad);
window.addEventListener('turbolinks:load', onLoad);
twttr.events.bind( 'rendered', (event) => { onLoad(); });
