class CommentsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    text = params[:text]
    if text == ''
      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id]), alert: 'Empty comment'
      return
    end
    post.comments.create(text: text, author: current_user)
    redirect_to user_post_path(user, post), notice: 'Comment added'
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    comment.destroy
    comment.save
    redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id]), notice: 'Comment deleted'
  end
end
