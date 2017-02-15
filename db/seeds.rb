puts "Removing existing quotes..."
Quote.destroy_all

puts "Generating fake quotes..."
10.times do
  quote = Quote.create!(
    content: Faker::ChuckNorris.fact,
    author: Faker::Name.name,
  )
end
