class PostLikesSerializer < ActiveModel::Serializer
    include ActiveModel::Serialization

    has_one :post, serializer: PostSerializer
    has_many :users, serializer: UserReferenceSerializer
    def users
        object[:users]
    end
    def post
        object[:post]
    end
end
