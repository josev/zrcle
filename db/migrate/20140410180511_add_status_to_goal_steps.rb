class AddStatusToGoalSteps < ActiveRecord::Migration
  def change
  	add_column :user_steps, :status, :integer
  	add_column :user_steps, :goal_step_id, :integer
  end
end