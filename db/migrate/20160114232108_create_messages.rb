class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :text,   null: false, default: ""
      t.boolean :delivered, null: false, default: false
      t.timestamps      null: false
    end

    add_reference :messages, :sender, references: :users, index: true, foreign_key: true
    add_reference :messages, :to, references: :users, index: true, foreign_key: true
  end
end
