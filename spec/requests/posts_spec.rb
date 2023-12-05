require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:each) do
    @user = User.create(name: 'John Doe')
    @post = Post.create(author: @user, title: 'New post')
  end

  describe 'GET /posts' do
    before(:each) { get "/users/#{@user.id}/posts" }
    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'includes the text "Here is a list of all posts:"' do
      expect(response.body).to include('Here is a list of all posts of a given user:')
    end
  end

  describe 'GET /posts/:id' do
    before(:each) { get "/users/#{@user.id}/posts/#{@post.id}" }

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'includes the text "Here is a post page:"' do
      expect(response.body).to include('Here is a post page by a given user:')
    end
  end
end
