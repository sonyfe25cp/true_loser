class User::BaseController < ApplicationController
  layout 'user/default'

  protected
  def current_resource_name
    :user
  end
end
