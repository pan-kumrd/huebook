class CommentLikesSerializer < ActiveModel::Serializer
    include ActiveModel::Serialization

    has_one :comment, serializer: CommentSerializer
    has_many :users, serializer: UserReferenceSerializer
    def users
        object[:users]
    end
    def comment
        object[:comment]
    end
end
 
