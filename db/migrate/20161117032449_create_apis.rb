class CreateApis < ActiveRecord::Migration
  def change
    create_table :apis do |t|
      t.string :name
      t.string :api_s3_name
      t.datetime :aws_last_updated_at

      t.timestamps null: false
    end
  end
end
