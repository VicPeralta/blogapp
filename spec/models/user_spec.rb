require 'rails_helper'

RSpec.describe 'User model', type: :request do
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

  it 'Create valid user' do
    user = User.new(name: 'Victor',
                    photo: 'url',
                    bio: 'Programmer',
                    email: 'victor.peralta.gomez@gmail.com',
                    password: '121212')
    expect(user).to be_valid
  end

  it 'Create invalid user due to empty name' do
    user = User.new(name: '',
                    photo: 'url',
                    bio: 'Programmer',
                    email: 'victor.peralta.gomez@gmail.com',
                    password: '121212')
    expect(user).to_not be_valid
    expect(user.errors[:name][0]).to be == 'Name can not be blank'
  end

  it 'Expect right error message due to empty name' do
    user = User.new(name: '',
                    photo: 'url',
                    bio: 'Programmer',
                    email: 'victor.peralta.gomez@gmail.com',
                    password: '121212')
    expect(user).to_not be_valid
    expect(user.errors[:name][0]).to be == 'Name can not be blank'
  end

  it 'Create invalid user due to wrong postCounter value' do
    user = User.new(name: '',
                    photo: 'url',
                    bio: 'Programmer',
                    email: 'victor.peralta.gomez@gmail.com',
                    password: '121212',
                    postCounter: -1)
    expect(user).to_not be_valid
  end

  it 'Expect right error message due to wrong postCounter value' do
    user = User.new(name: '',
                    photo: 'url',
                    bio: 'Programmer',
                    email: 'victor.peralta.gomez@gmail.com',
                    password: '121212',
                    postCounter: -1)
    expect(user).to_not be_valid
    expect(user.errors[:postCounter][0]).to be == 'postCounter must be integer and >=0'
  end

  it 'Expect the three most recent posts for the first user (Instance method)' do
    user = User.first
    posts = user.three_most_recent_posts
    expect(posts.size).to be == 3
  end

  it 'Expect the three most recent posts for the first user (Class method)' do
    user = User.first
    posts = User.three_most_recent_posts(user)
    expect(posts.size).to be == 3
  end
end
