class Portal < ActiveRecord::Base
	has_many :requests

	# TODO add voting controls DOM IDs
end