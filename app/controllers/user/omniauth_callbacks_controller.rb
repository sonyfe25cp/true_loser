class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def weibo
    @user = User::User.find_for_weibo(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauthth_callbacks.success", :kind => "Weibo"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.weibo_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
#  def renren 
#    @user = User::User.find_for_renren(request.env["omniauth.auth"], current_user)
#    if @user.persisted?
#      flash[:notice] = I18n.t "devise.omniauthth_callbacks.success", :kind => "renren"
#      sign_in_and_redirect @user, :event => :authentication
#    else
#      session["devise.renren_data"] = request.env["omniauth.auth"]
#      redirect_to new_user_registration_url
#    end
#  end
end
