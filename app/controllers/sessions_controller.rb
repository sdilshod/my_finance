class SessionsController < Devise::SessionsController

  def new
    if params[:demo]
      guest_user = User.find_by_email 'guest@guest.com'
      sign_in(resource_name, guest_user)
      redirect_to root_path, notice: t('devise.sessions.signed_in')
    else
      super
    end

  end

end
