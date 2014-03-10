class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.date :date

      t.timestamps
    end
  end
end
