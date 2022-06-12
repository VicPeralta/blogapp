class ServiceController < ApplicationController
  def initialize
    super()
    @current_user = ApplicationController.current_user
  end

  def like
    user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    Like.create(author: user, post: post)
    redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id]), notice: 'Like Added'
  end

  def comment
    post = Post.find(params[:post_id])
    text = params[:text]
    if text == ''
      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id]), alert: 'Empty comment'
      return
    end
    Comment.create(author: @current_user, post: post, text: text)
    redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id]), notice: 'Comment added'
  end
end
