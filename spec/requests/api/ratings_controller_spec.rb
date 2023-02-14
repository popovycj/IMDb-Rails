require 'rails_helper'

RSpec.describe Api::RatingsController, type: :request do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }

  before { sign_in(user) }

  describe 'PUT #update_or_create' do
    context 'with valid params' do

      it 'updates or creates the rating' do
        put update_or_create_api_ratings_path, params: { rating: { movie_id: movie.id, score: 5 } }

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("user_rating")
        expect(response.body).to include("average_rating")
        expect(response.body).to include("reviews_count")

        expect(JSON.parse(response.body)["user_rating"]).to eq(5)
      end
    end

    context 'with invalid params' do
      it 'returns an error' do
        put update_or_create_api_ratings_path, params: { rating: { movie_id: movie.id, score: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("errors")
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the rating exists' do
      it 'destroys the rating' do
        rating = create(:rating, user: user, movie: movie)

        delete api_ratings_path, params: { rating: { id: rating.id, movie_id: movie.id } }

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("user_rating")
        expect(response.body).to include("average_rating")
        expect(response.body).to include("reviews_count")
      end
    end

    context 'when the rating does not exist' do
      it 'returns not found' do
        delete api_ratings_path, params: { rating: { id: 0, movie_id: movie.id } }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Rating not found.")
      end
    end
  end
end
