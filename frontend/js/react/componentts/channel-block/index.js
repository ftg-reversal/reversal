import React, { Component } from 'react';

import ChannelLoadForm from '../channel-load-form';
import MessagesPane from '../messages-pane';

export default class ChannelBlock extends Component {
  render() {
    return (
      <div className="col-lg-6">
        <div className="main-card card">
          <div className="card-block">
            <ChannelLoadForm loadChannel={this.props.loadChannel} />
            <MessagesPane messages={this.props.messages} handleClickMessage={this.props.handleClickMessage} />
          </div>
        </div>
      </div>
    );
  }
}
