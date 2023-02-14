FactoryBot.define do
  factory :rating do
    score { rand(1..10) }
    association :user
    association :movie
  end
end
