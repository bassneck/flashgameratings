# -*- encoding : utf-8 -*-

class GamesController < ApplicationController

	before_filter :require_login, :except => [:index]
	#before_filter :require_points, :only => [:new, :create]

	def index
		# TODO index should only show games that current_user hasn't voted for
		@games = Game.latest

		respond_to do |format|
			format.html
			format.atom
      	end
	end

	def show
		@game = Game.find(params[:id])
	end

	def new
		@game = Game.new
		Portal.exclude(@game.portals).each do |p|
			@game.requests.build(:portal => p)
		end
	end

	def create
		@game = current_user.games.build(params[:game])

		if @game.save
			flash[:success] = "Игра добавлена. Сейчас мы дружно её плюсанем..."
			redirect_to root_url
		else
			Portal.exclude(@game.portals).each do |p|
				@game.requests.build(:portal => p)
			end
			flash.now[:error] = "Произошла ошибка..."
			render :new
		end
	end

	def edit
		# TODO allow users to edit their games
		@game = current_user.games.find(params[:id])
		Portal.exclude(@game.portals).each do |p|
			@game.requests.build(:portal => p)
		end
	end

	def update
		@game = current_user.games.find(params[:id])

		if @game.update_attributes(params[:game])
			flash[:success] = 'Игра обновлена'
			redirect_to root_url
		else
			Portal.exclude(@game.portals).each do |p|
				@game.requests.build(:portal => p)
			end
			render :action => "edit"
		end
	end

	protected

		def require_points
			if current_user.points < 0
				flash[:error] = "Рейтинг должен быть > 0. Проголосуйте за игры камрадов"
      			redirect_to root_url
			end
		end
end
