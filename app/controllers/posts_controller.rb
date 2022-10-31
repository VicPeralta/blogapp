class PostsController < ApplicationController
  before_action :set_user

  def new
    @post = @user.posts.new
  end

  def create
    @post = @user.posts.new(post_params)
    @post.author = current_user
   
    if @post.save
      redirect_to user_path(id: @post.author.id), notice: 'Post created sucessfully'
    else
      render :new, status: 400
    end
  end

  def index
    @posts = @user.posts.includes(:comments).order(id: :desc)
  end

  def show
    @post = @user.posts.includes(:comments, comments: [:author]).find(params[:id])
  end

  def destroy
    @user.posts.find(params[:id]).destroy
    redirect_to user_path(@user), notice: 'Post deleted', status: 303
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
