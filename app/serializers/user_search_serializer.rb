class UserSearchSerializer < ActiveModel::Serializer
    include ActiveModel::Serialization

    has_many :users

    def users
        # FIXME: Workaround ActiveModel bug that does not pass serialization_options
        # down to each_serializer when using ArraySerializer
        object.map {
            |o| UserSerializer.new(o, { current_user: @serialization_options[:current_user], root: false })
        }
    end
end
