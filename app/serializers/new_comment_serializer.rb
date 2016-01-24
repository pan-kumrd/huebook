class NewCommentSerializer < ActiveModel::Serializer
    attributes :post,
               :comment

    def post
        return PostSerializer.new(object[:post], { root: false })
    end

    def comment
        return CommentSerializer.new(object[:comment], { root: false })
    end
end
