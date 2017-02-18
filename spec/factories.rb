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
    content { Faker::ChuckNorris.fact }
    author  { Faker::Name.name }
    team
  end
end

# enrollment
FactoryGirl.define do
  factory :enrollment do
    user
    team
  end
end
