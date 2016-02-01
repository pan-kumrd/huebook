class AppController < ApplicationController

  rescue_from CanCan::AccessDenied do |exception|
    render json: {
             error: {
               reason: "auth",
               message: "Authentication expired, please log in"
             }
           }
  end
end
