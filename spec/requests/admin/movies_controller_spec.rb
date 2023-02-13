require "rails_helper"

describe Admin::MoviesController, type: :request do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin) }
  let!(:movie) { create(:movie) }
  let!(:valid_attributes) { attributes_for(:movie) }
  let!(:invalid_attributes) { attributes_for(:movie, :invalid) }

  describe "GET #new" do
    context "when user is not admin" do
      it "redirects to root path with alert" do
        get new_admin_movie_path
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eq "You are not authorized to access this page."
      end
    end

    context "when user is admin" do
      before { sign_in(admin) }

      it "returns a success response" do
        get new_admin_movie_path
        expect(response).to be_successful
      end
    end
  end

  describe "POST #create" do
    context "when user is not admin" do
      it "redirects to root path with alert" do
        post admin_movies_path, params: { movie: valid_attributes }
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eq "You are not authorized to access this page."
      end
    end

    context "when user is admin" do
      before { sign_in(admin) }

      context "with valid params" do
        it "creates a new Movie" do
          expect {
            post admin_movies_path, params: { movie: valid_attributes }
          }.to change(Movie, :count).by(1)
        end

        it "redirects to the created movie" do
          post admin_movies_path, params: { movie: valid_attributes }
          expect(response).to redirect_to Movie.last
        end

        it "displays a success message" do
          post admin_movies_path, params: { movie: valid_attributes }
          expect(flash[:notice]).to eq "Movie was successfully created."
        end
      end

      context "with invalid params" do
        it "does not create a new Movie" do
          expect {
            post admin_movies_path, params: { movie: invalid_attributes }
          }.to change(Movie, :count).by(0)
        end

        it "returns a unprocessable entity response" do
          post admin_movies_path, params: { movie: invalid_attributes }
          expect(response.status).to eq 422
        end
      end
    end
  end

  describe "GET #edit" do
    context "when user is not admin" do
      it "redirects to root path with alert" do
        get edit_admin_movie_path(movie)
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eq "You are not authorized to access this page."
      end
    end
  end

  describe "PUT #update" do
    before { sign_in(admin) }

    context "as an admin user" do
      context "with valid params" do
        it "updates the movie" do
          put admin_movie_path(movie), params: { movie: valid_attributes }

          expect(movie.reload.title).to eq(valid_attributes[:title])
        end

        it "redirects to the movie" do
          put admin_movie_path(movie), params: { movie: valid_attributes }

          expect(response).to redirect_to(movie)
        end
      end

      context "with invalid params" do
        it "does not update the movie" do
          put admin_movie_path(movie), params: { movie: invalid_attributes }

          expect(movie.reload.title).to_not be_nil
        end

        it "renders the edit template" do
          put admin_movie_path(movie), params: { movie: invalid_attributes }

          expect(response).to render_template(:edit)
        end
      end
    end

    context "as a non-admin user" do
      before { sign_in(user) }

      it "redirects to the root path with an alert" do
        put admin_movie_path(movie), params: { movie: valid_attributes }

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("You are not authorized to access this page.")
      end
    end
  end

  describe "DELETE #destroy" do
    context "as an admin user" do
      before { sign_in(admin) }

      it "deletes the movie" do
        expect {
          delete admin_movie_path(movie)
        }.to change(Movie, :count).by(-1)
      end

      it "redirects to the root path with a notice" do
        delete admin_movie_path(movie)

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Movie was successfully deleted.")
      end
    end

    context "as a non-admin user" do
      before { sign_in(user) }

      it "does not delete the movie" do
        expect {
          delete admin_movie_path(movie)
        }.to_not change(Movie, :count)
      end

      it "redirects to the root path with an alert" do
        delete admin_movie_path(movie)

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("You are not authorized to access this page.")
      end
    end
  end
end
