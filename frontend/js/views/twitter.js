function onLoad() {
  if (twttr) {
    twttr.widgets.load();

    const widget = $('#online-bot-widget');
    widget.empty();
    twttr.widgets.createTimeline('753550279807672320', document.getElementById('online-bot-widget'));
  }
}

window.addEventListener('turbolinks:load', onLoad);
