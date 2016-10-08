import salert from 'sweetalert';
import '../vendor/jquery.validationEngine-ja';
import '../vendor/jquery.validationEngine';

function onLoad() {
  $('#new-entry-submit').click((e) => {
    e.preventDefault();

    if (!$('#new_entry').validationEngine('validate')) {
      return false;
    }

    const eventTitle = $('h2:first').text().replace(/\s+/g, '');

    const players = {
      names: [],
      charas: [],
      ranks: [],
    };

    $('div[id ^= player]').each((i) => {
      players.names.push($(`#player_name_${i + 1}`).val());
      players.charas.push($(`#player_chara_${i + 1}`).val());
      players.ranks.push($(`#player_rank_${i + 1}`).val());
    });

    $.ajax({
      type: 'post',
      url: '/entries',
      data: Object.assign(players, {
        authenticity_token: $('meta[name="csrf-token"]').attr('content'),
        [$('#entry_event').attr('name')]: $('#entry_event').attr('value'),
        [$('#entry_comment').attr('name')]: $('#entry_comment').val(),
      }),
    }).done((_data) => {
      $('#entryModal').modal('hide');
      salert({
        title: 'エントリー完了',
        text: `エントリーに成功しました<br>エントリーしたことをツイートする<br><a href="https://twitter.com/intent/tweet?button_hashtag=ftg_reversal&text=${eventTitle}にエントリーしました" class="twitter-hashtag-button" data-size="large" data-url="${window.location.href}">`,
        type: 'success',
        html: true,
      }, () => { location.reload(); });
      twttr.widgets.load();
    }).fail((_data) => {
      salert({
        title: 'エントリー失敗',
        text: '入力を確認してください',
        type: 'error',
      });
    });
    return true;
  });
}

window.addEventListener('turbolinks:load', onLoad);
