class Api::SessionsController < Api::BaseController  
  def create
    if basic_authenticate!
      render :json => current_user.hash_format
    else
      head :unauthorized
    end
  end
end
