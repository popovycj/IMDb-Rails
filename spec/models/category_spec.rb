require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it 'requires a name' do
      category = Category.new(name: nil)
      expect(category).not_to be_valid
      expect(category.errors.full_messages).to include("Name can't be blank")
    end

    it 'requires a unique name' do
      create(:category, name: 'Action')
      category = Category.new(name: 'Action')
      expect(category).not_to be_valid
      expect(category.errors.full_messages).to include("Name has already been taken")
    end
  end

  describe 'relationships' do
    let!(:category) { create(:category) }
    let!(:movie) { create(:movie) }
    let!(:category_movie) { create(:category_movie, category: category, movie: movie) }

    it 'has many category_movies' do
      expect(category.category_movies).to include(category_movie)
    end

    it 'has many movies through category_movies' do
      expect(category.movies).to include(movie)
    end

    it 'has many movies through category_movies, dependent: :destroy' do
      expect { category.destroy }.to change { CategoryMovie.count }.by(-1)
      expect(movie.categories).not_to include(category)
    end
  end
end
