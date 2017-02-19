module QuotesHelper
  def quote_like_css(user, quote)
    icon = "fa fa-heart"
    return "#{icon}-o" if user.nil?
    user.liked?(quote) ? icon : "#{icon}-o"
  end
end
