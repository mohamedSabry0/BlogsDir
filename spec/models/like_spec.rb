require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe '#update_likes_count_on_create' do
    it 'updates the likes count on create' do
      user = User.create(name: 'John Doe')
      post = Post.create(author: user, title: 'New post')
      expect do
        Like.create(user:, post:)
      end.to change { post.likes_counter }.by(1)
    end
  end
end
