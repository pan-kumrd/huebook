class CommentSerializer < ActiveModel::Serializer
    attributes :id,
               :text,
               :created_at,
               :updated_at,
               :likes_count,
               :user_liked
               :user
               :post_id

    has_one :user, serializer: UserReferenceSerializer
end 
