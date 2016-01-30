class Event < ActiveRecord::Base
    resourcify
    has_one :organizer, class_name: 'User', foreign_key: 'id'

    has_many :event_rsvps
    has_many :attendees, through: :event_rsvps

end
