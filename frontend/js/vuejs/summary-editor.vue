<style lang="sass">
#summary-editor
  h3
    font-size: 1.5rem
    margin-top: .3rem

  p
    font-size: .9rem

  .drag-over
    margin-bottom: 5px

  blockquote
    font-size: 1rem
    padding-left: 10px
    margin-bottom: 0

  select
    height: 2.5rem

  button
    height: 2.5rem

  ul
    margin: 0
    padding: 0

  li
    margin: 0
    padding: 0

  textarea
    height: 5rem

  .main-card
    height: 820px

  .header
    height: 60px

  .load-messages
    height: 600px
    overflow-y: scroll

  .selected-messages
    height: 430px
    overflow-y: scroll

  .card-footer
    background: white
    border: 0

  .media-left
    img
      width: 32px
      height: 32px
      border-radius: 5px
</style>

<template lang="html">
<div class="app-root">
  <div class="hidden-lg-up">
    <div class="card">
      <div class="card-block">
        <p>ご利用の端末からはご利用頂けません
        </p>
      </div>
    </div>
  </div>
  <div class="hidden-md-down">
    <div class="row">
      <div class="col-lg-6">
        <div class="main-card card">
          <div class="card-block">
            <form action="#" @submit.prevent="onSelectChannel($event, channel, loadMessages)" class="summary-form">
              <div class="header">
                <div class="row">
                  <div class="col-lg-8">
                    <select v-model="channel" class="form-control">
                      <option v-for="channel in channels" :value="channel.value">#{{ channel.text }}
                      </option>
                    </select>
                  </div>
                  <div class="col-lg-2">
                    <button type="submit" :disabled="nowLoading" class="form-control"><i v-if="!nowLoading" class="fa fa-refresh"></i><i v-if="nowLoading" class="fa fa-spinner fa-spin"></i>
                    </button>
                  </div>
                  <div class="col-lg-2">
                    <button type="button" v-on:click="loadTweet" class="form-control"><i class="fa fa-twitter"></i>
                    </button>
                  </div>
                </div>
              </div>
            </form>
            <div class="card">
              <div class="card-block">
                <div class="load-messages slack-channel">
                  <ul>
                    <li v-for="message in loadMessages" @click="onClickLoadMessage(this)" class="slack-message">
                      <div class="media">
                        <div class="slack-icon media-object pull-left">
                          <div class="media-left"><img :src="message.avatar_url"/>
                          </div>
                        </div>
                        <div class="media-body">
                          <div class="media-heading">
                            <h4 class="pull-left">{{ message.username }}
                            </h4><small class="m-l-1">{{ message.date }}
</small>
                            <p>{{{ message.format_text }}}
                            </p>
                          </div>
                          <div v-for="attachment in message.attachments">
                            <template v-if="attachment.service_name === &quot;twitter&quot;">
                              <blockquote class="twitter-tweet">
                                <p>{{ attachment.text }}
                                </p>&mdash;
" {{ attachment.author_name }} ({{ attachment.author_subname }}) "
<a :href="attachment.from_url"></a>
                              </blockquote>
                            </template>
                          </div>
                        </div>
                      </div>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="card-footer text-muted">左パネルからクリックで発言を選択<br>ドラッグで並び替え
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-6">
        <div class="main-card card">
          <div class="card-block">
            <div class="header row">
              <h3 class="m-l-1">まとめプレビュー ({{ messages.length }} / 100)
              </h3>
            </div>
            <div class="card">
              <div class="card-block">
                <div class="selected-messages slack-channel editor-main-list">
                  <ul>
                    <li v-for="message in messages" @click="onClickMessage(this)" id="{{ $index }}" v-drag-and-drop drop="handleDrop" class="slack-message media u-no-marker">
                      <div class="slack-icon media-object pull-left">
                        <div class="media-left"><img :src="message.avatar_url"/>
                        </div>
                      </div>
                      <div class="media-body">
                        <div class="media-heading">
                          <h4 class="pull-left">{{ message.username }}
                          </h4><small class="m-l-1">{{ message.date }}
</small>
                          <p>{{{ message.format_text }}}
                          </p>
                        </div>
                        <div v-for="attachment in message.attachments">
                          <template v-if="attachment.service_name === &quot;twitter&quot;">
                            <blockquote class="twitter-tweet">
                              <p>{{ attachment.text }}
                              </p>&mdash;
" {{ attachment.author_name }} ({{ attachment.author_subname }}) "
<a :href="attachment.from_url"></a>
                            </blockquote>
                          </template>
                        </div>
                      </div>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          <div class="card-footer">
            <fieldset class="form-group">
              <input name="title" type="text" value="" placeholder="まとめのタイトル" v-model="title" :readonly="nowSubmitting" class="form-control js-edit-app-title"/>
            </fieldset>
            <fieldset class="form-group">
              <textarea name="description" placeholder="まとめの説明文(省略可)" v-model="description" :readonly="nowSubmitting" class="form-control js-edit-app-description"></textarea>
            </fieldset>
            <div class="form-group">
              <button @click="onSubmit($event, title, description, messages)" :disabled="nowSubmitting" class="btn btn-primary">まとめを投稿する </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</template>

<script>
const Vue = require('vue');
Vue.use(require('vendor/vue-drag-and-drop'));

export default class SummaryEditor extends Vue {
  constructor() {
    const properties = {
      el: "#summary-editor",

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
          console.log(message);
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

        $.ajax({
          type: "get",
          url: "/api/channels"
        }).done((resp) => {
          resp.map((channel) => {
            this.channels.push({text: channel.name, value: channel.id});
          });
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
          if (channel.toString() === '') return;
          this.nowLoading = true;
          loadMessages.splice(0, loadMessages.length);
          this.messages.splice(0, this.messages.length);
          loadChannel(channel, loadMessages, this);
        },
        handleDrop: (itemOne, itemTwo) => {
          if (itemOne.tagName !== "LI") {
            itemOne = $(itemOne).parents('li')[0];
          }
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
    url: "/api/channels/" + channel
  }).done((resp) => {
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
  }).fail((resp) => {
    self.nowLoading = false;
    swal('取得できませんでした');
  });
}

$(document).on('ready turbolinks:load', () => {
  if (document.querySelector("#summary-editor")) {
    new SummaryEditor();
  }
});
</script>
