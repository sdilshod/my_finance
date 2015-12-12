class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :authenticate_user!

  helper_method :admin_user?

  #TODO In the future may be needed to add attribute to user, but for now it's ok
  def admin_user?
    return true if current_user.email == 'samatov.dilshod@gmail.com' && Rails.env.production?
    return false if Rails.env.production?
    true
  end
end
