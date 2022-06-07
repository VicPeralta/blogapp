class PostController < ApplicationController
  def new
    @post = Post.new
    @errors = []
  end

  def create
    title = params[:post][:title]
    text = params[:post][:text]
    @post = Post.new(post_params)
    @post.author = ApplicationController.current_user
    @errors = []
    @errors.push 'Title can not be empty' if title == ''
    @errors.push 'Text can not be empty' if text == ''
    if @errors.empty?
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
