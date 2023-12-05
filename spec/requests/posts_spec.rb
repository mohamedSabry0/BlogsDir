require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:each) do
    @user = User.create(name: 'John Doe')
  end

  describe 'GET /posts' do
    it 'returns a success response' do
      get "/users/#{@user.id}/posts"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /posts/:id' do
    post = Post.create(author: @user, title: 'New post')

    it 'returns a success response' do
      get "/users/#{@user.id}/posts/#{post.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
