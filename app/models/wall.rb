class Wall < ActiveRecord::Base
    self.table_name = "walls_view"
    has_many :posts, class_name: "Posts",
                     foreign_key: [ 'wall_id', 'wall_type' ]
end

