class Api::SessionsController < Api::BaseController  
  def create
    if basic_authenticate!
      render :json => current_user.hash_format
    else
      head :conflict
    end
  end

  def logout
    session.delete(:user_id)
    head :ok
  end
end
