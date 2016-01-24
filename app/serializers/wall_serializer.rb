class WallSerializer < ActiveModel::Serializer
    attributes :id,
               :wall_type

    has_many   :posts, serializer: PostSerializer

    def posts
        Post.where( { wall_id: object.id,
                      wall_type: object.wall_type }).order(created_at: :desc)
    end
end
