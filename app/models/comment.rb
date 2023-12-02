class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :update_comments_count_on_create

  private

  def update_comments_count_on_create
    post.increment!(:comments_counter)
  end
end
