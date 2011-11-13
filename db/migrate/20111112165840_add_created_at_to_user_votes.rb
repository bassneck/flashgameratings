class AddCreatedAtToUserVotes < ActiveRecord::Migration
	def change
		add_column :user_votes, :created_at, :timestamp

		add_index :user_votes, :created_at

	    UserVote.all.each { |v| v.update_attribute(:created_at, v.request.game.created_at) }
	end
end
