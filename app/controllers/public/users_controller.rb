class Public::UsersController < ApplicationController

  # ゲストユーザーでedit画面に遷移させない
  before_action :ensure_guest_user, only: [:edit, :unsubscribe]
   # ログインユーザー以外のeditとupdateをさせない
  before_action :ensure_correct_user, only: [:update, :edit, :unsubscribe]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(5)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "編集しました"
      redirect_to user_path(@user)
    else
      flash[:alert] = "空欄を入力してください"
      redirect_to edit_user_path(@user)
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    @user.update(members_status: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def search
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(10)
  end

  # 投稿データのストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email, :encrypted_password, :members_status)
  end

  # ゲストユーザーでedit画面に遷移させない
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@guest.com"
      flash[:notice] = 'ゲストユーザーでは遷移できません。'
      redirect_to user_path(current_user)
    end
  end

  # ログインしたユーザー以外のedit画面に遷移させない
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:notice] = '他ユーザーの編集はできません。'
      redirect_to user_path(current_user)
    end
  end

end