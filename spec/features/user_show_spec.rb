require 'rails_helper'

RSpec.describe 'User Show', type: :feature do
  before :each do
    @user = User.create!(name: 'John Doe', photo: 'https://i.pravatar.cc/150?img=0', bio: 'I am a test user.')
    @posts = []
    6.times do |i|
      @posts.push(Post.create!(author: @user, title: "Post #{i}", text: "Body #{i}"))
    end

    visit user_path(@user)
  end

  it 'shows the user\'s profile picture' do
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end

  it 'shows the user\'s name' do
    expect(page).to have_content(@user.name)
  end

  it 'shows the number of posts the user has written' do
    expect(page).to have_content(@user.posts.count)
  end

  it 'shows the user\'s bio' do
    expect(page).to have_content(@user.bio)
  end

  it 'shows the user\'s most recent 3 posts' do
    @posts.last(3).reverse.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'shows a button that lets me view all of a user\'s posts' do
    expect(page).to have_link('See all posts')
  end

  it 'redirects me to that post\'s show page when I click a user\'s post' do
    @posts.last(3).reverse.each do |post|
      click_on post.title
      expect(page).to have_current_path(user_post_path(@user, post))
      visit user_path(@user)
    end
  end

  it 'redirects me to the user\'s post\'s index page when I click to see all posts' do
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
