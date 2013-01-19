# -*- encoding : utf-8 -*-

class RequestsController < ApplicationController

	before_filter :require_login, except: []

	def show
		@request = Request.find(params[:id])

		if logged_in? and current_user.can_vote?(@request) and @request.fresh?
			current_user.user_votes.create(request: @request)
		end

		redirect_to "http://#{@request.url}"

	end
end