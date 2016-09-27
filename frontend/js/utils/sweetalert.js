import $ from 'jquery';
import salert from 'sweetalert';

function onLoad() {
  $('[data-behavior="delete"]').on('click', function clickEvent(e) {
    e.preventDefault();
    const url = $(this).attr('href');

    salert({
      title: '削除確認',
      text: '本当に削除してよろしいですか？',
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: '削除',
      cancelButtonText: 'キャンセル',
      closeOnConfirm: false,
    },
    () => {
      $.ajax({
        type: 'delete',
        url,
        data: {
          authenticity_token: $('meta[name="csrf-token"]').attr('content'),
        },
      });
      setTimeout(() => {
        Turbolinks.clearCache();  // eslint-disable-line no-undef
        location.href = $(this).data('redirect-to');
      }, 500);
    });
  });
}

window.addEventListener('turbolinks:load', onLoad);
