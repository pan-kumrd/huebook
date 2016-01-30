class AppController < ApplicationController
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    render json: {
             error: {
               reason: "auth",
               message: "Authentication expired, please log in"
             }
           }
  end
end
