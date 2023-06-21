class Admin::PostsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(10)
    # @posts = Post.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    # @comment = current_user.comments.new
    @comments = @post.comments.page(params[:page]).per(5).reverse_order
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

end