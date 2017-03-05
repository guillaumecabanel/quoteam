var QuoteItem = React.createClass({
  render: function() {
    return (
      <div className="quote">
        <h4 className="quote-content">
          <i className="fa fa-quote-left"></i>
          &nbsp;
          {this.props.quote.content}
        </h4>
        <div className="quote-author">
          — {this.props.quote.author}
        </div>
        <div className="quote-action-panel">
          <div className="flexbox flexbox-between">
            <div>
              <span className="quote-action-panel-text">
                { this.props.quote.created_at }
              </span>
              &nbsp; by { this.props.quote.user.nickname }
            </div>
            <div className="quote-like">
              <Like quote={this.props.quote} />
            </div>
          </div>
        </div>
      </div>
    );
  }
});
