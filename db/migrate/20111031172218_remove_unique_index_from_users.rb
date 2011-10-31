class RemoveUniqueIndexFromUsers < ActiveRecord::Migration
  def up
	  remove_index :users, :blogs
	  remove_index :users, :forums
  end

  def down
  end
end
