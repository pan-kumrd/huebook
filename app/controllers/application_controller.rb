class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
#  protect_from_forgery with: :exception
  before_filter :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  # HACK: Make current_user available in Models
  def set_current_user
    User.current_user = current_user
  end

  protected
  # Custom devise parameters for registration
  def configure_permitted_parameters
    #devise_parameter_sanitizer.for(:sign_up) << [ :first_name, :last_name ]
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :first_name, :last_name, :password, :password_confirmation)
    end
  end
end
