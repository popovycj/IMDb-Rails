class Movie < ApplicationRecord
  has_many :ratings
  has_and_belongs_to_many :categories

  validates :title, presence: true
  validates :average_rating, presence: true, numericality: { in: 0..10 }
  validates :categories, presence: true

  scope :sort_by_ratings, -> { all.order(average_rating: :desc) }
  scope :search_by_title, -> (title) { where('title like ?', "%#{title}%") }

  self.per_page = 6

  has_one_attached :image

  has_rich_text :description
end
