FactoryBot.define do
  factory :group do
    slug  { 'someSlug' }
    team  { Team.last }
    owner { User.last }
  end
end
