class AddColumnToFollowUser < ActiveRecord::Migration
  def change
  	add_column :follow_users, :status, :integer
  end
end
