class Portal < ActiveRecord::Base

	has_many :requests
	has_many :user_portal_accounts
	has_many :users, through: :user_portal_accounts

	attr_accessible :name, :short_name, :url, :pattern, :color

	scope :exclude, lambda { |records| where("?.id NOT IN (?)", self.table_name, records) unless records.empty? }
end