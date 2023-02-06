class Movie < ApplicationRecord
  has_many :ratings
  has_and_belongs_to_many :categories

  validates :title, presence: true
  validates :average_rating, presence: true, numericality: { in: 0..10 }

  self.per_page = 6
end
