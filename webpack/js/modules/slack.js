$(function(){
  $("#history-menubar").sticky({topSpacing:0});
});

$(function() {
  $('#history-menu').mmenu({
    offCanvas: { position : "bottom" },
    navbar: { title : "チャンネル一覧" },
    searchfield: true,
    extensions: ["theme-dark"]
  });
});
