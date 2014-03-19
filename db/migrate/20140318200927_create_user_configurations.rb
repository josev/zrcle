class CreateUserConfigurations < ActiveRecord::Migration
  def change
    create_table :user_configurations do |t|
      t.integer :user_id
      t.boolean :notification
      t.boolean :new_message
      t.boolean :new_follower
      t.boolean :replies
      t.boolean :likes

      t.timestamps
    end
  end
end
