class PostsController < ApplicationController
  before_action :find_post, only: [ :show, :edit, :update ]
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def show
  end

  def create
    @post = Post.new
    if @post.create(post_params)
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.expect(post: [ :caption, :image ])
  end
end
