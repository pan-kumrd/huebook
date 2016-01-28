class EventSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :description,
               :location,
               :start,
               :end,
               :organizer

    has_one :rsvp
    has_one :organizer, serializer: UserReferenceSerializer

    def rsvp
        EventRsvp.where({ event_id: object.id, user_id: User.current_user.id }).first
    end
end
