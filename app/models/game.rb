class Game < ActiveRecord::Base
	belongs_to :user
	has_many :requests, :dependent => :destroy, :include => :portal, :validate => true

	accepts_nested_attributes_for :requests, :reject_if => lambda { |a| a[:url].blank? }, :allow_destroy => true

	default_scope order("games.updated_at DESC")

	scope :latest, where("games.updated_at > ?", Time.now - 2.weeks)
	scope :unvoted, lambda{ |u| includes(:requests, :user).where("games.user_id != ?", u.id).where("requests.id NOT IN (?)", u.voted_requests.any? ? u.voted_request_ids : 0) }

	after_create do |record|
		record.user.points -= 20
		record.user.save
	end
end
