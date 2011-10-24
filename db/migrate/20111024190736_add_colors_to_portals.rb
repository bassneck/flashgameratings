class AddColorsToPortals < ActiveRecord::Migration
  def change
    add_column :portals, :color, :string, :length => 6, :default => "000000"
  end
end
