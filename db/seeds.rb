require "faker"

User.create!(email: "Vikabtg@gmail.com", password: "password", role: :admin)
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

m1 = Movie.new(
  :title => "The Shawshank Redemption",
  :description => "Over the course of several years, two convicts form a friendship, seeking consolation and, eventually, redemption through basic compassion.",
  :year => 1994,
  :actors => "Tim Robbins, Morgan Freeman, Bob Gunton"
)

m1.image.attach(io: File.open(Rails.root.join("public", "posters", "shawshank.jpg")), filename: "shawshank.jpg")
m1.save

m2 = Movie.new(
  :title => "The Godfather",
  :description => "The aging patriarch of an organized crime dynasty in postwar New York City transfers control of his clandestine empire to his reluctant youngest son.",
  :year => 1972,
  :duration => "1:54:12",
  :actors => "Marlon Brando, Al Pacino, James Caan"
)

m2.image.attach(io: File.open(Rails.root.join("public", "posters", "godfather.jpg")), filename: "godfather.jpg")
m2.save

m3 = Movie.new(
  :title => "The Dark Knight",
  :description => "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
  :year => 2008,
  :duration => "2:13:12",
  :actors => "Christian Bale, Heath Ledger, Aaron Eckhart"
)

m3.image.attach(io: File.open(Rails.root.join("public", "posters", "darkkhight.jpg")), filename: "darkkhight.jpg")
m3.save

m4 = Movie.new(
  :title => "12 Angry Men",
  :description => "The jury in a New York City murder trial is frustrated by a single member whose skeptical caution forces them to more carefully consider the evidence before jumping to a hasty verdict.",
  :year => 1957,
  :duration => "1:48:04",
  :actors => "Henry Fonda, Lee J. Cobb, Martin Balsam"
)

m4.image.attach(io: File.open(Rails.root.join("public", "posters", "angryman.jpg")), filename: "angryman.jpg")
m4.save

m5 = Movie.new(
  :title => "Schindler's List",
  :description => "In German-occupied Poland during World War II, industrialist Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis.",
  :year => 1993,
  :duration => "1:38:01",
  :actors => "Liam Neeson, Ralph Fiennes, Ben Kingsley"
)

m5.image.attach(io: File.open(Rails.root.join("public", "posters", "schindler.jpg")), filename: "schindler.jpg")
m5.save

m6 = Movie.new(
  :title => "Seven",
  :description => "Two detectives, a rookie and a veteran, hunt a serial killer who uses the seven deadly sins as his motives.",
  :year => 1995,
  :duration => "2:01:12",
  :actors => "Morgan Freeman, Brad Pitt, Kevin Spacey"
)

m6.image.attach(io: File.open(Rails.root.join("public", "posters", "seven.jpg")), filename: "seven.jpg")
m6.save

m7 = Movie.new(
  :title => "Interstellar",
  :description => "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
  :year => 2014,
  :duration => "1:55:57",
  :actors => "Matthew McConaughey, Anne Hathaway, Jessica Chastain"
)

m7.image.attach(io: File.open(Rails.root.join("public", "posters", "interstellar.jpg")), filename: "interstellar.jpg")
m7.save

Movie.all.each do |movie|
  Category.offset(rand(Category.count)).each do |category|
    movie.categories << category
  end

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
