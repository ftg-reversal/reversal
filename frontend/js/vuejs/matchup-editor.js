import salert from 'sweetalert';
import Vue from 'vue';
import VideoMatchupApi from '../api/video-matchup-api';
import './matchup-editor.sass';
import template from './matchup-editor.html';

let player;

export default class MatchupEditor extends Vue {
  constructor() {
    const properties = {
      el: '#matchup-editor',
      template,

      data: {
        videoID: 0,
        videoUrl: '',
        matchups: [],
        authority: 'disable',
        addFlag: false,
        minutes: [...Array(60)].map((_v, i) => i),
        seconds: [...Array(60)].map((_v, i) => i),
        minute: 0,
        second: 0,
        chara1: null,
        chara2: null,
      },

      ready: async function ready() {
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
        displayForm: () => {
          this.addFlag = true;
        },

        hideForm: () => {
          this.addFlag = false;
        },

        setPlayheadTime: (_e, time) => {
          player.ext_setPlayheadTime(time);
        },

        onSubmit: (async) () => {
          try {
            const sec = (this.minute * 60) + this.second;
            await VideoMatchupApi.newMatchup(this.videoID, sec, this.chara1, this.chara2);
            salert('追加に成功しました');
            const response = await VideoMatchupApi.fetchMatchups(this.videoID);
            this.matchups = await response.json();
          } catch (error) {
            salert('追加に失敗しました');
          }
        },

        deleteMatchup: (e, matchup) => {
          salert({
            title: '削除確認',
            text: '本当に削除してよろしいですか？',
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#DD6B55',
            confirmButtonText: '削除',
            cancelButtonText: 'キャンセル',
            closeOnConfirm: false,
          }, (async) () => {
            try {
              await VideoMatchupApi.deleteMatchup(matchup.id);
              salert('削除に成功しました');
              const response = await VideoMatchupApi.fetchMatchups(this.videoID);
              this.matchups = await response.json();
            } catch (error) {
              salert('削除に失敗しました');
            }
          });
        },
      },
    };
    super(properties);
  }
}

window.onNicoPlayerReady = (id) => {
  player = document.getElementById(id);
};

window.addEventListener('turbolinks:load', () => {
  if (document.querySelector('#matchup-editor') != null) {
    new MatchupEditor(); // eslint-disable-line no-new
  }
});
