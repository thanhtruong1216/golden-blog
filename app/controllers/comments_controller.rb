class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html
        format.js { render layout: false }
      end
    else
      render root_path
    end
  end

  def edit
    @comment = @post.comments.find(params[:id])
    @comment.user_id = current_user.id
    if @comment.update_attributes(comment_params)
      flash[:success] = "You commented updated"
      respond_to do |format|
        format.html { redirect_to @post }
        format.js { render layout: false }
      end
    else
      flash[:alert] = "Edit wrong"
      render @post
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to @post }
        format.js { render layout: false }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
