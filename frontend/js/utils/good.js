import salert from 'sweetalert';

function onLoad() {
  $("[data-behavior='good']").click(function clickEvent(e) {
    e.preventDefault();

    const url = $(this).data('url');
    const button = $(this).find('button')[0];

    $.ajax({
      type: $(button).hasClass('is-good') ? 'delete' : 'put',
      url,
      data: {
        authenticity_token: $('meta[name="csrf-token"]').attr('content'),
        user: $(this).data('user'),
        type: $(this).data('type'),
        id: $(this).data('id'),
      },
    }).done((_data) => {
      const count = $(this).find('span')[0];
      if ($(button).hasClass('is-good')) {
        $(button).removeClass('is-good');
        $(button).prop('disabled', true);
        $(count).text(parseInt($(count).text(), 10) - 1);
      } else {
        $(button).addClass('is-good');
        $(count).text(parseInt($(count).text(), 10) + 1);
      }
    }).fail((_data) => {
      salert({
        title: '通信に失敗しました',
        type: 'error',
      });
    });
  });
}

document.addEventListener('turbolinks:load', onLoad);
