class User < ActiveRecord::Base
	has_many :games
	has_many :user_votes
	has_many :voted_requests, :through => :user_votes, :source => :request
	has_many :user_portal_accounts, :dependent => :destroy

	attr_accessible :username, :password, :password_confirmation, :remember_me

	validates :username, :presence => true, :uniqueness => true
	validates :password, :presence => true, :confirmation => true, :length => { :minimum => 5 }, :on => :create

	authenticates_with_sorcery!

	accepts_nested_attributes_for :user_portal_accounts, :reject_if => lambda { |a| a[:username].blank? }, :allow_destroy => true
end
