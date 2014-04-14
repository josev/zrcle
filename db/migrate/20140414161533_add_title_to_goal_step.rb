class AddTitleToGoalStep < ActiveRecord::Migration
  def change
  	add_column :goal_steps,:title,:string
  end
end
