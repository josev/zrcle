class AddImageToGoalCategories < ActiveRecord::Migration
  def change
  	add_column :goal_categories, :image, :string
  end
end
