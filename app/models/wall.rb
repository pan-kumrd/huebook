class Wall < ActiveRecord::Base
    self.table_name = "walls_view"

    has_many :posts

    def posts
        print("MODELTYPE ", self.wall_type, "\n")

        if self.wall_type == 'Event'
            return allPosts
        else
            print(self.id, " and ", User.current_user.id, " friends? ", User.current_user.friends?(User.find(self.id)), "\n")
            if self.id == User.current_user.id or User.current_user.friends?(User.find(self.id)) then
                return allPosts
            else
                return Post.where("wall_id = ? AND wall_type = ? AND private = 0", self.id, self.wall_type)
            end
        end
    end

    private
    def allPosts
        return Post.where("wall_id = ? AND wall_type = ?", self.id, self.wall_type)
    end
end

