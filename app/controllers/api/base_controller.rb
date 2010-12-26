class Api::BaseController < ApplicationController
  def ensure_authenticated
    unless current_user
      basic_authenticate!
    end
  end

  def basic_authenticate!
    authenticate_or_request_with_http_basic do |email, password|
      session_form = SessionForm.new(:email => email, :password => password)
      if session_form.valid?
        session[:user_id] = session_form.user_id
        return true
      end
    end
    return false
  end
end

