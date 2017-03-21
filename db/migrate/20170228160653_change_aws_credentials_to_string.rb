class ChangeAwsCredentialsToString < ActiveRecord::Migration
  def change
  	change_column :organizations, :aws_key, :string
  	change_column :organizations, :aws_secret, :string
  end
end
