json.quotes do
  json.array! @quotes do |quote|
    json.partial! "quotes/quote", quote: quote
  end
end
