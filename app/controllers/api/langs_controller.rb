class Api::LangsController < Api::BaseController
  before_filter :ensure_authenticated

  def index
    render :json => Lang.index_hash
  end
end
