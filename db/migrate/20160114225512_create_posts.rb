class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string  :text,              null: false, default: ""
      t.boolean :private,           null: false, default: true

      t.integer :wall_id,           null: false, default: 0
      t.string  :wall_type,         null: false, default: ""

      t.integer :attachment_type,   null: true
      t.string  :attacment_url,     null: true

      t.integer :likes_count,       null: false, default: 0
      t.integer :shares_count,      null: false, default: 0
      t.integer :comments_count,    null: false, default: 0

      t.timestamps null: false
    end

    add_reference :posts, :user, index: true, foreign_key: true
    add_reference :posts, :orig_post, references: :posts, index: true, foreign_key: true, null: true
    add_index :posts, [ :wall_id, :wall_type ], unique: false
  end
end
