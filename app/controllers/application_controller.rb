class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html', status: :forbidden }
      format.html { redirect_to main_app.root_url, notice: exception.message, status: :forbidden }
    end
  end

end
