import React, { Component } from 'react';
import salert from 'sweetalert';

import ChannelApi from '../../../api/channel-api';

export default class SummaryForm extends Component {
  constructor(props) {
    super(props)

    this.onSubmit = this.onSubmit.bind(this);
    this.onTitleChange = this.onTitleChange.bind(this);
    this.onDescriptionChange = this.onDescriptionChange.bind(this);
  }

  onTitleChange(event) {
    this.setState({ title: event.target.value });
  }

  onDescriptionChange(event) {
    this.setState({ description: event.target.value });
  }

  validate(title, description, messages) {
    if (messages.length === 0) {
      salert('まとめるメッセージを選択してください。');
      return false;
    }
    if (title === undefined || title.length < 1 || title.length > 64) {
      salert('タイトルを1〜64文字で入力してください。');
      return false;
    }
    if (description.length > 1024) {
      salert('説明文を1024文字以内で入力してください。');
      return false;
    }

    return true;
  }

  async onSubmit(event) {
    event.preventDefault();

    const { title, description } = this.state;
    const { channelId, messages } = this.props;
    const messageIds = messages.map(message => message.id);

    this.validate(title, description, messages);

    try {
      if (!this.props.form.summaryId) {
        await ChannelApi.newSummary(title, description, channelId, messageIds);
        location.href = '/summaries/';
      } else {
        await ChannelApi.editSummary(
          this.props.form.summaryId,
          title,
          description,
          channelId,
          messageIds
        );
        location.href = `/summaries/${this.props.form.summaryId}`;
      }
    } catch (error) {
      salert('投稿できませんでした');
    }
  }

  componentWillMount() {
    this.setState(
      {
        title: this.props.form.title,
        description: this.props.form.description,
      }
    )
  }

  render() {
    const { summaryId, channelId, title, description, messages } = this.props.form;

    return (
      <div>
        <div className="card-footer">
          <fieldset className="form-group">
            <input name="title" type="text" defaultValue={title} placeholder="まとめのタイトル" className="form-control" onChange={this.onTitleChange} />
          </fieldset>
          <fieldset className="form-group">
            <textarea name="description" defaultValue={description} placeholder="まとめの説明文(省略可)" className="form-control" onChange={this.onDescriptionChange} />
          </fieldset>
          <div className="form-group">
            <button
              className="btn btn-primary"
              onClick={this.onSubmit}
            >
              まとめを投稿する
            </button>
          </div>
        </div>
      </div>
    );
  }
}
