const Vue = require('vue');
const template = require('./summary-editor.jade');
require('./summary-editor.sass');
Vue.use(require('vendor/vue-drag-and-drop'));

export default class SummaryEditor extends Vue {
  constructor() {
    const properties = {
      el: "#summary-editor",

      template: template(),

      data: {
        summaryID: null,
        title: "",
        description: "",
        selected: "",
        channels: [{text: "チャンネルを選択", value: ""}],
        channel: [""],
        channelID: null,
        messages: [],

        loadMessages: [],
        nowLoading: false,
        nowSubmitting: false
      },

      ready: function() {
        this.summaryID = $(this.$el).data("summary-id");
        this.title = $(this.$el).data("summary-title");
        this.description = $(this.$el).data("summary-description") ? $(this.$el).data("summary-description") : "";

        $(this.$el).data("messages").map((message) => {
          this.messages.push({
            id: message.id,
            avatar_url: message.icon_url,
            username: message.username,
            date: message.date,
            ts: message.ts,
            channel: message.channel,
            format_text: message.format_text
          });
        });

        $.ajax({
          type: "get",
          url: "/api/channels",
          success: (resp) => {
            resp.map((channel) => {
              this.channels.push({text: channel.name, value: channel.id});
            });
          }
        });

        const channelID = $(this.$el).data("channel-id");
        if (channelID) {
          this.channelID = channelID;
          loadChannel(channelID, this.loadMessages, this);
        }
      },

      methods: {
        loadTweet: (e) => {
          twttr.widgets.load();
        },
        onSelectChannel: (e, channel, loadMessages) => {
          this.nowLoading = true;
          loadMessages.splice(0, loadMessages.length);
          this.messages.splice(0, this.messages.length);
          loadChannel(channel, loadMessages, this);
        },
        handleDrop: (itemOne, itemTwo) => {
          if (itemTwo.tagName !== "LI") {
            itemTwo = $(itemTwo).parents('li')[0];
          }
          const dummy = this.messages[itemOne.id];
          this.messages.$set(itemOne.id, this.messages[itemTwo.id]);
          this.messages.$set(itemTwo.id, dummy);
        },
        onClickLoadMessage: (el) => {
          this.messages.push(this.loadMessages[el.$index]);
          this.loadMessages.splice(el.$index, 1);
        },
        onClickMessage: (el) => {
          this.loadMessages.push(this.messages[el.$index]);
          this.messages.splice(el.$index, 1);
          this.loadMessages.sort((a, b) => {
            return b.ts - a.ts;
          });
        },
        onSubmit: (e, title, description, messages) => {
          const messageIDs = messages.map((n) => {
            return n.id
          });
          e.preventDefault();
          if (messageIDs.length === 0) {
            swal('まとめるメッセージを選択してください。');
            return;
          }
          if (title === undefined || title.length < 1 || title.length > 64) {
            swal('タイトルを1〜64文字で入力してください。');
            return;
          }
          if (description.length > 1024) {
            swal('説明文を1024文字以内で入力してください。');
            return;
          }

          this.nowSubmitting = true;
          $.ajax({
            type: (this.summaryID ? 'put' : 'post'),
            url: (this.summaryID ? `/summaries/${this.summaryID}.json` : '/summaries.json'),
            data: {
              authenticity_token: $('meta[name="csrf-token"]')[0].content,
              title: title,
              description: description,
              slack_channel: this.channelID,
              slack_messages: messageIDs
            },
            success: (data) => {
              location.href = data.path
            },
            error: () => {
              this.nowSubmitting = false;
              swal('投稿できませんでした')
            }
          })
        }
      }
    };
    super(properties);
  }
}

function loadChannel(channel, loadMessages, self) {
  self.nowLoading = true;
  $.ajax({
    type: "get",
    url: "/api/channels/" + channel,
    success: (resp) => {
      self.nowLoading = false;
      self.channelID = channel;

      resp.map((message) => {
        if (!self.messages.some((selectedMessage) => { return message.id === selectedMessage.id })) {
          loadMessages.push({
            id: message.id,
            avatar_url: message.icon_url,
            username: message.username,
            date: message.date,
            ts: message.ts,
            channel: message.channel,
            format_text: message.format_text,
            attachments: message.attachments
          });
        }
      });
    },
    error: (resp) => {
      self.nowLoading = false;
      swal('取得できませんでした');
    }
  });
}

$(document).on('ready turbolinks:load', () => {
  if (document.querySelector("#summary-editor")) {
    new SummaryEditor();
  }
});
