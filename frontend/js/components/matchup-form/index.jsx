import React, { Component } from 'react';

import MatchupSelector from '../matchup-selector'

export default class MatchupForm extends Component {
  constructor(props) {
    super(props);

    this.beginEdit = this.beginEdit.bind(this);
    this.endEdit = this.endEdit.bind(this);
  }

  componentWillMount() {
    this.setState({ addFlag: false });
  }

  beginEdit(e) {
    e.preventDefault(e);
    this.setState({ addFlag: true });
  }

  endEdit(e) {
    e.preventDefault(e);
    this.setState({ addFlag: false }); }

  render() {
    if (this.props.authority !== 'enable') {
      return (
        <div className="clearfix">
          <nav className="nav nav-inline pull-right">
            <a href="/login?redirect_to=/videos/{{ videoID }}" className="nav-link">
              <i className="fa fa-pencil">編集</i>
            </a>
          </nav>
        </div>
      );
    } else if (!this.state.addFlag) {
      return (
        <div className="clearfix">
          <nav className="nav nav-inline pull-right">
            <a href="#" className="nav-link" onClick={this.beginEdit}>
              <i className="fa fa-pencil">編集</i>
            </a>
          </nav>
        </div>
      );
    } else if (this.state.addFlag) {
      return (
        <div>
          <MatchupSelector
            charas={this.props.charas}
          />
          <div>
            <div className="clearfix">
              <nav className="nav nav-inline pull-right">
                <a href="#" className="nav-link" onClick={this.endEdit}>
                  <i className="fa fa-pencil">編集を終了</i>
                </a>
              </nav>
            </div>
          </div>
        </div>
      );
    }
    return <div />;
  }
}
