class Movie < ApplicationRecord
  has_many :ratings
  has_and_belongs_to_many :categories

  validates :title, presence: true
end
