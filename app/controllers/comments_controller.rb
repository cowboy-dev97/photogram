class CommentsController < ApplicationController
  before_action :set_post, only: %i[ create destroy ]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to root_path, notice: "Comment sent."
    else
      render root_path, alert: "Something went wrong with sending the comment."
    end
  end


  def destroy
    @comment = @post.comments.find(params[:id])

    @comment.destroy
    redirect_to root_path, notice: "Comment deleted"
  end

  private
  def comment_params
    comment_params.expect(comment: [ :content ])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
