class PostController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    text = params[:post][:text]
    @post = Post.new(post_params)
    @post.author = current_user

    if text.blank?
      flash.now[:alert] = 'Text can not be empty'
      render :new, status: 400
      return
    end
    if @post.save
      redirect_to user_path(id: @post.author.id), notice: 'Post created sucessfully'
    else
      render :new, status: 400
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
