class CreateGoalStepCalendars < ActiveRecord::Migration
  def change
    create_table :goal_step_calendars do |t|
      t.integer :goal_id
      t.integer :user_id
      t.text :description
      t.date :date
      t.date :end_date

      t.timestamps
    end
  end
end
