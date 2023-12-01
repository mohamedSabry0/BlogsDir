require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should have_many(:posts).with_foreign_key(:author_id).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe '#three_most_recent_posts' do
    it 'returns the three most recent posts' do
      user = User.create(name: 'John Doe')
      posts = []
      10.times do |i|
        posts.push(Post.create!(author: user, title: "Post #{i}"))
      end
      expect(user.three_most_recent_posts).to eq(posts.last(3).reverse)
    end
  end
end
