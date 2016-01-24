class UserSerializer < ActiveModel::Serializer
    attributes :id,
               :first_name,
               :last_name,
               :email,
               :bio,
               :profile_picture_file_name,
               :created_at,
               :friendship,
               :is_me

    def email
        if @serialization_options[:current_user].id == object.id then
            return object.email
        else
            return nil
        end
    end

    def friendship
        current_user = @serialization_options[:current_user]
        if current_user then
            Friendship.where("(initiator_id = ? AND friend_id = ?) OR (initiator_id = ? AND friend_id = ?)",
                             current_user.id, object.id, object.id, current_user.id)
        else
            nil
        end
    end

    def is_me
        if @serialization_options[:current_user].id == object.id then
            return true
        else
            return false
        end
    end
end

