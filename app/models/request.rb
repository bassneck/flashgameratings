# -*- encoding : utf-8 -*-

class Request < ActiveRecord::Base

	belongs_to :game, touch: true
	belongs_to :portal
	has_many :user_votes
	has_many :voters, class_name: 'User', through: :user_votes

	attr_accessible :url, :portal, :portal_id

	validates_each :url do |model, attribute, value|
		unless value =~ Regexp.new('^(http://|https://)?(www\.)?' + model.portal.url + model.portal.pattern + '$')
			model.errors.add(attribute, 'не соответствует шаблону')
		end
	end

	after_create { |record| record.game.user.calculate_points.save }

	scope :unvoted, lambda { |u| where('requests.id NOT IN (?)', u.voted_request_ids) if u }

	def url=(value)
		unless value.blank?
			value.strip!
			value = value.slice(Regexp.new(portal.url + portal.pattern + '$'))
		end

		self[:url] = value
	end

	def fresh?
		created_at.to_date >= Request.fresh_date
	end

	def awards_points(user = nil)
		result = fresh? and not game.user.banned?
		result &= user.can_vote?(self) unless user.nil?
		result
	end

	def self.fresh_date
		Date.today - 1.day
	end

end