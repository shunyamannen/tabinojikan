class Public::PostsController < ApplicationController
   

  def index
    @posts = Post.all
    @post_page = Post.page(params[:page]).per(8)
  end

  def show
    @post = Post.find(params[:id])
    @comment = current_user.comments.new
    @comments = @post.comments.page(params[:page]).per(5).reverse_order
  end

  def edit
     @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

 def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿作成しました"
      redirect_to posts_path
    else
      flash[:alert] = "投稿作成できませんでした"
      render :new
    end
  end
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集しました"
      redirect_to post_path(@post.id)
    else
      flash[:alert] = "空欄を入力してください"
      redirect_to edit_post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user.id == current_user
      @post.destroy
      redirect_to posts_path
    else
      redirect_to post_path(@post.id)
    end
  end


# 投稿データのストロングパラメータ
  private

  def post_params
    params.require(:post).permit(:title, :image, :body)
  end

end