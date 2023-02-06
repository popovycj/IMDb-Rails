# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Create categories
categories = [
  { name: "Action" },
  { name: "Comedy" },
  { name: "Drama" },
  { name: "Thriller" },
  { name: "Romance" }
]

categories.each do |category|
  Category.create!(category)
end

# Create movies
movies = [
  { title: "The Avengers", categories: [Category.find_by(name: "Action"), Category.find_by(name: "Thriller")] },
  { title: "The Hangover", categories: [Category.find_by(name: "Comedy")] },
  { title: "The Shawshank Redemption", categories: [Category.find_by(name: "Drama")] },
  { title: "The Notebook", categories: [Category.find_by(name: "Romance"), Category.find_by(name: "Drama")] },
  { title: "The Dark Knight", categories: [Category.find_by(name: "Action"), Category.find_by(name: "Thriller")] }
]

movies.each do |movie|
  new_movie = Movie.new(title: movie[:title])
  new_movie.categories = movie[:categories]
  new_movie.save!
end
