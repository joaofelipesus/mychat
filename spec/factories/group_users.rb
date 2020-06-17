FactoryBot.define do
  factory :group_user do
    user { nil }
    group { nil }
    invite_status { 1 }
  end
end
