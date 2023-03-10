FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role { :user }

    trait :admin do
      role { :admin }
    end
  end
end
