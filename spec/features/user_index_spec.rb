require 'rails_helper'

RSpec.describe 'User Index', type: :feature do
  before :each do
    @users = []
    6.times do |i|
      @users.push(User.create!(name: "User #{i}", photo: 'https://i.pravatar.cc/150?img=0'))
    end

    visit users_path
  end

  it 'shows all users' do
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'shows the profile picture for each user' do
    @users.each do |user|
      expect(page).to have_css("img[src*='#{user.photo}']")
    end
  end

  it 'shows the number of posts each user has written' do
    @users.each do |user|
      expect(page).to have_content(user.posts.count)
    end
  end

  it 'redirects to the user show page when a user is clicked' do
    @users.each do |user|
      click_link user.name
      expect(page).to have_current_path(user_path(user))
      visit users_path
    end
  end
end
