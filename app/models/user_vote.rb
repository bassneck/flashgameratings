class UserVote < ActiveRecord::Base
	belongs_to :user
	belongs_to :request

	after_create { |record| record.user.calculate_points.save}

end