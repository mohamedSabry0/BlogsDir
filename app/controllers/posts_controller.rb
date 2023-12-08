class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id]).paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end
end
