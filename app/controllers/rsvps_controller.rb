class RsvpsController < AppController
    load_and_authorize_resource
    before_action :set_event, only: [:index, :filter, :update, :leave]
    layout false

    # GET /events/:eventId/rsvp.json
    def index
        rsvps = EventRsvp.where(event: @event)
        render json: rsvps
    end

    # GET /events/:eventId/rsvp/:status.json
    def filter
        rsvps = EventRsvp.where({ event: @event, status: EventRsvp.statuses[params[:status]] })
        render json: rsvps
    end

    # POST /events/:eventId/rsvp/:status.json
    def update
        rsvp = EventRsvp.where(event: @event, user: current_user).first_or_initialize
        rsvp.event = @event
        rsvp.user = current_user
        rsvp.invited_by = current_user
        rsvp.status = params[:status]
        rsvp.save
        render json: rsvp, root: 'rsvp'
    end

    # DELETE /events/:eventId/rsvp.json
    def leave
        rsvp = EventRsvp.where(event: @event, user: current_user).first
        rsvp.destroy
        respond_to do |format|
            format.json { head :no_content }
        end
    end

    # POST /events/:eventId/rsvp/:userId.json
    def invite
        rsvp = EventRsvp.create({ user_id: params[:userId],
                                  event_id: params[:eventId],
                                  invited_by_id: current_user.id,
                                  status: EventRsvp.statuses[:invited]
                                });
        render json: rsvp, root: 'rsvp'
    end

    private
    def set_event
        @event = Event.find(params[:eventId])
    end
end
