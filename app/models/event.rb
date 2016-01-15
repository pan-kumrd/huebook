class Event < ActiveRecord::Base
    has_many :attendees, through: :event_rsvps
end
