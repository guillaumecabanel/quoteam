# team
FactoryGirl.define do
  factory :team do
    name    { Faker::Name.name }
  end
end

# user
FactoryGirl.define do
  factory :user do
    email    { Faker::Internet.email }
    password "password"
    admin    false
    team
  end
end

# admin
FactoryGirl.define do
  factory :admin, class: User do
    email    "admin@email.com"
    password "password"
    admin    true
    team
  end
end

# quote
FactoryGirl.define do
  factory :quote do
    content { Faker::ChuckNorris.fact }
    author  { Faker::Name.name }
    team
  end
end
