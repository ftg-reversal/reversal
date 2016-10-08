import React, { Component } from 'react';
import { render } from 'react-dom';

import ChannelBlock from './componentts/channel-block';
import SummaryBlock from './componentts/summary-block';
import './summary-editor.css';

import ChannelApi from '../api/channel-api';

export default class SummaryEditor extends Component {
  constructor(props) {
    super(props);

    this.state = { channelId: 0, messages: [], summaryMessages: [] };
    this.loadChannel = this.loadChannel.bind(this);
    this.handleClickMessage = this.handleClickMessage.bind(this);
    this.handleClickSummaryMessage = this.handleClickSummaryMessage.bind(this);

    const params = document.querySelector('#editor-param');
    if (params.dataset.summaryId) {
      this.state.channelId = params.dataset.channelId;
      this.state.form = {
        summaryId: params.dataset.summaryId,
        title: params.dataset.summaryTitle,
        description: params.dataset.summaryDescription,
      };
      JSON.parse(params.dataset.messages).forEach((message) => {
        this.state.summaryMessages.push({
          id: message.id,
          avatar_url: message.icon_url,
          username: message.username,
          date: message.date,
          ts: message.ts,
          channel: message.channel,
          format_text: message.format_text,
          attachments: message.attachments,
        });
      });
    } else {
      this.state.channelId = 0;
      this.state.form = {
        summaryId: '',
        channelId: 0,
        title: '',
        description: '',
      };
    }

    if (params.dataset.channelId) {
      this.loadChannel(params.dataset.channelId);
    }
  }

  async loadChannel(channelId) {
    const response = await ChannelApi.fetchLatestMessages(channelId);
    const json = await response.json();
    if (this.state.channelId !== channelId) {
      this.setState({ channelId, messages: json, summaryMessages: [] });
    } else {
      this.state.summaryMessages.forEach((existMessage) => {
        json.map((message, index) => {
          if (existMessage.id == message.id) {
            json.splice(index, 1);
          }
        });
      });
      this.setState({ channelId, messages: json});
    }
  }

  handleClickMessage(clickedMessageEl) {
    const messageId = clickedMessageEl.dataset.messageId;
    const newMessages = this.state.messages.filter(message => message.id !== parseInt(messageId));
    this.setState({ messages: newMessages });

    const clickedMessage = this.state.messages.find(message => message.id === parseInt(messageId));
    const summaryMessages = this.state.summaryMessages.concat([clickedMessage]);
    this.setState({ summaryMessages });
  }

  handleClickSummaryMessage(clickedMessageEl) {
    const messageId = clickedMessageEl.dataset.messageId;
    const newSummaryMessages = this.state.summaryMessages.filter(message => message.id !== parseInt(messageId));
    this.setState({ summaryMessages: newSummaryMessages });

    const clickedMessage = this.state.summaryMessages.find(message => message.id === parseInt(messageId));
    const messages = this.state.messages.concat([clickedMessage]);
    this.setState({ messages: messages.sort((a, b) => b.ts - a.ts) });
  }

  render() {
    return (
      <div className="app-root">
        <div className="row">
          <ChannelBlock
            messages={this.state.messages}
            loadChannel={this.loadChannel}
            handleClickMessage={this.handleClickMessage}
          />
          <SummaryBlock
            channelId={this.state.channelId}
            messages={this.state.summaryMessages}
            form={this.state.form}
            handleClickMessage={this.handleClickSummaryMessage}
          />
        </div>
      </div>
    );
  }
}

window.addEventListener('turbolinks:load', () => {
  if (document.querySelector('#summary-editor') !== null) {
    render((
      <SummaryEditor />
    ), document.querySelector('#summary-editor'));
  }
});
