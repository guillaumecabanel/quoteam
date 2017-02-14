10.times do
  quote = Quote.create!(
    content: Faker::Commerce.product_name,
    author: Faker::Name.name,
  )
end
