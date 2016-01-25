class UsersController < ApplicationController
    layout false
    before_action :set_user, only: [:show]

    # GET /users
    def index
        render json: current_user, current_user: current_user, root: 'user'
    end

    # GET /users/:id
    def show
        render json: @user, current_user: current_user, root: 'user'
    end

    private

    def set_user
        @user = User.find(params[:id])
    end
end
