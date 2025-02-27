class PostsController < ApplicationController
  before_action :find_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new create edit update destroy]
  before_action :owned_post, only: %i[ edit update destroy ]
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def show
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Post succesfully created."
    else
      flash.now[:error] = "Something went wrong with creating the post"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Post succesfully updated."
    else
      flash.now[:alert] = "Something went wrong with updating the post"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted"
  end

  # private methods
  private
  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.expect(post: [ :caption, :image ])
  end

  def owned_post
    unless current_user == @post.user
      flash[:error] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end
end
