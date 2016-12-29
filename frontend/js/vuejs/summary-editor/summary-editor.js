import Vue from 'vue';
import Sortable from 'vue-sortable';
import salert from 'sweetalert';

import ChannelApi from '../../api/channel-api';
import './summary-editor.css';
import template from './summary-editor.html';

Vue.use(Sortable);

export default class SummaryEditor extends Vue {
  constructor() {
    const properties = {
      el: '#summary-editor',
      template,

      data: {
        summaryId: null,
        title: '',
        description: '',
        selected: '',
        channels: [{ text: 'チャンネルを選択', value: '' }],
        channel: [''],
        channelId: null,
        messages: [],

        loadedMessages: [],
        nowLoading: false,
        nowSubmitting: false,
      },

      methods: {
        loadTweet: () => {
          twttr.widgets.load();
        },

        onSelectChannel: async (e, channel, loadedMessages) => {
          if (channel.toString() === '') {
            return;
          }

          this.nowLoading = true;
          loadedMessages.splice(0, loadedMessages.length);
          this.messages.splice(0, this.messages.length);
          await this.loadChannelMessage(channel, loadedMessages);
        },

        onClickLoadMessage: (el) => {
          this.messages.push(this.loadedMessages[el.$index]);
          this.loadedMessages.splice(el.$index, 1);
        },

        onClickMessage: (el) => {
          this.loadedMessages.push(this.messages[el.$index]);
          this.messages.splice(el.$index, 1);
          this.loadedMessages.sort((a, b) => b.ts - a.ts);
        },

        onSubmit: async (e, title, description, messages) => {
          e.preventDefault();

          if (!this.validate(title, description, messages)) {
            return;
          }

          const messageIds = messages.map(message => message.Id);

          this.nowSubmitting = true;
          try {
            if (!this.summaryId) {
              await ChannelApi.newSummary(title, description, this.channelId, messageIds);
              location.href = '/summaries/';
            } else {
              await ChannelApi.editSummary(
                this.summaryId,
                title,
                description,
                this.channelId,
                messageIds,
              );
              location.href = `/summaries/${this.summaryId}`;
            }
          } catch (error) {
            this.nowSubmitting = false;
            salert('投稿できませんでした');
          }
        },
      },
    };
    super(properties);
    this.ready();
  }

  async ready() {
    const paramEl = document.querySelector('#editor-param');

    this.summaryId = paramEl.dataset.summaryId;
    this.title = paramEl.dataset.summaryTitle;

    const description = paramEl.dataset.summaryDescription;
    this.description = description ? description : ''; // eslint-disable-line no-unneeded-ternary, max-len

    JSON.parse(paramEl.dataset.messages).forEach((message) => {
      this.messages.push({
        Id: message.id,
        avatar_url: message.icon_url,
        username: message.username,
        date: message.date,
        ts: message.ts,
        channel: message.channel,
        format_text: message.format_text,
        attachments: message.attachments,
      });
    });

    const response = await ChannelApi.fetchChannelList();
    const json = await response.json();
    json.forEach((channel) => {
      this.channels.push({ text: channel.name, value: channel.id });
    });

    const channelId = paramEl.dataset.channelId;
    if (channelId) {
      this.channelId = channelId;
      await this.loadChannelMessage(channelId, this.loadedMessages);
    }
  }

  async loadChannelMessage(channelId) {
    this.nowLoading = true;

    try {
      const response = await ChannelApi.fetchLatestMessages(channelId);
      const json = await response.json();
      this.nowLoading = false;
      this.channelId = channelId;

      json.forEach((message) => {
        this.loadedMessages.push({
          Id: message.id,
          avatar_url: message.icon_url,
          username: message.username,
          date: message.date,
          ts: message.ts,
          channel: message.channel,
          format_text: message.format_text,
          attachments: message.attachments,
        });
      });

      this.messages.forEach((message) => {
        this.loadedMessages.forEach((loadedMessage, index) => {
          if (loadedMessage.Id === message.Id) {
            this.loadedMessages.splice(index, 1);
          }
        });
      });
    } catch (error) {
      this.nowLoading = false;
      salert('取得できませんでした');
    }
  }

  validate(title, description, messages) {
    if (messages.length === 0) {
      salert('まとめるメッセージを選択してください。');
      return false;
    }
    if (title === undefined || title.length < 1 || title.length > 64) {
      salert('タイトルを1〜64文字で入力してください。');
      return false;
    }
    if (description.length > 1024) {
      salert('説明文を1024文字以内で入力してください。');
      return false;
    }

    return true;
  }
}

window.addEventListener('turbolinks:load', () => {
  if (document.querySelector('#summary-editor') != null) {
    new SummaryEditor(); // eslint-disable-line no-new
  }
});
