class PostSerializer < ActiveModel::Serializer
    attributes :id,
               :user,
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
               :user_liked

    def user
        UserReferenceSerializer.new(object.user).attributes
    end
end