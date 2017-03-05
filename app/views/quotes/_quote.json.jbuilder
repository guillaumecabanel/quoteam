json.extract! quote, :content, :author, :team, :id, :created_at

json.user do
  json.extract! quote.user, :nickname
end

json.likes quote.votes_for.count

if user_signed_in?
  json.liked current_user.voted_for? quote
end
