function onLoad() {
  if (twttr) twttr.widgets.load();
}

window.addEventListener('DOMContentLoaded', onLoad);
window.addEventListener('turbolinks:load', onLoad);
