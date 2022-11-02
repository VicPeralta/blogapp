class LikesController < ApplicationController
  before_action :set_user_post
  def create
    like = @post.likes.new(author: current_user)
    redirect_to user_post_path(@user, @post), notice: 'Like Added' if like.save
  end

  def destroy
    like = @post.likes.find(params[:id])
    like.destroy
    redirect_to user_post_path(@user, @post), notice: 'Like removed'
  end

  private

  def set_user_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end
end
