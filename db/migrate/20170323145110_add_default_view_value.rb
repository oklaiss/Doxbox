class AddDefaultViewValue < ActiveRecord::Migration
  def change
  	change_column :apis, :view_count, :integer, :default => 0
  end
end
