class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    if @comment.save
      @comments = @post.comments.page(params[:page]).per(5).reverse_order
      render :post_comments
    else
      render 'posts/show'
    end
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    # redirect_to post_path(params[:post_id])
    @post = Post.find(params[:post_id])
    @comments = @post.comments.page(params[:page]).per(5).reverse_order
    render :post_comments
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :post_id)
  end

end
