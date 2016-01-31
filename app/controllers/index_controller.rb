class IndexController < ApplicationController
    layout "index"
    skip_before_action :verify_authenticity_token

    def welcome
        if current_user
            redirect_to "/app"
        end
    end
end
