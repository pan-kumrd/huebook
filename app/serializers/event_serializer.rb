class PostSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :description,
               :start,
               :end,
               :organizer

    has_one :organizer, serializer: UserReferenceSerializer
end
