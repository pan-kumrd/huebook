class HuebookController < ApplicationController
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: 'Please log in first'
  end

  def index
  end
end
