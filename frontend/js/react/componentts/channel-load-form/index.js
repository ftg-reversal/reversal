import React, { Component } from 'react';

import ChannelApi from '../../../api/channel-api';

export default class ChannelLoadForm extends Component {
  constructor(props) {
    super(props);
    this.state = { channels: [], channel: 1 };

    this.onChangeChannel = this.onChangeChannel.bind(this);
    this.onLoadChannel = this.onLoadChannel.bind(this);
    this.onLoadTweet = this.onLoadTweet.bind(this);
  }

  async componentWillMount() {
    const response = await ChannelApi.fetchChannelList();
    const json = await response.json();
    this.setState({ channels: json });
  }

  onChangeChannel(e) {
    this.setState({ channel: e.target.value });
  }

  onLoadChannel(e) {
    e.preventDefault();
    this.props.loadChannel(this.state.channel);
  }

  onLoadTweet(e) {
    e.preventDefault();
    twttr.widgets.load();
  }

  render() {
    const channels = this.state.channels.map((channel) => {
      return (
        <option
          value={channel.id}
          key={channel.id}
        >
          {channel.name}
        </option>
      );
    });

    return (
      <form action="#" className="summary-form">
        <div className="header">
          <div className="row u-vertical-align-center">
            <div className="col-lg-8">
              <select className="form-control" onChange={this.onChangeChannel} value={this.state.value}>
                {channels}
              </select>
            </div>
            <div className="col-lg-2">
              <button
                onClick={this.onLoadChannel}
                className="form-control"
              >
                <i className="fa fa-refresh" />
              </button>
            </div>
            <div className="col-lg-2">
              <button className="form-control" onClick={this.onLoadTweet}>
                <i className="fa fa-twitter" />
              </button>
            </div>
          </div>
        </div>
        <p className="m-l-1"><a href="/about#summary">※まとめの作り方について</a></p>
      </form>
    );
  }
}
