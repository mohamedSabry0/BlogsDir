require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'returns a success response' do
      get '/users'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /users/:id' do
    user = User.create(name: 'John Doe')

    it 'returns a success response' do
      get "/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
