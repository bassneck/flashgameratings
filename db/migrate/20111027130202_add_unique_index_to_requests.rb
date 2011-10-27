class AddUniqueIndexToRequests < ActiveRecord::Migration
  def change
	  add_index :user_votes, [:user_id, :request_id], :unique => true
  end
end
