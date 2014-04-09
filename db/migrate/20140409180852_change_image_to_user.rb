class ChangeImageToUser < ActiveRecord::Migration
  def change
  	remove_column :profiles, :image
  	add_column :users, :image, :string
  end
end
