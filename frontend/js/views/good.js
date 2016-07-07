function onLoad() {
  $("[data-behavior='good']").click(function(e) {
    e.preventDefault();
    const replace_page_title = `${$('title').text()} をGoodしました`;
    const url = $(this).data('url');
    const button = $(this).find('button')[0];
    const tw_link = $('.good-tweet-link')[0];
    console.log(url);

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
      const count = $(this).find('span')[0];
      if($(button).hasClass('is-good')) {
        $(button).removeClass('is-good');
        $(button).prop("disabled", true);
        $(count).text(parseInt($(count).text()) - 1);
      } else {
        $(button).addClass('is-good');
        $(count).text(parseInt($(count).text()) + 1);
        $(tw_link).attr('href', `https://twitter.com/share?url=${encodeURIComponent(url)}&text=${encodeURIComponent(replace_page_title)}`);
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
