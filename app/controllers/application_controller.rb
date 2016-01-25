class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_current_user

  # HACK: Make current_user available in Models
  def set_current_user
    User.current_user = current_user
  end
end
