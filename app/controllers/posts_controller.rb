class PostsController < ApplicationController
  before_action :set_post, only: %w[edit update destroy like unlike]
  before_action :owned_post, only: %w[edit update destroy]

  def index
    @posts = Post.
                with_attached_photo.
                includes(user: { avatar_attachment: :blob }).
                order(created_at: :desc).
                limit(20).
                all

  end

  def show
    @post = Post.includes(:comments, :likes).find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to @post
    else
      flash[:danger] = "Your new post couldn't be created! Please check the form."
      render 'new'
    end
  end

  def edit
    @post = Post.includes(:comments).find(params[id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path
  end

  def like
    @post.likes.where(user_id: current_user.id).first_or_create
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def unlike
    likes = @post.likes.where(user_id: current_user.id)
    if likes.count > 0
      likes.destroy_all
    else
      flash[:notice] = "Cannot unlike"
    end
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  private

  def post_params
    params.require(:post).permit(:photo, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
    p "current user id #{current_user.id}"
    p "post user id #{@post.user.id}"
    unless current_user.id == @post.user.id
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end
end
