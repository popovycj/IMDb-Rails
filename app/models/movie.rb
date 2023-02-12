class Movie < ApplicationRecord
  has_many :ratings, dependent: :delete_all
  has_many :category_movies, dependent: :destroy
  has_many :categories, through: :category_movies

  self.per_page = 6

  has_one_attached :image

  has_rich_text :description

  validates :title, presence: true
  validates :year, presence: true
  validates :average_rating, presence: true, numericality: { in: 0..10 }
  validates :image, attached: true,
                    content_type: [:png, :jpg, :jpeg],
                    size: { less_than: 2.megabytes,
                            message: 'too big' }

  scope :sort_by_ratings, -> { all.order(average_rating: :desc) }
  scope :search_by_title, -> (title) { where('title like ?', "%#{title}%") }
end
