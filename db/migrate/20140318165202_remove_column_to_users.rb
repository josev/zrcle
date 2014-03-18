class RemoveColumnToUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :name, :string
  	remove_column :users, :lastname, :string
  end
end
