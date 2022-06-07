class ServiceController < ApplicationController
  def like
    user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    Like.create(author: user, post: post)
    Like.update_counter_for_post(post)
    redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
  end
end
