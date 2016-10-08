import React, { Component } from 'react';
import { Sortable } from 'react-sortable';

import Message from '../message'

const SortableMessage = Sortable(Message);

export default class MessagesList extends Component {
  constructor(props) {
    super(props)

    this.state = {
      draggingIndex: null,
      messages: this.props.messages
    };
    this.updateState = this.updateState.bind(this);
    this.onClickMessage = this.onClickMessage.bind(this);
  }

  componentWillReceiveProps(props) {
    this.setState({ messages: props.messages });
  }

  updateState(message) {
    this.setState(message);
  }

  onClickMessage(e) {
    let message = e.target;
    if (message.tagName !== 'LI') {
      message = $(message).parents('li')[0];
    }
    this.props.handleClickMessage(message);
  }

  render() {
    const messages = this.state.messages.map((message, i) => {
      return (
        <div onClick={this.onClickMessage} key={i}>
          <SortableMessage
            key={i}
            updateState={this.updateState}
            items={this.state.messages}
            draggingIndex={this.state.draggingIndex}
            sortId={i}
            outline="list"
            childProps={{ message }}
          />
        </div>
      )
    });

    return (
      <ul>
        {messages}
      </ul>
    );
  }
}
