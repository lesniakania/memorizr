class BaseController < ApplicationController
  protect_from_forgery
  layout 'application'

  def ensure_authenticated
    unless current_user
      @session_form = SessionForm.new
      render '/sessions/new', :layout => 'anonymous', :status => :forbidden
    end
  end
end
