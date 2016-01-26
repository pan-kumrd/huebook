class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer  :status,       null: false, default: 0
      t.timestamps              null: false
    end

    add_reference :friendships, :initiator, references: :users, index: true, foreign_key: true, null: false, default: 0
    add_reference :friendships, :friend, references: :users, index: true, foreign_key: true, null: false, default: 0
    add_index :friendships, [ :initiator_id, :friend_id ], unique: true
  end
end
