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

	scope :profile, select('"users"."id", "users"."username", "users"."points"')
	scope :best, where('"users"."points" > 0').order('"users"."points" DESC').limit(10)

	def to_param
		username
	end

	def points
		user_votes.count - (games.count * 20)
	end

	def self.calculate_points
		User.all.each do |u|
			u.points = u.user_votes.count - (u.games.count * 20)
			u.save
		end
	end

end
