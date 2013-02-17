class Portal < ActiveRecord::Base

	has_many :requests
	has_many :user_portal_accounts
	has_many :users, through: :user_portal_accounts

	attr_accessible :name, :short_name, :url, :pattern, :color

	scope :exclude, lambda { |records| where("#{self.table_name}.id NOT IN (?)", records) unless records.empty? }
end