FactoryBot.define do
  factory :group do
    slug { Faker::Internet.slug }
    team
    owner
  end
end
