class Admin::CategoriesController < Admin::ApplicationController
  before_action :set_category, only: %i[edit update destroy add_category remove_category]

  def index
    @categories = Category.all.order(created_at: :desc)
    respond_to do |format|
      format.html
      format.json { render json: @categories }
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@category,
                                                 partial: "admin/categories/edit_form",
                                                 locals: { category: @category })
      end
      format.json { render json: @category }
    end
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        flash.now[:success] = "Category was created"

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_category',
                                partial: "admin/categories/form",
                                locals: { category: Category.new }),
            turbo_stream.prepend('categories',
                                partial: "admin/categories/category",
                                locals: { category: @category }),
            turbo_stream.update('category_counter', Category.count),
            turbo_stream.prepend("flash", partial: "layouts/flash")
          ]
        end
        format.json { render json: @category, status: :created }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_category',
                                partial: "admin/categories/form",
                                locals: { category: @category })
          ]
        end
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        flash.now[:success] = "Category was updated"

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@category,
                                partial: "admin/categories/category_inner",
                                locals: { category: @category }),
            turbo_stream.prepend("flash", partial: "layouts/flash")
          ]
        end
        format.json { render json: @category, status: :ok }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@category,
                                                   partial: "admin/categories/edit_form",
                                                   locals: { category: @category })
        end
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    flash.now[:success] = "Category was deleted"

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@category),
          turbo_stream.update('category_counter', Category.count),
          turbo_stream.prepend("flash", partial: "layouts/flash")
        ]
      end
      format.json { head :no_content }
    end
  end

  def add_category
    @movie = Movie.find(params[:movie_id])
    @movie.categories << @category
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def remove_category
    @movie = Movie.find(params[:movie_id])
    @movie.categories.delete(@category)
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
