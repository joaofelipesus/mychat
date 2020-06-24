FactoryBot.define do
  factory :team_user do
    team { Team.last }
    user { User.last }
    inviting_status { :pending }
  end
end
