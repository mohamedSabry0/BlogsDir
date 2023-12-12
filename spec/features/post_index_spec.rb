require 'rails_helper'

RSpec.describe 'User Post Index', type: :feature do
  before :each do
    @user = User.create!(name: 'John Doe', photo: 'https://i.pravatar.cc/150?img=0', bio: 'I am a test user.')
    @posts = []
    6.times do |i|
      @posts.push(Post.create!(author: @user, title: "Post #{i}", text: "Body #{i}"))
    end

    visit user_posts_path(@user)
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

  it 'shows a post\'s title' do
    @posts.first(2).each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'shows some of the post\'s body' do
    @posts.first(2).each do |post|
      expect(page).to have_content(post.text)
    end
  end

  it 'shows the first comments on a post' do
    @posts.first(2).each do |post|
      post.comments.first(3).each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end

  it 'shows how many comments a post has' do
    @posts.first(2).each do |post|
      expect(page).to have_content(post.comments.count)
    end
  end

  it 'shows how many likes a post has' do
    @posts.first(2).each do |post|
      expect(page).to have_content(post.likes.count)
    end
  end

  it 'shows a section for pagination if there are more posts than fit on the view' do
    expect(page).to have_css('.pagination')
  end

  it 'redirects me to that post\'s show page when I click a user\'s post' do
    @posts.first(2).each do |post|
      click_on post.title
      expect(page).to have_current_path(user_post_path(@user, post))
      visit user_posts_path(@user)
    end
  end
end
