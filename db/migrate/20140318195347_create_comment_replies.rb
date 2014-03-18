class CreateCommentReplies < ActiveRecord::Migration
  def change
    create_table :comment_replies do |t|
      t.integer :comment_id
      t.integer :user_id
      t.text :comment
      t.datetime :date

      t.timestamps
    end
  end
end
