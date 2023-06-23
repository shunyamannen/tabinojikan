# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

   # ゲスト会員ログイン
  def guest_sign_in
    user = User.find_or_create_by!(email: "guest@guest.com") do |guest|
      guest.name = "ゲストユーザー"
      guest.password = "aaaaaa"
    end

    sign_in user
    redirect_to about_path
  end


  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

 # 退会した会員が、同じアカウントでログイン出来ない処理
  def reject_withdraw_user
    @user = User.find_by(name: params[:user][:name])
    return if !@user
    if @user.valid_password?(params[:user][:password]) && @user.members_status == true
      flash[:notice] = "退会済みの為、再登録が必要です。"
      redirect_to new_user_registration_path
    end
  end
end