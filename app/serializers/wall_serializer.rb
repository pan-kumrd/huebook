class WallSerializer < ActiveModel::Serializer
    attributes :id,
               :wall_type,
               :wall_name

    has_many   :posts, serializer: PostSerializer

    #def posts
    #    Post.where( { wall_id: object.id,
    #                  wall_type: object.wall_type }).order(created_at: :desc)
    #end

    def wall_name
        if object.wall_type == 'Event' then
            return Event.find(object.id).name
        else
            user = User.find(object.id)
            return sprintf('%s %s', user.first_name, user.last_name)
        end
    end
end
