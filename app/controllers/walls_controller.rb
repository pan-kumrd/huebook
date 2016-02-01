class WallsController < AppController
    layout false

    # GET /walls.json
    def default
        authorize! :default, Wall

        wall = Wall.defaultWall(params)
        render json: wall
    end

    # GET /walls/:type/:id.json
    def show
        authorize! :show, Wall

        if params[:type].downcase == 'user' then
            type = "User"
        elsif params[:type].downcase == 'event' then
            type = "Event"
        else
            # TODO: Error
        end

        wall = Wall.wall(params[:id], type, params)
        render json: wall
    end
end
