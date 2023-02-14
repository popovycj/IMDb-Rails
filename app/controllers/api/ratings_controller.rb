class Api::RatingsController < ApplicationController
  before_action :authenticate_user!

  def update_or_create
    @rating = Rating.find_or_initialize_by(
      movie_id: rating_params[:movie_id],
      user_id: current_user.id
    )

    if @rating.update(score: rating_params[:score])
      render json: {
        user_rating: @rating.score,
        average_rating: @rating.movie.average_rating,
        reviews_count: @rating.movie.ratings.count
      }, status: :ok
    else
      render json: { errors: @rating.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @rating = Rating.find_by(
      movie_id: rating_params[:movie_id],
      user_id: current_user.id
    )

    if @rating
      if @rating.destroy
        render json: {
          user_rating: @rating.score,
          average_rating: @rating.movie.average_rating,
          reviews_count: @rating.movie.ratings.count
        }, status: :ok
      else
        render json: { errors: @rating.errors }, status: :unprocessable_entity
      end
    else
      render json: { message: "Rating not found." }, status: :not_found
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:user_id, :movie_id, :score)
  end
end
