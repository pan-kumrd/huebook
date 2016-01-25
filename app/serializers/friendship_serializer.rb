class FriendshipSerializer < ActiveModel::Serializer
    attributes :status,
               :created_at

    has_one :friend, serializer: UserReferenceSerializer
    has_one :initiator, serializer: UserReferenceSerializer

    # FIXME: Without this, the Serializer produces the same value for both
    # for some reason...
    def friend
        User.find(object.friend_id)
    end
    def initiator
        User.find(object.initiator_id)
    end
end
