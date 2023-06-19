class Public::FavoritesController < ApplicationController

  # before_action :post_params

  def create
  @post = Post.find(params[:post_id])
  @post_favorite = Favorite.new(user_id: current_user.id, post_id: params[:post_id])
  @post_favorite.save
  # 非同期通信のため
  # redirect_to post_path(params[:post_id])
  end

  def destroy
  @post = Post.find(params[:post_id])
  @post_favorite = Favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
  @post_favorite.destroy
  # 非同期通信のため
  # redirect_to post_path(params[:post_id])
  end

  private

  # def post_params
  #   @post = Post.find(params[:id])
  # end

end
