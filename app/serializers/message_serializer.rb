class MessageSerializer < ActiveModel::Serializer
    attributes :id,
               :text,
               :delivered,
               :created_at

    has_one :sender, serializer: UserReferenceSerializer
    has_one :to, serializer: UserReferenceSerializer

    def sender
        User.find(object.sender_id)
    end

    def to
        User.find(object.to_id)
    end
end
