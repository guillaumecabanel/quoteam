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
      </div>
    );
  }
});
