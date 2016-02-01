class Wall < ActiveRecord::Base
    self.table_name = "walls_view"

    has_many :posts

    def posts
        if self.wall_type == 'Event' then
            return allPosts
        else
            if self.id == User.current_user.id then
                return homePosts
            elsif User.current_user.friends?(User.find(self.id)) then
                return allPosts
            else
                return Post.where("user_id = ? AND private = 0", self.id).order(created_at: :desc)
            end
        end
    end

    private
    def homePosts
        friends = User.current_user.friends()
        ids = friends.map { |f| f.id }
        ids.push(User.current_user.id)
        return Post.where("(wall_id = ? AND wall_type = 'User') OR (user_id IN (?))",
                           self.id, ids)
                   .order(created_at: :desc)
    end

    def allPosts
        if self.wall_type == 'Event' then
            return Post.where("wall_id = ? AND wall_type = ?",
                              self.id, self.wall_type).order(created_at: :desc)
        else
            return Post.where("(wall_id = ? AND wall_type = ?) OR (user_id = ?)",
                              self.id, self.wall_type, self.id).order(created_at: :desc)
        end
    end
end

