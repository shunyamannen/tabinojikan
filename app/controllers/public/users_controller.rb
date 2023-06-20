class Public::UsersController < ApplicationController
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

  def withdraw
    @user = current_user
    @user.update(members_status: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  def unsubscribe
  end
end
