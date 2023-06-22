class Admin::CommentsController < ApplicationController

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to admin_post_path(params[:post_id])
  end

end