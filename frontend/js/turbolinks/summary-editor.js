function onLoad() {
  if (document.querySelector("#summary-editor")) {
    new SummaryEditor();
  }
}

window.addEventListener('DOMContentLoaded', onLoad);
window.addEventListener('turbolinks:load', onLoad);
