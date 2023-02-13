FactoryBot.define do
  factory :movie do
    title { Faker::Lorem.word }
    year { Faker::Number.within(range: 1960..2023) }
    average_rating { 0 }
    description { Faker::Lorem.paragraph }

    after(:build) do |movie|
      movie.image.attach(
        io: File.new(Tempfile.new(['example_image', '.png'], content_type: "image/png")),
        filename: 'example_image.png'
      )
    end
  end
end
