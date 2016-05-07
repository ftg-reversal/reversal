function onLoad() {
  $("[data-behavior='delete']").on("click", function(e) {
    e.preventDefault();
    const url = $(this).attr('href');

    swal({
      title: '削除確認',
      text: '本当に削除してよろしいですか？',
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: '削除',
      cancelButtonText: 'キャンセル',
      closeOnConfirm: false,
    },
    function() {
      $.ajax({
        type: 'delete',
        url: url,
        data: {
          authenticity_token: $('meta[name="csrf-token"]').attr('content')
        }
      });
      setTimeout(location.reload(), 500);
    })
  });
};

window.addEventListener('DOMContentLoaded', onLoad);
