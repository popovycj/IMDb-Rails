class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      flash[:success] = 'Comment created'
    else
      flash[:alert] = @comment.errors.full_messages.first
    end

    redirect_to movie_path(@comment.movie)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :movie_id)
  end
end
