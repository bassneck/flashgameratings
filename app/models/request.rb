# -*- encoding : utf-8 -*-

class Request < ActiveRecord::Base
	belongs_to :game#, :touch => true
	belongs_to :portal
	has_many :user_votes

	validates_each :url do |model, attribute, value|
		if not value =~ Regexp.new("^(http://|https://)?(www\.)?" + model.portal.url + model.portal.pattern + "$")
			model.errors.add(attribute, 'не соответствует шаблону')
		end
	end

	scope :unvoted, lambda{ |u|
		if u
			where("requests.id NOT IN (?)", u.voted_request_ids)
		end
	}

	def url=(value)
		if value
			value.strip!
			value = value.slice(Regexp.new(portal.url + portal.pattern + "$"))
		end

		self[:url] = value
	end

	def url
		self[:url]
	end


end