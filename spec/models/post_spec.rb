require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe '#five_most_recent_comments' do
    it 'returns the five most recent comments for the post' do
      user1 = User.create(name: 'John Doe')
      post1 = Post.create(author: user, title: 'New post')
      comments = []
      10.times do |i|
        comments.push(Comment.create!(user: user1, post: post1, text: "Comment #{i}"))
      end
      expect(post.five_most_recent_comments).to eq(comments.last(5).reverse)
    end
  end

  describe '#update_posts_count_on_create' do
    it 'updates the posts count on create' do
      user = User.create(name: 'John Doe')
      expect do
        Post.create(author: user, title: 'New post')
      end.to change { user.posts_counter }.by(1)
    end
  end
end
