function onLoad() {
  /* eslint-disable no-undef */
  if (twttr) {
    twttr.widgets.load();

    const widget = $('#online-bot-widget');
    widget.empty();
    twttr.widgets.createTimeline(
      '753550279807672320',
      document.getElementById('online-bot-widget'),
      { screenName: 'ggxrd_online' }
    );
  }
  /* eslint-disable no-undef */
}

window.addEventListener('turbolinks:load', onLoad);
