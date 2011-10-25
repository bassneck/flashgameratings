class CreateUserPortalAccounts < ActiveRecord::Migration
	def up
		create_table :user_portal_accounts do |t|
			t.belongs_to :user
			t.belongs_to :portal
			t.string :username
		end
	end

	def down
	end
end
