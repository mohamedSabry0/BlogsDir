require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe '#update_comments_count_on_create' do
    it 'updates the comments count on create' do
      user = User.create(name: 'John Doe')
      post = Post.create(author: user, title: 'New post')
      expect do
        Comment.create(user:, post:, text: 'New comment')
      end.to change { post.comments_counter }.by(1)
    end
  end
end
