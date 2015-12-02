class WelcomeController < ApplicationController

  skip_before_action :authenticate_user!

  def index; end

  def not_found; render status: '404'; end

end
