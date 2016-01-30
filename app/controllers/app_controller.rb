class AppController < ApplicationController
  #load_and_authorize_resource
  #after_filter :set_csrf_cookie_for_ng
  # Turn off CSFR for XHR
  skip_before_action :verify_authenticity_token

  rescue_from CanCan::AccessDenied do |exception|
    render json: {
             error: {
               reason: "auth",
               message: "Authentication expired, please log in"
             }
           }
  end
end
