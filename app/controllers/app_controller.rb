class AppController < ApplicationController
  load_and_authorize_resource
  after_filter :set_csrf_cookie_for_ng
  # Turn off CSFR for XHR
  skip_before_action :verify_authenticity_token, if: :json_request?

  rescue_from CanCan::AccessDenied do |exception|
    render json: {
             error: {
               reason: "auth",
               message: "Authentication expired, please log in"
             }
           }
  end

  # Magic to make our XHR from Angular work with auth
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected
  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  def json_request?
    request.format.json?
  end
end
