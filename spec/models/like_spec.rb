require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe '#update_likes_count_on_create' do
    it 'updates the likes count on create' do
      user1 = User.create(name: 'John Doe')
      post1 = Post.create(author: user1, title: 'New post')
      expect do
        Like.create(user: user1, post: post1)
      end.to change { post1.likes_counter }.by(1)
    end
  end
end
