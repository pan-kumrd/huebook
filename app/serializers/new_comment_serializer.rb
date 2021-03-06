class NewCommentSerializer < ActiveModel::Serializer
    include ActiveModel::Serialization

    has_one :post, serializer: PostSerializer
    has_one :comment, serializer: CommentSerializer

    def post
        object[:post]
    end
    def comment
        object[:comment]
    end
end
