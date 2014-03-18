class AddColumnToUserGoal < ActiveRecord::Migration
  def change
  	add_column :user_goals, :private, :boolean
  end
end
