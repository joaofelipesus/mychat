FactoryBot.define do
  factory :team do
    slug { Faker::Internet.slug }
    owner { User.last }
  end
end
