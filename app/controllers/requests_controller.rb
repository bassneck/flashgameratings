# -*- encoding : utf-8 -*-

class RequestsController < ApplicationController

	before_filter :require_login, :except => []

	def show
		request = Request.find(params[:id])

		if request.game.user != current_user
			current_user.user_votes.create(:request => request)
			redirect_to request.url
		else
		    flash[:warning] = "Вы не можете голосовать за свои игры"
			redirect_to root_url
		end
	end
end