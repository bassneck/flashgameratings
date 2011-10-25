# -*- encoding : utf-8 -*-

class GamesController < ApplicationController

	before_filter :require_login, :except => [:index]

	def index
		# TODO index should only show games that current_user hasn't voted for
		@games = Game.latest.unvoted(current_user)
	end

	def new
		@game = Game.new
		Portal.all.each do |p|
			@game.requests.build(:portal => p)
		end
	end

	def create
		@game = current_user.games.build(params[:game])

		if @game.save
			flash[:success] = "Игра добавлена. Сейчас мы дружно её плюсанем..."
			redirect_to root_url
		else
			flash.now[:error] = @game.errors.full_messages
			render :new
		end
	end

	def edit
		# TODO allow users to edit their games
		@game = current_user.games.find(params[:id])
	end

	def update
		@game = current_user.games.find(params[:id])
		# TODO update attributes
	end
end
