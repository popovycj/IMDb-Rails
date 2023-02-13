require 'rails_helper'

RSpec.describe CategoryMovie, type: :model do
  let!(:category) { create(:category) }
  let!(:movie) { create(:movie) }
  let!(:category_movie) { create(:category_movie, category: category, movie: movie) }

  describe 'relationships' do
    it 'belongs to a category and a movie' do
      expect(category_movie.category).to eq(category)
      expect(category_movie.movie).to eq(movie)
    end
  end

  describe 'validations' do
    it 'validates the uniqueness of a category and movie combination' do
      duplicate_category_movie = build(:category_movie, category: category, movie: movie)
      expect(duplicate_category_movie).to_not be_valid
    end
  end
end
