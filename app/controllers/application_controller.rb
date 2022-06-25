class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :api_path
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name bio password password_confirmation])
  end

  def api_path
    request.path.start_with?('/api')
  end
end
