class SettingsController < ApplicationController
  before_filter :ensure_authenticated
  before_filter :load_user

  def edit_password    
  end

  def update_password
    if current_user.update(params[:user])
      redirect_to edit_password_settings_path, :notice => "You've updated your settings successfully"
    else
      render :edit_password, :status => :conflict
    end
  end

  def load_user
    @user = current_user
  end
end