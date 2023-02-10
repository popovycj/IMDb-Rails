class MoviesController < ApplicationController
  def index
    @movies = if params[:query].present?
                Movie.search_by_title(params[:query])
              else
                Movie.sort_by_ratings
              end

    @categories = Category.all

    @selected_category = params[:category]
    @page = params[:page] || 1

    if @selected_category.present?
      if Category.exists?(name: @selected_category)
        @movies = Movie.joins(:categories).where(categories: { name: @selected_category })
      else
        redirect_to root_path, alert: "Invalid category selected."
      end
    end

    @movies = @movies.paginate(page: @page)

    if turbo_frame_request?
      render partial: "movies", locals: { movies: @movies }
    else
      render "index"
    end
  end

  def show
    @movie = Movie.find_by(id: params[:id])

    redirect_to root_path, alert: "Movie with id: #{params[:id]} not found." unless @movie
  end
end
