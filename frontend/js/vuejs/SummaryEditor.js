import Vue from "vue";

Vue.use(require('../vendor/vue-drag-and-drop'));

export default class SummaryEditor extends Vue {
  constructor() {
    let properties = {
      el: "#summary-editor",

      template: require("./SummaryEditor.jade")(),

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
            avatar_url: message.slack_user.icon_url,
            username: message.slack_user.name,
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

        let channelID = $(this.$el).data("channel-id");
        if (channelID) {
          this.channelID = channelID;
          $.ajax({
            type: "get",
            url: "/api/channels/" + channelID,
            success: (resp) => {
              resp.filter((message) => {
                return !this.messages.map((m) => {
                  return m.id;
                }).includes(message.id);
              }).map((message) => {
                this.loadMessages.push({
                  id: message.id,
                  avatar_url: message.slack_user.icon_url,
                  username: message.slack_user.name,
                  date: message.date,
                  ts: message.ts,
                  channel: message.channel,
                  format_text: message.format_text
                });
              });
            }
          });
        }
      },

      methods: {
        onSelectChannel: (e, channel, loadMessages) => {
          this.nowLoading = true;
          $.ajax({
            type: "get",
            url: "/api/channels/" + channel,
            success: (resp) => {
              this.nowLoading = false;
              loadMessages.splice(0, loadMessages.length);
              this.messages.splice(0, this.messages.length);
              this.channelID = channel;

              resp.map((message) => {
                loadMessages.push({
                  id: message.id,
                  avatar_url: message.icon_url,
                  username: message.username,
                  date: message.date,
                  ts: message.ts,
                  channel: message.channel,
                  format_text: message.format_text
                });
              });
            },
            error: (resp) => {
              this.nowLoading = false;
              alert('取得できませんでした');
            }
          });
        },
        handleDrop: (itemOne, itemTwo) => {
          if (itemTwo.tagName !== "LI") {
            itemTwo = $(itemTwo).parents('li')[0];
          }
          let dummy = this.messages[itemOne.id];
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
          let messageIDs = messages.map((n) => {
            return n.id
          });
          e.preventDefault();
          if (messageIDs.length == 0) {
            alert('まとめるメッセージを選択してください。');
            return;
          }
          if (title.length < 1 || title.length > 64) {
            alert('タイトルを1〜64文字で入力してください。');
            return;
          }
          if (description.length > 1024) {
            alert('説明文を1024文字以内で入力してください。');
            return;
          }

          this.nowSubmitting = true;
          $.ajax({
            type: (this.summaryID ? 'put' : 'post'),
            url: (this.summaryID ? `/summaries/${this.summaryID}.json` : '/summaries.json'),
            data: {
              authenticity_token: $('meta[name="csrf-token"]').content,
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
              alert('投稿できませんでした')
            }
          })
        }
      }
    };
    super(properties);
  }
};

$(function() {
  new SummaryEditor();
});
