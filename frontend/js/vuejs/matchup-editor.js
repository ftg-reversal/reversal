import Vue from 'vue'
import VideoMatchupApi from '../api/video-matchup-api'
import './matchup-editor.sass'

var player;

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

      ready: async function() {
        this.videoID = this.$el.dataset.videoId;
        this.videoUrl = this.$el.dataset.videoUrl;
        this.authority = this.$el.dataset.authority;
        this.charas = JSON.parse(this.$el.dataset.charas);

        this.chara1 = this.charas[0].id;
        this.chara2 = this.charas[0].id;

        const response = await VideoMatchupApi.fetchMatchups(this.videoID);
        this.matchups = await response.json();
      },

      methods: {
        displayForm: (e) => {
          this.addFlag = true;
        },

        hideForm: (e) => {
          this.addFlag = false;
        },

        setPlayheadTime: (e, time) => {
          player.ext_setPlayheadTime(time);
        },

        onSubmit: async (event) => {
          try {
            await VideoMatchupApi.newMatchup(this.videoID, this.minute * 60 + this.second, this.chara1, this.chara2);
            swal('追加に成功しました');
            const response = await VideoMatchupApi.fetchMatchups(this.videoID);
            this.matchups = await response.json();
          } catch (error) {
            console.error(error);
            swal('追加に失敗しました');
          }
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
          }, async () => {
            try {
              await VideoMatchupApi.deleteMatchup(matchup.id);
              swal('削除に成功しました');
              const response = await VideoMatchupApi.fetchMatchups(this.videoID);
              this.matchups = await response.json();
            } catch (error) {
              console.error(error);
              swal('削除に失敗しました');
            }
          })
        }
      }
    };
    super(properties);
  }

  static csrfToken() {
    return document.querySelector('meta[name="csrf-token"]').content;
  }
}

window.onNicoPlayerReady = function (id) {
  player = document.getElementById(id);
};

window.addEventListener('turbolinks:load', () => {
  if (document.querySelector('#matchup-editor') != null) {
    new MatchupEditor();
  }
});
