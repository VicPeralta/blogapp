class UsersController < ApplicationController
  def index
    @users = User.all.order(id: :asc)
  end

  def show
    index = params['id'].to_i
    @user = User.find(index)
    @posts = @user.three_most_recent_posts
  end
end
