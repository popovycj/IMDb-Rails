require "faker"

User.create!(email: "admin@example.com", password: "password", role: :admin)
User.create!(email: "user@example.com", password: "password", role: :user)

5.times do
  User.create!(
    email: Faker::Internet.email,
    password: "password",
    role: :user
  )
end

categories = ["Action",  "Comedy",  "Drama",  "Thriller",  "Adventure",  "Romance",  "Mystery",  "Fantasy"]

categories.each do |name|
  Category.create!(name: name)
end

15.times do
  movie = Movie.new(
    title: Faker::Movie.unique.title,
    year: Faker::Number.between(from: 1950, to: 2023),
    description: Faker::Lorem.paragraphs(number: 3).join("\n\n") + "<br><strong>#{Faker::Movie.quote}</strong>"
  )

  Category.offset(rand(Category.count)).each do |category|
    movie.categories << category
  end

  file = URI.open(Faker::LoremFlickr.unique.image(search_terms: [movie.title.gsub(/[^a-zA-Z]/, "")]))
  movie.image.attach(io: file, filename: "movie-#{movie.id}.jpg")

  movie.save!

  rand(5).times do
    begin
      User.find_by(id: rand(1..5)).ratings.create!(
        movie: movie,
        score: Faker::Number.between(from: 1, to: 10)
      )
    rescue ActiveRecord::RecordNotUnique
    end
  end
end
