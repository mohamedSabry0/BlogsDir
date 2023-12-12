require 'rails_helper'

RSpec.describe 'Post Show', type: :feature do
  before :each do
    @user = User.create!(name: 'John Doe', photo: 'https://i.pravatar.cc/150?img=0', bio: 'I am a test user.')
    @post = Post.create!(author: @user, title: 'New post', text: 'This is a new post.')
    @comments = []
    6.times do |i|
      @comments.push(Comment.create!(user: @user, post: @post, text: "Comment #{i}"))
    end

    visit user_post_path(@user, @post)
  end

  it 'shows the post\'s title' do
    expect(page).to have_content(@post.title)
  end

  it 'shows who wrote the post' do
    expect(page).to have_content(@post.author.name)
  end

  it 'shows how many comments it has' do
    expect(page).to have_content(@post.comments.count)
  end

  it 'shows how many likes it has' do
    expect(page).to have_content(@post.likes.count)
  end

  it 'shows the post body' do
    expect(page).to have_content(@post.text)
  end

  it 'shows the username of each commentor' do
    @comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  it 'shows the comment each commentor left' do
    @comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
