class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string  :name,          null: false, default: ""
      t.string  :description,   null: false, default: ""

      t.datetime :start,        null: false
      t.datetime :end,          null: false

      t.timestamps null: false
    end

    add_reference :events, :organizer, references: :users, index: true, foreign_key: true

  end
end
