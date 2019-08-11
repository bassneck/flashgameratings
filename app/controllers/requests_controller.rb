# -*- encoding : utf-8 -*-

class RequestsController < ApplicationController

	before_filter :require_login, except: []

	def show
		@request = Request.find(params[:id])

		if logged_in?
			policy = AwardPointsPolicy.build_from_env(current_user, @request)

			if policy.should_award_points?
				current_user.user_votes.create(request: @request)
			end
		end

		redirect_to "http://#{@request.url}"
	end
end
