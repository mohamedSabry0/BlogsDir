class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create!(user_id: current_user.id, post_id: params[:post_id],
                                      text: params[:comment][:text])
    redirect_to user_post_path(@post.author, @post)
  end
end
