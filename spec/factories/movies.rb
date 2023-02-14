FactoryBot.define do
  factory :movie do
    title { Faker::Lorem.word }
    year { Faker::Number.within(range: 1960..2023) }
    average_rating { 0 }
    description { Faker::Lorem.paragraph }
    image { Rack::Test::UploadedFile.new(Tempfile.new(["test_image", ".png"], content_type: "image/png"), "image/png") }

    trait :invalid do
      title { nil }
    end
  end
end
