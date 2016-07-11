require('./matchup-editor.sass');
const Vue = require('vue');

export default class MatchupEditor extends Vue {
  constructor() {
    const properties = {
      el: "#matchup-editor",
      template: require('./matchup-editor.html'),

      data: {
        matchups: [],
      },

      ready: function() {
        this.matchups = $(this.$el).data("matchups");
        this.authority = $(this.$el).data("authority");
        this.charas = $(this.$el).data("charas");
        console.log(this.matchups);
      },

      methods: {
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
