class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text,   null: false, default: ""

      t.timestamps      null: false
    end

    add_reference :comments, :user, index: true, foreign_key: true
    add_reference :comments, :post, index: true, foreign_key: true
  end
end
