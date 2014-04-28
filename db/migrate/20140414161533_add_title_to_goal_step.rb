class AddTitleToGoalStep < ActiveRecord::Migration
  def change
  	add_column :goal_steps, :title, :string
  	add_column :goal_steps, :order, :integer
  end
end
