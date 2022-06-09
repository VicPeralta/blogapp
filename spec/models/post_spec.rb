require 'rails_helper'

RSpec.describe 'User model', type: :request do
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
