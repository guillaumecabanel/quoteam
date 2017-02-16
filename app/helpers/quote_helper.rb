module QuoteHelper
  def quote_like_css(user, quote)
    return "fa fa-2x fa-heart-o" if user.nil?
    user.liked?(quote) ? "fa fa-2x fa-heart" : "fa fa-2x fa-heart-o"
  end
end
