class RequestsController < ApplicationController
	def show
		require_login

		request = Request.find(params[:id])

		current_user.user_votes.create(:request => request)

		redirect_to "http://kongregate.com"
	end
end