class ApiController < ApplicationController
  skip_before_action :authenticate_user!

  def validate_credentials(credential)
    user = User.where(email: credential).take
    puts user.class
    return false unless user

    @current_user = user
    true
  end

  def show_api_users
    respond_to :json
    token = params[:token]
    user_id = params[:user_id]
    credential = ApiHelper::JsonWebToken.decode(token)[0]
    if validate_credentials(credential)
      puts @current_user.name
      posts = Post.where(author_id: user_id)
      puts posts
      render json: { message: "Welcome #{@current_user.name}" }
    else
      render json: { error: 'unauthorized' }
    end
  end
end
