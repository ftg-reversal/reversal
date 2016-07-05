function onLoad() {
  $("[data-behavior='good']").click(function(e) {
    e.preventDefault();
    const url = $(this).data('url');
    const button = $(this).find('button')[0];

    $.ajax({
      type: $(button).hasClass('is-good') ? 'delete' : 'put',
      url: url,
      data: {
        authenticity_token: $('meta[name="csrf-token"]').attr('content'),
        user : $(this).data('user'),
        type : $(this).data('type'),
        id : $(this).data('id')
      }
    }).done((data) => {
      // TODO: ツイートボタンのテキストを書き換える
      if($(button).hasClass('is-good')) {
        $(button).removeClass('is-good')
      } else {
        $(button).addClass('is-good')
      }
    }).fail((data) => {
      swal({
        title: '通信に失敗しました',
        type:  'error'
      });
    });
  });
}

document.addEventListener('turbolinks:load', onLoad);
