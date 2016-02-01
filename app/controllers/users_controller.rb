class UsersController < AppController
    load_and_authorize_resource
    layout false
    before_action :set_user, only: [:show]

    # GET /users
    def index
        authorize! :index, current_user
        render json: current_user, current_user: current_user, root: 'user'
    end

    # GET /users/:id
    def show
        authorize! :show, @user
        render json: @user, current_user: current_user, root: 'user'
    end

    private

    def set_user
        @user = User.find(params[:id])
    end
end
