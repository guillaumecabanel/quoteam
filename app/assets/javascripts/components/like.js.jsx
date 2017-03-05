var Like = React.createClass({
  getInitialState: function() {
    return {
      quote: this.props.quote
    }
  },

  render: function() {
    var divClasses = classNames({
      "btn btn-link": true,
      "fa": true,
      "fa-heart": this.state.quote.liked,
      "fa-heart-o": !this.state.quote.liked
    });

    return (
      <div>
        <em>{ this.state.quote.likes }</em>
        &nbsp;
        <i className={ divClasses } onClick={ this.handleClick }></i>
      </div>
    )
  },

  handleClick: function() {
    var that = this;
    $.ajax({
      type: 'PATCH',
      url: Routes.like_team_quote_path(this.props.quote.team.id, this.props.quote.id, { format: 'json'}),
      success: function(data) {
        that.setState({ quote: data });
      }
    });
  }
})
