class AddColumnToComment < ActiveRecord::Migration
  def change
  	add_column :comments, :to_user_id, :integer
  end
end
