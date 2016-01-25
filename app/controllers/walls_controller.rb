class WallsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    layout false

    # GET /walls.json
    def default
        wall = Wall.where("id = ? AND wall_type = 'User'", current_user.id)
        render json: wall
    end

    # GET /walls/:type/:id.json
    def show
        if params[:type].downcase == 'user' then
            type = "User"
        elsif params[:type].downcase == 'event' then
            type = "Event"
        else
            # TODO: Error
        end

        wall = Wall.where("id = ? AND wall_type = ?", params[:id], type).first
        render json: wall
    end
end
