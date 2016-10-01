import React, { Component } from 'react';
import { render } from 'react-dom';
import VideoMatchupApi from '../api/video-matchup-api';
import Matchup from './matchup';
import MatchupForm from './matchup-form';

export default class MatchupEditor extends Component {
  constructor(props) {
    super(props);
    this.fetchMatchups();
    this.state = {
      matchups: [],
    };

    this.fetchMatchups = this.fetchMatchups.bind(this);
  }

  async fetchMatchups() {
    const response = await VideoMatchupApi.fetchMatchups(this.props.videoId);
    const matchups = await response.json();
    this.setState({
      matchups,
    });
  }

  render() {
    return (
      <div>
        <p>対戦組み合わせ</p>
        <ul>
          {this.state.matchups.map(matchup => (
            <Matchup
              key={matchup.id}
              matchup={matchup}
              videoUrl={this.props.videoUrl}
              charas={this.props.charas}
            />
          ))}
        </ul>
      </div>
    );
  }
}

window.addEventListener('turbolinks:load', () => {
  const matchupEditor = document.querySelector('#matchup-editor');
  const addFlag = false;
  if (matchupEditor) {
    render((
      <div className="col-lg-12">
        <div className="card u-bg-gray m-t-1">
          <div className="card-block">
            <MatchupEditor
              videoId={matchupEditor.dataset.videoId}
              videoUrl={matchupEditor.dataset.videoUrl}
              authority={matchupEditor.dataset.authority}
              charas={JSON.parse(matchupEditor.dataset.charas)}
            />
            <MatchupForm
              authority={matchupEditor.dataset.authority}
              charas={JSON.parse(matchupEditor.dataset.charas)}
            />
          </div>
        </div>
      </div>
    ), document.querySelector('#matchup-editor'));
  }
});
