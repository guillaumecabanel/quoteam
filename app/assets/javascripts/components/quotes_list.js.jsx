var QuotesList = React.createClass({
  render: function() {
    return (
      <div>
        {this.props.quotes.map(function(quote){
          return <QuoteItem quote={quote} key={quote.id} />
        })}
      </div>
    );
  }
});
