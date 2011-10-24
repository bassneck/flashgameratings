class Request < ActiveRecord::Base
	belongs_to :game
	belongs_to :portal
end