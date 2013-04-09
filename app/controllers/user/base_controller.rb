class User::BaseController < ApplicationController
  layout 'user/default'


  #before_filter :authenticate_user!

  protected
  def current_resource_name
    :user
  end
end
