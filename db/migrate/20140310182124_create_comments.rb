class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :goal_id
      t.integer :user_id
      t.text :comment
      t.date :date

      t.timestamps
    end
  end
end
