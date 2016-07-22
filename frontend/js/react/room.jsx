import * as React from 'react';
import * as ReactDOM from 'react-dom';
import {connector} from '../cable/connector.js'

const RoomHeader = (props) => {
  return (
    <div>
      <h4 className="fa fa-2x fa-slack m-r-2">
        &nbsp;{props.roomName}
      </h4>
      <hr className="m-t-0" />
    </div>
  );
};

const MessageView = (props) => {
};

class MessageForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      user: undefined,
    };

    this.setUser();
  }

  async setUser() {
    const response = await connector.fetchUser();
    this.setState({user: await response.json()});
  }

  render() {
    const onKeyDown = this.onKeyDown.bind(this);
    const onKeyPress = this.onKeyPress.bind(this);
    if (this.state.user) {
      return (
        <textarea className="message-form" onKeyDown={onKeyDown} onKeyPress={onKeyPress} data-csrf-token={this.props.csrfToken} />
      )
    } else {
      return (
        <textarea className="message-form" disabled placeholder="Please login first." data-csrf-token={this.props.csrfToken} />
      )
    }
  }

  onKeyPress(event) {
    if (event.key === "Enter") {
      const textarea = event.target;
      event.preventDefault();
      if (!event.shiftKey && !event.ctrlKey && textarea.value !== "") {
        connector.newMessage(textarea.value);
        textarea.value = "";
      }
    }
  }

  onKeyDown(event) {
    if (event.key === "Enter") {
      const textarea = event.target;
      if (event.shiftKey || event.ctrlKey) {
        const start = textarea.selectionStart;
        const end = textarea.selectionEnd;
        const text = textarea.value;
        textarea.value = textarea.value.substring(0, start) + "\n" + textarea.value.substring(end, text.length);
        textarea.selectionStart = textarea.selectionEnd = start + "\n".length
      }
    }
  }
}

export default
class Room extends React.Component {
  constructor() {
    super();
    this.state = {
      csrfToken: connector.csrfToken(),
      roomName: connector.roomName(),
      messages: []
    };
  }

  render() {
    const messages = this.state.messages;
    return (
      <div className="card">
        <div className="card-block">
          <RoomHeader roomName={this.state.roomName} />
          <MessageForm csrfToken={this.state.csrfToken} />
          {messages.map((msg, i) => <MessageView key={i} message={msg} />)}
        </div>
      </div>
    );
  }
}

window.addEventListener('turbolinks:load', () => {
  if (document.querySelector('#room') != null) {
    ReactDOM.render(<Room />, document.querySelector('#room'));
  }
});
