class CreateUserSteps < ActiveRecord::Migration
  def change
    create_table :user_steps do |t|
      t.integer :user_id
      t.date :date
      t.date :end_date

      t.timestamps
    end
  end
end
