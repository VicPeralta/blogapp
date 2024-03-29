require 'rails_helper'

RSpec.describe 'Post index page test', type: :feature do
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
  end

  before :each do
    visit root_path
    fill_in 'user_email', with: 'victorperaltagomez@gmail.com'
    fill_in 'user_password', with: '121212'
    click_button 'Log in'
    visit "/users/#{User.first.id}/posts"
  end

  after :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    @first_user.destroy
    @second_user.destroy
  end

  it 'The user\'s profile picture should be visible.' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    expect(page.has_xpath?("//img[@src = '#{user.photo}' ]"))
  end

  it 'The user\'s username should be visible.' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    expect(page.has_link?(user.name)).to be true
  end

  it 'The number of posts that the user has written should be visible.' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    expect(page).to have_content("Number of posts: #{user.postCounter}")
  end

  it 'The user\'s posts title should be visible' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    post = user.three_most_recent_posts[0]
    expect(page).to have_content(post.title[0..100])
  end

  it 'The user\'s posts body should be visible' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    post = user.three_most_recent_posts[0]
    expect(page).to have_content(post.text)
  end

  it 'The user\'s posts comment should be visible' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    post = user.three_most_recent_posts[0]
    comment = post.comments.last
    expect(page).to have_content(comment.text)
  end

  it 'Can see how many comments a post has' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    post = user.three_most_recent_posts[0]
    expect(page.has_link?(href: "/users/#{user.id}/posts/#{post.id}")).to be true
    expect(page).to have_content("Comments: #{post.commentsCounter} Likes: #{post.likesCounter}")
  end

  it 'Can see how many likes a post has' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    post = user.three_most_recent_posts[0]
    expect(page.has_link?(href: "/users/#{user.id}/posts/#{post.id}")).to be true
    expect(page).to have_content("Comments: #{post.commentsCounter} Likes: #{post.likesCounter}")
  end

  it 'When click on a post, it redirects to that post\'s show page' do
    user_id = current_path.split('/')[2]
    user = User.find(user_id)
    post = user.three_most_recent_posts[0]
    find_link(href: "/users/#{user.id}/posts/#{post.id}").click
    expect(page).to have_content(post.title) && have_content(post.text)
  end
end
