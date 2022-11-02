require 'rails_helper'

RSpec.describe 'User page test', type: :feature do
  before :all do
    @first_user = User.create(
      name: 'Tom',
      photo: 'https://live.staticflickr.com/65535/52122569383_698a119861_z.jpg',
      bio: 'A teacher from Mexico',
      email: 'victorperaltagomez@gmail.com',
      password: '121212',
      created_at: '2022-06-15 01:40:30.027196000 +0000',
      confirmed_at: '2022-06-14 21:22:04.937699'
    )
    @second_user = User.create(
      name: 'Lilly',
      photo: 'https://live.staticflickr.com/65535/52122569383_698a119861_z.jpg',
      bio: 'A teacher from Poland',
      email: '123@123.com',
      password: '121212',
      created_at: '2022-06-15 01:40:30.027196000 +0000',
      confirmed_at: '2022-06-14 21:22:04.937699'
    )
    @first_user.posts.create(title: 'First Post', text: 'This is a post')
    @first_user.posts.create(title: 'Second Post', text: 'This is a post')
    @first_user.posts.create(title: 'Third Post', text: 'This is a post')
    @first_user.posts.create(title: 'Fourth Post', text: 'This is a post')
    @first_user.posts.create(title: 'Fifth Post', text: 'This is a post')
    @first_user.posts.first.comments.create(author: @second_user, text: 'Hi Tom!!')
    @first_user.posts.first.comments.create(author: @second_user, text: 'Hi Tom!!')
    @first_user.posts.first.comments.create(author: @second_user, text: 'Hi Tom!!')
    @first_user.posts.first.comments.create(author: @second_user, text: 'Hi Tom!!')
    @first_user.posts.first.comments.create(author: @second_user, text: 'Hi Tom!!')
  end

  before :each do
    sign_in @first_user
    visit user_path(@first_user)
  end

  after :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    @first_user.destroy
    @second_user.destroy
  end

  it 'The user\'s profile picture should be visible.' do
    expect(page.has_xpath?("//img[@src = '#{@first_user.photo}' ]"))
  end

  it 'The user\'s username should be visible.' do
    expect(page.has_link?(@first_user.name)).to be true
  end

  it 'The number of posts that the user has written should be visible.' do
    Post.update_counter_for_user(@first_user)
    expect(page).to have_content("Number of posts: #{@first_user.postCounter}")
  end

  it 'The user\'s bio should be visible.' do
    expect(page).to have_content(@first_user.bio) && have_content('Bio')
  end

  it 'The first 3 posts of the user should be visible' do
    @first_user.three_most_recent_posts.all.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'A button that redirects to the user\'s posts should be available.' do
    expect(page.has_link?('See all posts', href: "/users/#{@first_user.id}/posts")).to be true
  end

  it 'By clicking on a user\'s post, it should be redirected to that post\'s show page' do
    post = @first_user.three_most_recent_posts[1]
    find_link(href: "/users/#{@first_user.id}/posts/#{post.id}").click
    expect(page).to have_content(post.title) && have_content(post.text)
  end

  it 'By clicking on the "see all posts", it should be redirected to the user\'s post\'s index page' do
    find_link('See all posts', href: "/users/#{@first_user.id}/posts").click
    expect(page).to have_current_path("/users/#{@first_user.id}/posts")
  end
end
