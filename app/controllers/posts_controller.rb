class PostsController < ApplicationController
  def initialize
    super()
    @users = []
  end

  def index
    @users.push(UserInfo.new(1, 'Homer', 1, 'homer.jpg'))
    @users.push(UserInfo.new(2, 'Marge', 2, 'marge.jpg'))
    @users.push(UserInfo.new(3, 'Bart', 2, 'bart.gif'))
    @users.push(UserInfo.new(4, 'Lisa', 10, 'lisa.png'))
    index = params['user_id'].to_i - 1
    @user_info = @users[index]
  end

  def show
    @users.push(UserInfo.new(1, 'Homer', 1, 'homer.jpg'))
    @users.push(UserInfo.new(2, 'Marge', 2, 'marge.jpg'))
    @users.push(UserInfo.new(3, 'Bart', 2, 'bart.gif'))
    @users.push(UserInfo.new(4, 'Lisa', 10, 'lisa.png'))
    index = params['user_id'].to_i - 1
    @user_info = @users[index]
    @post_number = params['id']
  end
end
