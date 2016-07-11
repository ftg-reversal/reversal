require('./matchup-editor.sass');
const Vue = require('vue');

export default class MatchupEditor extends Vue {
  constructor() {
    const properties = {
      el: "#matchup-editor",
      template: require('./matchup-editor.html'),

      data: {
        videoID: 0,
        videoUrl: '',
        matchups: [],
        authority: 'disable',
        addFlag: false,
        minutes: Array.apply(null, {length: 60}).map(Number.call, Number),
        seconds: Array.apply(null, {length: 60}).map(Number.call, Number),
        minute: 0,
        second: 0,
        chara1: null,
        chara2: null
      },

      ready: function() {
        this.videoID = $(this.$el).data("video-id");
        this.videoUrl = $(this.$el).data("video-url");
        this.matchups = $(this.$el).data("matchups");
        this.authority = $(this.$el).data("authority");
        this.charas = $(this.$el).data("charas");

        this.chara1 = this.charas[0].id;
        this.chara2 = this.charas[0].id;
      },

      methods: {
        displayForm: (e) => {
          this.addFlag = true;
        },

        onSubmit: (e) => {
          $.ajax({
            type: 'post',
            url: `/videos/${this.videoID}/matchups`,
            data: {
              authenticity_token: $('meta[name="csrf-token"]')[0].content,
              sec: this.minute * 60 + this.second,
              chara1_id: this.chara1,
              chara2_id: this.chara2
            },
            success: (data) => {
              swal('追加に成功しました');
              Turbolinks.clearCache();
              location.reload();
            },
            error: () => {
              swal('追加に失敗しました');
            }
          })
        },

        deleteMatchup: (e, matchup) => {
          swal({
            title: '削除確認',
            text: '本当に削除してよろしいですか？',
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#DD6B55',
            confirmButtonText: '削除',
            cancelButtonText: 'キャンセル',
            closeOnConfirm: false
          },
          () => {
            $.ajax({
              type: 'delete',
              url: `/video_matchups/${matchup.id}`,
              data: {
                authenticity_token: $('meta[name="csrf-token"]')[0].content,
              },
              success: (data) => {
                swal('削除に成功しました');
                Turbolinks.clearCache();
                location.reload();
              },
              error: () => {
                swal('削除に失敗しました');
              }
            })
          })
        }
      }
    };
    super(properties);
  }
}

window.addEventListener('turbolinks:load', () => {
  if ($('#matchup-editor')) {
    new MatchupEditor();
  }
});
