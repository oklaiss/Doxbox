class AddAwScredentialstoorganizations < ActiveRecord::Migration
  def change
  	add_column :organizations, :owner_id, :integer
  	add_column :organizations, :aws_key, :integer
  	add_column :organizations, :aws_secret, :integer
  end
end
