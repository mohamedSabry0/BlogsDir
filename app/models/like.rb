class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :update_likes_count_on_create

  def update_likes_count_on_create
    post.increment!(:likes_counter)
  end
end
