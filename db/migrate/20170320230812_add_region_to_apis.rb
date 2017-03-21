class AddRegionToApis < ActiveRecord::Migration
  def change
  	add_column :organizations, :region, :string
  end
end
