class CreatePortals < ActiveRecord::Migration
  def up
	  create_table :portals do |t|
		  t.string :name
		  t.string :short_name
		  t.string :url
		  t.string :pattern
	  end
  end

  def down
  end
end
