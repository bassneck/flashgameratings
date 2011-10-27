class AddAccountsToUsers < ActiveRecord::Migration
  def change
	  change_table :users do |t|
		  t.string :forums
		  t.string :blogs
	  end

	  add_index :users, :forums, :unique => true
	  add_index :users, :blogs, :unique => true
  end
end
