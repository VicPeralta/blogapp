class UsersController < ApplicationController
  def initialize
    super()
    @users = []
  end

  def index
    @users = User.all
  end

  def show
    index = params['id'].to_i
    @user_info = User.find(index)
    @posts = Post.where(author_id: index)
  end
end
