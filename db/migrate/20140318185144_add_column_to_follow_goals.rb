class AddColumnToFollowGoals < ActiveRecord::Migration
  def change
  	add_column :follow_goals, :status, :integer
  end
end
