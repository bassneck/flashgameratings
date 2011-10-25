class Game < ActiveRecord::Base
	belongs_to :user
	has_many :requests, :dependent => :destroy, :include => :portal, :validate => true

	accepts_nested_attributes_for :requests, :reject_if => lambda { |a| a[:url].blank? }, :allow_destroy => true

	default_scope order("games.updated_at DESC")

	scope :latest, where("games.updated_at > ?", Time.now - 2.weeks)
	scope :unvoted, lambda{ |u| includes(:requests, :user).where("requests.id NOT IN (?)", u ? u.voted_request_ids : "") }
end
