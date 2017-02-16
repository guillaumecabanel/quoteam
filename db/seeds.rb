puts 'Removing existing quotes...'
Quote.destroy_all
puts 'Removing existing users...'
User.destroy_all
puts 'Removing existing teams...'
Team.destroy_all


puts 'Generating a team...'
team = Team.create!(name: Faker::Company.name)


puts 'Generating an admin...'
User.create!(
  email: 'admin@email.com',
  password: 'password',
  admin: true,
  team: team
)

puts 'Generating users...'
5.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'password',
    team: team
  )
end

puts 'Generating fake quotes...'
10.times do
  quote = Quote.create!(
    content: Faker::ChuckNorris.fact,
    author: Faker::Name.name,
    team: team
  )
end
