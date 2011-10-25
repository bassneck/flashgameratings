class UserVote < ActiveRecord::Base
	belongs_to :user
	belongs_to :request

	before_create do |r|
		r.user.points += 1
		r.user.save
	end
end