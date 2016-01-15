class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :object_id,     null: false, default: 0
      t.string  :object_type,   null: false, default: ""
      t.timestamps              null: false
    end

    add_reference :likes, :user, index: true, foreign_key: true
    add_index :likes, [ :object_id, :object_type ], unique: true
  end
end
