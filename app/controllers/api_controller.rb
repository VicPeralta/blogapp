class ApiController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user!

  def validate_credentials(credential)
    user = User.where(email: credential).take
    puts user.class
    return false unless user

    @current_user = user
    true
  end

  def show_users_posts
    respond_to :json
    token = params[:token]
    author_id = params[:author_id]
    credential = ApiHelper::JsonWebToken.decode(token)[0]
    if validate_credentials(credential)
      posts = Post.where(author_id: author_id)
      render json: posts
    else
      render json: { error: 'unauthorized' }
    end
  end

  def show_posts_comments
    respond_to :json
    token = params[:token]
    post_id = params[:post_id]
    credential = ApiHelper::JsonWebToken.decode(token)[0]
    if validate_credentials(credential)
      comments = Comment.where(post_id: post_id)
      puts comments
      render json: comments
    else
      render json: { error: 'unauthorized' }
    end
  end

  def add_comment_to_post
    # puts 'Hellooooooooooooooooooooooooooooooooooo'
    respond_to :json
    token = params[:token]
    post_id = params[:post_id]
    comment_text = params[:text]
    credential = ApiHelper::JsonWebToken.decode(token)[0]
    if validate_credentials(credential)
      Comment.create(post_id: post_id, author: @current_user, text: comment_text)
      render json: { message: 'your comment saved successfully' }
    else
      render json: { error: 'unauthorized' }
    end
  end
end
