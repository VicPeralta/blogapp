class PostController < ApplicationController
  def new
    @post = Post.new
    @errors = []
  end

  def create
    user = ApplicationController.current_user
    title = params[:post][:title]
    text = params[:post][:text]
    @post = Post.new(author: user, title: title, text: text)
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
end
