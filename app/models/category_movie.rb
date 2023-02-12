class CategoryMovie < ApplicationRecord
  belongs_to :category
  belongs_to :movie

  validates :category, uniqueness: { scope: :movie }
end
