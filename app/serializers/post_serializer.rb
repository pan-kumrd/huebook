class PostSerializer < ActiveModel::Serializer
    attributes :id,
               :text,
               :private,
               :wall_id,
               :wall_type,
               :created_at,
               :updated_at,
               :attacment_url,
               :attachment_type,
               :orig_post,
               :likes_count,
               :shares_count,
               :comments_count,
               :user_liked
               :user

    has_one :user, serializer: UserReferenceSerializer
end
