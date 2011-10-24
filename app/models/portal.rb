class Portal < ActiveRecord::Base
	has_many :requests

	# TODO add custom colors for links
	# TODO add voting controls DOM IDs
end