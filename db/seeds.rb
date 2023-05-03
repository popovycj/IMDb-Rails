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

m1 = Movie.new(
  :title => "Inception",
  :description => "In a world where technology exists to enter the human mind through dream invasion, a highly skilled thief is given a final chance at redemption which involves executing his toughest job to date: Inception.",
  :year => 2010,
  :actors => "Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page, Tom Hardy"
)

m1.image.attach(io: File.open(Rails.root.join("public", "posters", "inception.jpg")), filename: "inception.jpg")
m1.save

m2 = Movie.new(
  :title => "The Avengers",
  :description => "Nick Fury of S.H.I.E.L.D. brings together a team of super humans to form The Avengers to help save the Earth from Loki and his army.",
  :year => 2012,
  :duration => "1:54:12",
  :actors => "Robert Downey Jr., Chris Evans, Scarlett Johansson, Jeremy Renner"
)

m2.image.attach(io: File.open(Rails.root.join("public", "posters", "avengers.jpg")), filename: "avengers.jpg")
m2.save

m3 = Movie.new(
  :title => "The Matrix",
  :description => "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.",
  :year => 1999,
  :duration => "2:13:12",
  :actors => "Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss, Hugo Weaving"
)

m3.image.attach(io: File.open(Rails.root.join("public", "posters", "matrix.jpg")), filename: "matrix.jpg")
m3.save

m4 = Movie.new(
  :title => "Iron Man",
  :description => "When wealthy industrialist Tony Stark is forced to build an armored suit after a life-threatening incident, he ultimately decides to use its technology to fight against evil.",
  :year => 2008,
  :duration => "1:48:04",
  :actors => "Robert Downey Jr., Gwyneth Paltrow, Terrence Howard, Jeff Bridges"
)

m4.image.attach(io: File.open(Rails.root.join("public", "posters", "ironman.jpg")), filename: "ironman.jpg")
m4.save

m5 = Movie.new(
  :title => "Pulp Fiction",
  :description => "The lives of two mob hit men, a boxer, a gangster's wife, and a pair of diner bandits intertwine in four tales of violence and redemption.",
  :year => 1994,
  :duration => "1:38:01",
  :actors => "John Travolta, Uma Thurman, Samuel L. Jackson, Bruce Willis"
)

m5.image.attach(io: File.open(Rails.root.join("public", "posters", "pulpfiction.jpg")), filename: "pulpfiction.jpg")
m5.save

m6 = Movie.new(
  :title => "Inglourious Basterds",
  :description => "In Nazi-occupied France during World War II, a plan to assassinate Nazi leaders by a group of Jewish U.S. soldiers coincides with a theatre owner's vengeful plans for the same.",
  :year => 2009,
  :duration => "2:01:12",
  :actors => "Brad Pitt, Diane Kruger, Eli Roth, Mélanie Laurent"
)

m6.image.attach(io: File.open(Rails.root.join("public", "posters", "inglouriousbasterds.jpg")), filename: "inglouriousbasterds.jpg")
m6.save

m7 = Movie.new(
  :title => "Shaun of the Dead",
  :description => "A man decides to turn his moribund life around by winning back his ex-girlfriend, reconciling his relationship with his mother, and dealing with an entire community that has returned from the dead to eat the living.",
  :year => 2004,
  :duration => "1:55:57",
  :actors => "Simon Pegg, Nick Frost, Kate Ashfield, Lucy Davis"
)

m7.image.attach(io: File.open(Rails.root.join("public", "posters", "shaunofthedead.jpg")), filename: "shaunofthedead.jpg")
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
