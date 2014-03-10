class CreateGoalRates < ActiveRecord::Migration
  def change
    create_table :goal_rates do |t|
      t.integer :user_id
      t.integer :goal_id
      t.integer :rate

      t.timestamps
    end
  end
end
