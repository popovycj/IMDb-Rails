class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @categories = Category.all

    @selected_category = params[:category]
    @page = params[:page] || 1

    unless @selected_category.blank?
      if Category.exists?(name: @selected_category)
        @movies = Movie.joins(:categories).where(categories: { name: @selected_category })
      else
        redirect_to root_path, alert: "Invalid category selected."
      end
    end

    @movies = @movies.paginate(page: @page)
  end

  def show
    @movie = Movie.find_by(id: params[:id])

    redirect_to root_path, alert: "Movie with id: #{params[:id]} not found." unless @movie
  end
end
