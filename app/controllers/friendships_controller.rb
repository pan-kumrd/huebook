class FriendshipsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    layout false
    before_action :set_my_friendship, only: [:reject, :accept]
    before_action :set_our_friendship, only: [:show, :unfriend]
    
    # GET /friends.json
    def index
        friends = Friendship.where("initiator_id = ? OR friend_id = ?", current_user.id, current_user.id)
        render json: friends
    end

    # GET /friends/:id.json
    def show
        render json: @friend
    end

    # POST /friends/:id/reject
    def reject
        @friend.destroy
        respond_to do |format|
            format.json { head :no_content }
        end
    end

    # POST /friends/:id/accept
    def accept
        @friend.status = "accepted"
        @friend.save!
        render json: @friend
    end

    # POST /friends/:id/request
    def create
        user = User.find(params[:id])
        friend = Friendship.new({ status: "requested",
                                  initiator: current_user,
                                  friend: user })
        friend.status = "requested"
        friend.initiator_id = current_user.id
        friend.friend_id = user.id
        friend.save!
        render json: friend
    end

    # DELETE /friends/:id/unfriend
    def unfriend
        @friend.destroy
        respond_to do |format|
            format.json { head :no_content }
        end
    end

    private
    def set_my_friendship
        friend = Friendship.where("initiator_id = ? AND friend_id = ?", params[:id], current_user.id)
        if friend.length == 1
            @friend = friend[0]
        end
    end

    def set_our_friendship
        friend = Friendship.where("(initiator_id = ? AND friend_id = ?) OR (initiator_id = ? AND friend_id = ?)",
                                  current_user.id, params[:id], params[:id], current_user.id)
        if friend.length == 1
            @friend = friend[0]
        end
    end
end
