class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :image
      t.integer :goal_category_id
      t.text :expected_result
      t.date :date
      t.integer :goal_type_id

      t.timestamps
    end
  end
end
