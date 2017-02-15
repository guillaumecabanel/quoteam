# user
FactoryGirl.define do
  factory :user do
    email    Faker::Internet.email
    password "password"
    admin    false
  end
end

# admin
FactoryGirl.define do
  factory :admin, class: User do
    email    "admin@email.com"
    password "password"
    admin    true
  end
end

# quote
FactoryGirl.define do
  factory :quote do
    content Faker::ChuckNorris.fact
    author  Faker::Name.name
  end
end
