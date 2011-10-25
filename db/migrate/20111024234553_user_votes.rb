class UserVotes < ActiveRecord::Migration
  def up
	  create_table :user_votes do |t|
		  t.belongs_to :user
		  t.belongs_to :request
	  end
  end

  def down
  end
end
