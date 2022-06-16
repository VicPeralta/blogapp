require 'rails_helper'

RSpec.describe 'Post show page test', type: :feature do
  before :all do
    @first_user ||= User.create(
      name: 'Tom',
      photo: 'https://live.staticflickr.com/65535/52122569383_698a119861_z.jpg',
      bio: 'A teacher from Mexico',
      email: 'victorperaltagomez@gmail.com',
      password: '121212',
      created_at: '2022-06-15 01:40:30.027196000 +0000',
      confirmed_at: '2022-06-14 21:22:04.937699'
    )
    @second_user ||= User.create(
      name: 'Lilly',
      photo: 'https://live.staticflickr.com/65535/52122569383_698a119861_z.jpg',
      bio: 'A teacher from Poland',
      email: '123@123.com',
      password: '121212',
      created_at: '2022-06-15 01:40:30.027196000 +0000',
      confirmed_at: '2022-06-14 21:22:04.937699'
    )
    Post.create(author: @first_user, title: 'First Post', text: 'This is my first post')
    Post.create(author: @first_user, title: 'Second Post', text: 'This is my second post')
    Post.create(author: @first_user, title: 'Third Post', text: 'This is my third post')
    Post.create(author: @first_user, title: 'Fourth Post', text: 'This is my fourth post')
    Post.create(author: @first_user, title: 'Fifth Post', text: 'This is my fifth post')
    post = Post.last
    5.times do
      Comment.create(author: @second_user, post: post, text: 'Hi Tom!!')
    end
    5.times do
      Like.create(author: @second_user, post: post)
    end
  end

  before :each do
    visit root_path
    fill_in 'user_email', with: 'victorperaltagomez@gmail.com'
    fill_in 'user_password', with: '121212'
    click_button 'Log in'
    visit "/users/#{User.first.id}/posts/#{Post.last.id}"
  end

  after :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    @first_user.destroy
    @second_user.destroy
  end

  it 'The posts title should be visible' do
    post_id = current_path.split('/')[4]
    post = Post.find(post_id)
    expect(page).to have_content(post.title)
  end

  it 'Who wrote the post should be visible.' do
    post_id = current_path.split('/')[4]
    post = Post.find(post_id)
    expect(page).to have_content("by #{post.author.name}")
  end

  it 'The number of post\'s comments can be seen' do
    post_id = current_path.split('/')[4]
    post = Post.find(post_id)
    expect(page).to have_content("Comments: #{post.commentsCounter}")
  end

  it 'The number of post\'s likes can be seen' do
    post_id = current_path.split('/')[4]
    post = Post.find(post_id)
    expect(page).to have_content("Likes: #{post.likesCounter}")
  end

  it 'The post\'s body can be seen' do
    post_id = current_path.split('/')[4]
    post = Post.find(post_id)
    expect(page).to have_content(post.text)
  end

  it 'Can see the username of each commentor' do
    post_id = current_path.split('/')[4]
    post = Post.find(post_id)
    comments = post.comments
    comments.each do |comment|
      expect(page).to have_content(comment.author.name)
    end
  end

  it 'Can see the comments each commentor left' do
    post_id = current_path.split('/')[4]
    post = Post.find(post_id)
    comments = post.comments
    comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
