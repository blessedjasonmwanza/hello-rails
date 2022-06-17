class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to user_post_path(id: @comment.post_id, user_id: @comment.author_id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :author_id, :post_id)
  end
end
