class AddOrgIdToApis < ActiveRecord::Migration
  def change
  	add_column :apis, :org_id, :integer
  end
end
