require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe '#update_comments_count_on_create' do
    it 'updates the comments count on create' do
      user1 = User.create(name: 'John Doe')
      post1 = Post.create(author: user, title: 'New post')
      expect do
        Comment.create(user: user1, post: post1, text: 'New comment')
      end.to change { post.comments_counter }.by(1)
    end
  end
end
