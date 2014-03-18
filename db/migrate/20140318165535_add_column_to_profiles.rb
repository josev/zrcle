class AddColumnToProfiles < ActiveRecord::Migration
  def change
  	add_column :profiles, :name, :string
  	add_column :profiles, :last_name, :string
  end
end
