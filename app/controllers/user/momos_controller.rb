# -*- encoding: utf-8 -*-
class User::MomosController < User::BaseController
  def create
    post_id = params[:post_id]

    momo = Momo.create(:post_id => post_id, :user_id => current_user.id)

    momo.save

  end

  #获得某个post的momo数
  def count

  end
end
