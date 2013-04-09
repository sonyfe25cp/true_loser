# -*- encoding: utf-8 -*-
class User::CommentsController < User::BaseController
  
  def index
    post_id = params[:post_id]
    @comments = Comments.search(:post_id => post_id).all(:id => desc)

    respond_to do |format|
      format.json {render json: @comments}
    end
  end

  def create
    comment = Comment.new(:content => params[:content], :user_id => params[:user_id], :post_id => params[:post_id])
    user = User::User.get(params[:user_id])
    comment.user_img = user.user_img
    comment.username = user.username
    comment.user_weibo = user.user_weibo
    comment.save
    redirect_to post_path(params[:post_id])
  end
end
