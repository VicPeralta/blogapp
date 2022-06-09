class UsersController < ApplicationController
  def index
    @users = User.all.order(id: :asc)
  end

  def show
    index = params['id'].to_i
    @user_info = User.find(index)
    @posts = @user_info.three_most_recent_posts
  end
end
