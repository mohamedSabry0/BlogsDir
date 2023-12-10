class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create!(user_id: current_user.id, post_id: params[:post_id])
    redirect_to user_post_path(@post.author, @post)
  end
end
