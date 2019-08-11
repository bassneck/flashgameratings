class Game < ActiveRecord::Base

	belongs_to :user
	has_many :requests, dependent: :destroy, include: :portal, validate: true
	has_many :portals, through: :requests
	has_many :user_votes, through: :requests
	has_many :voters, through: :user_votes, source: :user, uniq: true

	attr_accessible :name, :requests_attributes

	accepts_nested_attributes_for :requests, reject_if: lambda { |a| a[:url].blank? }, allow_destroy: true

	validates :name, presence: true

	default_scope order('games.updated_at DESC').includes(:user)

	scope :not_banned, lambda { where(users: { banned: false }) }
	scope :latest, lambda { limit(20) }
	scope :fresh, lambda { where('games.updated_at > ?', Request.fresh_date) }
	scope :unvoted, lambda { |u|
    includes(:requests, :user)
    .where('games.user_id != ?', u.id)
    .where('requests.created_at > ?', Request.fresh_date)
    .where('requests.id NOT IN (?)', u.voted_requests.any? ? u.voted_request_ids : 0)
  }

  def build_requests
    Portal.exclude(self.requests.map(&:portal_id)).each do |p|
      self.requests.build({ portal_id: p.id })
    end
  end

	def updated_at_date
		self[:updated_at].to_date
	end

end
