class CreateGoalReminds < ActiveRecord::Migration
  def change
    create_table :goal_reminds do |t|
      t.integer :user_id
      t.integer :goal_id
      t.integer :frequently
      t.time :time

      t.timestamps
    end
  end
end
