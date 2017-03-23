class AddViewCountToApis < ActiveRecord::Migration
  def change
  	add_column :apis, :view_count, :integer
  end
end
