class LangsController < ApplicationController

  before_filter :ensure_authenticated

  def index
    respond_to do |format|
      format.json { render :json => Lang.index_hash }
    end
  end

end
