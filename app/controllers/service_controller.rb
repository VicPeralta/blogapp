class ServiceController < ApplicationController
  def initialize
    super()
    @current_user = ApplicationController.current_user
  end

  def like
    user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    Like.create(author: user, post: post)
    Like.update_counter_for_post(post)
    redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
  end

  def comment
    post = Post.find(params[:post_id])
    text = params[:text]
    if text == ''
      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
      return
    end
    Comment.create(author: @current_user, post: post, text: text)
    Comment.update_counter_for_post(post)
    redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
  end
end
