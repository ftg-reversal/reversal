import React, { Component } from 'react';

import MessagesPane from '../messages-pane';
import SummaryPane from '../summary-pane';
import SummaryForm from '../summary-form';

export default class SummaryBlock extends Component {
  render() {
    return (
      <div className="col-lg-6">
        <div className="main-card card">
          <div className="card-block">
            <div className="header row">
              <h3 className="m-l-1">まとめプレビュー ({this.props.messages.length} / 100)
              </h3>
            </div>
            <SummaryPane
              defaultMessages={this.props.defaultMessages}
              messages={this.props.messages}
              handleClickMessage={this.props.handleClickMessage}
            />
            <SummaryForm
              channelId={this.props.channelId}
              messages={this.props.messages}
              form={this.props.form}
            />
          </div>
        </div>
      </div>
    );
  }
}
