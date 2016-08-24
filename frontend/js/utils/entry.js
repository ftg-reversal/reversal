require('vendor/jquery.validationEngine-ja.js');
require('vendor/jquery.validationEngine');

function onLoad() {
  $('#new-entry-submit').click((e) => {
    e.preventDefault();

    if (!$("#new_entry").validationEngine('validate')) {
      return false;
    }

    const eventTitle = $('h2:first').text().replace(/\s+/g, "");

    const players = {
      names: [],
      charas: [],
      ranks: []
    }
    $('div[id ^= player]').each((i) => {
      i++;
      players.names.push($(`#player_name_${i}`).val());
      players.charas.push($(`#player_chara_${i}`).val());
      players.ranks.push($(`#player_rank_${i}`).val());
    });

    $.ajax({
      type: 'post',
      url: '/entries',
      data: Object.assign(players, {
        authenticity_token: $('meta[name="csrf-token"]').attr('content'),
        [$('#entry_event').attr('name')] : $('#entry_event').attr('value'),
        [$('#entry_comment').attr('name')] : $('#entry_comment').val()
      })
    }).done((data) => {
      $('#entryModal').modal('hide');
      swal({
        title: 'エントリー完了',
        text: 'エントリーに成功しました<br>エントリーしたことをツイートする<br><a href="https://twitter.com/intent/tweet?button_hashtag=ftg_reversal&text=' + eventTitle + 'にエントリーしました" class="twitter-hashtag-button" data-size="large" data-url="' + window.location.href + '">',
        type:  'success',
        html: true
      }, () => { location.reload() });
      twttr.widgets.load();
    }).fail((data) => {
      swal({
        title: 'エントリー失敗',
        text: '入力を確認してください',
        type:  'error'
      });
    });
  });
}

window.addEventListener('turbolinks:load', onLoad);