class ApplicationController < ActionController::Base

  helper_method :current_user

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_error
    rescue_from ActionController::RoutingError, :with => :not_found
  end
  
  private

  def current_user
    @current_user ||= User.get(session[:user_id])
  end

  def render_error
    render '/exceptions/500', :layout => 'exception', :status => :internal_server_error
  end

  def not_found
    render '/exceptions/404', :layout => 'exception', :status => :not_found
  end
end
