class CreateGoalCategories < ActiveRecord::Migration
  def change
    create_table :goal_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
