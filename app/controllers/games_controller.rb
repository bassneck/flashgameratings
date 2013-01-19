# -*- encoding : utf-8 -*-

class GamesController < ApplicationController

	before_filter :require_login, :except => [:index, :informer]
	before_filter :check_banned, :except => [:index, :show, :informer]
	before_filter :require_points, :only => [:new, :create]

	def index
		@games = Game.latest.not_banned

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
			@game.requests.build(portal: p)
		end
	end

	def create
		@game = current_user.games.build(params[:game])

		if @game.save
			flash[:success] = 'Игра добавлена. Сейчас мы дружно её плюсанем...'
			redirect_to root_url
		else
			Portal.exclude(@game.portals).each do |p|
				@game.requests.build(portal: p)
			end
			flash.now[:error] = 'Произошла ошибка...'
			render :new
		end
	end

	def edit
		@game = current_user.games.find(params[:id])
		Portal.exclude(@game.portals).each do |p|
			@game.requests.build(portal: p)
		end
	end

	def update
		@game = current_user.games.find(params[:id])

		if @game.update_attributes(params[:game])
			flash[:success] = 'Игра обновлена'
			redirect_to root_url
		else
			Portal.exclude(@game.portals).each do |p|
				@game.requests.build(portal: p)
			end
			render json: :edit
		end
	end

	def votable

		if params[:forum_user]
			@user = User.find_by_forums(params[:forum_user])
		elsif params[:blog_user]
			@user = User.find_by_blogs(params[:blog_user])
		end

		if @user
			count = Game.latest.not_banned.unvoted(@user).count
		else
			count = -1
		end

		@count = { json: count }

		respond_to do |format|
			format.js  { render json: @count, callback: params[:callback] }
			format.json { render json: @count }
			format.xml { render xml: @count }
		end
	end

	protected

		def require_points
			if current_user.points < Game::MINIMUM_RATING
				flash[:error] = "Ваш рейтинг должен быть не меньше #{Game::MINIMUM_RATING}. Проголосуйте за игры камрадов."
      			redirect_to root_url
			end
		end
end
