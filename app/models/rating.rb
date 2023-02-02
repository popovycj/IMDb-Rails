class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :score, presence: true
  validates :score, numericality: { only_integer: true, in: 1..10 }
end
