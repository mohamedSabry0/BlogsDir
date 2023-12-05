require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    before(:each) { get '/users' }
    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'includes the text "Here is a list of all users:"' do
      expect(response.body).to include('Here is a list of all users:')
    end
  end

  describe 'GET /users/:id' do
    before(:each) do
      user = User.create(name: 'John Doe')
      get "/users/#{user.id}"
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'includes the text "Here is a user details page:"' do
      expect(response.body).to include('Here is a user details page:')
    end
  end
end
