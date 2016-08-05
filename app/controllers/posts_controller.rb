class PostsController < ApplicationController

  def new
    @post = Post.new
    @category_options = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @post = Post.new(whitelisted_post_params)
    if @post.save
      flash[:success] = "Post saved."
      redirect_to @post
    else
      flash[:danger] = "Post not saved."
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @category_options = Category.all.map { |c| [c.name, c.id] }
  end

  def update
    @post = Post.find(params[:id])
    if @post = Post.update(whitelisted_post_params)
      flash[:success] = "Post updated."
      redirect_to @post
    else
      flash[:danger] = "Post not updated."
      render 'new'
    end
  end






  private


  def whitelisted_post_params
    params.require(:post).permit(:title, :body, {:category_id => []}, :tag_ids => [])
  end
end
