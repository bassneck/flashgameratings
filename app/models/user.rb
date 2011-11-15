class User < ActiveRecord::Base
	has_many :games
	has_many :user_votes
	has_many :voted_requests, :through => :user_votes, :source => :request
	has_many :user_portal_accounts, :dependent => :destroy
	has_many :portals, :through => :user_portal_accounts
	has_many :requests, :through => :games

	attr_accessible :username, :password, :password_confirmation, :remember_me

	validates :username, :presence => true, :uniqueness => true

	validates :email, :presence => true, :on => :create
	validates :email, :uniqueness => true, :format => { :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i }, :allow_blank => true

	validates :forums, :uniqueness => true, :if => :forums?, :allow_blank => true
	validates :blogs, :uniqueness => true, :if => :blogs?, :allow_blank => true

	validates :password, :presence => true, :confirmation => true, :length => { :minimum => 5 }, :on => :create

	authenticates_with_sorcery!

	accepts_nested_attributes_for :user_portal_accounts, :reject_if => lambda { |a| a[:username].blank? }, :allow_destroy => true

	scope :profile, select('"users"."id", "users"."username", "users"."points"').includes(:user_votes)
	scope :best, where('"users"."points" > 0').order('"users"."points" DESC').limit(10)

	def to_param
		username
	end

	def email=(value)
		self[:email] = value unless value.blank?
	end

	def calculate_points
		self[:points] = user_votes.count - (requests.count * 10)
		self
	end

	def self.calculate_points
		User.all.each do |u|
			u.calculate_points
			u.save
		end
	end

end
