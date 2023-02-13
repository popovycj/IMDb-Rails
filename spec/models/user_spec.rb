require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }
  let(:rating) { create(:rating, user: user, movie: movie) }

  describe '#rating' do
    it 'returns 0 if user did not evaluate movie' do
      expect(user.ratings.count).to eq(0)
      expect(user.rating(movie.id)).to eq(0)
    end

    it "returns user's score if user evaluated movie" do
      expect(rating).to be_valid

      expect(user.ratings).to include(rating)
      expect(user.rating(movie.id)).to eq(rating.score)
    end
  end
end
