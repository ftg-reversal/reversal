import React, { Component } from 'react';

export default class Message extends Component {
  constructor(props) {
    super(props);

    this.state = {
      draggingIndex: null,
      messages: this.props.messages,
    };
  }

  onClickMessage(e) {
    let message = e.target;
    if (message.tagName !== 'LI') {
      message = $(message).parents('li')[0];
    }
    this.props.handleClickMessage(message);
  }

  render() {
    const message = this.props.message;
    const attachments = message.attachments.map((attachment, index) => {
      if (attachment.service_name === 'twitter') {
        const key = `${message.id}_${attachment.from_url}`;
        return (
          <blockquote className="twitter-tweet" key={key}>
            <p>{attachment.text}</p>
            &mdash; " {attachment.author_name} ({attachment.author_subname}) " <a href={attachment.from_url} />
          </blockquote>
        );
      } else {
        return (
          <div />
        );
      }
    });

    return (
      <li className="message" data-message-id={message.id} key={message.id}>
        <div className="media">
          <div className="slack-icon media-object pull-left">
            <div className="media-left">
              <img src={message.icon_url || message.avatar_url} alt="avatar" />
            </div>
          </div>
          <div className="media-body">
            <div className="media-heading">
              <h4 className="pull-left">{message.username}</h4>
              <small className="m-l-1">{message.date}</small>
              <p dangerouslySetInnerHTML={{ __html: message.format_text }} />
            </div>
            {attachments}
          </div>
        </div>
      </li>
    );
  }
}
