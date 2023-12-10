class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id]).paginate(page: params[:page])
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.create!(post_params)
    redirect_to user_post_path(current_user, @post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
