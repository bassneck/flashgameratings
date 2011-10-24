# -*- encoding : utf-8 -*-

class GamesController < ApplicationController
	def index
		# TODO index should only show games that current_user hasn't voted for and that are not older than X days
		@games = Game.all
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
			redirect_to root_url
			flash[:success] = "Игра добавлена. Сейчас мы дружно её плюсанем..."
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
