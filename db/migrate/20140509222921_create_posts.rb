class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_step_id
      t.string :title
      t.text :comment
      t.string :image

      t.timestamps
    end
  end
end
