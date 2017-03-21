class AddBucketNameToOrganizations < ActiveRecord::Migration
  def change
  	add_column :organizations, :bucket_name, :string
  end
end
