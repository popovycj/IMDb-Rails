class Category < ApplicationRecord
  has_many :category_movies
  has_many :movies, through: :category_movies, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
