FactoryBot.define do
  factory :team_user do
    team { Team.last }
    user { User.last }
  end
end
