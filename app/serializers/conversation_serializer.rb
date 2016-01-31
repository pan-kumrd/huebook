class ConversationSerializer < ActiveModel::Serializer
    include ActiveModel::Serialization

    has_one :user, serializer: UserReferenceSerializer
    attributes :delivered_cnt,
               :received_cnt

    def user
        return User.find(object.user_id)
    end
end
