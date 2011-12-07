# -*- encoding : utf-8 -*-

class GamesController < ApplicationController

	before_filter :require_login, :except => [:index, :informer]
	#before_filter :require_points, :only => [:new, :create]

	def index
		@games = Game.latest

		respond_to do |format|
			format.html
			format.atom
      	end
	end

	def show
		@game = Game.find(params[:id])
		votes = @game.user_votes.select("user_votes.created_at, COUNT(user_votes.id) as count").order("user_votes.created_at ASC").group("user_votes.created_at")

		#Game.find(13).user_votes.select("user_votes.created_at, COUNT(user_votes.id) as count").order("user_votes.created_at ASC").group("user_votes.created_at")

		#@chart = LazyHighCharts::HighChart.new('graph') do |f|
		#	f.options[:title] = { :text => "Статистика голосов за #{@game.name}" }
		#
		#	f.xAxis :type => "datetime", :dateTimeLabelFormats => { :day => '%e of %b' }
		#	f.series :name => "Голоса", :data => votes.map { |v| [v.created_at.to_time.to_i * 1000, v.count.to_i] }
	    #
		#end
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

	def informer

		if params[:forum_user]
			@user = User.find_by_forums(params[:forum_user])
		elsif params[:blog_user]
			@user = User.find_by_blogs(params[:blog_user])
		end

		if @user
			count = Game.latest.unvoted(@user).count
		else
			count = -1
		end

		@count = { :count => count }

		respond_to do |format|
			format.js  { render :json => @count, :callback => params[:callback] }
			format.json { render :json => @count }
			format.xml { render :xml => @count }
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
