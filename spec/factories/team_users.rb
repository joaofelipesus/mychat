FactoryBot.define do
  factory :team_user do
    team { nil }
    user { nil }
    inviting_status { 1 }
  end
end
