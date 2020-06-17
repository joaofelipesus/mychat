FactoryBot.define do
  factory :team do
    slug { 'SomeOtherSlug' }
    owner { User.last }
  end
end
