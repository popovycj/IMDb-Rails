class Admin::MoviesController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_movie, only: [:edit, :update, :destroy]

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to root_path, notice: "Movie was successfully deleted."
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user.admin?
  end

  def find_movie
    @movie = Movie.find_by(id: params[:id])
    redirect_to root_path, alert: "Movie with id: #{params[:id]} not found." unless @movie
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :image)
  end
end
