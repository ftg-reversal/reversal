import React, {Component} from 'react';

export default class Matchup extends Component {
  constructor(props) {
    super(props);
  }

  handleDeleteClick = (event) => {
    console.log(event.target);
  }

  render() {
    return (
      <li>
        {(() => {
          if (this.props.addFlag) {
            return <a href="#" className="nav-link" onClick={this.handleDeleteClick}><i className="fa fa-times" /></a>
          }
          if (this.props.addFlag) {
            return <div>&nbsp;&nbsp;</div>
          }
        })()}
        <a href="#" onClick={this.handleClick}>
          {this.props.sec}&nbsp;
          { this.props.charas[this.props.matchup.chara1_id - 1].name }
          &nbsp;vs&nbsp;
          { this.props.charas[this.props.matchup.chara2_id - 1].name }
        </a>
        （
        <a href={ `${this.props.videoUrl}?from=${this.props.matchup.sec - 10}` } target="_blank">
          ニコニコ動画で見る
        </a>
        ）
      </li>
    );
  }
}

