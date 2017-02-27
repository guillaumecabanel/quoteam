# Destroy previous records
puts 'Removing existing enrollments'
Enrollment.destroy_all
puts 'Removing existing quotes...'
Quote.destroy_all
puts 'Removing existing teams...'
Team.destroy_all
puts 'Removing existing users...'
User.destroy_all

# Generating new records
puts 'Generating an admin...'
User.create!(
  email: 'admin@email.com',
  password: 'password',
  nickname: "#{Faker::Name.name}-admin",
  admin: true
)

puts 'Generating users...'
5.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'password',
    nickname: Faker::Name.name,
  )
end

puts 'Generating a team...'
team = Team.create!(name: Faker::Company.name)

puts 'Enrolling all users in this team'
User.all.each do |user|
  Enrollment.create!(
  user: user,
  team: team
  )
end

puts 'Generating fake quotes...'
10.times do
  quote = Quote.create!(
    content: Faker::ChuckNorris.fact,
    author: Faker::Name.name,
    team: team,
    user: User.all.sample
  )
end
