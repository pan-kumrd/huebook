class CreateWalls < ActiveRecord::Migration
  def change
    create_view :walls_view, "SELECT users.id AS id, 'User' AS wall_type FROM users
                              UNION
                              SELECT events.id AS id, 'Event' AS wall_type FROM events",
                              force: true
  end
end
