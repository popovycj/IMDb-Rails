require 'rails_helper'

RSpec.describe Rating, type: :model do
  let!(:movie) { create(:movie) }
  let!(:user) { create(:user) }
  let!(:rating) { create(:rating, movie: movie, user: user) }

  describe 'relationships' do
    it "belongs to a movie" do
      expect(rating.movie).to eq(movie)
    end

    it "belongs to a user" do
      expect(rating.user).to eq(user)
    end

    it "will be deleted if user is deleted" do
      expect { user.destroy }.to change { Rating.count }.by(-1)
    end

    it "will be deleted if movie is deleted" do
      expect { movie.destroy }.to change { Rating.count }.by(-1)
    end
  end

  describe 'validations' do
    it "is not valid without a score" do
      rating.score = nil
      expect(rating).to_not be_valid
    end

    it "is not valid with score less than 0" do
      rating.score = -1
      expect(rating).to_not be_valid
    end

    it "is not valid with score greater than 10" do
      rating.score = 11
      expect(rating).to_not be_valid
    end
  end

  describe '#recalculate_movie_average_rating' do
    it "recalculates average rating of the movie" do
      rating.update(score: 9)
      expect(movie.reload.average_rating).to eq(9)

      rating.destroy
      expect(movie.reload.average_rating).to eq(0)
    end
  end
end
