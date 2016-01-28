class CreateEventRsvps < ActiveRecord::Migration
  def change
    create_table :event_rsvps do |t|
      t.integer :status,    null: false, default: 0
      t.timestamps          null: false
    end

    add_reference :event_rsvps, :user, index: true, foreign_key: true
    add_reference :event_rsvps, :event, index: true, foreign_key: true
    add_reference :event_rsvps, :invited_by, references: :users, index: true, foreign_key: true
    add_index :event_rsvps, [ :user_id, :event_id ], unique: true
  end
end
