class Admin::MoviesController < Admin::ApplicationController
  before_action :find_movie, only: [:edit, :update, :destroy]

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to root_path, notice: "Movie was successfully deleted."
  end

  private

  def find_movie
    @movie = Movie.find_by(id: params[:id])
    redirect_to root_path, alert: "Movie with id: #{params[:id]} not found." unless @movie
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :image, :year)
  end
end
