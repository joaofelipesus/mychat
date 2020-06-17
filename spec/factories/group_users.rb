FactoryBot.define do
  factory :group_user do
    user { User.last }
    group { Group.last }
    invite_status { :pending }
  end
end
