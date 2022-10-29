class PostsController < ApplicationController
  def index
    user_index = params['user_id'].to_i
    @user_info = User.find(user_index)
    @posts = Post.includes(:comments, comments: [:author]).where(author_id: user_index).order(id: :desc)
  end

  def show
    user_index = params['user_id'].to_i
    post_index = params['id'].to_i
    @user_info = User.find(user_index)
    @post_info = Post.includes(:comments, comments: [:author]).find(post_index)
  end

  def delete
    puts 'Deleting'
    puts params
    post_index = params['id'].to_i
    user_id = params['user_id'].to_i
    post = Post.find(post_index)
    post.destroy
    redirect_to user_path(id: user_id), notice: 'Post deleted', status: 303
  end
end
