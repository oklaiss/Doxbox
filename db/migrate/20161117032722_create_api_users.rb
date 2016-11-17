class CreateApiUsers < ActiveRecord::Migration
  def change
    create_table :api_users do |t|
      t.integer :user_id
      t.integer :api_id

      t.timestamps null: false
    end
  end
end
