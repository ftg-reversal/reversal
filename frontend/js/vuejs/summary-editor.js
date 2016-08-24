import './summary-editor.sass'
import Vue from 'vue';
import ChannelApi from '../api/channel-api'

Vue.use(require('vendor/vue-drag-and-drop'));

export default class SummaryEditor extends Vue {
  constructor() {
    const properties = {
      el: "#summary-editor",
      template: require('./summary-editor.html'),

      data: {
        summaryID: null,
        title: "",
        description: "",
        selected: "",
        channels: [{text: "チャンネルを選択", value: ""}],
        channel: [""],
        channelID: null,
        messages: [],

        loadedMessages: [],
        nowLoading: false,
        nowSubmitting: false,
      },

      ready: async function() {
        this.summaryID = this.$el.dataset.summaryId;
        this.title = this.$el.dataset.summaryTitle;
        this.description = this.$el.dataset.summaryDescription ? this.$el.dataset.summaryDescription : "";

        JSON.parse(this.$el.dataset.messages).map((message) => {
          this.messages.push({
            id: message.id,
            avatar_url: message.icon_url,
            username: message.username,
            date: message.date,
            ts: message.ts,
            channel: message.channel,
            format_text: message.format_text,
            attachments: message.attachments
          });
        });

        const response = await ChannelApi.fetchChannelList();
        const json = await response.json();
        json.map((channel) => {
          this.channels.push({text: channel.name, value: channel.id});
        });

        const channelID = this.$el.dataset.channelId;
        if (channelID) {
          this.channelID = channelID;
          await this.loadChannelMessage(channelID, this.loadedMessages);
          twttr.widgets.load();
        }
      },

      methods: {
        loadTweet: (e) => {
          twttr.widgets.load();
        },

        onSelectChannel: async (e, channel, loadedMessages) => {
          if (channel.toString() === '') return;
          this.nowLoading = true;
          loadedMessages.splice(0, loadedMessages.length);
          this.messages.splice(0, this.messages.length);
          await this.loadChannelMessage(channel, loadedMessages);
          twttr.widgets.load();
        },

        handleDrop: (itemOne, itemTwo) => {
          if (itemOne.tagName !== "LI") {
            itemOne = $(itemOne).parents('li')[0];
          }
          if (itemTwo.tagName !== "LI") {
            itemTwo = $(itemTwo).parents('li')[0];
          }
          const dummy = this.messages[itemOne.id];
          this.messages.splice(itemOne.id, 1);
          this.messages.splice(itemTwo.id, 0, dummy);
        },

        onClickLoadMessage: (el) => {
          this.messages.push(this.loadedMessages[el.$index]);
          this.loadedMessages.splice(el.$index, 1);
        },

        onClickMessage: (el) => {
          this.loadedMessages.push(this.messages[el.$index]);
          this.messages.splice(el.$index, 1);
          this.loadedMessages.sort((a, b) => {
            return b.ts - a.ts;
          });
        },

        onSubmit: async (e, title, description, messages) => {
          e.preventDefault();

          if (!this.validate(title, description, messages)) {
            return;
          }

          const messageIDs = messages.map((message) => {
            return message.id
          });

          this.nowSubmitting = true;
          try {
            if (!this.summaryID) {
              await ChannelApi.newSummary(title, description, this.channelID, messageIDs);
              location.href = '/summaries/';
            } else {
              await ChannelApi.editSummary(this.summaryID, title, description, this.channelID, messageIDs);
              location.href = `/summaries/${this.summaryID}`;
            }
          } catch(error) {
            this.nowSubmitting = false;
            swal('投稿できませんでした')
          }
        }
      }
    };
    super(properties);
  }

  async loadChannelMessage(channelID) {
    this.nowLoading = true;

    try {
      const response = await ChannelApi.fetchLatestMessages(channelID);
      const json = await response.json();
      this.nowLoading = false;
      this.channelID = channelID;

      json.map((message) => {
        if (!this.messages.some((selectedMessage) => { return message.id === selectedMessage.id })) {
          this.loadedMessages.push({
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
    } catch(error) {
      this.nowLoading = false;
      console.log(error);
      swal('取得できませんでした');
    }
  }

  validate(title, description, messages) {
    if (messages.length === 0) {
      swal('まとめるメッセージを選択してください。');
      return false;
    }
    if (title === undefined || title.length < 1 || title.length > 64) {
      swal('タイトルを1〜64文字で入力してください。');
      return false;
    }
    if (description.length > 1024) {
      swal('説明文を1024文字以内で入力してください。');
      return false;
    }

    return true;
  }
}

window.addEventListener('turbolinks:load', () => {
  if (document.querySelector("#summary-editor") != null) {
    new SummaryEditor();
  }
});
