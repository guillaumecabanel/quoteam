module QuotesHelper
  def quote_like_css(user, quote)
    icon = "fa fa-heart"
    return "#{icon}-o" if user.nil?
    user.liked?(quote) ? icon : "#{icon}-o"
  end

  def quote_owner(user, quote)
    if quote.user == user
      t('.by_you')
    elsif quote.user.nickname.empty?
      t('.by_user', user: 'anonym')
    else
      t('.by_user', user: quote.user.nickname.capitalize)
    end
  end
end
