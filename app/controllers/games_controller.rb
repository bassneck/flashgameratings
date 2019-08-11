# -*- encoding : utf-8 -*-

class GamesController < ApplicationController

	before_filter :require_login, :except => [:index, :voteable]
	before_filter :check_banned, :except => [:index, :show, :voteable]
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
    @game.build_requests
	end

	def create
		@game = current_user.games.build(params[:game])

		if @game.save
			flash[:success] = 'Игра добавлена. Сейчас мы дружно её плюсанем...'
			redirect_to root_url
    else
      @game.build_requests
			flash.now[:error] = 'Произошла ошибка...'
			render :new
		end
	end

	def edit
		@game = current_user.games.find(params[:id])
		@game.build_requests
	end

	def update
		@game = current_user.games.find(params[:id])

		if @game.update_attributes(params[:game])
			flash[:success] = 'Игра обновлена'
			redirect_to root_url
    else
      @game.build_requests
			render :edit
		end
	end

	def voteable
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

		@count = { count: count }

		respond_to do |format|
			format.js  { render json: @count, callback: params[:callback] }
			format.json { render json: @count }
			format.xml { render xml: @count }
		end
	end

	protected

	def require_points
		policy = SubmitNewGamePolicy.build_from_env(current_user)

		unless policy.can_submit_new_game?
			flash[:error] = "Ваш рейтинг должен быть не меньше #{policy.minimum_rating}. Проголосуйте за игры камрадов."
			redirect_to root_url
		end
	end
end
