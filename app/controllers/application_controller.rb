class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.get(session[:user_id])
  end

  def ensure_authenticated
    redirect_to '/session/new' unless current_user
  end
end
