class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :score, presence: true
  validates :score, numericality: { only_integer: true, in: 1..10 }

  after_create :recalculate_movie_average_rating

  private

  def recalculate_movie_average_rating
    movie.update(average_rating: movie.ratings.average(:score).to_f.round(1))
  end
end
