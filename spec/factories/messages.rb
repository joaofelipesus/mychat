FactoryBot.define do
  factory :message do
    body { "MyString" }
    sent_at { "2020-06-17 17:39:24" }
    group { nil }
  end
end
