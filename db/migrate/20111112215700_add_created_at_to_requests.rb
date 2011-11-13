class AddCreatedAtToRequests < ActiveRecord::Migration
	def change
		add_column :requests, :created_at, :timestamp

		add_index :requests, :created_at

		Request.all.each { |r| r.update_attribute(:created_at, r.game.created_at) }
	end
end
