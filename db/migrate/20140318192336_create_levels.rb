class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :level_number
      t.integer :required_points

      t.timestamps
    end
  end
end
