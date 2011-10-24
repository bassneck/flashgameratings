class Game < ActiveRecord::Base
	belongs_to :user
	has_many :requests

	accepts_nested_attributes_for :requests

	default_scope order("updated_at DESC")
end
