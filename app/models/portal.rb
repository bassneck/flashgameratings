class Portal < ActiveRecord::Base
	has_many :requests
	has_many :user_portal_accounts
	has_many :users, :through => :user_portal_accounts

	scope :exclude, lambda { |records| where("portals.id NOT IN (?)", records.map!(&:id)) unless records.empty? }
end