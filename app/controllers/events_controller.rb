class PostsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    before_action :set_event, only: [:show, :rsvps, :rsvp, :setRsvp, :destroyRsvp :destroy]
    layout false

    # GET /events
    # GET /events.json
    def index
        events = Events.where('start >= ?', DateTime.now()).ordered(start: :asc)
        render json: events
    end

    # GET /events/1
    # GET /events/1.json
    def show
        render json: @event
    end

    ####### TODO TODO TODO TODO #######
    # MOVE RSVP TO ITS OWN CONTROLLER #
    ####### TODO TODO TODO TODO #######

    # GET /events/1/rsvps
    # GET /events/1/rsvps.json
    def rsvps
        rsvps = EventRsvps.where({ event: @event })
        render json: rsvps, serializer: ActiveModel::ArraySerializer,
                            each_serializer: EventRSVPSerializer,
                            root: 'rsvps'
    end

    # GET /events/1/rsvp
    # GET /events/1/rsvp
    def rsvp
        rsvp = EventRsvps.where({ event: @event,
                                  user: current_user })
        render json: rsvp
    end

    # POST /events/1/rsvp
    def setRsvp
        rsvp = EventRsvp.find_or_create_by({ event: @event,
                                             user: current_user })
        rsvp.status = post_params[:status]
        rsvp.save()
        render json: rsvp
    end

    # DELETE /events/1/rsvp/
    def destroyRsvp
        EventsRsvp.where({ event: @event, user: current_user }).destroy
        respond_to do |format|
            format.json { head :no_content }
        end
    def 

    # POST /event/create
    def create
        event = Event.new(post_params)
        event.user = current_user
        event.save
        render json: event
    end

    # DELETE /event/1
    # DELETE /event/1.json
    def destroy
        @event.destroy
        respond_to do |format|
            format.json { head :no_content }
        end
    end

    private

    # use callbacks to share common setup or constraints between actions.
    def set_event
        @event = Event.find(params[:id])
    end

    # never trust parameters from the scary internet, only allow the white list through.
    def post_params
        params.require(:event).permit(:name, :description, :start, :end)
    end
end
