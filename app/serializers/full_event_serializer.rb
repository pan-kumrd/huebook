class FullEventSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :description,
               :location,
               :start,
               :end,
               :rsvp,
               :organizer,
               :accepted,
               :tentative,
               :rejected,
               :invited

    has_one :rsvp
    has_one :organizer, serializer: UserReferenceSerializer

    def rsvp
        EventRsvp.where({ event_id: object.id, user_id: User.current_user.id }).first
    end

    def accepted
        EventRsvp.where({ event_id: object.id, status: EventRsvp.statuses[:accepted] }).count
    end

    def tentative
        EventRsvp.where({ event_id: object.id, status: EventRsvp.statuses[:tentative] }).count
    end

    def rejected
        EventRsvp.where({ event_id: object.id, status: EventRsvp.statuses[:rejected] }).count
    end

    def invited
        EventRsvp.where({ event_id: object.id, status: EventRsvp.statuses[:invited] }).count
    end
end
