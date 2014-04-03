class RemoveColumnsToGoalSteps < ActiveRecord::Migration
  def change
  	remove_column :goal_steps, :user_id
  	remove_column :goal_steps, :date
  	remove_column :goal_steps, :end_date
  end
end
