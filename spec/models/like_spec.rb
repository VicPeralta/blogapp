require 'rails_helper'

RSpec.describe 'Like model', type: :request do
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
    (1..5).each do |n|
      @first_user.posts.create(title: "Post # #{n}", text: "This is post # #{n}")
    end
    5.times { @first_user.posts.first.comments.create(author: @second_user, text: 'Hi Tom!!') }
  end

  after :all do
    Comment.all.destroy_all
    Like.all.destroy_all
    Post.all.destroy_all
    @first_user.destroy
    @second_user.destroy
  end

  it 'Creates a valid instance' do
    post = @first_user.posts.first
    like = post.likes.new(author: @second_user)
    expect(like).to be_valid
  end

  it 'Update likes counter for post' do
    post = @first_user.posts.first
    Like.update_counter_for_post(post)
    expect(post.likesCounter).to be == Like.where(post: post).count
  end
end
