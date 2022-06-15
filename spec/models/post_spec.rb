require 'rails_helper'

RSpec.describe 'Post model', type: :request do
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
    post = Post.first
    5.times { Comment.create(author: @second_user, post: post, text: 'Hi Tom!!') }
  end

  after :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    @first_user.destroy
    @second_user.destroy
  end

  it 'Creates a valid instance' do
    user = User.first
    post = Post.new(author: user, title: 'Test', text: 'This is a test', commentsCounter: 0, likesCounter: 0)
    expect(post).to be_valid
  end

  it 'Creates an invalid instance due to empty title' do
    user = User.first
    post = Post.new(author: user,
                    title: '',
                    text: 'This is a test',
                    commentsCounter: 0,
                    likesCounter: 0)
    expect(post).to_not be_valid
    expect(post.errors[:title][0]).to be == 'Title can not be blank'
  end

  it 'Creates an invalid instance due to title too long' do
    user = User.first
    title = 'a' * 251
    post = Post.new(author: user,
                    title: title,
                    text: 'This is a test',
                    commentsCounter: 0,
                    likesCounter: 0)
    expect(post).to_not be_valid
    expect(post.errors[:title][0]).to be == 'Title can only accept a maximum of 250 characters'
  end

  it 'Creates an invalid instance due to invalid commentsCounter' do
    user = User.first
    post = Post.new(author: user,
                    title: 'Test',
                    text: 'This is a test',
                    commentsCounter: -1,
                    likesCounter: 0)
    expect(post).to_not be_valid
    expect(post.errors[:commentsCounter][0]).to be == 'commentsCounter must be integer and >=0'
  end

  it 'Creates an invalid instance due to invalid likesCounter' do
    user = User.first
    post = Post.new(author: user,
                    title: 'Test',
                    text: 'This is a test',
                    commentsCounter: 0,
                    likesCounter: -1)
    expect(post).to_not be_valid
    expect(post.errors[:likesCounter][0]).to be == 'likesCounter must be integer and >=0'
  end

  it 'Return five most recent comments (Class method)' do
    comments = Post.five_most_recent_comments(Post.first)
    expect(comments.size).to be == 5
  end

  it 'Return five most recent comments (Instance method)' do
    post = Post.first
    comments = post.five_most_recent_comments
    expect(comments.size).to be == 5
  end

  it 'Update post counter for user' do
    user = User.first
    Post.update_counter_for_user(user)
    expect(user.postCounter).to be == Post.where(author: user).count
  end
end
