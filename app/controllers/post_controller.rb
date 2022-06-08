class PostController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    title = params[:post][:title]
    text = params[:post][:text]
    @post = Post.new(post_params)
    @post.author = ApplicationController.current_user
    flash.alert = 'Title can not be empty' if title == ''
    flash.alert = 'Text can not be empty' if text == ''
    if flash.none?
      if @post.save
        redirect_to user_path(id: @post.author.id), notice: 'Post created sucessfully'
      else
        render :new, status: 400
      end
    else
      render :new, status: 400
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
