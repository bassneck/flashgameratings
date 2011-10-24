class CreateVoteRequest < ActiveRecord::Migration
	def up
		create_table :requests do |t|
			t.belongs_to :game
			t.string :remote_id
			t.string :url
			t.belongs_to :portal
		end
	end

	def down
	end
end
