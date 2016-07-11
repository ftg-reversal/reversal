function onLoad() {
  if (twttr) twttr.widgets.load();
}

window.addEventListener('turbolinks:load', onLoad);
