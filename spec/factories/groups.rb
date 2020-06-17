FactoryBot.define do
  factory :group do
    slug  { Faker::Internet.slug }
    team  { Team.last }
    owner { User.last }
  end
end
