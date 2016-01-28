class RsvpsController < ApplicationController
    skip_before_filter :verify_authenticity_token
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

    private
    def set_event
        @event = Event.find(params[:eventId])
    end
end
