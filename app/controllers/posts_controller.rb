class PostsController < ApplicationController
  def initialize
    super()
    @users = []
  end

  def index
    user_index = params['user_id'].to_i
    @user_info = User.find(user_index)
    @posts = Post.where(author_id: user_index)
  end

  def show
    user_index = params['user_id'].to_i
    post_index = params['id'].to_i
    @user_info = User.find(user_index)
    @post_info = Post.find(post_index)
    puts "Likes: #{@post_info.likes.count}"
  end
end
