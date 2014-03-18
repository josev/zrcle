class RemoveColumnToGoal < ActiveRecord::Migration
  def change
  	remove_column :goals, :user_id, :integer
  end
end
