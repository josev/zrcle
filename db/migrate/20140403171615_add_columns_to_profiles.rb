class AddColumnsToProfiles < ActiveRecord::Migration
  def change
  	add_column :profiles, :image, :string
  	add_column :profiles, :country, :string
  	add_column :profiles, :description, :text

  	remove_column :profiles, :name
  	remove_column :profiles, :last_name
  end
end
