class Admin::CategoriesController < Admin::ApplicationController
  def add_category
    @movie = Movie.find(params[:movie_id])
    @category = Category.find(params[:id])
    @movie.categories << @category
  end

  def remove_category
    @movie = Movie.find(params[:movie_id])
    @category = Category.find(params[:id])
    @movie.categories.delete(@category)
  end
end
