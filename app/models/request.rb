# -*- encoding : utf-8 -*-

class Request < ActiveRecord::Base
	belongs_to :game
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
end