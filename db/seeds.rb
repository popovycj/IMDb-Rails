# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# categories.rb
Category.create!(name: "Action")
Category.create!(name: "Comedy")
Category.create!(name: "Drama")
Category.create!(name: "Thriller")

# movies.rb
m1 = Movie.create!(title: "The Dark Knight")
m2 = Movie.create!(title: "The Hangover")
m3 = Movie.create!(title: "The Shawshank Redemption")
m4 = Movie.create!(title: "The Silence of the Lambs")
m5 = Movie.create!(title: "Inception")
m6 = Movie.create!(title: "The Godfather")
m7 = Movie.create!(title: "Pulp Fiction")
m8 = Movie.create!(title: "The Matrix")

m1.categories << Category.find_by(name: "Action")
m1.categories << Category.find_by(name: "Thriller")
m2.categories << Category.find_by(name: "Comedy")
m3.categories << Category.find_by(name: "Drama")
m4.categories << Category.find_by(name: "Thriller")
m5.categories << Category.find_by(name: "Action")
m5.categories << Category.find_by(name: "Thriller")
m6.categories << Category.find_by(name: "Drama")
m7.categories << Category.find_by(name: "Thriller")
m7.categories << Category.find_by(name: "Comedy")
m8.categories << Category.find_by(name: "Action")
m8.categories << Category.find_by(name: "Thriller")

# users.rb
u1 = User.create!(email: "user1@example.com", password: "password", role: "user")
u2 = User.create!(email: "user2@example.com", password: "password", role: "user")
u3 = User.create!(email: "admin@example.com", password: "password", role: "admin")

# ratings.rb
Rating.create!(user: u1, movie: m1, score: 9)
Rating.create!(user: u2, movie: m1, score: 8)
Rating.create!(user: u1, movie: m2, score: 7)
Rating.create!(user: u2, movie: m2, score: 8)
Rating.create!(user: u3, movie: m3, score: 10)
