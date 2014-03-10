class CreateGoalMessages < ActiveRecord::Migration
  def change
    create_table :goal_messages do |t|
      t.integer :from_user_id
      t.integer :to_goal_id
      t.text :message
      t.date :date

      t.timestamps
    end
  end
end
