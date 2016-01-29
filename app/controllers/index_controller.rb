class IndexController < ApplicationController
    layout "index"

    def welcome
        if current_user
            redirect_to "/app"
        end
    end
end
