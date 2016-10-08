import React, { Component } from 'react';

import MessageList from '../messages-list';

export default class SummaryPane extends Component {
  render() {
    return (
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
    );
  }
}
