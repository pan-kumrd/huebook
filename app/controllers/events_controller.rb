class EventsController < AppController
    load_and_authorize_resource
    before_action :set_event, only: [:show]
    layout false

    # GET /events
    # GET /events.json
    def index
        # FIXME: ActiveRecord is literally one of the stupidest pieces of crap
        # I had the unfortunate "luck" to ever deal with. Apparently it's OK to
        # use placeholders in WHERE conditions, but not in JOINS, because FUCK
        # YOU, consistent API designs.....I want back to Qt!
        # Luckily current_user is coming from the database so we can be reasonably
        # sure that no SQL injection can happen here. Right? RIGHT?
        events = Event.joins("LEFT JOIN event_rsvps ON (events.id = event_rsvps.event_id AND event_rsvps.user_id = " + current_user.id.to_s + ")")
                      .where("events.organizer_id = ? OR event_rsvps.user_id IS NOT NULL", current_user.id)
                      .select("events.*")
        render json: events
    end

    # GET /events/1
    # GET /events/1.json
    def show
        render json: @event, serializer: FullEventSerializer, root: 'event'
    end

    # POST /events
    def create
        event = Event.new(event_params)
        ActiveRecord::Base.transaction do
            event.start = DateTime.strptime(event_params[:start], '%s')
            event.end = DateTime.strptime(event_params[:start], '%s')
            event.organizer_id = current_user.id
            event.save
            rsvp = EventRsvp.new()
            rsvp.user = current_user
            rsvp.event = event
            rsvp.invited_by = current_user
            rsvp.status = EventRsvp.statuses[:accepted]
            rsvp.save
        end
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
    def event_params
        params.require(:event).permit(:name, :description, :location, :start, :end)
    end
end
