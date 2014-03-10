class CreateUserMessages < ActiveRecord::Migration
  def change
    create_table :user_messages do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.text :message
      t.date :date

      t.timestamps
    end
  end
end
