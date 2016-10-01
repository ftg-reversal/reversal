import React, { Component } from 'react';

export default class MatchupSelector extends Component {

  constructor(props) {
    super(props);

    this.state = {
      minutes: 0,
      seconds: 0,
      chara1: 0,
      chara2: 0,
    };

    this.onChangeMinute = this.onChangeMinute.bind(this);
    this.onChangeSeconds = this.onChangeSeconds.bind(this);
  }

  onChangeMinute(e) {
    this.setState({ minutes: e.target.value });
  }

  onChangeSeconds(e) {
    this.setState({ seconds: e.target.value });
  }

  render() {
    const minutes = [...Array(60)].map((_v, i) => <option value={i} key={i}>{i}</option>);
    const seconds = [...Array(60)].map((_v, i) => <option value={i} key={i}>{i}</option>);
    const chara1 = this.props.charas.map((v, i) => <option value={i} key={i}>{v.name}</option>);
    const chara2 = this.props.charas.map((v, i) => <option value={i} key={i}>{v.name}</option>);

    return (
      <form>
        <fieldset className="form-group">
          <div className="col-md-3 col-xs-6">
            <label htmlFor="minutes">分</label>
            <select
              id="minutes"
              className="form-control"
              value={this.state.minutes}
              onChange={this.onChangeMinute}
            >
              {minutes}
            </select>
          </div>
          <div className="col-md-3 col-xs-6">
            <label htmlFor="seconds">秒</label>
            <select id="seconds" className="form-control" value={this.state.seconds}>
              {seconds}
            </select>
          </div>
          <div className="col-md-3 col-xs-6">
            <label htmlFor="chara1">1P</label>
            <select id="chara1" className="form-control" value={this.state.chara1}>
              {chara1}
            </select>
          </div>
          <div className="col-md-3 col-xs-6">
            <label htmlFor="chara2">2P</label>
            <select id="chara2" className="form-control" value={this.state.chara2}>
              {chara2}
            </select>
          </div>
        </fieldset>
        <fieldset className="form-group">
          <button type="submit" className="btn btn-primary m-l-1">対戦組み合わせを登録</button>
        </fieldset>
      </form>
    );
  }
}
