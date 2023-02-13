require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  let!(:movie) { create(:movie, title: "The Shawshank Redemption") }
  let(:movie2) { create(:movie, title: "The Godfather") }

  describe "GET #index" do
    context "when there is a query param present" do
      it "returns movies matching the query" do
        get :index, params: { query: "Shawshank" }

        expect(assigns(:movies)).to include(movie)
      end
    end

    context "when there is no query param present" do
      it "returns movies sorted by ratings" do
        get :index

        expect(assigns(:movies)).to eq([movie, movie2])
      end
    end

    context "when there is a category param present" do
      context "when the category exists" do
        it "returns movies belonging to that category" do
          category = create(:category, name: "Drama")

          get :index, params: { category: "Drama" }

          expect(assigns(:movies)).not_to include(movie)

          movie.categories << category
          get :index, params: { category: "Drama" }

          expect(assigns(:movies)).to include(movie)
        end
      end

      context "when the category does not exist" do
        it "redirects to the root path with an alert" do
          get :index, params: { category: "invalid_category" }

          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to eq("Invalid category selected.")
        end
      end
    end
  end

  describe "GET #show" do
    context "when the movie exists" do
      it "returns the movie" do
        get :show, params: { id: movie.id }

        expect(assigns(:movie)).to eq(movie)
      end
    end

    context "when the movie does not exist" do
      it "redirects to the root path with an alert" do
        get :show, params: { id: 999 }

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("Movie with id: 999 not found.")
      end
    end
  end
end
