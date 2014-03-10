class CreateFollowGoals < ActiveRecord::Migration
  def change
    create_table :follow_goals do |t|
      t.integer :user_id
      t.integer :follow_goal_id

      t.timestamps
    end
  end
end
