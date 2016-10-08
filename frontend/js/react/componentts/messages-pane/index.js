import React, { Component } from 'react';

import MessageList from '../messages-list';

export default class MessagesPane extends Component {
  render() {
    return (
      <div>
        <div className="card">
          <div className="card-block">
            <div className="load-messages room">
              <MessageList
                messages={this.props.messages}
                handleClickMessage={this.props.handleClickMessage}
              />
            </div>
          </div>
        </div>
        <div className="card-footer text-muted">
          左パネルからクリックで発言を選択<br />ドラッグで並び替え
        </div>
      </div>
    );
  }
}
