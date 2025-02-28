class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to root_path
    else
      render "posts/index", status: :unprocessable_entity
    end
  end


  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to root_path, notice: "Comment deleted"
  end

  private
  def comment_params
    params.expect(comment: [ :content ])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
