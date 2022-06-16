class ApiController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user!

  def validate_credentials(credential)
    user = User.where(email: credential).take
    puts user.class
    return false unless user
    return false unless user.confirmed?

    @current_user = user
    true
  end

  def show_users_posts
    respond_to :json
    token = params[:token]
    author_id = params[:author_id]
    puts "Token: #{token}"
    if !author_id || !token
      render json: { error: 'Invalid parameters' }, status: 400
      return
    end
    credential = ApiHelper::JsonWebToken.decode(token)[0]
    if validate_credentials(credential)
      posts = Post.where(author_id: author_id)
      render json: posts, status: 200
    else
      render json: { error: 'unauthorized' }, status: 401
    end
  end

  def show_posts_comments
    respond_to :json
    token = params[:token]
    post_id = params[:post_id]
    if !post_id || !token
      render json: { error: 'Invalid parameters' }, status: 400
      return
    end
    credential = ApiHelper::JsonWebToken.decode(token)[0]
    if validate_credentials(credential)
      comments = Comment.where(post_id: post_id)
      puts comments, status: 200
      render json: comments
    else
      render json: { error: 'unauthorized' }, status: 401
    end
  end

  def add_comment_to_post
    respond_to :json
    token = params[:token]
    post_id = params[:post_id]
    comment_text = params[:text]
    if !post_id || !token || !comment_text
      render json: { error: 'Invalid parameters' }, status: 400
      return
    end
    credential = ApiHelper::JsonWebToken.decode(token)[0]
    if validate_credentials(credential)
      Comment.create(post_id: post_id, author: @current_user, text: comment_text)
      render json: { message: 'your comment was saved successfully' }
    else
      render json: { error: 'unauthorized' }
    end
  end
end
