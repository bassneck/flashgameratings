class UserVote < ActiveRecord::Base

  attr_accessible :request, :request_id

  belongs_to :user
	belongs_to :request

	after_create { |record| record.user.calculate_points.save }

end