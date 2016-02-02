class PostSerializer < ActiveModel::Serializer
    attributes :id,
               :text,
               :private,
               :wall,
               :created_at,
               :updated_at,
               :attachment_url,
               :attachment_type,
               :orig_post,
               :likes_count,
               :shares_count,
               :comments_count,
               :user_liked
               :user

    has_one :wall, serializer: WallReferenceSerializer
    has_one :user, serializer: UserReferenceSerializer
end
