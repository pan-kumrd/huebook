class EventRsvpSerializer < ActiveModel::Serializer

    attributes :id,
               :status,
               :created_at,
               :event_id

    has_one :user, serializer: UserReferenceSerializer
    has_one :invited_by, serializer: UserReferenceSerializer
end

