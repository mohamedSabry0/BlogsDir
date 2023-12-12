class UsersController < ApplicationController
  def index
    @users = User.includes(:posts).all
  end

  def show
    @user = User.find(params[:id])
    @user_posts = @user.three_most_recent_posts.includes(:comments)
  end
end
