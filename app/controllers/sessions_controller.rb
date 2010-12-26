class SessionsController < BaseController
  layout 'anonymous'

  def new
    @session_form = SessionForm.new
  end
  
  def create
    @session_form = SessionForm.new(params[:session_form])
    if @session_form.valid?
      session[:user_id] = @session_form.user_id
      redirect_to root_path
    else
      render :new, :status => :conflict
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to root_path, :notice => 'You have successfully logged out.'
  end
end
