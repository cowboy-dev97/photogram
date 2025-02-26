class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    
  end

  def create
    @post = Post.create(post_params)

    redirect_to @post
  end

  private
    def post_params
      params.expect(post: [ :caption, :image ])
    end
end
