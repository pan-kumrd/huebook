class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer  :status,       null: false, default: 0
      t.timestamps              null: false
    end

    add_reference :friendships, :initiator, references: :users, index: true, foreign_key: true
    add_reference :friendships, :friend, references: :user, index: true, foreign_key: true
    add_index :friendships, [ :initiator, :friend ], unique: false
  end
end
