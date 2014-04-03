class RenameTableGoalStepCalendars < ActiveRecord::Migration
  def change
  	rename_table :goal_step_calendars, :goal_steps
  end
end
