FactoryBot.define do
  factory :message do
    body  { "Some cool message" }
    group { Group.last }
    user  { User.last }
  end
end
